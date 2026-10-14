import '../json.dart';

class StoryPage {
  const StoryPage({required this.pageNumber, required this.content, this.id, this.imageUrl, this.audioUrl});

  factory StoryPage.fromJson(Json json) => StoryPage(
    id: asIntOrNull(json['id']),
    pageNumber: asInt(json['pageNumber']),
    content: json['content'] as String? ?? '',
    imageUrl: json['imageUrl'] as String?,
    audioUrl: json['audioUrl'] as String?,
  );

  final int? id;
  final int pageNumber;
  final String content;
  final String? imageUrl;
  final String? audioUrl;
}

/// Truyện (GET /Story, GET /Story/{id}).
class Story {
  const Story({
    required this.id,
    required this.title,
    required this.ageBand,
    required this.status,
    required this.isPublished,
    required this.createdAt,
    this.synopsis,
    this.content,
    this.coverImageUrl,
    this.genre,
    this.moralLesson,
    this.language,
    this.source,
    this.authorName,
    this.childProfileId,
    this.categoryName,
    this.pages = const [],
  });

  factory Story.fromJson(Json json) => Story(
    id: asInt(json['id']),
    title: json['title'] as String? ?? '',
    ageBand: json['ageBand'] as String? ?? '',
    status: json['status'] as String? ?? 'draft',
    isPublished: json['isPublished'] as bool? ?? false,
    createdAt: asDate(json['createdAt']),
    synopsis: json['synopsis'] as String? ?? json['description'] as String?,
    content: json['content'] as String?,
    coverImageUrl: json['coverImageUrl'] as String?,
    genre: json['genre'] as String?,
    moralLesson: json['moralLesson'] as String?,
    language: json['language'] as String?,
    source: json['source'] as String?,
    authorName: json['authorName'] as String?,
    childProfileId: asIntOrNull(json['childProfileId']),
    categoryName: json['categoryName'] as String?,
    pages: asList(json['pages'], StoryPage.fromJson)..sort((a, b) => a.pageNumber.compareTo(b.pageNumber)),
  );

  final int id;
  final String title;
  final String ageBand;
  final String status;
  final bool isPublished;
  final DateTime createdAt;
  final String? synopsis;
  final String? content;
  final String? coverImageUrl;
  final String? genre;
  final String? moralLesson;
  final String? language;

  /// 'AI' khi truyện do AI tạo.
  final String? source;
  final String? authorName;
  final int? childProfileId;
  final String? categoryName;
  final List<StoryPage> pages;

  bool get fromAi => (source ?? '').toLowerCase().contains('ai');
}

class PagedResult<T> {
  const PagedResult({required this.items, required this.totalCount, required this.pageNumber, required this.pageSize, required this.hasNextPage});

  factory PagedResult.fromJson(Json json, T Function(Json json) parse) => PagedResult(
    items: asList(json['items'], parse),
    totalCount: asInt(json['totalCount']),
    pageNumber: asInt(json['pageNumber']),
    pageSize: asInt(json['pageSize']),
    hasNextPage: json['hasNextPage'] as bool? ?? false,
  );

  final List<T> items;
  final int totalCount;
  final int pageNumber;
  final int pageSize;
  final bool hasNextPage;
}

/// Bộ lọc danh sách truyện (query của GET /Story).
class StoryFilter {
  const StoryFilter({
    this.childProfileId,
    this.search,
    this.ageBand,
    this.categoryId,
    this.status,
    this.sortBy = 'createdAt',
    this.sortDescending = true,
    this.pageNumber = 1,
    this.pageSize = 100,
  });

  final int? childProfileId;
  final String? search;
  final String? ageBand;
  final int? categoryId;
  final String? status;
  final String sortBy;
  final bool sortDescending;
  final int pageNumber;
  final int pageSize;

  Map<String, dynamic> toQuery() => {
    if (search != null && search!.trim().isNotEmpty) 'search': search!.trim(),
    'ageBand': ?ageBand,
    'categoryId': ?categoryId,
    'status': ?status,
    'childProfileId': ?childProfileId,
    'sortBy': sortBy,
    'sortDescending': sortDescending,
    'pageNumber': pageNumber,
    'pageSize': pageSize,
  };
}
