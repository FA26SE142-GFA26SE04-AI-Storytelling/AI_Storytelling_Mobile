import 'package:freezed_annotation/freezed_annotation.dart';

part 'library_story_dto.freezed.dart';
part 'library_story_dto.g.dart';

/// Một truyện của GET /Story hoặc GET /Story/community (bản community có thêm số lượt).
@freezed
abstract class LibraryStoryDto with _$LibraryStoryDto {
  const factory LibraryStoryDto({
    required int id,
    @Default('') String title,
    String? description,
    String? content,
    String? coverImageUrl,
    String? genre,
    String? moralLesson,
    @Default('') String ageBand,
    @Default('') String source,
    @Default('') String status,
    @Default(false) bool isPublished,
    int? authorUserId,
    String? authorName,
    DateTime? createdAt,
    int? viewCount,
    int? favoriteCount,
    // Chỉ GET /Story/community trả; thiếu trường (null) thì không hiện icon câu đố.
    bool? hasQuiz,
  }) = _LibraryStoryDto;

  factory LibraryStoryDto.fromJson(Map<String, dynamic> json) =>
      _$LibraryStoryDtoFromJson(json);
}

@freezed
abstract class LibraryStoryPageDto with _$LibraryStoryPageDto {
  const factory LibraryStoryPageDto({
    @Default(<LibraryStoryDto>[]) List<LibraryStoryDto> items,
    @Default(0) int totalCount,
    @Default(false) bool hasNextPage,
  }) = _LibraryStoryPageDto;

  factory LibraryStoryPageDto.fromJson(Map<String, dynamic> json) =>
      _$LibraryStoryPageDtoFromJson(json);
}

/// Tranh minh hoạ của một cảnh (gói media).
@freezed
abstract class MediaIllustrationDto with _$MediaIllustrationDto {
  const factory MediaIllustrationDto({
    @Default(0) int beatOrder,
    @Default('') String status,
    String? url,
  }) = _MediaIllustrationDto;

  factory MediaIllustrationDto.fromJson(Map<String, dynamic> json) =>
      _$MediaIllustrationDtoFromJson(json);
}

/// Một đoạn giọng đọc của cảnh (gói media).
@freezed
abstract class MediaAudioDto with _$MediaAudioDto {
  const factory MediaAudioDto({
    @Default(0) int segmentOrder,
    @Default('') String text,
    @Default('') String status,
    String? url,
  }) = _MediaAudioDto;

  factory MediaAudioDto.fromJson(Map<String, dynamic> json) =>
      _$MediaAudioDtoFromJson(json);
}

@freezed
abstract class MediaSceneDto with _$MediaSceneDto {
  const factory MediaSceneDto({
    @Default(0) int sceneIndex,
    String? text,
    @Default(<MediaIllustrationDto>[]) List<MediaIllustrationDto> illustrations,
    @Default(<MediaAudioDto>[]) List<MediaAudioDto> audio,
  }) = _MediaSceneDto;

  factory MediaSceneDto.fromJson(Map<String, dynamic> json) =>
      _$MediaSceneDtoFromJson(json);
}

/// Gói media của truyện: /stories/{id}/media/package hoặc /Story/community/{id}/media.
@freezed
abstract class StoryMediaPackageDto with _$StoryMediaPackageDto {
  const factory StoryMediaPackageDto({
    @Default(<MediaSceneDto>[]) List<MediaSceneDto> scenes,
  }) = _StoryMediaPackageDto;

  factory StoryMediaPackageDto.fromJson(Map<String, dynamic> json) =>
      _$StoryMediaPackageDtoFromJson(json);
}
