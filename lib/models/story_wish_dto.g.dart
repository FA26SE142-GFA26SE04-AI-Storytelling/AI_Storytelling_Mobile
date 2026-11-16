// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_wish_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChildWishCard _$ChildWishCardFromJson(Map<String, dynamic> json) =>
    _ChildWishCard(
      id: (json['id'] as num).toInt(),
      group: json['group'] as String,
      label: json['label'] as String,
      imageUrl: json['imageUrl'] as String,
      audioUrl: json['audioUrl'] as String?,
    );

Map<String, dynamic> _$ChildWishCardToJson(_ChildWishCard instance) =>
    <String, dynamic>{
      'id': instance.id,
      'group': instance.group,
      'label': instance.label,
      'imageUrl': instance.imageUrl,
      'audioUrl': instance.audioUrl,
    };

_WishSuggestion _$WishSuggestionFromJson(Map<String, dynamic> json) =>
    _WishSuggestion(
      rank: (json['rank'] as num).toInt(),
      storyId: (json['storyId'] as num?)?.toInt(),
      communitySubmissionId: (json['communitySubmissionId'] as num?)?.toInt(),
      title: json['title'] as String,
      coverImageUrl: json['coverImageUrl'] as String?,
      matchedCards:
          (json['matchedCards'] as List<dynamic>?)
              ?.map((e) => ChildWishCard.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ChildWishCard>[],
    );

Map<String, dynamic> _$WishSuggestionToJson(_WishSuggestion instance) =>
    <String, dynamic>{
      'rank': instance.rank,
      'storyId': instance.storyId,
      'communitySubmissionId': instance.communitySubmissionId,
      'title': instance.title,
      'coverImageUrl': instance.coverImageUrl,
      'matchedCards': instance.matchedCards,
    };

_WishDraft _$WishDraftFromJson(Map<String, dynamic> json) => _WishDraft(
  wishId: (json['wishId'] as num).toInt(),
  resumed: json['resumed'] as bool,
  expiresAt: json['expiresAt'] as String,
  cards:
      (json['cards'] as List<dynamic>?)
          ?.map((e) => ChildWishCard.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ChildWishCard>[],
  lessonLeftToParent: json['lessonLeftToParent'] as bool,
  canSubmit: json['canSubmit'] as bool,
);

Map<String, dynamic> _$WishDraftToJson(_WishDraft instance) =>
    <String, dynamic>{
      'wishId': instance.wishId,
      'resumed': instance.resumed,
      'expiresAt': instance.expiresAt,
      'cards': instance.cards,
      'lessonLeftToParent': instance.lessonLeftToParent,
      'canSubmit': instance.canSubmit,
    };

_StoryWish _$StoryWishFromJson(Map<String, dynamic> json) => _StoryWish(
  wishId: (json['wishId'] as num).toInt(),
  kind: json['kind'] as String,
  status: json['status'] as String,
  message: json['message'] as String,
  cards:
      (json['cards'] as List<dynamic>?)
          ?.map((e) => ChildWishCard.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ChildWishCard>[],
  lessonLeftToParent: json['lessonLeftToParent'] as bool,
  fulfilledStoryId: (json['fulfilledStoryId'] as num?)?.toInt(),
  submittedAt: json['submittedAt'] as String?,
  suggestions:
      (json['suggestions'] as List<dynamic>?)
          ?.map((e) => WishSuggestion.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <WishSuggestion>[],
);

Map<String, dynamic> _$StoryWishToJson(_StoryWish instance) =>
    <String, dynamic>{
      'wishId': instance.wishId,
      'kind': instance.kind,
      'status': instance.status,
      'message': instance.message,
      'cards': instance.cards,
      'lessonLeftToParent': instance.lessonLeftToParent,
      'fulfilledStoryId': instance.fulfilledStoryId,
      'submittedAt': instance.submittedAt,
      'suggestions': instance.suggestions,
    };

_SelectWishCardRequest _$SelectWishCardRequestFromJson(
  Map<String, dynamic> json,
) => _SelectWishCardRequest(
  group: json['group'] as String,
  cardId: (json['cardId'] as num?)?.toInt(),
  leaveToParent: json['leaveToParent'] as bool? ?? false,
);

Map<String, dynamic> _$SelectWishCardRequestToJson(
  _SelectWishCardRequest instance,
) => <String, dynamic>{
  'group': instance.group,
  'cardId': instance.cardId,
  'leaveToParent': instance.leaveToParent,
};

_ParentWish _$ParentWishFromJson(Map<String, dynamic> json) => _ParentWish(
  wishId: (json['wishId'] as num).toInt(),
  childProfileId: (json['childProfileId'] as num?)?.toInt() ?? 0,
  kind: json['kind'] as String? ?? '',
  status: json['status'] as String? ?? '',
  cards:
      (json['cards'] as List<dynamic>?)
          ?.map((e) => ChildWishCard.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ChildWishCard>[],
  lessonLeftToParent: json['lessonLeftToParent'] as bool? ?? false,
  submittedAt: json['submittedAt'] == null
      ? null
      : DateTime.parse(json['submittedAt'] as String),
  expiresAt: json['expiresAt'] == null
      ? null
      : DateTime.parse(json['expiresAt'] as String),
  declineReason: json['declineReason'] as String?,
  generatedStoryId: (json['generatedStoryId'] as num?)?.toInt(),
  fulfilledStoryId: (json['fulfilledStoryId'] as num?)?.toInt(),
  fulfilledWithExistingStory:
      json['fulfilledWithExistingStory'] as bool? ?? false,
  resolvedAt: json['resolvedAt'] == null
      ? null
      : DateTime.parse(json['resolvedAt'] as String),
);

Map<String, dynamic> _$ParentWishToJson(_ParentWish instance) =>
    <String, dynamic>{
      'wishId': instance.wishId,
      'childProfileId': instance.childProfileId,
      'kind': instance.kind,
      'status': instance.status,
      'cards': instance.cards,
      'lessonLeftToParent': instance.lessonLeftToParent,
      'submittedAt': instance.submittedAt?.toIso8601String(),
      'expiresAt': instance.expiresAt?.toIso8601String(),
      'declineReason': instance.declineReason,
      'generatedStoryId': instance.generatedStoryId,
      'fulfilledStoryId': instance.fulfilledStoryId,
      'fulfilledWithExistingStory': instance.fulfilledWithExistingStory,
      'resolvedAt': instance.resolvedAt?.toIso8601String(),
    };
