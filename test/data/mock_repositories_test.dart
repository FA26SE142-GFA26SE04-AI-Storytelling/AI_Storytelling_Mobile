import 'package:ai_storytelling_mobile/data/mock/mock_db.dart';
import 'package:ai_storytelling_mobile/data/mock/mock_repositories.dart';
import 'package:ai_storytelling_mobile/data/models/ai_story_models.dart';
import 'package:ai_storytelling_mobile/data/models/child_models.dart';
import 'package:ai_storytelling_mobile/data/models/story_models.dart';
import 'package:ai_storytelling_mobile/domain/story_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Đồng hồ giả: tua thời gian để "AI" mẫu chuyển bước mà không phải chờ thật.
class FakeClock {
  DateTime value = DateTime.utc(2026, 10, 14, 9);
  DateTime call() => value;
  void advance(int ms) => value = value.add(Duration(milliseconds: ms));
}

void main() {
  late FakeClock clock;
  late SharedPreferences prefs;
  late MockDb db;
  late MockStoryRepository stories;
  late MockChildRepository children;
  late MockAiStoryRepository ai;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    clock = FakeClock();
    db = MockDb(prefs, clock: clock.call);
    stories = MockStoryRepository(db, latency: Duration.zero);
    children = MockChildRepository(db, latency: Duration.zero);
    ai = MockAiStoryRepository(db, latency: Duration.zero);
  });

  const idea = CreativeInput(topic: 'Mèo Mun đi tìm cầu vồng', lesson: 'Biết kiên trì', vocabularyLevel: 'level_2', targetLength: 500, characters: ['Mèo Mun']);

  group('dữ liệu khởi tạo', () {
    test('2 bé, mỗi bé có truyện sẵn sàng đọc và truyện chờ duyệt', () async {
      final kids = (await children.getMyChildren()).data!;
      expect(kids.map((k) => k.nickname), ['Bé Na', 'Bin']);

      final na = (await stories.getStories(const StoryFilter(childProfileId: 1))).data!.items;
      expect(na, hasLength(3));
      expect(na.where(isReadable), hasLength(2));
      expect(na.where(awaitsReview).single.title, 'Rùa Bông và chiếc đèn lồng trăng');
      expect(na.first.pages, hasLength(6));
    });

    test('lọc theo tên truyện', () async {
      final res = await stories.getStories(const StoryFilter(search: 'robot'));
      expect(res.data!.items.single.title, 'Robot nhỏ dọn biển');
    });

    test('chính sách mặc định chặn kinh dị và bạo lực', () async {
      final p = (await children.getSafetyPolicy(1)).data!;
      expect(p.ruleOf(5), CategoryRule.blocked);
      expect(p.ruleOf(1), CategoryRule.allowed);
      expect(p.approvalMode, ApprovalMode.alwaysManual);
    });
  });

  test('đi hết quy trình tạo truyện: ý tưởng → dàn ý → nội dung → duyệt → minh hoạ → bé đọc được', () async {
    final submitted = (await ai.submitInput(1, idea, idempotencyKey: 'k1')).data!;
    final id = submitted.storyId;
    expect(submitted.status, InputStatus.checkingInput);
    expect(
      (await stories.getStories(const StoryFilter(childProfileId: 1))).data!.items.map((s) => s.id),
      isNot(contains(id)),
      reason: 'chưa hiện khi đang xử lý',
    );

    clock.advance(MockTiming.accept);
    expect((await ai.getInputProgress(id, submitted.requestId)).data!.status, InputStatus.inputAccepted);
    expect((await ai.getOutline(id)).data!.currentVersion, isNull, reason: 'AI chưa viết xong dàn ý');

    clock.advance(MockTiming.outline);
    final outline = (await ai.getOutline(id)).data!;
    expect(outlineReady(outline), isTrue);
    expect(outline.currentVersion!.opening, contains('Mèo Mun'));

    await ai.approveOutline(id, outline.currentVersion!.versionNo, approvalKey: 'a1');
    expect((await ai.getGenerationProgress(id)).data!.currentStep, 'content');

    clock.advance(MockTiming.content);
    expect(generatingLearning((await ai.getGenerationProgress(id)).data), isTrue);

    clock.advance(MockTiming.review);
    final gen = (await ai.getGenerationProgress(id)).data!;
    expect(gen.isComplete, isTrue);
    final pkg = (await ai.getReviewPackage(id)).data!;
    expect(pkg.canApprove, isTrue);
    expect(pkg.missingLearning, isFalse);
    expect((await ai.getQuiz(id)).data!.where((q) => q.playable), hasLength(2));

    await ai.approveStory(id);
    clock.advance(MockTiming.media ~/ 2);
    final half = (await ai.getMediaProgress(id)).data!;
    expect(half.isReady, isFalse);
    expect(half.readyIllustrations, 3);

    clock.advance(MockTiming.media);
    expect((await ai.getMediaProgress(id)).data!.isReady, isTrue);
    final story = (await stories.getStory(id)).data!;
    expect(isReadable(story), isTrue);
    expect(storyStatus(story).$2, 'Đã xuất bản');
  });

  test('ý tưởng không an toàn bị chặn kèm lời giải thích thân thiện', () async {
    final p = (await ai.submitInput(
      1,
      const CreativeInput(topic: 'Chuyện ma quỷ', lesson: 'x', vocabularyLevel: 'level_2', targetLength: 300),
      idempotencyKey: 'k',
    )).data!;
    clock.advance(MockTiming.accept);
    final res = (await ai.getInputProgress(p.storyId, p.requestId)).data!;
    expect(res.status, InputStatus.inputBlocked);
    expect(res.fallbackMessage, isNotEmpty);
  });

  test('viết lại dàn ý: có phiên bản mới sau khi AI làm xong', () async {
    final id = (await ai.submitInput(2, idea, idempotencyKey: 'k')).data!.storyId;
    clock.advance(MockTiming.outline);
    await ai.regenerateOutline(id, 1, operationKey: 'r');
    expect(outlineReady((await ai.getOutline(id)).data!), isFalse, reason: 'đang viết lại');

    clock.advance(MockTiming.regenerate);
    final o = (await ai.getOutline(id)).data!;
    expect(o.currentVersion!.versionNo, 2);
    expect(outlineReady(o, previousVersion: 1), isTrue);
  });

  test('sửa và lưu trữ bản thảo chờ duyệt', () async {
    final updated = (await ai.updateStoryReview(1, versionId: 11, title: 'Đèn lồng của Rùa', content: 'Một đoạn.', lesson: 'kiên nhẫn')).data!;
    expect(updated, 12);
    expect((await stories.getStory(1)).data!.title, 'Đèn lồng của Rùa');

    await ai.archiveStory(1);
    final na = (await stories.getStories(const StoryFilter(childProfileId: 1))).data!.items;
    expect(na.map((s) => s.id), isNot(contains(1)));
  });

  test('cấu hình tạo truyện theo chính sách an toàn đang lưu', () async {
    final policy = (await children.getSafetyPolicy(2)).data!;
    await children.setSafetyPolicy(policy.copyWith(maxStoryLength: 2000, rules: {...policy.rules, 3: CategoryRule.restricted}));

    final ctx = (await ai.getCreationContext(2)).data!;
    expect(ctx.childNickname, 'Bin');
    expect(ctx.maximumLength, 2000);
    expect(ctx.blockedCategoryCodes, ['horror', 'violence']);
    expect(ctx.restrictedCategoryCodes, ['science']);
    expect(ctx.interests, ['robot', 'vũ trụ']);
  });

  test('dữ liệu được lưu lại giữa các lần mở app, và đặt lại được', () async {
    final id = (await ai.submitInput(1, idea, idempotencyKey: 'k')).data!.storyId;
    await children.setSafetyPolicy(defaultMockPolicy(1).copyWith(maxStoryLength: 999));

    final reopened = MockDb(prefs, clock: clock.call);
    expect(reopened.find(id)?.topic, idea.topic);
    expect(reopened.policies[1]?.maxStoryLength, 999);
    expect(reopened.nextStoryId, id + 1);

    reopened.reset();
    expect(MockDb(prefs, clock: clock.call).find(id), isNull);
  });
}
