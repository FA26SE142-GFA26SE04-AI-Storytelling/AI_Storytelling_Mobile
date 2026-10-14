import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../json.dart';
import '../models/ai_story_models.dart';
import '../models/child_models.dart';

// Dữ liệu mẫu (USE_MOCK=true), port từ AI_Storytelling_Frontend/src/app/mocks/mockDb.ts.
// Trạng thái được lưu vào SharedPreferences để đóng mở app không mất truyện vừa tạo.

final mockChildren = [
  ChildProfile(id: 1, ownerUserId: 1, nickname: 'Bé Na', ageBand: 'Age_6_8', language: 'vi', status: 'Active', createdAt: DateTime.utc(2026, 8, 1, 8)),
  ChildProfile(id: 2, ownerUserId: 1, nickname: 'Bin', ageBand: 'Age_9_12', language: 'vi', status: 'Active', createdAt: DateTime.utc(2026, 8, 5, 8)),
];

const mockCategories = [
  ContentCategory(id: 1, code: 'animals', displayName: 'Động vật'),
  ContentCategory(id: 2, code: 'adventure', displayName: 'Phiêu lưu'),
  ContentCategory(id: 3, code: 'science', displayName: 'Khoa học'),
  ContentCategory(id: 4, code: 'fairytale', displayName: 'Cổ tích'),
  ContentCategory(id: 5, code: 'horror', displayName: 'Ma quỷ, kinh dị'),
  ContentCategory(id: 6, code: 'violence', displayName: 'Bạo lực'),
];

const mockInterests = {
  1: ['động vật', 'rừng xanh'],
  2: ['robot', 'vũ trụ'],
};

SafetyPolicy defaultMockPolicy(int childId) => SafetyPolicy(
  id: childId,
  childProfileId: childId,
  maxStoryLength: childId == 2 ? 1200 : 800,
  approvalMode: ApprovalMode.alwaysManual,
  parentalGateEnabled: true,
  consentRecorded: true,
  rules: const {5: CategoryRule.blocked, 6: CategoryRule.blocked},
);

/// Truyện trong dữ liệu mẫu. Các mốc thời gian (ms) quyết định trạng thái hiện tại, xem mock_repositories.dart.
class MockStory {
  MockStory({
    required this.id,
    required this.childId,
    required this.requestId,
    required this.topic,
    required this.genre,
    required this.lesson,
    required this.characters,
    required this.createdAt,
    required this.acceptedAt,
    required this.blocked,
    required this.outlineVersions,
    required this.reviewVersionId,
    required this.title,
    required this.content,
    required this.vocabulary,
    required this.quiz,
    required this.discussion,
    this.pendingRegenAt,
    this.outlineApprovedAt,
    this.mediaStartedAt,
    this.archived = false,
  });

  factory MockStory.fromJson(Json j) => MockStory(
    id: asInt(j['id']),
    childId: asInt(j['childId']),
    requestId: asInt(j['requestId']),
    topic: j['topic'] as String,
    genre: j['genre'] as String,
    lesson: j['lesson'] as String,
    characters: asStrings(j['characters']),
    createdAt: asDate(j['createdAt']),
    acceptedAt: asInt(j['acceptedAt']),
    blocked: j['blocked'] as bool,
    outlineVersions: asList(j['outlineVersions'], OutlineVersion.fromJson),
    pendingRegenAt: asIntOrNull(j['pendingRegenAt']),
    outlineApprovedAt: asIntOrNull(j['outlineApprovedAt']),
    reviewVersionId: asInt(j['reviewVersionId']),
    title: j['title'] as String,
    content: j['content'] as String,
    vocabulary: asList(j['vocabulary'], VocabularyItem.fromJson),
    quiz: asList(j['quiz'], QuizQuestion.fromJson),
    discussion: asList(j['discussion'], DiscussionPrompt.fromJson),
    mediaStartedAt: asIntOrNull(j['mediaStartedAt']),
    archived: j['archived'] as bool? ?? false,
  );

  final int id;
  final int childId;
  final int requestId;
  final String topic;
  final String genre;
  String lesson;
  final List<String> characters;
  final DateTime createdAt;
  int acceptedAt;
  bool blocked;
  List<OutlineVersion> outlineVersions;
  int? pendingRegenAt;
  int? outlineApprovedAt;
  int reviewVersionId;
  String title;
  String content;
  List<VocabularyItem> vocabulary;
  List<QuizQuestion> quiz;
  List<DiscussionPrompt> discussion;
  int? mediaStartedAt;
  bool archived;

  Json toJson() => {
    'id': id,
    'childId': childId,
    'requestId': requestId,
    'topic': topic,
    'genre': genre,
    'lesson': lesson,
    'characters': characters,
    'createdAt': createdAt.toIso8601String(),
    'acceptedAt': acceptedAt,
    'blocked': blocked,
    'outlineVersions': [for (final v in outlineVersions) v.toJson()],
    'pendingRegenAt': pendingRegenAt,
    'outlineApprovedAt': outlineApprovedAt,
    'reviewVersionId': reviewVersionId,
    'title': title,
    'content': content,
    'vocabulary': [for (final v in vocabulary) v.toJson()],
    'quiz': [for (final q in quiz) q.toJson()],
    'discussion': [for (final d in discussion) d.toJson()],
    'mediaStartedAt': mediaStartedAt,
    'archived': archived,
  };
}

typedef ComposedStory = ({
  String title,
  String opening,
  String development,
  String ending,
  String content,
  List<VocabularyItem> vocabulary,
  List<QuizQuestion> quiz,
  List<DiscussionPrompt> discussion,
});

/// "AI" của dữ liệu mẫu: ghép truyện 6 đoạn từ chủ đề, nhân vật và bài học.
ComposedStory composeStory(String topic, List<String> characters, String lesson) {
  final hero = characters.isNotEmpty ? characters[0] : 'Sóc Bông';
  final friend = characters.length > 1 ? characters[1] : 'Thỏ Trắng';
  final t = topic.toLowerCase(), l = lesson.toLowerCase();
  return (
    title: topic.length > 48 ? '${topic.substring(0, 45).trim()}…' : topic,
    opening: '$hero bắt đầu một ngày mới với một điều muốn làm: $t.',
    development: '$hero gặp $friend và cùng nhau vượt qua một khó khăn nhỏ trên đường đi.',
    ending: 'Cuối cùng, cả hai hiểu ra: $l.',
    content: [
      'Sáng nay, $hero thức dậy thật sớm. Trời trong xanh, gió nhẹ nhàng thổi qua tán lá. $hero nghĩ về điều mình muốn làm hôm nay: $t.',
      '$hero chuẩn bị mọi thứ thật cẩn thận rồi lên đường cùng mẹ. Trên đường đi, $hero nhìn thấy những bông hoa nở rực rỡ ven lối nhỏ.',
      'Bỗng $friend chạy tới, vẻ mặt lo lắng. “Mình bị lạc mất đường rồi!” $friend nói. $hero mỉm cười và rủ $friend đi cùng.',
      'Con đường không dễ đi. Có lúc $hero thấy mệt, có lúc $friend muốn bỏ cuộc. Nhưng hai bạn động viên nhau, từng bước từng bước tiến lên.',
      'Khi mặt trời lên cao, hai bạn đã đến nơi. Mọi người vui mừng chào đón. $hero và $friend ôm nhau thật chặt.',
      'Tối đó, $hero kể lại cho mẹ nghe và nói: “Con hiểu rồi, $l.” Mẹ xoa đầu $hero và cười thật hiền.',
    ].join('\n\n'),
    vocabulary: const [
      VocabularyItem(id: 1, term: 'cẩn thận', definition: 'Làm việc chậm rãi, chú ý để không sai sót hay gặp nguy hiểm.'),
      VocabularyItem(id: 2, term: 'động viên', definition: 'Nói lời tốt đẹp để bạn thêm sức mạnh và niềm tin.'),
      VocabularyItem(id: 3, term: 'tán lá', definition: 'Phần lá xanh xoè rộng phía trên của cây.'),
    ],
    quiz: [
      QuizQuestion(id: 1, question: 'Ai đã chạy tới gặp $hero với vẻ lo lắng?', correctAnswer: friend, choices: [friend, 'Bác Cú', 'Cô Gió']),
      const QuizQuestion(
        id: 2,
        question: 'Hai bạn đã làm gì khi thấy mệt?',
        correctAnswer: 'Động viên nhau',
        choices: ['Bỏ cuộc', 'Động viên nhau', 'Ngủ một giấc'],
      ),
    ],
    discussion: [
      const DiscussionPrompt(id: 1, question: 'Con đã bao giờ giúp một người bạn đang gặp khó khăn chưa? Con cảm thấy thế nào?', isMoralLesson: true),
      DiscussionPrompt(id: 2, question: 'Nếu là $hero, con sẽ chuẩn bị gì trước khi lên đường?'),
    ],
  );
}

OutlineVersion makeOutlineVersion(int storyId, int versionNo, MockStory s, DateTime now, {String editType = 'ai_generated'}) {
  final c = composeStory(s.topic, s.characters, s.lesson);
  return OutlineVersion(
    id: storyId * 100 + versionNo,
    versionNo: versionNo,
    editType: editType,
    title: c.title,
    opening: c.opening,
    development: c.development,
    ending: c.ending,
    isCurrent: true,
    createdAt: now,
  );
}

/// Kho dữ liệu mẫu dùng chung cho các Mock*Repository.
class MockDb {
  MockDb(this._prefs, {DateTime Function()? clock}) : now = clock ?? DateTime.now {
    _load();
  }

  static const storageKey = 'taletale-mock-db:v1';

  /// Mốc thời gian rất cũ: coi như bước đó đã xong từ lâu.
  static const old = 1;

  final SharedPreferences? _prefs;
  final DateTime Function() now;

  late int nextStoryId;
  late List<MockStory> stories;
  late Map<int, SafetyPolicy> policies;

  int get nowMs => now().millisecondsSinceEpoch;

  MockStory? find(int id) => stories.where((s) => s.id == id).firstOrNull;

  void _load() {
    final raw = _prefs?.getString(storageKey);
    if (raw != null) {
      try {
        final j = asJson(jsonDecode(raw));
        nextStoryId = asInt(j['nextStoryId']);
        stories = asList(j['stories'], MockStory.fromJson);
        policies = {for (final p in asList(j['policies'], SafetyPolicy.fromJson)) p.childProfileId: p};
        return;
      } catch (_) {
        // Dữ liệu cũ hỏng hoặc khác phiên bản: tạo lại từ đầu.
      }
    }
    _seed();
  }

  void save() => _prefs?.setString(
    storageKey,
    jsonEncode({
      'nextStoryId': nextStoryId,
      'stories': [for (final s in stories) s.toJson()],
      'policies': [for (final p in policies.values) p.toJson()],
    }),
  );

  /// Xoá mọi thay đổi, quay về 5 truyện mẫu ban đầu.
  void reset() {
    _seed();
    save();
  }

  void _seed() {
    nextStoryId = 101;
    policies = {};
    stories = [
      _seedStory(1, 1, 'Rùa Bông và chiếc đèn lồng trăng', 'kiên nhẫn và cẩn thận', ['Rùa Bông', 'Đom Đóm Lém'], ready: false),
      _seedStory(2, 1, 'Chú gấu và tổ ong ngọt', 'biết chia sẻ', ['Gấu Nâu', 'Ong Vàng'], ready: true),
      _seedStory(3, 1, 'Con đường lên đỉnh mây', 'lòng dũng cảm', ['Sóc Bông', 'Thỏ Trắng'], ready: true),
      _seedStory(4, 2, 'Robot nhỏ dọn biển', 'bảo vệ môi trường', ['Robo', 'Rùa Biển'], ready: false),
      _seedStory(5, 2, 'Hệ Mặt Trời có mấy anh em', 'tò mò khám phá', ['Tiến Sĩ Sao', 'Bé Mai'], ready: true),
    ];
  }

  /// Truyện mẫu: `ready` = đã duyệt và có minh hoạ; ngược lại đang chờ phụ huynh duyệt nội dung.
  MockStory _seedStory(int id, int childId, String topic, String lesson, List<String> characters, {required bool ready}) {
    final c = composeStory(topic, characters, lesson);
    final s = MockStory(
      id: id,
      childId: childId,
      requestId: id,
      topic: topic,
      genre: 'Cổ tích',
      lesson: lesson,
      characters: characters,
      createdAt: now().subtract(Duration(days: id % 7)),
      acceptedAt: old,
      blocked: false,
      outlineVersions: const [],
      outlineApprovedAt: old,
      reviewVersionId: id * 10 + 1,
      title: c.title,
      content: c.content,
      vocabulary: c.vocabulary,
      quiz: c.quiz,
      discussion: c.discussion,
      mediaStartedAt: ready ? old : null,
    );
    s.outlineVersions = [makeOutlineVersion(id, 1, s, now()).copyWith(outlineApprovedAt: DateTime.utc(2026, 9, 20))];
    return s;
  }
}
