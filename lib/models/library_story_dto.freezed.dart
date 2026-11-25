// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'library_story_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LibraryStoryDto {

 int get id; String get title; String? get description; String? get content; String? get coverImageUrl; String? get genre; String? get moralLesson; String get ageBand; String get source; String get status; bool get isPublished; String? get authorName; DateTime? get createdAt; int? get viewCount; int? get favoriteCount; bool? get hasQuiz;
/// Create a copy of LibraryStoryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LibraryStoryDtoCopyWith<LibraryStoryDto> get copyWith => _$LibraryStoryDtoCopyWithImpl<LibraryStoryDto>(this as LibraryStoryDto, _$identity);

  /// Serializes this LibraryStoryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as LibraryStoryDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LibraryStoryDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.content, _this.content) || other.content == _this.content)&&(identical(other.coverImageUrl, _this.coverImageUrl) || other.coverImageUrl == _this.coverImageUrl)&&(identical(other.genre, _this.genre) || other.genre == _this.genre)&&(identical(other.moralLesson, _this.moralLesson) || other.moralLesson == _this.moralLesson)&&(identical(other.ageBand, _this.ageBand) || other.ageBand == _this.ageBand)&&(identical(other.source, _this.source) || other.source == _this.source)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.isPublished, _this.isPublished) || other.isPublished == _this.isPublished)&&(identical(other.authorName, _this.authorName) || other.authorName == _this.authorName)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.viewCount, _this.viewCount) || other.viewCount == _this.viewCount)&&(identical(other.favoriteCount, _this.favoriteCount) || other.favoriteCount == _this.favoriteCount)&&(identical(other.hasQuiz, _this.hasQuiz) || other.hasQuiz == _this.hasQuiz));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as LibraryStoryDto;
  return Object.hash(runtimeType,_this.id,_this.title,_this.description,_this.content,_this.coverImageUrl,_this.genre,_this.moralLesson,_this.ageBand,_this.source,_this.status,_this.isPublished,_this.authorName,_this.createdAt,_this.viewCount,_this.favoriteCount,_this.hasQuiz);
}

@override
String toString() {
  final _this = this as LibraryStoryDto;
  return 'LibraryStoryDto(id: ${_this.id}, title: ${_this.title}, description: ${_this.description}, content: ${_this.content}, coverImageUrl: ${_this.coverImageUrl}, genre: ${_this.genre}, moralLesson: ${_this.moralLesson}, ageBand: ${_this.ageBand}, source: ${_this.source}, status: ${_this.status}, isPublished: ${_this.isPublished}, authorName: ${_this.authorName}, createdAt: ${_this.createdAt}, viewCount: ${_this.viewCount}, favoriteCount: ${_this.favoriteCount}, hasQuiz: ${_this.hasQuiz})';
}


}

/// @nodoc
abstract mixin class $LibraryStoryDtoCopyWith<$Res>  {
  factory $LibraryStoryDtoCopyWith(LibraryStoryDto value, $Res Function(LibraryStoryDto) _then) = _$LibraryStoryDtoCopyWithImpl;
@useResult
$Res call({
 int id, String title, String? description, String? content, String? coverImageUrl, String? genre, String? moralLesson, String ageBand, String source, String status, bool isPublished, String? authorName, DateTime? createdAt, int? viewCount, int? favoriteCount, bool? hasQuiz
});




}
/// @nodoc
class _$LibraryStoryDtoCopyWithImpl<$Res>
    implements $LibraryStoryDtoCopyWith<$Res> {
  _$LibraryStoryDtoCopyWithImpl(this._self, this._then);

  final LibraryStoryDto _self;
  final $Res Function(LibraryStoryDto) _then;

/// Create a copy of LibraryStoryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? content = freezed,Object? coverImageUrl = freezed,Object? genre = freezed,Object? moralLesson = freezed,Object? ageBand = null,Object? source = null,Object? status = null,Object? isPublished = null,Object? authorName = freezed,Object? createdAt = freezed,Object? viewCount = freezed,Object? favoriteCount = freezed,Object? hasQuiz = freezed,}) {
  return _then(LibraryStoryDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,genre: freezed == genre ? _self.genre : genre // ignore: cast_nullable_to_non_nullable
as String?,moralLesson: freezed == moralLesson ? _self.moralLesson : moralLesson // ignore: cast_nullable_to_non_nullable
as String?,ageBand: null == ageBand ? _self.ageBand : ageBand // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,isPublished: null == isPublished ? _self.isPublished : isPublished // ignore: cast_nullable_to_non_nullable
as bool,authorName: freezed == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,viewCount: freezed == viewCount ? _self.viewCount : viewCount // ignore: cast_nullable_to_non_nullable
as int?,favoriteCount: freezed == favoriteCount ? _self.favoriteCount : favoriteCount // ignore: cast_nullable_to_non_nullable
as int?,hasQuiz: freezed == hasQuiz ? _self.hasQuiz : hasQuiz // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [LibraryStoryDto].
extension LibraryStoryDtoPatterns on LibraryStoryDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LibraryStoryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LibraryStoryDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LibraryStoryDto value)  $default,){
final _that = this;
switch (_that) {
case _LibraryStoryDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LibraryStoryDto value)?  $default,){
final _that = this;
switch (_that) {
case _LibraryStoryDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String? description,  String? content,  String? coverImageUrl,  String? genre,  String? moralLesson,  String ageBand,  String source,  String status,  bool isPublished,  String? authorName,  DateTime? createdAt,  int? viewCount,  int? favoriteCount,  bool? hasQuiz)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LibraryStoryDto() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.content,_that.coverImageUrl,_that.genre,_that.moralLesson,_that.ageBand,_that.source,_that.status,_that.isPublished,_that.authorName,_that.createdAt,_that.viewCount,_that.favoriteCount,_that.hasQuiz);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String? description,  String? content,  String? coverImageUrl,  String? genre,  String? moralLesson,  String ageBand,  String source,  String status,  bool isPublished,  String? authorName,  DateTime? createdAt,  int? viewCount,  int? favoriteCount,  bool? hasQuiz)  $default,) {final _that = this;
switch (_that) {
case _LibraryStoryDto():
return $default(_that.id,_that.title,_that.description,_that.content,_that.coverImageUrl,_that.genre,_that.moralLesson,_that.ageBand,_that.source,_that.status,_that.isPublished,_that.authorName,_that.createdAt,_that.viewCount,_that.favoriteCount,_that.hasQuiz);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String? description,  String? content,  String? coverImageUrl,  String? genre,  String? moralLesson,  String ageBand,  String source,  String status,  bool isPublished,  String? authorName,  DateTime? createdAt,  int? viewCount,  int? favoriteCount,  bool? hasQuiz)?  $default,) {final _that = this;
switch (_that) {
case _LibraryStoryDto() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.content,_that.coverImageUrl,_that.genre,_that.moralLesson,_that.ageBand,_that.source,_that.status,_that.isPublished,_that.authorName,_that.createdAt,_that.viewCount,_that.favoriteCount,_that.hasQuiz);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LibraryStoryDto implements LibraryStoryDto {
  const _LibraryStoryDto({required this.id, this.title = '', this.description, this.content, this.coverImageUrl, this.genre, this.moralLesson, this.ageBand = '', this.source = '', this.status = '', this.isPublished = false, this.authorName, this.createdAt, this.viewCount, this.favoriteCount, this.hasQuiz});
  factory _LibraryStoryDto.fromJson(Map<String, dynamic> json) => _$LibraryStoryDtoFromJson(json);

@override final  int id;
@override@JsonKey() final  String title;
@override final  String? description;
@override final  String? content;
@override final  String? coverImageUrl;
@override final  String? genre;
@override final  String? moralLesson;
@override@JsonKey() final  String ageBand;
@override@JsonKey() final  String source;
@override@JsonKey() final  String status;
@override@JsonKey() final  bool isPublished;
@override final  String? authorName;
@override final  DateTime? createdAt;
@override final  int? viewCount;
@override final  int? favoriteCount;
@override final  bool? hasQuiz;

/// Create a copy of LibraryStoryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LibraryStoryDtoCopyWith<_LibraryStoryDto> get copyWith => __$LibraryStoryDtoCopyWithImpl<_LibraryStoryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LibraryStoryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LibraryStoryDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.content, content) || other.content == content)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.genre, genre) || other.genre == genre)&&(identical(other.moralLesson, moralLesson) || other.moralLesson == moralLesson)&&(identical(other.ageBand, ageBand) || other.ageBand == ageBand)&&(identical(other.source, source) || other.source == source)&&(identical(other.status, status) || other.status == status)&&(identical(other.isPublished, isPublished) || other.isPublished == isPublished)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.viewCount, viewCount) || other.viewCount == viewCount)&&(identical(other.favoriteCount, favoriteCount) || other.favoriteCount == favoriteCount)&&(identical(other.hasQuiz, hasQuiz) || other.hasQuiz == hasQuiz));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,description,content,coverImageUrl,genre,moralLesson,ageBand,source,status,isPublished,authorName,createdAt,viewCount,favoriteCount,hasQuiz);
}

@override
String toString() {
    return 'LibraryStoryDto(id: $id, title: $title, description: $description, content: $content, coverImageUrl: $coverImageUrl, genre: $genre, moralLesson: $moralLesson, ageBand: $ageBand, source: $source, status: $status, isPublished: $isPublished, authorName: $authorName, createdAt: $createdAt, viewCount: $viewCount, favoriteCount: $favoriteCount, hasQuiz: $hasQuiz)';
}


}

/// @nodoc
abstract mixin class _$LibraryStoryDtoCopyWith<$Res> implements $LibraryStoryDtoCopyWith<$Res> {
  factory _$LibraryStoryDtoCopyWith(_LibraryStoryDto value, $Res Function(_LibraryStoryDto) _then) = __$LibraryStoryDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String? description, String? content, String? coverImageUrl, String? genre, String? moralLesson, String ageBand, String source, String status, bool isPublished, String? authorName, DateTime? createdAt, int? viewCount, int? favoriteCount, bool? hasQuiz
});




}
/// @nodoc
class __$LibraryStoryDtoCopyWithImpl<$Res>
    implements _$LibraryStoryDtoCopyWith<$Res> {
  __$LibraryStoryDtoCopyWithImpl(this._self, this._then);

  final _LibraryStoryDto _self;
  final $Res Function(_LibraryStoryDto) _then;

/// Create a copy of LibraryStoryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? content = freezed,Object? coverImageUrl = freezed,Object? genre = freezed,Object? moralLesson = freezed,Object? ageBand = null,Object? source = null,Object? status = null,Object? isPublished = null,Object? authorName = freezed,Object? createdAt = freezed,Object? viewCount = freezed,Object? favoriteCount = freezed,Object? hasQuiz = freezed,}) {
  return _then(_LibraryStoryDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,genre: freezed == genre ? _self.genre : genre // ignore: cast_nullable_to_non_nullable
as String?,moralLesson: freezed == moralLesson ? _self.moralLesson : moralLesson // ignore: cast_nullable_to_non_nullable
as String?,ageBand: null == ageBand ? _self.ageBand : ageBand // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,isPublished: null == isPublished ? _self.isPublished : isPublished // ignore: cast_nullable_to_non_nullable
as bool,authorName: freezed == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,viewCount: freezed == viewCount ? _self.viewCount : viewCount // ignore: cast_nullable_to_non_nullable
as int?,favoriteCount: freezed == favoriteCount ? _self.favoriteCount : favoriteCount // ignore: cast_nullable_to_non_nullable
as int?,hasQuiz: freezed == hasQuiz ? _self.hasQuiz : hasQuiz // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}


/// @nodoc
mixin _$LibraryStoryPageDto {

 List<LibraryStoryDto> get items; int get totalCount; bool get hasNextPage;
/// Create a copy of LibraryStoryPageDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LibraryStoryPageDtoCopyWith<LibraryStoryPageDto> get copyWith => _$LibraryStoryPageDtoCopyWithImpl<LibraryStoryPageDto>(this as LibraryStoryPageDto, _$identity);

  /// Serializes this LibraryStoryPageDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as LibraryStoryPageDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LibraryStoryPageDto&&const DeepCollectionEquality().equals(other.items, _this.items)&&(identical(other.totalCount, _this.totalCount) || other.totalCount == _this.totalCount)&&(identical(other.hasNextPage, _this.hasNextPage) || other.hasNextPage == _this.hasNextPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as LibraryStoryPageDto;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.items),_this.totalCount,_this.hasNextPage);
}

@override
String toString() {
  final _this = this as LibraryStoryPageDto;
  return 'LibraryStoryPageDto(items: ${_this.items}, totalCount: ${_this.totalCount}, hasNextPage: ${_this.hasNextPage})';
}


}

/// @nodoc
abstract mixin class $LibraryStoryPageDtoCopyWith<$Res>  {
  factory $LibraryStoryPageDtoCopyWith(LibraryStoryPageDto value, $Res Function(LibraryStoryPageDto) _then) = _$LibraryStoryPageDtoCopyWithImpl;
@useResult
$Res call({
 List<LibraryStoryDto> items, int totalCount, bool hasNextPage
});




}
/// @nodoc
class _$LibraryStoryPageDtoCopyWithImpl<$Res>
    implements $LibraryStoryPageDtoCopyWith<$Res> {
  _$LibraryStoryPageDtoCopyWithImpl(this._self, this._then);

  final LibraryStoryPageDto _self;
  final $Res Function(LibraryStoryPageDto) _then;

/// Create a copy of LibraryStoryPageDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? totalCount = null,Object? hasNextPage = null,}) {
  return _then(LibraryStoryPageDto(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<LibraryStoryDto>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,hasNextPage: null == hasNextPage ? _self.hasNextPage : hasNextPage // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [LibraryStoryPageDto].
extension LibraryStoryPageDtoPatterns on LibraryStoryPageDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LibraryStoryPageDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LibraryStoryPageDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LibraryStoryPageDto value)  $default,){
final _that = this;
switch (_that) {
case _LibraryStoryPageDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LibraryStoryPageDto value)?  $default,){
final _that = this;
switch (_that) {
case _LibraryStoryPageDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<LibraryStoryDto> items,  int totalCount,  bool hasNextPage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LibraryStoryPageDto() when $default != null:
return $default(_that.items,_that.totalCount,_that.hasNextPage);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<LibraryStoryDto> items,  int totalCount,  bool hasNextPage)  $default,) {final _that = this;
switch (_that) {
case _LibraryStoryPageDto():
return $default(_that.items,_that.totalCount,_that.hasNextPage);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<LibraryStoryDto> items,  int totalCount,  bool hasNextPage)?  $default,) {final _that = this;
switch (_that) {
case _LibraryStoryPageDto() when $default != null:
return $default(_that.items,_that.totalCount,_that.hasNextPage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LibraryStoryPageDto implements LibraryStoryPageDto {
  const _LibraryStoryPageDto({ List<LibraryStoryDto> items = const <LibraryStoryDto>[], this.totalCount = 0, this.hasNextPage = false}): _items = items;
  factory _LibraryStoryPageDto.fromJson(Map<String, dynamic> json) => _$LibraryStoryPageDtoFromJson(json);

 final  List<LibraryStoryDto> _items;
@override@JsonKey() List<LibraryStoryDto> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey() final  int totalCount;
@override@JsonKey() final  bool hasNextPage;

/// Create a copy of LibraryStoryPageDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LibraryStoryPageDtoCopyWith<_LibraryStoryPageDto> get copyWith => __$LibraryStoryPageDtoCopyWithImpl<_LibraryStoryPageDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LibraryStoryPageDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LibraryStoryPageDto&&const DeepCollectionEquality().equals(other.items, _items)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.hasNextPage, hasNextPage) || other.hasNextPage == hasNextPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),totalCount,hasNextPage);
}

@override
String toString() {
    return 'LibraryStoryPageDto(items: $items, totalCount: $totalCount, hasNextPage: $hasNextPage)';
}


}

/// @nodoc
abstract mixin class _$LibraryStoryPageDtoCopyWith<$Res> implements $LibraryStoryPageDtoCopyWith<$Res> {
  factory _$LibraryStoryPageDtoCopyWith(_LibraryStoryPageDto value, $Res Function(_LibraryStoryPageDto) _then) = __$LibraryStoryPageDtoCopyWithImpl;
@override @useResult
$Res call({
 List<LibraryStoryDto> items, int totalCount, bool hasNextPage
});




}
/// @nodoc
class __$LibraryStoryPageDtoCopyWithImpl<$Res>
    implements _$LibraryStoryPageDtoCopyWith<$Res> {
  __$LibraryStoryPageDtoCopyWithImpl(this._self, this._then);

  final _LibraryStoryPageDto _self;
  final $Res Function(_LibraryStoryPageDto) _then;

/// Create a copy of LibraryStoryPageDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? totalCount = null,Object? hasNextPage = null,}) {
  return _then(_LibraryStoryPageDto(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<LibraryStoryDto>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,hasNextPage: null == hasNextPage ? _self.hasNextPage : hasNextPage // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$MediaIllustrationDto {

 int get beatOrder; String get status; String? get url;
/// Create a copy of MediaIllustrationDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MediaIllustrationDtoCopyWith<MediaIllustrationDto> get copyWith => _$MediaIllustrationDtoCopyWithImpl<MediaIllustrationDto>(this as MediaIllustrationDto, _$identity);

  /// Serializes this MediaIllustrationDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MediaIllustrationDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MediaIllustrationDto&&(identical(other.beatOrder, _this.beatOrder) || other.beatOrder == _this.beatOrder)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.url, _this.url) || other.url == _this.url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MediaIllustrationDto;
  return Object.hash(runtimeType,_this.beatOrder,_this.status,_this.url);
}

@override
String toString() {
  final _this = this as MediaIllustrationDto;
  return 'MediaIllustrationDto(beatOrder: ${_this.beatOrder}, status: ${_this.status}, url: ${_this.url})';
}


}

/// @nodoc
abstract mixin class $MediaIllustrationDtoCopyWith<$Res>  {
  factory $MediaIllustrationDtoCopyWith(MediaIllustrationDto value, $Res Function(MediaIllustrationDto) _then) = _$MediaIllustrationDtoCopyWithImpl;
@useResult
$Res call({
 int beatOrder, String status, String? url
});




}
/// @nodoc
class _$MediaIllustrationDtoCopyWithImpl<$Res>
    implements $MediaIllustrationDtoCopyWith<$Res> {
  _$MediaIllustrationDtoCopyWithImpl(this._self, this._then);

  final MediaIllustrationDto _self;
  final $Res Function(MediaIllustrationDto) _then;

/// Create a copy of MediaIllustrationDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? beatOrder = null,Object? status = null,Object? url = freezed,}) {
  return _then(MediaIllustrationDto(
beatOrder: null == beatOrder ? _self.beatOrder : beatOrder // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MediaIllustrationDto].
extension MediaIllustrationDtoPatterns on MediaIllustrationDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MediaIllustrationDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MediaIllustrationDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MediaIllustrationDto value)  $default,){
final _that = this;
switch (_that) {
case _MediaIllustrationDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MediaIllustrationDto value)?  $default,){
final _that = this;
switch (_that) {
case _MediaIllustrationDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int beatOrder,  String status,  String? url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MediaIllustrationDto() when $default != null:
return $default(_that.beatOrder,_that.status,_that.url);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int beatOrder,  String status,  String? url)  $default,) {final _that = this;
switch (_that) {
case _MediaIllustrationDto():
return $default(_that.beatOrder,_that.status,_that.url);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int beatOrder,  String status,  String? url)?  $default,) {final _that = this;
switch (_that) {
case _MediaIllustrationDto() when $default != null:
return $default(_that.beatOrder,_that.status,_that.url);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MediaIllustrationDto implements MediaIllustrationDto {
  const _MediaIllustrationDto({this.beatOrder = 0, this.status = '', this.url});
  factory _MediaIllustrationDto.fromJson(Map<String, dynamic> json) => _$MediaIllustrationDtoFromJson(json);

@override@JsonKey() final  int beatOrder;
@override@JsonKey() final  String status;
@override final  String? url;

/// Create a copy of MediaIllustrationDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MediaIllustrationDtoCopyWith<_MediaIllustrationDto> get copyWith => __$MediaIllustrationDtoCopyWithImpl<_MediaIllustrationDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MediaIllustrationDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MediaIllustrationDto&&(identical(other.beatOrder, beatOrder) || other.beatOrder == beatOrder)&&(identical(other.status, status) || other.status == status)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,beatOrder,status,url);
}

@override
String toString() {
    return 'MediaIllustrationDto(beatOrder: $beatOrder, status: $status, url: $url)';
}


}

/// @nodoc
abstract mixin class _$MediaIllustrationDtoCopyWith<$Res> implements $MediaIllustrationDtoCopyWith<$Res> {
  factory _$MediaIllustrationDtoCopyWith(_MediaIllustrationDto value, $Res Function(_MediaIllustrationDto) _then) = __$MediaIllustrationDtoCopyWithImpl;
@override @useResult
$Res call({
 int beatOrder, String status, String? url
});




}
/// @nodoc
class __$MediaIllustrationDtoCopyWithImpl<$Res>
    implements _$MediaIllustrationDtoCopyWith<$Res> {
  __$MediaIllustrationDtoCopyWithImpl(this._self, this._then);

  final _MediaIllustrationDto _self;
  final $Res Function(_MediaIllustrationDto) _then;

/// Create a copy of MediaIllustrationDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? beatOrder = null,Object? status = null,Object? url = freezed,}) {
  return _then(_MediaIllustrationDto(
beatOrder: null == beatOrder ? _self.beatOrder : beatOrder // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$MediaAudioDto {

 int get segmentOrder; String get text; String get status; String? get url;
/// Create a copy of MediaAudioDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MediaAudioDtoCopyWith<MediaAudioDto> get copyWith => _$MediaAudioDtoCopyWithImpl<MediaAudioDto>(this as MediaAudioDto, _$identity);

  /// Serializes this MediaAudioDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MediaAudioDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MediaAudioDto&&(identical(other.segmentOrder, _this.segmentOrder) || other.segmentOrder == _this.segmentOrder)&&(identical(other.text, _this.text) || other.text == _this.text)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.url, _this.url) || other.url == _this.url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MediaAudioDto;
  return Object.hash(runtimeType,_this.segmentOrder,_this.text,_this.status,_this.url);
}

@override
String toString() {
  final _this = this as MediaAudioDto;
  return 'MediaAudioDto(segmentOrder: ${_this.segmentOrder}, text: ${_this.text}, status: ${_this.status}, url: ${_this.url})';
}


}

/// @nodoc
abstract mixin class $MediaAudioDtoCopyWith<$Res>  {
  factory $MediaAudioDtoCopyWith(MediaAudioDto value, $Res Function(MediaAudioDto) _then) = _$MediaAudioDtoCopyWithImpl;
@useResult
$Res call({
 int segmentOrder, String text, String status, String? url
});




}
/// @nodoc
class _$MediaAudioDtoCopyWithImpl<$Res>
    implements $MediaAudioDtoCopyWith<$Res> {
  _$MediaAudioDtoCopyWithImpl(this._self, this._then);

  final MediaAudioDto _self;
  final $Res Function(MediaAudioDto) _then;

/// Create a copy of MediaAudioDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? segmentOrder = null,Object? text = null,Object? status = null,Object? url = freezed,}) {
  return _then(MediaAudioDto(
segmentOrder: null == segmentOrder ? _self.segmentOrder : segmentOrder // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MediaAudioDto].
extension MediaAudioDtoPatterns on MediaAudioDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MediaAudioDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MediaAudioDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MediaAudioDto value)  $default,){
final _that = this;
switch (_that) {
case _MediaAudioDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MediaAudioDto value)?  $default,){
final _that = this;
switch (_that) {
case _MediaAudioDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int segmentOrder,  String text,  String status,  String? url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MediaAudioDto() when $default != null:
return $default(_that.segmentOrder,_that.text,_that.status,_that.url);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int segmentOrder,  String text,  String status,  String? url)  $default,) {final _that = this;
switch (_that) {
case _MediaAudioDto():
return $default(_that.segmentOrder,_that.text,_that.status,_that.url);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int segmentOrder,  String text,  String status,  String? url)?  $default,) {final _that = this;
switch (_that) {
case _MediaAudioDto() when $default != null:
return $default(_that.segmentOrder,_that.text,_that.status,_that.url);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MediaAudioDto implements MediaAudioDto {
  const _MediaAudioDto({this.segmentOrder = 0, this.text = '', this.status = '', this.url});
  factory _MediaAudioDto.fromJson(Map<String, dynamic> json) => _$MediaAudioDtoFromJson(json);

@override@JsonKey() final  int segmentOrder;
@override@JsonKey() final  String text;
@override@JsonKey() final  String status;
@override final  String? url;

/// Create a copy of MediaAudioDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MediaAudioDtoCopyWith<_MediaAudioDto> get copyWith => __$MediaAudioDtoCopyWithImpl<_MediaAudioDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MediaAudioDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MediaAudioDto&&(identical(other.segmentOrder, segmentOrder) || other.segmentOrder == segmentOrder)&&(identical(other.text, text) || other.text == text)&&(identical(other.status, status) || other.status == status)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,segmentOrder,text,status,url);
}

@override
String toString() {
    return 'MediaAudioDto(segmentOrder: $segmentOrder, text: $text, status: $status, url: $url)';
}


}

/// @nodoc
abstract mixin class _$MediaAudioDtoCopyWith<$Res> implements $MediaAudioDtoCopyWith<$Res> {
  factory _$MediaAudioDtoCopyWith(_MediaAudioDto value, $Res Function(_MediaAudioDto) _then) = __$MediaAudioDtoCopyWithImpl;
@override @useResult
$Res call({
 int segmentOrder, String text, String status, String? url
});




}
/// @nodoc
class __$MediaAudioDtoCopyWithImpl<$Res>
    implements _$MediaAudioDtoCopyWith<$Res> {
  __$MediaAudioDtoCopyWithImpl(this._self, this._then);

  final _MediaAudioDto _self;
  final $Res Function(_MediaAudioDto) _then;

/// Create a copy of MediaAudioDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? segmentOrder = null,Object? text = null,Object? status = null,Object? url = freezed,}) {
  return _then(_MediaAudioDto(
segmentOrder: null == segmentOrder ? _self.segmentOrder : segmentOrder // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$MediaSceneDto {

 int get sceneIndex; String? get text; List<MediaIllustrationDto> get illustrations; List<MediaAudioDto> get audio;
/// Create a copy of MediaSceneDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MediaSceneDtoCopyWith<MediaSceneDto> get copyWith => _$MediaSceneDtoCopyWithImpl<MediaSceneDto>(this as MediaSceneDto, _$identity);

  /// Serializes this MediaSceneDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MediaSceneDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MediaSceneDto&&(identical(other.sceneIndex, _this.sceneIndex) || other.sceneIndex == _this.sceneIndex)&&(identical(other.text, _this.text) || other.text == _this.text)&&const DeepCollectionEquality().equals(other.illustrations, _this.illustrations)&&const DeepCollectionEquality().equals(other.audio, _this.audio));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MediaSceneDto;
  return Object.hash(runtimeType,_this.sceneIndex,_this.text,const DeepCollectionEquality().hash(_this.illustrations),const DeepCollectionEquality().hash(_this.audio));
}

@override
String toString() {
  final _this = this as MediaSceneDto;
  return 'MediaSceneDto(sceneIndex: ${_this.sceneIndex}, text: ${_this.text}, illustrations: ${_this.illustrations}, audio: ${_this.audio})';
}


}

/// @nodoc
abstract mixin class $MediaSceneDtoCopyWith<$Res>  {
  factory $MediaSceneDtoCopyWith(MediaSceneDto value, $Res Function(MediaSceneDto) _then) = _$MediaSceneDtoCopyWithImpl;
@useResult
$Res call({
 int sceneIndex, String? text, List<MediaIllustrationDto> illustrations, List<MediaAudioDto> audio
});




}
/// @nodoc
class _$MediaSceneDtoCopyWithImpl<$Res>
    implements $MediaSceneDtoCopyWith<$Res> {
  _$MediaSceneDtoCopyWithImpl(this._self, this._then);

  final MediaSceneDto _self;
  final $Res Function(MediaSceneDto) _then;

/// Create a copy of MediaSceneDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sceneIndex = null,Object? text = freezed,Object? illustrations = null,Object? audio = null,}) {
  return _then(MediaSceneDto(
sceneIndex: null == sceneIndex ? _self.sceneIndex : sceneIndex // ignore: cast_nullable_to_non_nullable
as int,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,illustrations: null == illustrations ? _self.illustrations : illustrations // ignore: cast_nullable_to_non_nullable
as List<MediaIllustrationDto>,audio: null == audio ? _self.audio : audio // ignore: cast_nullable_to_non_nullable
as List<MediaAudioDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [MediaSceneDto].
extension MediaSceneDtoPatterns on MediaSceneDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MediaSceneDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MediaSceneDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MediaSceneDto value)  $default,){
final _that = this;
switch (_that) {
case _MediaSceneDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MediaSceneDto value)?  $default,){
final _that = this;
switch (_that) {
case _MediaSceneDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int sceneIndex,  String? text,  List<MediaIllustrationDto> illustrations,  List<MediaAudioDto> audio)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MediaSceneDto() when $default != null:
return $default(_that.sceneIndex,_that.text,_that.illustrations,_that.audio);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int sceneIndex,  String? text,  List<MediaIllustrationDto> illustrations,  List<MediaAudioDto> audio)  $default,) {final _that = this;
switch (_that) {
case _MediaSceneDto():
return $default(_that.sceneIndex,_that.text,_that.illustrations,_that.audio);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int sceneIndex,  String? text,  List<MediaIllustrationDto> illustrations,  List<MediaAudioDto> audio)?  $default,) {final _that = this;
switch (_that) {
case _MediaSceneDto() when $default != null:
return $default(_that.sceneIndex,_that.text,_that.illustrations,_that.audio);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MediaSceneDto implements MediaSceneDto {
  const _MediaSceneDto({this.sceneIndex = 0, this.text,  List<MediaIllustrationDto> illustrations = const <MediaIllustrationDto>[],  List<MediaAudioDto> audio = const <MediaAudioDto>[]}): _illustrations = illustrations,_audio = audio;
  factory _MediaSceneDto.fromJson(Map<String, dynamic> json) => _$MediaSceneDtoFromJson(json);

@override@JsonKey() final  int sceneIndex;
@override final  String? text;
 final  List<MediaIllustrationDto> _illustrations;
@override@JsonKey() List<MediaIllustrationDto> get illustrations {
  if (_illustrations is EqualUnmodifiableListView) return _illustrations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_illustrations);
}

 final  List<MediaAudioDto> _audio;
@override@JsonKey() List<MediaAudioDto> get audio {
  if (_audio is EqualUnmodifiableListView) return _audio;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_audio);
}


/// Create a copy of MediaSceneDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MediaSceneDtoCopyWith<_MediaSceneDto> get copyWith => __$MediaSceneDtoCopyWithImpl<_MediaSceneDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MediaSceneDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MediaSceneDto&&(identical(other.sceneIndex, sceneIndex) || other.sceneIndex == sceneIndex)&&(identical(other.text, text) || other.text == text)&&const DeepCollectionEquality().equals(other.illustrations, _illustrations)&&const DeepCollectionEquality().equals(other.audio, _audio));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,sceneIndex,text,const DeepCollectionEquality().hash(_illustrations),const DeepCollectionEquality().hash(_audio));
}

@override
String toString() {
    return 'MediaSceneDto(sceneIndex: $sceneIndex, text: $text, illustrations: $illustrations, audio: $audio)';
}


}

/// @nodoc
abstract mixin class _$MediaSceneDtoCopyWith<$Res> implements $MediaSceneDtoCopyWith<$Res> {
  factory _$MediaSceneDtoCopyWith(_MediaSceneDto value, $Res Function(_MediaSceneDto) _then) = __$MediaSceneDtoCopyWithImpl;
@override @useResult
$Res call({
 int sceneIndex, String? text, List<MediaIllustrationDto> illustrations, List<MediaAudioDto> audio
});




}
/// @nodoc
class __$MediaSceneDtoCopyWithImpl<$Res>
    implements _$MediaSceneDtoCopyWith<$Res> {
  __$MediaSceneDtoCopyWithImpl(this._self, this._then);

  final _MediaSceneDto _self;
  final $Res Function(_MediaSceneDto) _then;

/// Create a copy of MediaSceneDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sceneIndex = null,Object? text = freezed,Object? illustrations = null,Object? audio = null,}) {
  return _then(_MediaSceneDto(
sceneIndex: null == sceneIndex ? _self.sceneIndex : sceneIndex // ignore: cast_nullable_to_non_nullable
as int,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,illustrations: null == illustrations ? _self._illustrations : illustrations // ignore: cast_nullable_to_non_nullable
as List<MediaIllustrationDto>,audio: null == audio ? _self._audio : audio // ignore: cast_nullable_to_non_nullable
as List<MediaAudioDto>,
  ));
}


}


/// @nodoc
mixin _$StoryMediaPackageDto {

 List<MediaSceneDto> get scenes;
/// Create a copy of StoryMediaPackageDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoryMediaPackageDtoCopyWith<StoryMediaPackageDto> get copyWith => _$StoryMediaPackageDtoCopyWithImpl<StoryMediaPackageDto>(this as StoryMediaPackageDto, _$identity);

  /// Serializes this StoryMediaPackageDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as StoryMediaPackageDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StoryMediaPackageDto&&const DeepCollectionEquality().equals(other.scenes, _this.scenes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as StoryMediaPackageDto;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.scenes));
}

@override
String toString() {
  final _this = this as StoryMediaPackageDto;
  return 'StoryMediaPackageDto(scenes: ${_this.scenes})';
}


}

/// @nodoc
abstract mixin class $StoryMediaPackageDtoCopyWith<$Res>  {
  factory $StoryMediaPackageDtoCopyWith(StoryMediaPackageDto value, $Res Function(StoryMediaPackageDto) _then) = _$StoryMediaPackageDtoCopyWithImpl;
@useResult
$Res call({
 List<MediaSceneDto> scenes
});




}
/// @nodoc
class _$StoryMediaPackageDtoCopyWithImpl<$Res>
    implements $StoryMediaPackageDtoCopyWith<$Res> {
  _$StoryMediaPackageDtoCopyWithImpl(this._self, this._then);

  final StoryMediaPackageDto _self;
  final $Res Function(StoryMediaPackageDto) _then;

/// Create a copy of StoryMediaPackageDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? scenes = null,}) {
  return _then(StoryMediaPackageDto(
scenes: null == scenes ? _self.scenes : scenes // ignore: cast_nullable_to_non_nullable
as List<MediaSceneDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [StoryMediaPackageDto].
extension StoryMediaPackageDtoPatterns on StoryMediaPackageDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StoryMediaPackageDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StoryMediaPackageDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StoryMediaPackageDto value)  $default,){
final _that = this;
switch (_that) {
case _StoryMediaPackageDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StoryMediaPackageDto value)?  $default,){
final _that = this;
switch (_that) {
case _StoryMediaPackageDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<MediaSceneDto> scenes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StoryMediaPackageDto() when $default != null:
return $default(_that.scenes);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<MediaSceneDto> scenes)  $default,) {final _that = this;
switch (_that) {
case _StoryMediaPackageDto():
return $default(_that.scenes);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<MediaSceneDto> scenes)?  $default,) {final _that = this;
switch (_that) {
case _StoryMediaPackageDto() when $default != null:
return $default(_that.scenes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StoryMediaPackageDto implements StoryMediaPackageDto {
  const _StoryMediaPackageDto({ List<MediaSceneDto> scenes = const <MediaSceneDto>[]}): _scenes = scenes;
  factory _StoryMediaPackageDto.fromJson(Map<String, dynamic> json) => _$StoryMediaPackageDtoFromJson(json);

 final  List<MediaSceneDto> _scenes;
@override@JsonKey() List<MediaSceneDto> get scenes {
  if (_scenes is EqualUnmodifiableListView) return _scenes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_scenes);
}


/// Create a copy of StoryMediaPackageDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StoryMediaPackageDtoCopyWith<_StoryMediaPackageDto> get copyWith => __$StoryMediaPackageDtoCopyWithImpl<_StoryMediaPackageDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StoryMediaPackageDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StoryMediaPackageDto&&const DeepCollectionEquality().equals(other.scenes, _scenes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_scenes));
}

@override
String toString() {
    return 'StoryMediaPackageDto(scenes: $scenes)';
}


}

/// @nodoc
abstract mixin class _$StoryMediaPackageDtoCopyWith<$Res> implements $StoryMediaPackageDtoCopyWith<$Res> {
  factory _$StoryMediaPackageDtoCopyWith(_StoryMediaPackageDto value, $Res Function(_StoryMediaPackageDto) _then) = __$StoryMediaPackageDtoCopyWithImpl;
@override @useResult
$Res call({
 List<MediaSceneDto> scenes
});




}
/// @nodoc
class __$StoryMediaPackageDtoCopyWithImpl<$Res>
    implements _$StoryMediaPackageDtoCopyWith<$Res> {
  __$StoryMediaPackageDtoCopyWithImpl(this._self, this._then);

  final _StoryMediaPackageDto _self;
  final $Res Function(_StoryMediaPackageDto) _then;

/// Create a copy of StoryMediaPackageDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? scenes = null,}) {
  return _then(_StoryMediaPackageDto(
scenes: null == scenes ? _self._scenes : scenes // ignore: cast_nullable_to_non_nullable
as List<MediaSceneDto>,
  ));
}


}

// dart format on
