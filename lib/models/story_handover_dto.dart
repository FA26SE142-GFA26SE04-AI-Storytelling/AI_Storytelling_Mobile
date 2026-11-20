/// GET /ChildAccessCredential/story-handover?storyId=: bé nào đọc được truyện.
class StoryHandoverOptionsDto {
  const StoryHandoverOptionsDto({
    required this.storyId,
    required this.suggestedChildProfileId,
    required this.children,
  });

  factory StoryHandoverOptionsDto.fromJson(Map<String, dynamic> json) =>
      StoryHandoverOptionsDto(
        storyId: json['storyId'] as int? ?? 0,
        suggestedChildProfileId: json['suggestedChildProfileId'] as int?,
        children: [
          for (final c in json['children'] as List<dynamic>? ?? const [])
            StoryHandoverChildDto.fromJson(c as Map<String, dynamic>),
        ],
      );

  final int storyId;
  final int? suggestedChildProfileId;
  final List<StoryHandoverChildDto> children;

  /// Bé gợi ý lên đầu, rồi bé đọc được, cuối cùng bé chưa đọc được.
  List<StoryHandoverChildDto> get sorted {
    int rank(StoryHandoverChildDto c) =>
        (c.childProfileId == suggestedChildProfileId ? 0 : 2) +
        (c.canRead ? 0 : 1);
    return [...children]..sort((a, b) => rank(a).compareTo(rank(b)));
  }
}

class StoryHandoverChildDto {
  const StoryHandoverChildDto({
    required this.childProfileId,
    required this.nickname,
    required this.canRead,
    this.message,
  });

  factory StoryHandoverChildDto.fromJson(Map<String, dynamic> json) =>
      StoryHandoverChildDto(
        childProfileId: json['childProfileId'] as int,
        nickname: json['nickname'] as String? ?? '',
        canRead: json['canRead'] as bool? ?? false,
        message: json['message'] as String?,
      );

  final int childProfileId;
  final String nickname;
  final bool canRead;
  final String? message;
}

/// Một dòng trong AddRoadmapStoryResultDto.results (outcome Added/Skipped).
typedef RoadmapAddResult = ({int childProfileId, String outcome, String? message});
