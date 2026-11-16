import 'package:freezed_annotation/freezed_annotation.dart';

part 'story_wish_dto.freezed.dart';
part 'story_wish_dto.g.dart';

/// Thẻ gợi ý mong ước của bé
@freezed
abstract class ChildWishCard with _$ChildWishCard {
  const factory ChildWishCard({
    required int id,
    required String group,
    required String label,
    required String imageUrl,
    String? audioUrl,
  }) = _ChildWishCard;

  factory ChildWishCard.fromJson(Map<String, dynamic> json) =>
      _$ChildWishCardFromJson(json);
}

/// Gợi ý truyện phù hợp với mong ước
@freezed
abstract class WishSuggestion with _$WishSuggestion {
  const factory WishSuggestion({
    required int rank,
    int? storyId,
    int? communitySubmissionId,
    required String title,
    String? coverImageUrl,
    @Default(<ChildWishCard>[]) List<ChildWishCard> matchedCards,
  }) = _WishSuggestion;

  factory WishSuggestion.fromJson(Map<String, dynamic> json) =>
      _$WishSuggestionFromJson(json);
}

/// Bản nháp mong ước truyện của bé
@freezed
abstract class WishDraft with _$WishDraft {
  const factory WishDraft({
    required int wishId,
    required bool resumed,
    required String expiresAt,
    @Default(<ChildWishCard>[]) List<ChildWishCard> cards,
    required bool lessonLeftToParent,
    required bool canSubmit,
  }) = _WishDraft;

  factory WishDraft.fromJson(Map<String, dynamic> json) =>
      _$WishDraftFromJson(json);
}

/// Mong ước truyện hoàn chỉnh và trạng thái xử lý
@freezed
abstract class StoryWish with _$StoryWish {
  const factory StoryWish({
    required int wishId,
    required String kind,
    required String status,
    required String message,
    @Default(<ChildWishCard>[]) List<ChildWishCard> cards,
    required bool lessonLeftToParent,
    int? fulfilledStoryId,
    String? submittedAt,
    @Default(<WishSuggestion>[]) List<WishSuggestion> suggestions,
  }) = _StoryWish;

  factory StoryWish.fromJson(Map<String, dynamic> json) =>
      _$StoryWishFromJson(json);
}

/// Yêu cầu chọn thẻ mong ước khi gửi cập nhật
@freezed
abstract class SelectWishCardRequest with _$SelectWishCardRequest {
  const factory SelectWishCardRequest({
    required String group,
    int? cardId,
    @Default(false) bool leaveToParent,
  }) = _SelectWishCardRequest;

  factory SelectWishCardRequest.fromJson(Map<String, dynamic> json) =>
      _$SelectWishCardRequestFromJson(json);
}

/// Điều ước của bé như phụ huynh thấy (GET /parent/wishes?childProfileId=).
@freezed
abstract class ParentWish with _$ParentWish {
  const factory ParentWish({
    required int wishId,
    @Default(0) int childProfileId,
    @Default('') String kind,
    /// Pending, Accepted, Fulfilled, Declined, Expired, Cancelled.
    @Default('') String status,
    @Default(<ChildWishCard>[]) List<ChildWishCard> cards,
    @Default(false) bool lessonLeftToParent,
    DateTime? submittedAt,
    /// Hạn xử lý, chỉ có khi đang Pending.
    DateTime? expiresAt,
    String? declineReason,
    int? generatedStoryId,
    int? fulfilledStoryId,
    @Default(false) bool fulfilledWithExistingStory,
    DateTime? resolvedAt,
  }) = _ParentWish;

  factory ParentWish.fromJson(Map<String, dynamic> json) =>
      _$ParentWishFromJson(json);
}
