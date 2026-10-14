import '../json.dart';

// Hợp đồng quy trình tạo truyện AI, port từ AI_Storytelling_Frontend/src/app/types/aiStory.ts.
// Quy trình: gửi ý tưởng → kiểm tra an toàn → dàn ý (phụ huynh duyệt) → viết truyện + học liệu
// → phụ huynh duyệt nội dung → tạo minh hoạ và giọng đọc → sẵn sàng cho bé đọc.

/// Cấu hình tạo truyện của một bé, suy ra từ hồ sơ học tập và chính sách an toàn.
class StoryCreationContext {
  const StoryCreationContext({
    required this.childProfileId,
    required this.childNickname,
    required this.ageBand,
    required this.readingLevel,
    required this.defaultVocabularyLevel,
    required this.availableVocabularyLevels,
    required this.defaultLanguage,
    required this.availableLanguages,
    required this.maximumLength,
    required this.requiredApprovalMode,
    required this.parentalGateEnabled,
    required this.interests,
    required this.allowedCategoryCodes,
    required this.restrictedCategoryCodes,
    required this.blockedCategoryCodes,
    this.safetyScoreThreshold,
  });

  factory StoryCreationContext.fromJson(Json json) => StoryCreationContext(
    childProfileId: asInt(json['childProfileId']),
    childNickname: json['childNickname'] as String,
    ageBand: json['ageBand'] as String,
    readingLevel: asInt(json['readingLevel']),
    defaultVocabularyLevel: json['defaultVocabularyLevel'] as String,
    availableVocabularyLevels: asStrings(json['availableVocabularyLevels']),
    defaultLanguage: json['defaultLanguage'] as String,
    availableLanguages: asStrings(json['availableLanguages']),
    maximumLength: asInt(json['maximumLength']),
    requiredApprovalMode: json['requiredApprovalMode'] as String,
    parentalGateEnabled: json['parentalGateEnabled'] as bool? ?? true,
    safetyScoreThreshold: asDoubleOrNull(json['safetyScoreThreshold']),
    interests: asStrings(json['interests']),
    allowedCategoryCodes: asStrings(json['allowedCategoryCodes']),
    restrictedCategoryCodes: asStrings(json['restrictedCategoryCodes']),
    blockedCategoryCodes: asStrings(json['blockedCategoryCodes']),
  );

  final int childProfileId;
  final String childNickname;
  final String ageBand;
  final int readingLevel;

  /// 'level_1' … 'level_5'
  final String defaultVocabularyLevel;
  final List<String> availableVocabularyLevels;
  final String defaultLanguage;
  final List<String> availableLanguages;
  final int maximumLength;
  final String requiredApprovalMode;
  final bool parentalGateEnabled;
  final double? safetyScoreThreshold;
  final List<String> interests;
  final List<String> allowedCategoryCodes;
  final List<String> restrictedCategoryCodes;
  final List<String> blockedCategoryCodes;
}

/// Ý tưởng phụ huynh nhập ở bước đầu của Studio.
class CreativeInput {
  const CreativeInput({
    required this.topic,
    required this.lesson,
    required this.vocabularyLevel,
    required this.targetLength,
    this.genre,
    this.characters = const [],
    this.setting,
    this.language,
  });

  final String topic;
  final String? genre;

  /// Để trống thì AI tự gợi ý nhân vật.
  final List<String> characters;

  /// Để trống thì AI tự gợi ý bối cảnh.
  final String? setting;
  final String lesson;
  final String vocabularyLevel;
  final String? language;
  final int targetLength;

  Json toJson() => {
    'topic': topic,
    'genre': ?genre,
    'characterMode': characters.isEmpty ? 'ai_suggested' : 'specified',
    'characters': characters,
    'settingMode': (setting ?? '').trim().isEmpty ? 'ai_suggested' : 'specified',
    'setting': ?setting,
    'lesson': lesson,
    'vocabularyLevel': vocabularyLevel,
    'language': ?language,
    'targetLength': targetLength,
  };
}

enum InputStatus {
  pendingInput('pending_input'),
  checkingInput('checking_input'),
  inputAccepted('input_accepted'),
  inputBlocked('input_blocked'),
  inputCheckFailed('input_check_failed');

  const InputStatus(this.apiValue);
  final String apiValue;

  static InputStatus parse(String? v) => values.firstWhere((s) => s.apiValue == v, orElse: () => pendingInput);
}

/// Tiến trình kiểm tra an toàn ý tưởng.
class InputProgress {
  const InputProgress({
    required this.requestId,
    required this.storyId,
    required this.status,
    required this.canRetry,
    required this.attemptCount,
    required this.maxAttempts,
    this.reasonCode,
    this.fallbackMessage,
  });

  factory InputProgress.fromJson(Json json) => InputProgress(
    requestId: asInt(json['requestId']),
    storyId: asInt(json['storyId']),
    status: InputStatus.parse(json['inputStatus'] as String?),
    canRetry: json['canRetry'] as bool? ?? false,
    attemptCount: asIntOrNull(json['attemptCount']) ?? 1,
    maxAttempts: asIntOrNull(json['maxAttempts']) ?? 1,
    reasonCode: json['reasonCode'] as String?,
    fallbackMessage: json['fallbackMessage'] as String?,
  );

  final int requestId;
  final int storyId;
  final InputStatus status;
  final bool canRetry;
  final int attemptCount;
  final int maxAttempts;
  final String? reasonCode;

  /// Lời giải thích thân thiện khi ý tưởng bị chặn.
  final String? fallbackMessage;
}

class OutlineVersion {
  const OutlineVersion({
    required this.id,
    required this.versionNo,
    required this.editType,
    required this.title,
    required this.opening,
    required this.development,
    required this.ending,
    required this.isCurrent,
    required this.createdAt,
    this.outlineApprovedAt,
  });

  factory OutlineVersion.fromJson(Json json) => OutlineVersion(
    id: asInt(json['id']),
    versionNo: asInt(json['versionNo']),
    editType: json['editType'] as String? ?? '',
    title: json['title'] as String? ?? '',
    opening: json['opening'] as String? ?? '',
    development: json['development'] as String? ?? '',
    ending: json['ending'] as String? ?? '',
    isCurrent: json['isCurrent'] as bool? ?? false,
    createdAt: asDate(json['createdAt']),
    outlineApprovedAt: asDateOrNull(json['outlineApprovedAt']),
  );

  final int id;
  final int versionNo;

  /// 'ai_generated' | 'manual'
  final String editType;
  final String title;
  final String opening;
  final String development;
  final String ending;
  final bool isCurrent;
  final DateTime createdAt;
  final DateTime? outlineApprovedAt;

  OutlineVersion copyWith({bool? isCurrent, DateTime? outlineApprovedAt}) => OutlineVersion(
    id: id,
    versionNo: versionNo,
    editType: editType,
    title: title,
    opening: opening,
    development: development,
    ending: ending,
    isCurrent: isCurrent ?? this.isCurrent,
    createdAt: createdAt,
    outlineApprovedAt: outlineApprovedAt ?? this.outlineApprovedAt,
  );

  Json toJson() => {
    'id': id,
    'versionNo': versionNo,
    'editType': editType,
    'title': title,
    'opening': opening,
    'development': development,
    'ending': ending,
    'isCurrent': isCurrent,
    'createdAt': createdAt.toIso8601String(),
    'outlineApprovedAt': outlineApprovedAt?.toIso8601String(),
  };
}

class OutlineProgress {
  const OutlineProgress({required this.storyId, required this.storyStatus, this.currentVersion, this.activeOperation, this.lastErrorCode});

  factory OutlineProgress.fromJson(Json json) => OutlineProgress(
    storyId: asInt(json['storyId']),
    storyStatus: json['storyStatus'] as String? ?? '',
    currentVersion: json['currentVersion'] == null ? null : OutlineVersion.fromJson(asJson(json['currentVersion'])),
    activeOperation: json['activeOperation'] as String?,
    lastErrorCode: json['lastErrorCode'] as String?,
  );

  final int storyId;
  final String storyStatus;
  final OutlineVersion? currentVersion;

  /// 'regenerate' khi AI đang viết lại dàn ý.
  final String? activeOperation;
  final String? lastErrorCode;
}

/// Tiến trình viết truyện và học liệu sau khi dàn ý được duyệt.
class GenerationProgress {
  const GenerationProgress({
    required this.storyId,
    required this.storyStatus,
    required this.currentStep,
    required this.content,
    required this.vocabulary,
    required this.quiz,
    required this.discussion,
    required this.isComplete,
    this.lastErrorCode,
    this.stableStoryVersionId,
  });

  factory GenerationProgress.fromJson(Json json) => GenerationProgress(
    storyId: asInt(json['storyId']),
    storyStatus: json['storyStatus'] as String? ?? '',
    currentStep: json['currentStep'] as String? ?? '',
    content: json['content'] as String? ?? 'pending',
    vocabulary: json['vocabulary'] as String? ?? 'pending',
    quiz: json['quiz'] as String? ?? 'pending',
    discussion: json['discussion'] as String? ?? 'pending',
    isComplete: json['isComplete'] as bool? ?? false,
    lastErrorCode: json['lastErrorCode'] as String?,
    stableStoryVersionId: asIntOrNull(json['stableStoryVersionId']),
  );

  final int storyId;
  final String storyStatus;

  /// 'not_started' | 'content' | 'learning_materials' | 'completed'
  final String currentStep;

  /// 'pending' | 'running' | 'stable'
  final String content;

  /// 'pending' | 'running' | 'completed' (giống cho quiz, discussion)
  final String vocabulary;
  final String quiz;
  final String discussion;
  final bool isComplete;
  final String? lastErrorCode;
  final int? stableStoryVersionId;
}

/// Tóm tắt bản thảo chờ duyệt.
class ReviewPackage {
  const ReviewPackage({
    required this.storyId,
    required this.storyVersionId,
    required this.storyStatus,
    required this.title,
    required this.content,
    required this.lesson,
    required this.vocabularyCount,
    required this.quizCount,
    required this.discussionCount,
    required this.canEdit,
    required this.canApprove,
    required this.canArchive,
    this.readabilityFkgl,
  });

  factory ReviewPackage.fromJson(Json json) => ReviewPackage(
    storyId: asInt(json['storyId']),
    storyVersionId: asInt(json['storyVersionId']),
    storyStatus: json['storyStatus'] as String? ?? '',
    title: json['title'] as String? ?? '',
    content: json['content'] as String? ?? '',
    lesson: json['lesson'] as String? ?? '',
    readabilityFkgl: asDoubleOrNull(json['readabilityFkgl']),
    vocabularyCount: asIntOrNull((json['vocabulary'] as Map?)?['itemCount']) ?? 0,
    quizCount: asIntOrNull((json['quiz'] as Map?)?['itemCount']) ?? 0,
    discussionCount: asIntOrNull((json['discussion'] as Map?)?['itemCount']) ?? 0,
    canEdit: json['canEdit'] as bool? ?? false,
    canApprove: json['canApprove'] as bool? ?? false,
    canArchive: json['canArchive'] as bool? ?? false,
  );

  final int storyId;
  final int storyVersionId;
  final String storyStatus;
  final String title;
  final String content;
  final String lesson;

  /// Độ khó Flesch–Kincaid.
  final double? readabilityFkgl;
  final int vocabularyCount;
  final int quizCount;
  final int discussionCount;
  final bool canEdit;
  final bool canApprove;
  final bool canArchive;

  bool get missingLearning => vocabularyCount == 0 || quizCount == 0 || discussionCount == 0;
}

class VocabularyItem {
  const VocabularyItem({required this.term, required this.definition, this.id});

  factory VocabularyItem.fromJson(Json json) =>
      VocabularyItem(id: asIntOrNull(json['id']), term: json['term'] as String, definition: json['definition'] as String? ?? '');

  final int? id;
  final String term;
  final String definition;

  Json toJson() => {'id': id, 'term': term, 'definition': definition};
}

class QuizQuestion {
  const QuizQuestion({required this.question, this.type = 'multiple_choice', this.correctAnswer, this.choices = const [], this.id});

  factory QuizQuestion.fromJson(Json json) => QuizQuestion(
    id: asIntOrNull(json['id']),
    type: json['type'] as String? ?? 'multiple_choice',
    question: json['question'] as String,
    correctAnswer: json['correctAnswer'] as String?,
    choices: asStrings(json['choices']),
  );

  final int? id;
  final String type;
  final String question;
  final String? correctAnswer;
  final List<String> choices;

  /// Dùng được trong câu đố của bé: có ít nhất 2 lựa chọn và có đáp án.
  bool get playable => choices.length > 1 && (correctAnswer ?? '').isNotEmpty;

  Json toJson() => {'id': id, 'type': type, 'question': question, 'correctAnswer': correctAnswer, 'choices': choices};
}

class DiscussionPrompt {
  const DiscussionPrompt({required this.question, this.isMoralLesson = false, this.id});

  factory DiscussionPrompt.fromJson(Json json) =>
      DiscussionPrompt(id: asIntOrNull(json['id']), question: json['question'] as String, isMoralLesson: json['isMoralLesson'] as bool? ?? false);

  final int? id;
  final String question;
  final bool isMoralLesson;

  Json toJson() => {'id': id, 'question': question, 'isMoralLesson': isMoralLesson};
}

class ValidationCheck {
  const ValidationCheck({required this.name, required this.passed, this.message});

  factory ValidationCheck.fromJson(Json json) =>
      ValidationCheck(name: json['name'] as String, passed: json['passed'] as bool? ?? false, message: json['message'] as String?);

  final String name;
  final bool passed;
  final String? message;
}

class ValidationResult {
  const ValidationResult({required this.canApprove, required this.checks, this.issues = const []});

  factory ValidationResult.fromJson(Json json) => ValidationResult(
    canApprove: json['canApprove'] as bool? ?? false,
    checks: asList(json['checks'], ValidationCheck.fromJson),
    issues: asStrings(json['issues']),
  );

  final bool canApprove;
  final List<ValidationCheck> checks;
  final List<String> issues;
}

/// Tiến trình tạo tranh minh hoạ và giọng đọc sau khi duyệt.
class MediaProgress {
  const MediaProgress({
    required this.storyId,
    required this.storyStatus,
    required this.sceneCount,
    required this.requiredIllustrations,
    required this.readyIllustrations,
    required this.readyAudio,
    required this.isReady,
    this.errorCode,
  });

  factory MediaProgress.fromJson(Json json) => MediaProgress(
    storyId: asInt(json['storyId']),
    storyStatus: json['storyStatus'] as String? ?? '',
    sceneCount: asIntOrNull(json['sceneCount']) ?? 0,
    requiredIllustrations: asIntOrNull(json['requiredIllustrations']) ?? 0,
    readyIllustrations: asIntOrNull(json['readyIllustrations']) ?? 0,
    readyAudio: asIntOrNull(json['readyAudio']) ?? 0,
    isReady: json['isReady'] as bool? ?? false,
    errorCode: json['errorCode'] as String?,
  );

  final int storyId;
  final String storyStatus;
  final int sceneCount;
  final int requiredIllustrations;
  final int readyIllustrations;
  final int readyAudio;
  final bool isReady;
  final String? errorCode;
}
