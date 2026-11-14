// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'child_reading_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChildStory {

 int get storyId; String get title; String? get coverImageUrl; String? get description; String get source;
/// Create a copy of ChildStory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChildStoryCopyWith<ChildStory> get copyWith => _$ChildStoryCopyWithImpl<ChildStory>(this as ChildStory, _$identity);

  /// Serializes this ChildStory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ChildStory;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChildStory&&(identical(other.storyId, _this.storyId) || other.storyId == _this.storyId)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.coverImageUrl, _this.coverImageUrl) || other.coverImageUrl == _this.coverImageUrl)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.source, _this.source) || other.source == _this.source));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChildStory;
  return Object.hash(runtimeType,_this.storyId,_this.title,_this.coverImageUrl,_this.description,_this.source);
}

@override
String toString() {
  final _this = this as ChildStory;
  return 'ChildStory(storyId: ${_this.storyId}, title: ${_this.title}, coverImageUrl: ${_this.coverImageUrl}, description: ${_this.description}, source: ${_this.source})';
}


}

/// @nodoc
abstract mixin class $ChildStoryCopyWith<$Res>  {
  factory $ChildStoryCopyWith(ChildStory value, $Res Function(ChildStory) _then) = _$ChildStoryCopyWithImpl;
@useResult
$Res call({
 int storyId, String title, String? coverImageUrl, String? description, String source
});




}
/// @nodoc
class _$ChildStoryCopyWithImpl<$Res>
    implements $ChildStoryCopyWith<$Res> {
  _$ChildStoryCopyWithImpl(this._self, this._then);

  final ChildStory _self;
  final $Res Function(ChildStory) _then;

/// Create a copy of ChildStory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? storyId = null,Object? title = null,Object? coverImageUrl = freezed,Object? description = freezed,Object? source = null,}) {
  return _then(ChildStory(
storyId: null == storyId ? _self.storyId : storyId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ChildStory].
extension ChildStoryPatterns on ChildStory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChildStory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChildStory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChildStory value)  $default,){
final _that = this;
switch (_that) {
case _ChildStory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChildStory value)?  $default,){
final _that = this;
switch (_that) {
case _ChildStory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int storyId,  String title,  String? coverImageUrl,  String? description,  String source)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChildStory() when $default != null:
return $default(_that.storyId,_that.title,_that.coverImageUrl,_that.description,_that.source);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int storyId,  String title,  String? coverImageUrl,  String? description,  String source)  $default,) {final _that = this;
switch (_that) {
case _ChildStory():
return $default(_that.storyId,_that.title,_that.coverImageUrl,_that.description,_that.source);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int storyId,  String title,  String? coverImageUrl,  String? description,  String source)?  $default,) {final _that = this;
switch (_that) {
case _ChildStory() when $default != null:
return $default(_that.storyId,_that.title,_that.coverImageUrl,_that.description,_that.source);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChildStory implements ChildStory {
  const _ChildStory({required this.storyId, required this.title, this.coverImageUrl, this.description, required this.source});
  factory _ChildStory.fromJson(Map<String, dynamic> json) => _$ChildStoryFromJson(json);

@override final  int storyId;
@override final  String title;
@override final  String? coverImageUrl;
@override final  String? description;
@override final  String source;

/// Create a copy of ChildStory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChildStoryCopyWith<_ChildStory> get copyWith => __$ChildStoryCopyWithImpl<_ChildStory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChildStoryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChildStory&&(identical(other.storyId, storyId) || other.storyId == storyId)&&(identical(other.title, title) || other.title == title)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.description, description) || other.description == description)&&(identical(other.source, source) || other.source == source));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,storyId,title,coverImageUrl,description,source);
}

@override
String toString() {
    return 'ChildStory(storyId: $storyId, title: $title, coverImageUrl: $coverImageUrl, description: $description, source: $source)';
}


}

/// @nodoc
abstract mixin class _$ChildStoryCopyWith<$Res> implements $ChildStoryCopyWith<$Res> {
  factory _$ChildStoryCopyWith(_ChildStory value, $Res Function(_ChildStory) _then) = __$ChildStoryCopyWithImpl;
@override @useResult
$Res call({
 int storyId, String title, String? coverImageUrl, String? description, String source
});




}
/// @nodoc
class __$ChildStoryCopyWithImpl<$Res>
    implements _$ChildStoryCopyWith<$Res> {
  __$ChildStoryCopyWithImpl(this._self, this._then);

  final _ChildStory _self;
  final $Res Function(_ChildStory) _then;

/// Create a copy of ChildStory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? storyId = null,Object? title = null,Object? coverImageUrl = freezed,Object? description = freezed,Object? source = null,}) {
  return _then(_ChildStory(
storyId: null == storyId ? _self.storyId : storyId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ChildStoryPage {

 bool get isLocked; int? get unlockStoryId; String? get message; List<ChildStory> get items; int get totalCount; int get pageIndex; int get pageSize;
/// Create a copy of ChildStoryPage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChildStoryPageCopyWith<ChildStoryPage> get copyWith => _$ChildStoryPageCopyWithImpl<ChildStoryPage>(this as ChildStoryPage, _$identity);

  /// Serializes this ChildStoryPage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ChildStoryPage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChildStoryPage&&(identical(other.isLocked, _this.isLocked) || other.isLocked == _this.isLocked)&&(identical(other.unlockStoryId, _this.unlockStoryId) || other.unlockStoryId == _this.unlockStoryId)&&(identical(other.message, _this.message) || other.message == _this.message)&&const DeepCollectionEquality().equals(other.items, _this.items)&&(identical(other.totalCount, _this.totalCount) || other.totalCount == _this.totalCount)&&(identical(other.pageIndex, _this.pageIndex) || other.pageIndex == _this.pageIndex)&&(identical(other.pageSize, _this.pageSize) || other.pageSize == _this.pageSize));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChildStoryPage;
  return Object.hash(runtimeType,_this.isLocked,_this.unlockStoryId,_this.message,const DeepCollectionEquality().hash(_this.items),_this.totalCount,_this.pageIndex,_this.pageSize);
}

@override
String toString() {
  final _this = this as ChildStoryPage;
  return 'ChildStoryPage(isLocked: ${_this.isLocked}, unlockStoryId: ${_this.unlockStoryId}, message: ${_this.message}, items: ${_this.items}, totalCount: ${_this.totalCount}, pageIndex: ${_this.pageIndex}, pageSize: ${_this.pageSize})';
}


}

/// @nodoc
abstract mixin class $ChildStoryPageCopyWith<$Res>  {
  factory $ChildStoryPageCopyWith(ChildStoryPage value, $Res Function(ChildStoryPage) _then) = _$ChildStoryPageCopyWithImpl;
@useResult
$Res call({
 bool isLocked, int? unlockStoryId, String? message, List<ChildStory> items, int totalCount, int pageIndex, int pageSize
});




}
/// @nodoc
class _$ChildStoryPageCopyWithImpl<$Res>
    implements $ChildStoryPageCopyWith<$Res> {
  _$ChildStoryPageCopyWithImpl(this._self, this._then);

  final ChildStoryPage _self;
  final $Res Function(ChildStoryPage) _then;

/// Create a copy of ChildStoryPage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLocked = null,Object? unlockStoryId = freezed,Object? message = freezed,Object? items = null,Object? totalCount = null,Object? pageIndex = null,Object? pageSize = null,}) {
  return _then(ChildStoryPage(
isLocked: null == isLocked ? _self.isLocked : isLocked // ignore: cast_nullable_to_non_nullable
as bool,unlockStoryId: freezed == unlockStoryId ? _self.unlockStoryId : unlockStoryId // ignore: cast_nullable_to_non_nullable
as int?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<ChildStory>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,pageIndex: null == pageIndex ? _self.pageIndex : pageIndex // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ChildStoryPage].
extension ChildStoryPagePatterns on ChildStoryPage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChildStoryPage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChildStoryPage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChildStoryPage value)  $default,){
final _that = this;
switch (_that) {
case _ChildStoryPage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChildStoryPage value)?  $default,){
final _that = this;
switch (_that) {
case _ChildStoryPage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLocked,  int? unlockStoryId,  String? message,  List<ChildStory> items,  int totalCount,  int pageIndex,  int pageSize)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChildStoryPage() when $default != null:
return $default(_that.isLocked,_that.unlockStoryId,_that.message,_that.items,_that.totalCount,_that.pageIndex,_that.pageSize);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLocked,  int? unlockStoryId,  String? message,  List<ChildStory> items,  int totalCount,  int pageIndex,  int pageSize)  $default,) {final _that = this;
switch (_that) {
case _ChildStoryPage():
return $default(_that.isLocked,_that.unlockStoryId,_that.message,_that.items,_that.totalCount,_that.pageIndex,_that.pageSize);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLocked,  int? unlockStoryId,  String? message,  List<ChildStory> items,  int totalCount,  int pageIndex,  int pageSize)?  $default,) {final _that = this;
switch (_that) {
case _ChildStoryPage() when $default != null:
return $default(_that.isLocked,_that.unlockStoryId,_that.message,_that.items,_that.totalCount,_that.pageIndex,_that.pageSize);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChildStoryPage implements ChildStoryPage {
  const _ChildStoryPage({this.isLocked = false, this.unlockStoryId, this.message,  List<ChildStory> items = const <ChildStory>[], this.totalCount = 0, this.pageIndex = 0, this.pageSize = 0}): _items = items;
  factory _ChildStoryPage.fromJson(Map<String, dynamic> json) => _$ChildStoryPageFromJson(json);

@override@JsonKey() final  bool isLocked;
@override final  int? unlockStoryId;
@override final  String? message;
 final  List<ChildStory> _items;
@override@JsonKey() List<ChildStory> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey() final  int totalCount;
@override@JsonKey() final  int pageIndex;
@override@JsonKey() final  int pageSize;

/// Create a copy of ChildStoryPage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChildStoryPageCopyWith<_ChildStoryPage> get copyWith => __$ChildStoryPageCopyWithImpl<_ChildStoryPage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChildStoryPageToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChildStoryPage&&(identical(other.isLocked, isLocked) || other.isLocked == isLocked)&&(identical(other.unlockStoryId, unlockStoryId) || other.unlockStoryId == unlockStoryId)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.items, _items)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.pageIndex, pageIndex) || other.pageIndex == pageIndex)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,isLocked,unlockStoryId,message,const DeepCollectionEquality().hash(_items),totalCount,pageIndex,pageSize);
}

@override
String toString() {
    return 'ChildStoryPage(isLocked: $isLocked, unlockStoryId: $unlockStoryId, message: $message, items: $items, totalCount: $totalCount, pageIndex: $pageIndex, pageSize: $pageSize)';
}


}

/// @nodoc
abstract mixin class _$ChildStoryPageCopyWith<$Res> implements $ChildStoryPageCopyWith<$Res> {
  factory _$ChildStoryPageCopyWith(_ChildStoryPage value, $Res Function(_ChildStoryPage) _then) = __$ChildStoryPageCopyWithImpl;
@override @useResult
$Res call({
 bool isLocked, int? unlockStoryId, String? message, List<ChildStory> items, int totalCount, int pageIndex, int pageSize
});




}
/// @nodoc
class __$ChildStoryPageCopyWithImpl<$Res>
    implements _$ChildStoryPageCopyWith<$Res> {
  __$ChildStoryPageCopyWithImpl(this._self, this._then);

  final _ChildStoryPage _self;
  final $Res Function(_ChildStoryPage) _then;

/// Create a copy of ChildStoryPage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLocked = null,Object? unlockStoryId = freezed,Object? message = freezed,Object? items = null,Object? totalCount = null,Object? pageIndex = null,Object? pageSize = null,}) {
  return _then(_ChildStoryPage(
isLocked: null == isLocked ? _self.isLocked : isLocked // ignore: cast_nullable_to_non_nullable
as bool,unlockStoryId: freezed == unlockStoryId ? _self.unlockStoryId : unlockStoryId // ignore: cast_nullable_to_non_nullable
as int?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<ChildStory>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,pageIndex: null == pageIndex ? _self.pageIndex : pageIndex // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ReadingStartBody {

 int? get storyId; int? get communitySubmissionId;
/// Create a copy of ReadingStartBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadingStartBodyCopyWith<ReadingStartBody> get copyWith => _$ReadingStartBodyCopyWithImpl<ReadingStartBody>(this as ReadingStartBody, _$identity);

  /// Serializes this ReadingStartBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ReadingStartBody;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadingStartBody&&(identical(other.storyId, _this.storyId) || other.storyId == _this.storyId)&&(identical(other.communitySubmissionId, _this.communitySubmissionId) || other.communitySubmissionId == _this.communitySubmissionId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ReadingStartBody;
  return Object.hash(runtimeType,_this.storyId,_this.communitySubmissionId);
}

@override
String toString() {
  final _this = this as ReadingStartBody;
  return 'ReadingStartBody(storyId: ${_this.storyId}, communitySubmissionId: ${_this.communitySubmissionId})';
}


}

/// @nodoc
abstract mixin class $ReadingStartBodyCopyWith<$Res>  {
  factory $ReadingStartBodyCopyWith(ReadingStartBody value, $Res Function(ReadingStartBody) _then) = _$ReadingStartBodyCopyWithImpl;
@useResult
$Res call({
 int? storyId, int? communitySubmissionId
});




}
/// @nodoc
class _$ReadingStartBodyCopyWithImpl<$Res>
    implements $ReadingStartBodyCopyWith<$Res> {
  _$ReadingStartBodyCopyWithImpl(this._self, this._then);

  final ReadingStartBody _self;
  final $Res Function(ReadingStartBody) _then;

/// Create a copy of ReadingStartBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? storyId = freezed,Object? communitySubmissionId = freezed,}) {
  return _then(ReadingStartBody(
storyId: freezed == storyId ? _self.storyId : storyId // ignore: cast_nullable_to_non_nullable
as int?,communitySubmissionId: freezed == communitySubmissionId ? _self.communitySubmissionId : communitySubmissionId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReadingStartBody].
extension ReadingStartBodyPatterns on ReadingStartBody {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReadingStartBody value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReadingStartBody() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReadingStartBody value)  $default,){
final _that = this;
switch (_that) {
case _ReadingStartBody():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReadingStartBody value)?  $default,){
final _that = this;
switch (_that) {
case _ReadingStartBody() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? storyId,  int? communitySubmissionId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReadingStartBody() when $default != null:
return $default(_that.storyId,_that.communitySubmissionId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? storyId,  int? communitySubmissionId)  $default,) {final _that = this;
switch (_that) {
case _ReadingStartBody():
return $default(_that.storyId,_that.communitySubmissionId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? storyId,  int? communitySubmissionId)?  $default,) {final _that = this;
switch (_that) {
case _ReadingStartBody() when $default != null:
return $default(_that.storyId,_that.communitySubmissionId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReadingStartBody implements ReadingStartBody {
  const _ReadingStartBody({this.storyId, this.communitySubmissionId});
  factory _ReadingStartBody.fromJson(Map<String, dynamic> json) => _$ReadingStartBodyFromJson(json);

@override final  int? storyId;
@override final  int? communitySubmissionId;

/// Create a copy of ReadingStartBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadingStartBodyCopyWith<_ReadingStartBody> get copyWith => __$ReadingStartBodyCopyWithImpl<_ReadingStartBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReadingStartBodyToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReadingStartBody&&(identical(other.storyId, storyId) || other.storyId == storyId)&&(identical(other.communitySubmissionId, communitySubmissionId) || other.communitySubmissionId == communitySubmissionId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,storyId,communitySubmissionId);
}

@override
String toString() {
    return 'ReadingStartBody(storyId: $storyId, communitySubmissionId: $communitySubmissionId)';
}


}

/// @nodoc
abstract mixin class _$ReadingStartBodyCopyWith<$Res> implements $ReadingStartBodyCopyWith<$Res> {
  factory _$ReadingStartBodyCopyWith(_ReadingStartBody value, $Res Function(_ReadingStartBody) _then) = __$ReadingStartBodyCopyWithImpl;
@override @useResult
$Res call({
 int? storyId, int? communitySubmissionId
});




}
/// @nodoc
class __$ReadingStartBodyCopyWithImpl<$Res>
    implements _$ReadingStartBodyCopyWith<$Res> {
  __$ReadingStartBodyCopyWithImpl(this._self, this._then);

  final _ReadingStartBody _self;
  final $Res Function(_ReadingStartBody) _then;

/// Create a copy of ReadingStartBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? storyId = freezed,Object? communitySubmissionId = freezed,}) {
  return _then(_ReadingStartBody(
storyId: freezed == storyId ? _self.storyId : storyId // ignore: cast_nullable_to_non_nullable
as int?,communitySubmissionId: freezed == communitySubmissionId ? _self.communitySubmissionId : communitySubmissionId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$ReadingStarted {

 int get sessionId; int get storyId; bool get resumed; int get lastPage; String? get lastReadingMode; bool get isBookmarked; bool get isFavorited; bool? get listenOnly;
/// Create a copy of ReadingStarted
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadingStartedCopyWith<ReadingStarted> get copyWith => _$ReadingStartedCopyWithImpl<ReadingStarted>(this as ReadingStarted, _$identity);

  /// Serializes this ReadingStarted to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ReadingStarted;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadingStarted&&(identical(other.sessionId, _this.sessionId) || other.sessionId == _this.sessionId)&&(identical(other.storyId, _this.storyId) || other.storyId == _this.storyId)&&(identical(other.resumed, _this.resumed) || other.resumed == _this.resumed)&&(identical(other.lastPage, _this.lastPage) || other.lastPage == _this.lastPage)&&(identical(other.lastReadingMode, _this.lastReadingMode) || other.lastReadingMode == _this.lastReadingMode)&&(identical(other.isBookmarked, _this.isBookmarked) || other.isBookmarked == _this.isBookmarked)&&(identical(other.isFavorited, _this.isFavorited) || other.isFavorited == _this.isFavorited)&&(identical(other.listenOnly, _this.listenOnly) || other.listenOnly == _this.listenOnly));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ReadingStarted;
  return Object.hash(runtimeType,_this.sessionId,_this.storyId,_this.resumed,_this.lastPage,_this.lastReadingMode,_this.isBookmarked,_this.isFavorited,_this.listenOnly);
}

@override
String toString() {
  final _this = this as ReadingStarted;
  return 'ReadingStarted(sessionId: ${_this.sessionId}, storyId: ${_this.storyId}, resumed: ${_this.resumed}, lastPage: ${_this.lastPage}, lastReadingMode: ${_this.lastReadingMode}, isBookmarked: ${_this.isBookmarked}, isFavorited: ${_this.isFavorited}, listenOnly: ${_this.listenOnly})';
}


}

/// @nodoc
abstract mixin class $ReadingStartedCopyWith<$Res>  {
  factory $ReadingStartedCopyWith(ReadingStarted value, $Res Function(ReadingStarted) _then) = _$ReadingStartedCopyWithImpl;
@useResult
$Res call({
 int sessionId, int storyId, bool resumed, int lastPage, String? lastReadingMode, bool isBookmarked, bool isFavorited, bool? listenOnly
});




}
/// @nodoc
class _$ReadingStartedCopyWithImpl<$Res>
    implements $ReadingStartedCopyWith<$Res> {
  _$ReadingStartedCopyWithImpl(this._self, this._then);

  final ReadingStarted _self;
  final $Res Function(ReadingStarted) _then;

/// Create a copy of ReadingStarted
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionId = null,Object? storyId = null,Object? resumed = null,Object? lastPage = null,Object? lastReadingMode = freezed,Object? isBookmarked = null,Object? isFavorited = null,Object? listenOnly = freezed,}) {
  return _then(ReadingStarted(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as int,storyId: null == storyId ? _self.storyId : storyId // ignore: cast_nullable_to_non_nullable
as int,resumed: null == resumed ? _self.resumed : resumed // ignore: cast_nullable_to_non_nullable
as bool,lastPage: null == lastPage ? _self.lastPage : lastPage // ignore: cast_nullable_to_non_nullable
as int,lastReadingMode: freezed == lastReadingMode ? _self.lastReadingMode : lastReadingMode // ignore: cast_nullable_to_non_nullable
as String?,isBookmarked: null == isBookmarked ? _self.isBookmarked : isBookmarked // ignore: cast_nullable_to_non_nullable
as bool,isFavorited: null == isFavorited ? _self.isFavorited : isFavorited // ignore: cast_nullable_to_non_nullable
as bool,listenOnly: freezed == listenOnly ? _self.listenOnly : listenOnly // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReadingStarted].
extension ReadingStartedPatterns on ReadingStarted {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReadingStarted value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReadingStarted() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReadingStarted value)  $default,){
final _that = this;
switch (_that) {
case _ReadingStarted():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReadingStarted value)?  $default,){
final _that = this;
switch (_that) {
case _ReadingStarted() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int sessionId,  int storyId,  bool resumed,  int lastPage,  String? lastReadingMode,  bool isBookmarked,  bool isFavorited,  bool? listenOnly)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReadingStarted() when $default != null:
return $default(_that.sessionId,_that.storyId,_that.resumed,_that.lastPage,_that.lastReadingMode,_that.isBookmarked,_that.isFavorited,_that.listenOnly);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int sessionId,  int storyId,  bool resumed,  int lastPage,  String? lastReadingMode,  bool isBookmarked,  bool isFavorited,  bool? listenOnly)  $default,) {final _that = this;
switch (_that) {
case _ReadingStarted():
return $default(_that.sessionId,_that.storyId,_that.resumed,_that.lastPage,_that.lastReadingMode,_that.isBookmarked,_that.isFavorited,_that.listenOnly);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int sessionId,  int storyId,  bool resumed,  int lastPage,  String? lastReadingMode,  bool isBookmarked,  bool isFavorited,  bool? listenOnly)?  $default,) {final _that = this;
switch (_that) {
case _ReadingStarted() when $default != null:
return $default(_that.sessionId,_that.storyId,_that.resumed,_that.lastPage,_that.lastReadingMode,_that.isBookmarked,_that.isFavorited,_that.listenOnly);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReadingStarted implements ReadingStarted {
  const _ReadingStarted({required this.sessionId, required this.storyId, this.resumed = false, this.lastPage = 0, this.lastReadingMode, this.isBookmarked = false, this.isFavorited = false, this.listenOnly});
  factory _ReadingStarted.fromJson(Map<String, dynamic> json) => _$ReadingStartedFromJson(json);

@override final  int sessionId;
@override final  int storyId;
@override@JsonKey() final  bool resumed;
@override@JsonKey() final  int lastPage;
@override final  String? lastReadingMode;
@override@JsonKey() final  bool isBookmarked;
@override@JsonKey() final  bool isFavorited;
@override final  bool? listenOnly;

/// Create a copy of ReadingStarted
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadingStartedCopyWith<_ReadingStarted> get copyWith => __$ReadingStartedCopyWithImpl<_ReadingStarted>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReadingStartedToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReadingStarted&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.storyId, storyId) || other.storyId == storyId)&&(identical(other.resumed, resumed) || other.resumed == resumed)&&(identical(other.lastPage, lastPage) || other.lastPage == lastPage)&&(identical(other.lastReadingMode, lastReadingMode) || other.lastReadingMode == lastReadingMode)&&(identical(other.isBookmarked, isBookmarked) || other.isBookmarked == isBookmarked)&&(identical(other.isFavorited, isFavorited) || other.isFavorited == isFavorited)&&(identical(other.listenOnly, listenOnly) || other.listenOnly == listenOnly));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,sessionId,storyId,resumed,lastPage,lastReadingMode,isBookmarked,isFavorited,listenOnly);
}

@override
String toString() {
    return 'ReadingStarted(sessionId: $sessionId, storyId: $storyId, resumed: $resumed, lastPage: $lastPage, lastReadingMode: $lastReadingMode, isBookmarked: $isBookmarked, isFavorited: $isFavorited, listenOnly: $listenOnly)';
}


}

/// @nodoc
abstract mixin class _$ReadingStartedCopyWith<$Res> implements $ReadingStartedCopyWith<$Res> {
  factory _$ReadingStartedCopyWith(_ReadingStarted value, $Res Function(_ReadingStarted) _then) = __$ReadingStartedCopyWithImpl;
@override @useResult
$Res call({
 int sessionId, int storyId, bool resumed, int lastPage, String? lastReadingMode, bool isBookmarked, bool isFavorited, bool? listenOnly
});




}
/// @nodoc
class __$ReadingStartedCopyWithImpl<$Res>
    implements _$ReadingStartedCopyWith<$Res> {
  __$ReadingStartedCopyWithImpl(this._self, this._then);

  final _ReadingStarted _self;
  final $Res Function(_ReadingStarted) _then;

/// Create a copy of ReadingStarted
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionId = null,Object? storyId = null,Object? resumed = null,Object? lastPage = null,Object? lastReadingMode = freezed,Object? isBookmarked = null,Object? isFavorited = null,Object? listenOnly = freezed,}) {
  return _then(_ReadingStarted(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as int,storyId: null == storyId ? _self.storyId : storyId // ignore: cast_nullable_to_non_nullable
as int,resumed: null == resumed ? _self.resumed : resumed // ignore: cast_nullable_to_non_nullable
as bool,lastPage: null == lastPage ? _self.lastPage : lastPage // ignore: cast_nullable_to_non_nullable
as int,lastReadingMode: freezed == lastReadingMode ? _self.lastReadingMode : lastReadingMode // ignore: cast_nullable_to_non_nullable
as String?,isBookmarked: null == isBookmarked ? _self.isBookmarked : isBookmarked // ignore: cast_nullable_to_non_nullable
as bool,isFavorited: null == isFavorited ? _self.isFavorited : isFavorited // ignore: cast_nullable_to_non_nullable
as bool,listenOnly: freezed == listenOnly ? _self.listenOnly : listenOnly // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}


/// @nodoc
mixin _$ReadingFlags {

 bool get isBookmarked; bool get isFavorited; bool? get listenOnly;
/// Create a copy of ReadingFlags
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadingFlagsCopyWith<ReadingFlags> get copyWith => _$ReadingFlagsCopyWithImpl<ReadingFlags>(this as ReadingFlags, _$identity);

  /// Serializes this ReadingFlags to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ReadingFlags;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadingFlags&&(identical(other.isBookmarked, _this.isBookmarked) || other.isBookmarked == _this.isBookmarked)&&(identical(other.isFavorited, _this.isFavorited) || other.isFavorited == _this.isFavorited)&&(identical(other.listenOnly, _this.listenOnly) || other.listenOnly == _this.listenOnly));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ReadingFlags;
  return Object.hash(runtimeType,_this.isBookmarked,_this.isFavorited,_this.listenOnly);
}

@override
String toString() {
  final _this = this as ReadingFlags;
  return 'ReadingFlags(isBookmarked: ${_this.isBookmarked}, isFavorited: ${_this.isFavorited}, listenOnly: ${_this.listenOnly})';
}


}

/// @nodoc
abstract mixin class $ReadingFlagsCopyWith<$Res>  {
  factory $ReadingFlagsCopyWith(ReadingFlags value, $Res Function(ReadingFlags) _then) = _$ReadingFlagsCopyWithImpl;
@useResult
$Res call({
 bool isBookmarked, bool isFavorited, bool? listenOnly
});




}
/// @nodoc
class _$ReadingFlagsCopyWithImpl<$Res>
    implements $ReadingFlagsCopyWith<$Res> {
  _$ReadingFlagsCopyWithImpl(this._self, this._then);

  final ReadingFlags _self;
  final $Res Function(ReadingFlags) _then;

/// Create a copy of ReadingFlags
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isBookmarked = null,Object? isFavorited = null,Object? listenOnly = freezed,}) {
  return _then(ReadingFlags(
isBookmarked: null == isBookmarked ? _self.isBookmarked : isBookmarked // ignore: cast_nullable_to_non_nullable
as bool,isFavorited: null == isFavorited ? _self.isFavorited : isFavorited // ignore: cast_nullable_to_non_nullable
as bool,listenOnly: freezed == listenOnly ? _self.listenOnly : listenOnly // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReadingFlags].
extension ReadingFlagsPatterns on ReadingFlags {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReadingFlags value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReadingFlags() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReadingFlags value)  $default,){
final _that = this;
switch (_that) {
case _ReadingFlags():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReadingFlags value)?  $default,){
final _that = this;
switch (_that) {
case _ReadingFlags() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isBookmarked,  bool isFavorited,  bool? listenOnly)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReadingFlags() when $default != null:
return $default(_that.isBookmarked,_that.isFavorited,_that.listenOnly);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isBookmarked,  bool isFavorited,  bool? listenOnly)  $default,) {final _that = this;
switch (_that) {
case _ReadingFlags():
return $default(_that.isBookmarked,_that.isFavorited,_that.listenOnly);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isBookmarked,  bool isFavorited,  bool? listenOnly)?  $default,) {final _that = this;
switch (_that) {
case _ReadingFlags() when $default != null:
return $default(_that.isBookmarked,_that.isFavorited,_that.listenOnly);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReadingFlags implements ReadingFlags {
  const _ReadingFlags({this.isBookmarked = false, this.isFavorited = false, this.listenOnly});
  factory _ReadingFlags.fromJson(Map<String, dynamic> json) => _$ReadingFlagsFromJson(json);

@override@JsonKey() final  bool isBookmarked;
@override@JsonKey() final  bool isFavorited;
@override final  bool? listenOnly;

/// Create a copy of ReadingFlags
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadingFlagsCopyWith<_ReadingFlags> get copyWith => __$ReadingFlagsCopyWithImpl<_ReadingFlags>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReadingFlagsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReadingFlags&&(identical(other.isBookmarked, isBookmarked) || other.isBookmarked == isBookmarked)&&(identical(other.isFavorited, isFavorited) || other.isFavorited == isFavorited)&&(identical(other.listenOnly, listenOnly) || other.listenOnly == listenOnly));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,isBookmarked,isFavorited,listenOnly);
}

@override
String toString() {
    return 'ReadingFlags(isBookmarked: $isBookmarked, isFavorited: $isFavorited, listenOnly: $listenOnly)';
}


}

/// @nodoc
abstract mixin class _$ReadingFlagsCopyWith<$Res> implements $ReadingFlagsCopyWith<$Res> {
  factory _$ReadingFlagsCopyWith(_ReadingFlags value, $Res Function(_ReadingFlags) _then) = __$ReadingFlagsCopyWithImpl;
@override @useResult
$Res call({
 bool isBookmarked, bool isFavorited, bool? listenOnly
});




}
/// @nodoc
class __$ReadingFlagsCopyWithImpl<$Res>
    implements _$ReadingFlagsCopyWith<$Res> {
  __$ReadingFlagsCopyWithImpl(this._self, this._then);

  final _ReadingFlags _self;
  final $Res Function(_ReadingFlags) _then;

/// Create a copy of ReadingFlags
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isBookmarked = null,Object? isFavorited = null,Object? listenOnly = freezed,}) {
  return _then(_ReadingFlags(
isBookmarked: null == isBookmarked ? _self.isBookmarked : isBookmarked // ignore: cast_nullable_to_non_nullable
as bool,isFavorited: null == isFavorited ? _self.isFavorited : isFavorited // ignore: cast_nullable_to_non_nullable
as bool,listenOnly: freezed == listenOnly ? _self.listenOnly : listenOnly // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}


/// @nodoc
mixin _$ReadingContent {

 int get sessionId; int get storyId; String get title; String? get lesson; bool get listenOnly; List<ReadingScene> get scenes; List<ReadingVocabulary> get vocabulary;
/// Create a copy of ReadingContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadingContentCopyWith<ReadingContent> get copyWith => _$ReadingContentCopyWithImpl<ReadingContent>(this as ReadingContent, _$identity);

  /// Serializes this ReadingContent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ReadingContent;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadingContent&&(identical(other.sessionId, _this.sessionId) || other.sessionId == _this.sessionId)&&(identical(other.storyId, _this.storyId) || other.storyId == _this.storyId)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.lesson, _this.lesson) || other.lesson == _this.lesson)&&(identical(other.listenOnly, _this.listenOnly) || other.listenOnly == _this.listenOnly)&&const DeepCollectionEquality().equals(other.scenes, _this.scenes)&&const DeepCollectionEquality().equals(other.vocabulary, _this.vocabulary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ReadingContent;
  return Object.hash(runtimeType,_this.sessionId,_this.storyId,_this.title,_this.lesson,_this.listenOnly,const DeepCollectionEquality().hash(_this.scenes),const DeepCollectionEquality().hash(_this.vocabulary));
}

@override
String toString() {
  final _this = this as ReadingContent;
  return 'ReadingContent(sessionId: ${_this.sessionId}, storyId: ${_this.storyId}, title: ${_this.title}, lesson: ${_this.lesson}, listenOnly: ${_this.listenOnly}, scenes: ${_this.scenes}, vocabulary: ${_this.vocabulary})';
}


}

/// @nodoc
abstract mixin class $ReadingContentCopyWith<$Res>  {
  factory $ReadingContentCopyWith(ReadingContent value, $Res Function(ReadingContent) _then) = _$ReadingContentCopyWithImpl;
@useResult
$Res call({
 int sessionId, int storyId, String title, String? lesson, bool listenOnly, List<ReadingScene> scenes, List<ReadingVocabulary> vocabulary
});




}
/// @nodoc
class _$ReadingContentCopyWithImpl<$Res>
    implements $ReadingContentCopyWith<$Res> {
  _$ReadingContentCopyWithImpl(this._self, this._then);

  final ReadingContent _self;
  final $Res Function(ReadingContent) _then;

/// Create a copy of ReadingContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionId = null,Object? storyId = null,Object? title = null,Object? lesson = freezed,Object? listenOnly = null,Object? scenes = null,Object? vocabulary = null,}) {
  return _then(ReadingContent(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as int,storyId: null == storyId ? _self.storyId : storyId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,lesson: freezed == lesson ? _self.lesson : lesson // ignore: cast_nullable_to_non_nullable
as String?,listenOnly: null == listenOnly ? _self.listenOnly : listenOnly // ignore: cast_nullable_to_non_nullable
as bool,scenes: null == scenes ? _self.scenes : scenes // ignore: cast_nullable_to_non_nullable
as List<ReadingScene>,vocabulary: null == vocabulary ? _self.vocabulary : vocabulary // ignore: cast_nullable_to_non_nullable
as List<ReadingVocabulary>,
  ));
}

}


/// Adds pattern-matching-related methods to [ReadingContent].
extension ReadingContentPatterns on ReadingContent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReadingContent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReadingContent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReadingContent value)  $default,){
final _that = this;
switch (_that) {
case _ReadingContent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReadingContent value)?  $default,){
final _that = this;
switch (_that) {
case _ReadingContent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int sessionId,  int storyId,  String title,  String? lesson,  bool listenOnly,  List<ReadingScene> scenes,  List<ReadingVocabulary> vocabulary)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReadingContent() when $default != null:
return $default(_that.sessionId,_that.storyId,_that.title,_that.lesson,_that.listenOnly,_that.scenes,_that.vocabulary);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int sessionId,  int storyId,  String title,  String? lesson,  bool listenOnly,  List<ReadingScene> scenes,  List<ReadingVocabulary> vocabulary)  $default,) {final _that = this;
switch (_that) {
case _ReadingContent():
return $default(_that.sessionId,_that.storyId,_that.title,_that.lesson,_that.listenOnly,_that.scenes,_that.vocabulary);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int sessionId,  int storyId,  String title,  String? lesson,  bool listenOnly,  List<ReadingScene> scenes,  List<ReadingVocabulary> vocabulary)?  $default,) {final _that = this;
switch (_that) {
case _ReadingContent() when $default != null:
return $default(_that.sessionId,_that.storyId,_that.title,_that.lesson,_that.listenOnly,_that.scenes,_that.vocabulary);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReadingContent implements ReadingContent {
  const _ReadingContent({required this.sessionId, required this.storyId, required this.title, this.lesson, this.listenOnly = false,  List<ReadingScene> scenes = const <ReadingScene>[],  List<ReadingVocabulary> vocabulary = const <ReadingVocabulary>[]}): _scenes = scenes,_vocabulary = vocabulary;
  factory _ReadingContent.fromJson(Map<String, dynamic> json) => _$ReadingContentFromJson(json);

@override final  int sessionId;
@override final  int storyId;
@override final  String title;
@override final  String? lesson;
@override@JsonKey() final  bool listenOnly;
 final  List<ReadingScene> _scenes;
@override@JsonKey() List<ReadingScene> get scenes {
  if (_scenes is EqualUnmodifiableListView) return _scenes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_scenes);
}

 final  List<ReadingVocabulary> _vocabulary;
@override@JsonKey() List<ReadingVocabulary> get vocabulary {
  if (_vocabulary is EqualUnmodifiableListView) return _vocabulary;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_vocabulary);
}


/// Create a copy of ReadingContent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadingContentCopyWith<_ReadingContent> get copyWith => __$ReadingContentCopyWithImpl<_ReadingContent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReadingContentToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReadingContent&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.storyId, storyId) || other.storyId == storyId)&&(identical(other.title, title) || other.title == title)&&(identical(other.lesson, lesson) || other.lesson == lesson)&&(identical(other.listenOnly, listenOnly) || other.listenOnly == listenOnly)&&const DeepCollectionEquality().equals(other.scenes, _scenes)&&const DeepCollectionEquality().equals(other.vocabulary, _vocabulary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,sessionId,storyId,title,lesson,listenOnly,const DeepCollectionEquality().hash(_scenes),const DeepCollectionEquality().hash(_vocabulary));
}

@override
String toString() {
    return 'ReadingContent(sessionId: $sessionId, storyId: $storyId, title: $title, lesson: $lesson, listenOnly: $listenOnly, scenes: $scenes, vocabulary: $vocabulary)';
}


}

/// @nodoc
abstract mixin class _$ReadingContentCopyWith<$Res> implements $ReadingContentCopyWith<$Res> {
  factory _$ReadingContentCopyWith(_ReadingContent value, $Res Function(_ReadingContent) _then) = __$ReadingContentCopyWithImpl;
@override @useResult
$Res call({
 int sessionId, int storyId, String title, String? lesson, bool listenOnly, List<ReadingScene> scenes, List<ReadingVocabulary> vocabulary
});




}
/// @nodoc
class __$ReadingContentCopyWithImpl<$Res>
    implements _$ReadingContentCopyWith<$Res> {
  __$ReadingContentCopyWithImpl(this._self, this._then);

  final _ReadingContent _self;
  final $Res Function(_ReadingContent) _then;

/// Create a copy of ReadingContent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionId = null,Object? storyId = null,Object? title = null,Object? lesson = freezed,Object? listenOnly = null,Object? scenes = null,Object? vocabulary = null,}) {
  return _then(_ReadingContent(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as int,storyId: null == storyId ? _self.storyId : storyId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,lesson: freezed == lesson ? _self.lesson : lesson // ignore: cast_nullable_to_non_nullable
as String?,listenOnly: null == listenOnly ? _self.listenOnly : listenOnly // ignore: cast_nullable_to_non_nullable
as bool,scenes: null == scenes ? _self._scenes : scenes // ignore: cast_nullable_to_non_nullable
as List<ReadingScene>,vocabulary: null == vocabulary ? _self._vocabulary : vocabulary // ignore: cast_nullable_to_non_nullable
as List<ReadingVocabulary>,
  ));
}


}


/// @nodoc
mixin _$ReadingVocabulary {

 int get id; String get term;
/// Create a copy of ReadingVocabulary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadingVocabularyCopyWith<ReadingVocabulary> get copyWith => _$ReadingVocabularyCopyWithImpl<ReadingVocabulary>(this as ReadingVocabulary, _$identity);

  /// Serializes this ReadingVocabulary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ReadingVocabulary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadingVocabulary&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.term, _this.term) || other.term == _this.term));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ReadingVocabulary;
  return Object.hash(runtimeType,_this.id,_this.term);
}

@override
String toString() {
  final _this = this as ReadingVocabulary;
  return 'ReadingVocabulary(id: ${_this.id}, term: ${_this.term})';
}


}

/// @nodoc
abstract mixin class $ReadingVocabularyCopyWith<$Res>  {
  factory $ReadingVocabularyCopyWith(ReadingVocabulary value, $Res Function(ReadingVocabulary) _then) = _$ReadingVocabularyCopyWithImpl;
@useResult
$Res call({
 int id, String term
});




}
/// @nodoc
class _$ReadingVocabularyCopyWithImpl<$Res>
    implements $ReadingVocabularyCopyWith<$Res> {
  _$ReadingVocabularyCopyWithImpl(this._self, this._then);

  final ReadingVocabulary _self;
  final $Res Function(ReadingVocabulary) _then;

/// Create a copy of ReadingVocabulary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? term = null,}) {
  return _then(ReadingVocabulary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,term: null == term ? _self.term : term // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ReadingVocabulary].
extension ReadingVocabularyPatterns on ReadingVocabulary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReadingVocabulary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReadingVocabulary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReadingVocabulary value)  $default,){
final _that = this;
switch (_that) {
case _ReadingVocabulary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReadingVocabulary value)?  $default,){
final _that = this;
switch (_that) {
case _ReadingVocabulary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String term)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReadingVocabulary() when $default != null:
return $default(_that.id,_that.term);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String term)  $default,) {final _that = this;
switch (_that) {
case _ReadingVocabulary():
return $default(_that.id,_that.term);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String term)?  $default,) {final _that = this;
switch (_that) {
case _ReadingVocabulary() when $default != null:
return $default(_that.id,_that.term);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReadingVocabulary implements ReadingVocabulary {
  const _ReadingVocabulary({required this.id, required this.term});
  factory _ReadingVocabulary.fromJson(Map<String, dynamic> json) => _$ReadingVocabularyFromJson(json);

@override final  int id;
@override final  String term;

/// Create a copy of ReadingVocabulary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadingVocabularyCopyWith<_ReadingVocabulary> get copyWith => __$ReadingVocabularyCopyWithImpl<_ReadingVocabulary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReadingVocabularyToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReadingVocabulary&&(identical(other.id, id) || other.id == id)&&(identical(other.term, term) || other.term == term));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,term);
}

@override
String toString() {
    return 'ReadingVocabulary(id: $id, term: $term)';
}


}

/// @nodoc
abstract mixin class _$ReadingVocabularyCopyWith<$Res> implements $ReadingVocabularyCopyWith<$Res> {
  factory _$ReadingVocabularyCopyWith(_ReadingVocabulary value, $Res Function(_ReadingVocabulary) _then) = __$ReadingVocabularyCopyWithImpl;
@override @useResult
$Res call({
 int id, String term
});




}
/// @nodoc
class __$ReadingVocabularyCopyWithImpl<$Res>
    implements _$ReadingVocabularyCopyWith<$Res> {
  __$ReadingVocabularyCopyWithImpl(this._self, this._then);

  final _ReadingVocabulary _self;
  final $Res Function(_ReadingVocabulary) _then;

/// Create a copy of ReadingVocabulary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? term = null,}) {
  return _then(_ReadingVocabulary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,term: null == term ? _self.term : term // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ReadingScene {

 int get sceneId; int get sceneIndex; String get text; String? get illustrationUrl; List<SceneIllustration>? get illustrations; List<ReadingSegment> get segments; Map<String, dynamic>? get interaction; bool get attemptedInSession;
/// Create a copy of ReadingScene
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadingSceneCopyWith<ReadingScene> get copyWith => _$ReadingSceneCopyWithImpl<ReadingScene>(this as ReadingScene, _$identity);

  /// Serializes this ReadingScene to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ReadingScene;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadingScene&&(identical(other.sceneId, _this.sceneId) || other.sceneId == _this.sceneId)&&(identical(other.sceneIndex, _this.sceneIndex) || other.sceneIndex == _this.sceneIndex)&&(identical(other.text, _this.text) || other.text == _this.text)&&(identical(other.illustrationUrl, _this.illustrationUrl) || other.illustrationUrl == _this.illustrationUrl)&&const DeepCollectionEquality().equals(other.illustrations, _this.illustrations)&&const DeepCollectionEquality().equals(other.segments, _this.segments)&&const DeepCollectionEquality().equals(other.interaction, _this.interaction)&&(identical(other.attemptedInSession, _this.attemptedInSession) || other.attemptedInSession == _this.attemptedInSession));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ReadingScene;
  return Object.hash(runtimeType,_this.sceneId,_this.sceneIndex,_this.text,_this.illustrationUrl,const DeepCollectionEquality().hash(_this.illustrations),const DeepCollectionEquality().hash(_this.segments),const DeepCollectionEquality().hash(_this.interaction),_this.attemptedInSession);
}

@override
String toString() {
  final _this = this as ReadingScene;
  return 'ReadingScene(sceneId: ${_this.sceneId}, sceneIndex: ${_this.sceneIndex}, text: ${_this.text}, illustrationUrl: ${_this.illustrationUrl}, illustrations: ${_this.illustrations}, segments: ${_this.segments}, interaction: ${_this.interaction}, attemptedInSession: ${_this.attemptedInSession})';
}


}

/// @nodoc
abstract mixin class $ReadingSceneCopyWith<$Res>  {
  factory $ReadingSceneCopyWith(ReadingScene value, $Res Function(ReadingScene) _then) = _$ReadingSceneCopyWithImpl;
@useResult
$Res call({
 int sceneId, int sceneIndex, String text, String? illustrationUrl, List<SceneIllustration>? illustrations, List<ReadingSegment> segments, Map<String, dynamic>? interaction, bool attemptedInSession
});




}
/// @nodoc
class _$ReadingSceneCopyWithImpl<$Res>
    implements $ReadingSceneCopyWith<$Res> {
  _$ReadingSceneCopyWithImpl(this._self, this._then);

  final ReadingScene _self;
  final $Res Function(ReadingScene) _then;

/// Create a copy of ReadingScene
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sceneId = null,Object? sceneIndex = null,Object? text = null,Object? illustrationUrl = freezed,Object? illustrations = freezed,Object? segments = null,Object? interaction = freezed,Object? attemptedInSession = null,}) {
  return _then(ReadingScene(
sceneId: null == sceneId ? _self.sceneId : sceneId // ignore: cast_nullable_to_non_nullable
as int,sceneIndex: null == sceneIndex ? _self.sceneIndex : sceneIndex // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,illustrationUrl: freezed == illustrationUrl ? _self.illustrationUrl : illustrationUrl // ignore: cast_nullable_to_non_nullable
as String?,illustrations: freezed == illustrations ? _self.illustrations : illustrations // ignore: cast_nullable_to_non_nullable
as List<SceneIllustration>?,segments: null == segments ? _self.segments : segments // ignore: cast_nullable_to_non_nullable
as List<ReadingSegment>,interaction: freezed == interaction ? _self.interaction : interaction // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,attemptedInSession: null == attemptedInSession ? _self.attemptedInSession : attemptedInSession // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ReadingScene].
extension ReadingScenePatterns on ReadingScene {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReadingScene value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReadingScene() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReadingScene value)  $default,){
final _that = this;
switch (_that) {
case _ReadingScene():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReadingScene value)?  $default,){
final _that = this;
switch (_that) {
case _ReadingScene() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int sceneId,  int sceneIndex,  String text,  String? illustrationUrl,  List<SceneIllustration>? illustrations,  List<ReadingSegment> segments,  Map<String, dynamic>? interaction,  bool attemptedInSession)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReadingScene() when $default != null:
return $default(_that.sceneId,_that.sceneIndex,_that.text,_that.illustrationUrl,_that.illustrations,_that.segments,_that.interaction,_that.attemptedInSession);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int sceneId,  int sceneIndex,  String text,  String? illustrationUrl,  List<SceneIllustration>? illustrations,  List<ReadingSegment> segments,  Map<String, dynamic>? interaction,  bool attemptedInSession)  $default,) {final _that = this;
switch (_that) {
case _ReadingScene():
return $default(_that.sceneId,_that.sceneIndex,_that.text,_that.illustrationUrl,_that.illustrations,_that.segments,_that.interaction,_that.attemptedInSession);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int sceneId,  int sceneIndex,  String text,  String? illustrationUrl,  List<SceneIllustration>? illustrations,  List<ReadingSegment> segments,  Map<String, dynamic>? interaction,  bool attemptedInSession)?  $default,) {final _that = this;
switch (_that) {
case _ReadingScene() when $default != null:
return $default(_that.sceneId,_that.sceneIndex,_that.text,_that.illustrationUrl,_that.illustrations,_that.segments,_that.interaction,_that.attemptedInSession);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReadingScene implements ReadingScene {
  const _ReadingScene({required this.sceneId, required this.sceneIndex, required this.text, this.illustrationUrl,  List<SceneIllustration>? illustrations,  List<ReadingSegment> segments = const <ReadingSegment>[],  Map<String, dynamic>? interaction, this.attemptedInSession = false}): _illustrations = illustrations,_segments = segments,_interaction = interaction;
  factory _ReadingScene.fromJson(Map<String, dynamic> json) => _$ReadingSceneFromJson(json);

@override final  int sceneId;
@override final  int sceneIndex;
@override final  String text;
@override final  String? illustrationUrl;
 final  List<SceneIllustration>? _illustrations;
@override List<SceneIllustration>? get illustrations {
  final value = _illustrations;
  if (value == null) return null;
  if (_illustrations is EqualUnmodifiableListView) return _illustrations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<ReadingSegment> _segments;
@override@JsonKey() List<ReadingSegment> get segments {
  if (_segments is EqualUnmodifiableListView) return _segments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_segments);
}

 final  Map<String, dynamic>? _interaction;
@override Map<String, dynamic>? get interaction {
  final value = _interaction;
  if (value == null) return null;
  if (_interaction is EqualUnmodifiableMapView) return _interaction;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override@JsonKey() final  bool attemptedInSession;

/// Create a copy of ReadingScene
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadingSceneCopyWith<_ReadingScene> get copyWith => __$ReadingSceneCopyWithImpl<_ReadingScene>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReadingSceneToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReadingScene&&(identical(other.sceneId, sceneId) || other.sceneId == sceneId)&&(identical(other.sceneIndex, sceneIndex) || other.sceneIndex == sceneIndex)&&(identical(other.text, text) || other.text == text)&&(identical(other.illustrationUrl, illustrationUrl) || other.illustrationUrl == illustrationUrl)&&const DeepCollectionEquality().equals(other.illustrations, _illustrations)&&const DeepCollectionEquality().equals(other.segments, _segments)&&const DeepCollectionEquality().equals(other.interaction, _interaction)&&(identical(other.attemptedInSession, attemptedInSession) || other.attemptedInSession == attemptedInSession));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,sceneId,sceneIndex,text,illustrationUrl,const DeepCollectionEquality().hash(_illustrations),const DeepCollectionEquality().hash(_segments),const DeepCollectionEquality().hash(_interaction),attemptedInSession);
}

@override
String toString() {
    return 'ReadingScene(sceneId: $sceneId, sceneIndex: $sceneIndex, text: $text, illustrationUrl: $illustrationUrl, illustrations: $illustrations, segments: $segments, interaction: $interaction, attemptedInSession: $attemptedInSession)';
}


}

/// @nodoc
abstract mixin class _$ReadingSceneCopyWith<$Res> implements $ReadingSceneCopyWith<$Res> {
  factory _$ReadingSceneCopyWith(_ReadingScene value, $Res Function(_ReadingScene) _then) = __$ReadingSceneCopyWithImpl;
@override @useResult
$Res call({
 int sceneId, int sceneIndex, String text, String? illustrationUrl, List<SceneIllustration>? illustrations, List<ReadingSegment> segments, Map<String, dynamic>? interaction, bool attemptedInSession
});




}
/// @nodoc
class __$ReadingSceneCopyWithImpl<$Res>
    implements _$ReadingSceneCopyWith<$Res> {
  __$ReadingSceneCopyWithImpl(this._self, this._then);

  final _ReadingScene _self;
  final $Res Function(_ReadingScene) _then;

/// Create a copy of ReadingScene
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sceneId = null,Object? sceneIndex = null,Object? text = null,Object? illustrationUrl = freezed,Object? illustrations = freezed,Object? segments = null,Object? interaction = freezed,Object? attemptedInSession = null,}) {
  return _then(_ReadingScene(
sceneId: null == sceneId ? _self.sceneId : sceneId // ignore: cast_nullable_to_non_nullable
as int,sceneIndex: null == sceneIndex ? _self.sceneIndex : sceneIndex // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,illustrationUrl: freezed == illustrationUrl ? _self.illustrationUrl : illustrationUrl // ignore: cast_nullable_to_non_nullable
as String?,illustrations: freezed == illustrations ? _self._illustrations : illustrations // ignore: cast_nullable_to_non_nullable
as List<SceneIllustration>?,segments: null == segments ? _self._segments : segments // ignore: cast_nullable_to_non_nullable
as List<ReadingSegment>,interaction: freezed == interaction ? _self._interaction : interaction // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,attemptedInSession: null == attemptedInSession ? _self.attemptedInSession : attemptedInSession // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$ReadingSegment {

 int get segmentId; int get segmentOrder; int? get startOffset; int? get endOffset; String get text; String? get audioUrl; String? get wordTimingsJson;
/// Create a copy of ReadingSegment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadingSegmentCopyWith<ReadingSegment> get copyWith => _$ReadingSegmentCopyWithImpl<ReadingSegment>(this as ReadingSegment, _$identity);

  /// Serializes this ReadingSegment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ReadingSegment;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadingSegment&&(identical(other.segmentId, _this.segmentId) || other.segmentId == _this.segmentId)&&(identical(other.segmentOrder, _this.segmentOrder) || other.segmentOrder == _this.segmentOrder)&&(identical(other.startOffset, _this.startOffset) || other.startOffset == _this.startOffset)&&(identical(other.endOffset, _this.endOffset) || other.endOffset == _this.endOffset)&&(identical(other.text, _this.text) || other.text == _this.text)&&(identical(other.audioUrl, _this.audioUrl) || other.audioUrl == _this.audioUrl)&&(identical(other.wordTimingsJson, _this.wordTimingsJson) || other.wordTimingsJson == _this.wordTimingsJson));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ReadingSegment;
  return Object.hash(runtimeType,_this.segmentId,_this.segmentOrder,_this.startOffset,_this.endOffset,_this.text,_this.audioUrl,_this.wordTimingsJson);
}

@override
String toString() {
  final _this = this as ReadingSegment;
  return 'ReadingSegment(segmentId: ${_this.segmentId}, segmentOrder: ${_this.segmentOrder}, startOffset: ${_this.startOffset}, endOffset: ${_this.endOffset}, text: ${_this.text}, audioUrl: ${_this.audioUrl}, wordTimingsJson: ${_this.wordTimingsJson})';
}


}

/// @nodoc
abstract mixin class $ReadingSegmentCopyWith<$Res>  {
  factory $ReadingSegmentCopyWith(ReadingSegment value, $Res Function(ReadingSegment) _then) = _$ReadingSegmentCopyWithImpl;
@useResult
$Res call({
 int segmentId, int segmentOrder, int? startOffset, int? endOffset, String text, String? audioUrl, String? wordTimingsJson
});




}
/// @nodoc
class _$ReadingSegmentCopyWithImpl<$Res>
    implements $ReadingSegmentCopyWith<$Res> {
  _$ReadingSegmentCopyWithImpl(this._self, this._then);

  final ReadingSegment _self;
  final $Res Function(ReadingSegment) _then;

/// Create a copy of ReadingSegment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? segmentId = null,Object? segmentOrder = null,Object? startOffset = freezed,Object? endOffset = freezed,Object? text = null,Object? audioUrl = freezed,Object? wordTimingsJson = freezed,}) {
  return _then(ReadingSegment(
segmentId: null == segmentId ? _self.segmentId : segmentId // ignore: cast_nullable_to_non_nullable
as int,segmentOrder: null == segmentOrder ? _self.segmentOrder : segmentOrder // ignore: cast_nullable_to_non_nullable
as int,startOffset: freezed == startOffset ? _self.startOffset : startOffset // ignore: cast_nullable_to_non_nullable
as int?,endOffset: freezed == endOffset ? _self.endOffset : endOffset // ignore: cast_nullable_to_non_nullable
as int?,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,audioUrl: freezed == audioUrl ? _self.audioUrl : audioUrl // ignore: cast_nullable_to_non_nullable
as String?,wordTimingsJson: freezed == wordTimingsJson ? _self.wordTimingsJson : wordTimingsJson // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReadingSegment].
extension ReadingSegmentPatterns on ReadingSegment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReadingSegment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReadingSegment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReadingSegment value)  $default,){
final _that = this;
switch (_that) {
case _ReadingSegment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReadingSegment value)?  $default,){
final _that = this;
switch (_that) {
case _ReadingSegment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int segmentId,  int segmentOrder,  int? startOffset,  int? endOffset,  String text,  String? audioUrl,  String? wordTimingsJson)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReadingSegment() when $default != null:
return $default(_that.segmentId,_that.segmentOrder,_that.startOffset,_that.endOffset,_that.text,_that.audioUrl,_that.wordTimingsJson);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int segmentId,  int segmentOrder,  int? startOffset,  int? endOffset,  String text,  String? audioUrl,  String? wordTimingsJson)  $default,) {final _that = this;
switch (_that) {
case _ReadingSegment():
return $default(_that.segmentId,_that.segmentOrder,_that.startOffset,_that.endOffset,_that.text,_that.audioUrl,_that.wordTimingsJson);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int segmentId,  int segmentOrder,  int? startOffset,  int? endOffset,  String text,  String? audioUrl,  String? wordTimingsJson)?  $default,) {final _that = this;
switch (_that) {
case _ReadingSegment() when $default != null:
return $default(_that.segmentId,_that.segmentOrder,_that.startOffset,_that.endOffset,_that.text,_that.audioUrl,_that.wordTimingsJson);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReadingSegment implements ReadingSegment {
  const _ReadingSegment({required this.segmentId, required this.segmentOrder, this.startOffset, this.endOffset, required this.text, this.audioUrl, this.wordTimingsJson});
  factory _ReadingSegment.fromJson(Map<String, dynamic> json) => _$ReadingSegmentFromJson(json);

@override final  int segmentId;
@override final  int segmentOrder;
@override final  int? startOffset;
@override final  int? endOffset;
@override final  String text;
@override final  String? audioUrl;
@override final  String? wordTimingsJson;

/// Create a copy of ReadingSegment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadingSegmentCopyWith<_ReadingSegment> get copyWith => __$ReadingSegmentCopyWithImpl<_ReadingSegment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReadingSegmentToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReadingSegment&&(identical(other.segmentId, segmentId) || other.segmentId == segmentId)&&(identical(other.segmentOrder, segmentOrder) || other.segmentOrder == segmentOrder)&&(identical(other.startOffset, startOffset) || other.startOffset == startOffset)&&(identical(other.endOffset, endOffset) || other.endOffset == endOffset)&&(identical(other.text, text) || other.text == text)&&(identical(other.audioUrl, audioUrl) || other.audioUrl == audioUrl)&&(identical(other.wordTimingsJson, wordTimingsJson) || other.wordTimingsJson == wordTimingsJson));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,segmentId,segmentOrder,startOffset,endOffset,text,audioUrl,wordTimingsJson);
}

@override
String toString() {
    return 'ReadingSegment(segmentId: $segmentId, segmentOrder: $segmentOrder, startOffset: $startOffset, endOffset: $endOffset, text: $text, audioUrl: $audioUrl, wordTimingsJson: $wordTimingsJson)';
}


}

/// @nodoc
abstract mixin class _$ReadingSegmentCopyWith<$Res> implements $ReadingSegmentCopyWith<$Res> {
  factory _$ReadingSegmentCopyWith(_ReadingSegment value, $Res Function(_ReadingSegment) _then) = __$ReadingSegmentCopyWithImpl;
@override @useResult
$Res call({
 int segmentId, int segmentOrder, int? startOffset, int? endOffset, String text, String? audioUrl, String? wordTimingsJson
});




}
/// @nodoc
class __$ReadingSegmentCopyWithImpl<$Res>
    implements _$ReadingSegmentCopyWith<$Res> {
  __$ReadingSegmentCopyWithImpl(this._self, this._then);

  final _ReadingSegment _self;
  final $Res Function(_ReadingSegment) _then;

/// Create a copy of ReadingSegment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? segmentId = null,Object? segmentOrder = null,Object? startOffset = freezed,Object? endOffset = freezed,Object? text = null,Object? audioUrl = freezed,Object? wordTimingsJson = freezed,}) {
  return _then(_ReadingSegment(
segmentId: null == segmentId ? _self.segmentId : segmentId // ignore: cast_nullable_to_non_nullable
as int,segmentOrder: null == segmentOrder ? _self.segmentOrder : segmentOrder // ignore: cast_nullable_to_non_nullable
as int,startOffset: freezed == startOffset ? _self.startOffset : startOffset // ignore: cast_nullable_to_non_nullable
as int?,endOffset: freezed == endOffset ? _self.endOffset : endOffset // ignore: cast_nullable_to_non_nullable
as int?,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,audioUrl: freezed == audioUrl ? _self.audioUrl : audioUrl // ignore: cast_nullable_to_non_nullable
as String?,wordTimingsJson: freezed == wordTimingsJson ? _self.wordTimingsJson : wordTimingsJson // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$SceneIllustration {

 int get beatOrder; int get startOffset; int get endOffset; String? get url;
/// Create a copy of SceneIllustration
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SceneIllustrationCopyWith<SceneIllustration> get copyWith => _$SceneIllustrationCopyWithImpl<SceneIllustration>(this as SceneIllustration, _$identity);

  /// Serializes this SceneIllustration to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SceneIllustration;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SceneIllustration&&(identical(other.beatOrder, _this.beatOrder) || other.beatOrder == _this.beatOrder)&&(identical(other.startOffset, _this.startOffset) || other.startOffset == _this.startOffset)&&(identical(other.endOffset, _this.endOffset) || other.endOffset == _this.endOffset)&&(identical(other.url, _this.url) || other.url == _this.url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SceneIllustration;
  return Object.hash(runtimeType,_this.beatOrder,_this.startOffset,_this.endOffset,_this.url);
}

@override
String toString() {
  final _this = this as SceneIllustration;
  return 'SceneIllustration(beatOrder: ${_this.beatOrder}, startOffset: ${_this.startOffset}, endOffset: ${_this.endOffset}, url: ${_this.url})';
}


}

/// @nodoc
abstract mixin class $SceneIllustrationCopyWith<$Res>  {
  factory $SceneIllustrationCopyWith(SceneIllustration value, $Res Function(SceneIllustration) _then) = _$SceneIllustrationCopyWithImpl;
@useResult
$Res call({
 int beatOrder, int startOffset, int endOffset, String? url
});




}
/// @nodoc
class _$SceneIllustrationCopyWithImpl<$Res>
    implements $SceneIllustrationCopyWith<$Res> {
  _$SceneIllustrationCopyWithImpl(this._self, this._then);

  final SceneIllustration _self;
  final $Res Function(SceneIllustration) _then;

/// Create a copy of SceneIllustration
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? beatOrder = null,Object? startOffset = null,Object? endOffset = null,Object? url = freezed,}) {
  return _then(SceneIllustration(
beatOrder: null == beatOrder ? _self.beatOrder : beatOrder // ignore: cast_nullable_to_non_nullable
as int,startOffset: null == startOffset ? _self.startOffset : startOffset // ignore: cast_nullable_to_non_nullable
as int,endOffset: null == endOffset ? _self.endOffset : endOffset // ignore: cast_nullable_to_non_nullable
as int,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SceneIllustration].
extension SceneIllustrationPatterns on SceneIllustration {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SceneIllustration value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SceneIllustration() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SceneIllustration value)  $default,){
final _that = this;
switch (_that) {
case _SceneIllustration():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SceneIllustration value)?  $default,){
final _that = this;
switch (_that) {
case _SceneIllustration() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int beatOrder,  int startOffset,  int endOffset,  String? url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SceneIllustration() when $default != null:
return $default(_that.beatOrder,_that.startOffset,_that.endOffset,_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int beatOrder,  int startOffset,  int endOffset,  String? url)  $default,) {final _that = this;
switch (_that) {
case _SceneIllustration():
return $default(_that.beatOrder,_that.startOffset,_that.endOffset,_that.url);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int beatOrder,  int startOffset,  int endOffset,  String? url)?  $default,) {final _that = this;
switch (_that) {
case _SceneIllustration() when $default != null:
return $default(_that.beatOrder,_that.startOffset,_that.endOffset,_that.url);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SceneIllustration implements SceneIllustration {
  const _SceneIllustration({required this.beatOrder, required this.startOffset, required this.endOffset, this.url});
  factory _SceneIllustration.fromJson(Map<String, dynamic> json) => _$SceneIllustrationFromJson(json);

@override final  int beatOrder;
@override final  int startOffset;
@override final  int endOffset;
@override final  String? url;

/// Create a copy of SceneIllustration
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SceneIllustrationCopyWith<_SceneIllustration> get copyWith => __$SceneIllustrationCopyWithImpl<_SceneIllustration>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SceneIllustrationToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SceneIllustration&&(identical(other.beatOrder, beatOrder) || other.beatOrder == beatOrder)&&(identical(other.startOffset, startOffset) || other.startOffset == startOffset)&&(identical(other.endOffset, endOffset) || other.endOffset == endOffset)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,beatOrder,startOffset,endOffset,url);
}

@override
String toString() {
    return 'SceneIllustration(beatOrder: $beatOrder, startOffset: $startOffset, endOffset: $endOffset, url: $url)';
}


}

/// @nodoc
abstract mixin class _$SceneIllustrationCopyWith<$Res> implements $SceneIllustrationCopyWith<$Res> {
  factory _$SceneIllustrationCopyWith(_SceneIllustration value, $Res Function(_SceneIllustration) _then) = __$SceneIllustrationCopyWithImpl;
@override @useResult
$Res call({
 int beatOrder, int startOffset, int endOffset, String? url
});




}
/// @nodoc
class __$SceneIllustrationCopyWithImpl<$Res>
    implements _$SceneIllustrationCopyWith<$Res> {
  __$SceneIllustrationCopyWithImpl(this._self, this._then);

  final _SceneIllustration _self;
  final $Res Function(_SceneIllustration) _then;

/// Create a copy of SceneIllustration
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? beatOrder = null,Object? startOffset = null,Object? endOffset = null,Object? url = freezed,}) {
  return _then(_SceneIllustration(
beatOrder: null == beatOrder ? _self.beatOrder : beatOrder // ignore: cast_nullable_to_non_nullable
as int,startOffset: null == startOffset ? _self.startOffset : startOffset // ignore: cast_nullable_to_non_nullable
as int,endOffset: null == endOffset ? _self.endOffset : endOffset // ignore: cast_nullable_to_non_nullable
as int,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ReadingProgress {

 int get sessionId; int get page; String? get readingMode; int get timeSpentSeconds;
/// Create a copy of ReadingProgress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadingProgressCopyWith<ReadingProgress> get copyWith => _$ReadingProgressCopyWithImpl<ReadingProgress>(this as ReadingProgress, _$identity);

  /// Serializes this ReadingProgress to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ReadingProgress;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadingProgress&&(identical(other.sessionId, _this.sessionId) || other.sessionId == _this.sessionId)&&(identical(other.page, _this.page) || other.page == _this.page)&&(identical(other.readingMode, _this.readingMode) || other.readingMode == _this.readingMode)&&(identical(other.timeSpentSeconds, _this.timeSpentSeconds) || other.timeSpentSeconds == _this.timeSpentSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ReadingProgress;
  return Object.hash(runtimeType,_this.sessionId,_this.page,_this.readingMode,_this.timeSpentSeconds);
}

@override
String toString() {
  final _this = this as ReadingProgress;
  return 'ReadingProgress(sessionId: ${_this.sessionId}, page: ${_this.page}, readingMode: ${_this.readingMode}, timeSpentSeconds: ${_this.timeSpentSeconds})';
}


}

/// @nodoc
abstract mixin class $ReadingProgressCopyWith<$Res>  {
  factory $ReadingProgressCopyWith(ReadingProgress value, $Res Function(ReadingProgress) _then) = _$ReadingProgressCopyWithImpl;
@useResult
$Res call({
 int sessionId, int page, String? readingMode, int timeSpentSeconds
});




}
/// @nodoc
class _$ReadingProgressCopyWithImpl<$Res>
    implements $ReadingProgressCopyWith<$Res> {
  _$ReadingProgressCopyWithImpl(this._self, this._then);

  final ReadingProgress _self;
  final $Res Function(ReadingProgress) _then;

/// Create a copy of ReadingProgress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionId = null,Object? page = null,Object? readingMode = freezed,Object? timeSpentSeconds = null,}) {
  return _then(ReadingProgress(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,readingMode: freezed == readingMode ? _self.readingMode : readingMode // ignore: cast_nullable_to_non_nullable
as String?,timeSpentSeconds: null == timeSpentSeconds ? _self.timeSpentSeconds : timeSpentSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ReadingProgress].
extension ReadingProgressPatterns on ReadingProgress {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReadingProgress value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReadingProgress() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReadingProgress value)  $default,){
final _that = this;
switch (_that) {
case _ReadingProgress():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReadingProgress value)?  $default,){
final _that = this;
switch (_that) {
case _ReadingProgress() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int sessionId,  int page,  String? readingMode,  int timeSpentSeconds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReadingProgress() when $default != null:
return $default(_that.sessionId,_that.page,_that.readingMode,_that.timeSpentSeconds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int sessionId,  int page,  String? readingMode,  int timeSpentSeconds)  $default,) {final _that = this;
switch (_that) {
case _ReadingProgress():
return $default(_that.sessionId,_that.page,_that.readingMode,_that.timeSpentSeconds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int sessionId,  int page,  String? readingMode,  int timeSpentSeconds)?  $default,) {final _that = this;
switch (_that) {
case _ReadingProgress() when $default != null:
return $default(_that.sessionId,_that.page,_that.readingMode,_that.timeSpentSeconds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReadingProgress implements ReadingProgress {
  const _ReadingProgress({required this.sessionId, required this.page, this.readingMode, this.timeSpentSeconds = 0});
  factory _ReadingProgress.fromJson(Map<String, dynamic> json) => _$ReadingProgressFromJson(json);

@override final  int sessionId;
@override final  int page;
@override final  String? readingMode;
@override@JsonKey() final  int timeSpentSeconds;

/// Create a copy of ReadingProgress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadingProgressCopyWith<_ReadingProgress> get copyWith => __$ReadingProgressCopyWithImpl<_ReadingProgress>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReadingProgressToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReadingProgress&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.page, page) || other.page == page)&&(identical(other.readingMode, readingMode) || other.readingMode == readingMode)&&(identical(other.timeSpentSeconds, timeSpentSeconds) || other.timeSpentSeconds == timeSpentSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,sessionId,page,readingMode,timeSpentSeconds);
}

@override
String toString() {
    return 'ReadingProgress(sessionId: $sessionId, page: $page, readingMode: $readingMode, timeSpentSeconds: $timeSpentSeconds)';
}


}

/// @nodoc
abstract mixin class _$ReadingProgressCopyWith<$Res> implements $ReadingProgressCopyWith<$Res> {
  factory _$ReadingProgressCopyWith(_ReadingProgress value, $Res Function(_ReadingProgress) _then) = __$ReadingProgressCopyWithImpl;
@override @useResult
$Res call({
 int sessionId, int page, String? readingMode, int timeSpentSeconds
});




}
/// @nodoc
class __$ReadingProgressCopyWithImpl<$Res>
    implements _$ReadingProgressCopyWith<$Res> {
  __$ReadingProgressCopyWithImpl(this._self, this._then);

  final _ReadingProgress _self;
  final $Res Function(_ReadingProgress) _then;

/// Create a copy of ReadingProgress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionId = null,Object? page = null,Object? readingMode = freezed,Object? timeSpentSeconds = null,}) {
  return _then(_ReadingProgress(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,readingMode: freezed == readingMode ? _self.readingMode : readingMode // ignore: cast_nullable_to_non_nullable
as String?,timeSpentSeconds: null == timeSpentSeconds ? _self.timeSpentSeconds : timeSpentSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ReadingCompleted {

 int get sessionId; int get storyId; bool get isRetake; bool get roadmapStepCompleted; int get expGained; List<String> get newBadges;
/// Create a copy of ReadingCompleted
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadingCompletedCopyWith<ReadingCompleted> get copyWith => _$ReadingCompletedCopyWithImpl<ReadingCompleted>(this as ReadingCompleted, _$identity);

  /// Serializes this ReadingCompleted to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ReadingCompleted;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadingCompleted&&(identical(other.sessionId, _this.sessionId) || other.sessionId == _this.sessionId)&&(identical(other.storyId, _this.storyId) || other.storyId == _this.storyId)&&(identical(other.isRetake, _this.isRetake) || other.isRetake == _this.isRetake)&&(identical(other.roadmapStepCompleted, _this.roadmapStepCompleted) || other.roadmapStepCompleted == _this.roadmapStepCompleted)&&(identical(other.expGained, _this.expGained) || other.expGained == _this.expGained)&&const DeepCollectionEquality().equals(other.newBadges, _this.newBadges));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ReadingCompleted;
  return Object.hash(runtimeType,_this.sessionId,_this.storyId,_this.isRetake,_this.roadmapStepCompleted,_this.expGained,const DeepCollectionEquality().hash(_this.newBadges));
}

@override
String toString() {
  final _this = this as ReadingCompleted;
  return 'ReadingCompleted(sessionId: ${_this.sessionId}, storyId: ${_this.storyId}, isRetake: ${_this.isRetake}, roadmapStepCompleted: ${_this.roadmapStepCompleted}, expGained: ${_this.expGained}, newBadges: ${_this.newBadges})';
}


}

/// @nodoc
abstract mixin class $ReadingCompletedCopyWith<$Res>  {
  factory $ReadingCompletedCopyWith(ReadingCompleted value, $Res Function(ReadingCompleted) _then) = _$ReadingCompletedCopyWithImpl;
@useResult
$Res call({
 int sessionId, int storyId, bool isRetake, bool roadmapStepCompleted, int expGained, List<String> newBadges
});




}
/// @nodoc
class _$ReadingCompletedCopyWithImpl<$Res>
    implements $ReadingCompletedCopyWith<$Res> {
  _$ReadingCompletedCopyWithImpl(this._self, this._then);

  final ReadingCompleted _self;
  final $Res Function(ReadingCompleted) _then;

/// Create a copy of ReadingCompleted
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionId = null,Object? storyId = null,Object? isRetake = null,Object? roadmapStepCompleted = null,Object? expGained = null,Object? newBadges = null,}) {
  return _then(ReadingCompleted(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as int,storyId: null == storyId ? _self.storyId : storyId // ignore: cast_nullable_to_non_nullable
as int,isRetake: null == isRetake ? _self.isRetake : isRetake // ignore: cast_nullable_to_non_nullable
as bool,roadmapStepCompleted: null == roadmapStepCompleted ? _self.roadmapStepCompleted : roadmapStepCompleted // ignore: cast_nullable_to_non_nullable
as bool,expGained: null == expGained ? _self.expGained : expGained // ignore: cast_nullable_to_non_nullable
as int,newBadges: null == newBadges ? _self.newBadges : newBadges // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [ReadingCompleted].
extension ReadingCompletedPatterns on ReadingCompleted {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReadingCompleted value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReadingCompleted() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReadingCompleted value)  $default,){
final _that = this;
switch (_that) {
case _ReadingCompleted():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReadingCompleted value)?  $default,){
final _that = this;
switch (_that) {
case _ReadingCompleted() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int sessionId,  int storyId,  bool isRetake,  bool roadmapStepCompleted,  int expGained,  List<String> newBadges)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReadingCompleted() when $default != null:
return $default(_that.sessionId,_that.storyId,_that.isRetake,_that.roadmapStepCompleted,_that.expGained,_that.newBadges);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int sessionId,  int storyId,  bool isRetake,  bool roadmapStepCompleted,  int expGained,  List<String> newBadges)  $default,) {final _that = this;
switch (_that) {
case _ReadingCompleted():
return $default(_that.sessionId,_that.storyId,_that.isRetake,_that.roadmapStepCompleted,_that.expGained,_that.newBadges);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int sessionId,  int storyId,  bool isRetake,  bool roadmapStepCompleted,  int expGained,  List<String> newBadges)?  $default,) {final _that = this;
switch (_that) {
case _ReadingCompleted() when $default != null:
return $default(_that.sessionId,_that.storyId,_that.isRetake,_that.roadmapStepCompleted,_that.expGained,_that.newBadges);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReadingCompleted implements ReadingCompleted {
  const _ReadingCompleted({required this.sessionId, required this.storyId, this.isRetake = false, this.roadmapStepCompleted = false, this.expGained = 0,  List<String> newBadges = const <String>[]}): _newBadges = newBadges;
  factory _ReadingCompleted.fromJson(Map<String, dynamic> json) => _$ReadingCompletedFromJson(json);

@override final  int sessionId;
@override final  int storyId;
@override@JsonKey() final  bool isRetake;
@override@JsonKey() final  bool roadmapStepCompleted;
@override@JsonKey() final  int expGained;
 final  List<String> _newBadges;
@override@JsonKey() List<String> get newBadges {
  if (_newBadges is EqualUnmodifiableListView) return _newBadges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_newBadges);
}


/// Create a copy of ReadingCompleted
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadingCompletedCopyWith<_ReadingCompleted> get copyWith => __$ReadingCompletedCopyWithImpl<_ReadingCompleted>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReadingCompletedToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReadingCompleted&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.storyId, storyId) || other.storyId == storyId)&&(identical(other.isRetake, isRetake) || other.isRetake == isRetake)&&(identical(other.roadmapStepCompleted, roadmapStepCompleted) || other.roadmapStepCompleted == roadmapStepCompleted)&&(identical(other.expGained, expGained) || other.expGained == expGained)&&const DeepCollectionEquality().equals(other.newBadges, _newBadges));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,sessionId,storyId,isRetake,roadmapStepCompleted,expGained,const DeepCollectionEquality().hash(_newBadges));
}

@override
String toString() {
    return 'ReadingCompleted(sessionId: $sessionId, storyId: $storyId, isRetake: $isRetake, roadmapStepCompleted: $roadmapStepCompleted, expGained: $expGained, newBadges: $newBadges)';
}


}

/// @nodoc
abstract mixin class _$ReadingCompletedCopyWith<$Res> implements $ReadingCompletedCopyWith<$Res> {
  factory _$ReadingCompletedCopyWith(_ReadingCompleted value, $Res Function(_ReadingCompleted) _then) = __$ReadingCompletedCopyWithImpl;
@override @useResult
$Res call({
 int sessionId, int storyId, bool isRetake, bool roadmapStepCompleted, int expGained, List<String> newBadges
});




}
/// @nodoc
class __$ReadingCompletedCopyWithImpl<$Res>
    implements _$ReadingCompletedCopyWith<$Res> {
  __$ReadingCompletedCopyWithImpl(this._self, this._then);

  final _ReadingCompleted _self;
  final $Res Function(_ReadingCompleted) _then;

/// Create a copy of ReadingCompleted
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionId = null,Object? storyId = null,Object? isRetake = null,Object? roadmapStepCompleted = null,Object? expGained = null,Object? newBadges = null,}) {
  return _then(_ReadingCompleted(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as int,storyId: null == storyId ? _self.storyId : storyId // ignore: cast_nullable_to_non_nullable
as int,isRetake: null == isRetake ? _self.isRetake : isRetake // ignore: cast_nullable_to_non_nullable
as bool,roadmapStepCompleted: null == roadmapStepCompleted ? _self.roadmapStepCompleted : roadmapStepCompleted // ignore: cast_nullable_to_non_nullable
as bool,expGained: null == expGained ? _self.expGained : expGained // ignore: cast_nullable_to_non_nullable
as int,newBadges: null == newBadges ? _self._newBadges : newBadges // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$ReadingSignal {

 bool get shouldExit; String? get returnTo; String? get message; String get sessionStatus;
/// Create a copy of ReadingSignal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadingSignalCopyWith<ReadingSignal> get copyWith => _$ReadingSignalCopyWithImpl<ReadingSignal>(this as ReadingSignal, _$identity);

  /// Serializes this ReadingSignal to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ReadingSignal;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadingSignal&&(identical(other.shouldExit, _this.shouldExit) || other.shouldExit == _this.shouldExit)&&(identical(other.returnTo, _this.returnTo) || other.returnTo == _this.returnTo)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.sessionStatus, _this.sessionStatus) || other.sessionStatus == _this.sessionStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ReadingSignal;
  return Object.hash(runtimeType,_this.shouldExit,_this.returnTo,_this.message,_this.sessionStatus);
}

@override
String toString() {
  final _this = this as ReadingSignal;
  return 'ReadingSignal(shouldExit: ${_this.shouldExit}, returnTo: ${_this.returnTo}, message: ${_this.message}, sessionStatus: ${_this.sessionStatus})';
}


}

/// @nodoc
abstract mixin class $ReadingSignalCopyWith<$Res>  {
  factory $ReadingSignalCopyWith(ReadingSignal value, $Res Function(ReadingSignal) _then) = _$ReadingSignalCopyWithImpl;
@useResult
$Res call({
 bool shouldExit, String? returnTo, String? message, String sessionStatus
});




}
/// @nodoc
class _$ReadingSignalCopyWithImpl<$Res>
    implements $ReadingSignalCopyWith<$Res> {
  _$ReadingSignalCopyWithImpl(this._self, this._then);

  final ReadingSignal _self;
  final $Res Function(ReadingSignal) _then;

/// Create a copy of ReadingSignal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? shouldExit = null,Object? returnTo = freezed,Object? message = freezed,Object? sessionStatus = null,}) {
  return _then(ReadingSignal(
shouldExit: null == shouldExit ? _self.shouldExit : shouldExit // ignore: cast_nullable_to_non_nullable
as bool,returnTo: freezed == returnTo ? _self.returnTo : returnTo // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,sessionStatus: null == sessionStatus ? _self.sessionStatus : sessionStatus // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ReadingSignal].
extension ReadingSignalPatterns on ReadingSignal {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReadingSignal value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReadingSignal() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReadingSignal value)  $default,){
final _that = this;
switch (_that) {
case _ReadingSignal():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReadingSignal value)?  $default,){
final _that = this;
switch (_that) {
case _ReadingSignal() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool shouldExit,  String? returnTo,  String? message,  String sessionStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReadingSignal() when $default != null:
return $default(_that.shouldExit,_that.returnTo,_that.message,_that.sessionStatus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool shouldExit,  String? returnTo,  String? message,  String sessionStatus)  $default,) {final _that = this;
switch (_that) {
case _ReadingSignal():
return $default(_that.shouldExit,_that.returnTo,_that.message,_that.sessionStatus);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool shouldExit,  String? returnTo,  String? message,  String sessionStatus)?  $default,) {final _that = this;
switch (_that) {
case _ReadingSignal() when $default != null:
return $default(_that.shouldExit,_that.returnTo,_that.message,_that.sessionStatus);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReadingSignal implements ReadingSignal {
  const _ReadingSignal({this.shouldExit = false, this.returnTo, this.message, required this.sessionStatus});
  factory _ReadingSignal.fromJson(Map<String, dynamic> json) => _$ReadingSignalFromJson(json);

@override@JsonKey() final  bool shouldExit;
@override final  String? returnTo;
@override final  String? message;
@override final  String sessionStatus;

/// Create a copy of ReadingSignal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadingSignalCopyWith<_ReadingSignal> get copyWith => __$ReadingSignalCopyWithImpl<_ReadingSignal>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReadingSignalToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReadingSignal&&(identical(other.shouldExit, shouldExit) || other.shouldExit == shouldExit)&&(identical(other.returnTo, returnTo) || other.returnTo == returnTo)&&(identical(other.message, message) || other.message == message)&&(identical(other.sessionStatus, sessionStatus) || other.sessionStatus == sessionStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,shouldExit,returnTo,message,sessionStatus);
}

@override
String toString() {
    return 'ReadingSignal(shouldExit: $shouldExit, returnTo: $returnTo, message: $message, sessionStatus: $sessionStatus)';
}


}

/// @nodoc
abstract mixin class _$ReadingSignalCopyWith<$Res> implements $ReadingSignalCopyWith<$Res> {
  factory _$ReadingSignalCopyWith(_ReadingSignal value, $Res Function(_ReadingSignal) _then) = __$ReadingSignalCopyWithImpl;
@override @useResult
$Res call({
 bool shouldExit, String? returnTo, String? message, String sessionStatus
});




}
/// @nodoc
class __$ReadingSignalCopyWithImpl<$Res>
    implements _$ReadingSignalCopyWith<$Res> {
  __$ReadingSignalCopyWithImpl(this._self, this._then);

  final _ReadingSignal _self;
  final $Res Function(_ReadingSignal) _then;

/// Create a copy of ReadingSignal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? shouldExit = null,Object? returnTo = freezed,Object? message = freezed,Object? sessionStatus = null,}) {
  return _then(_ReadingSignal(
shouldExit: null == shouldExit ? _self.shouldExit : shouldExit // ignore: cast_nullable_to_non_nullable
as bool,returnTo: freezed == returnTo ? _self.returnTo : returnTo // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,sessionStatus: null == sessionStatus ? _self.sessionStatus : sessionStatus // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$VocabularyDefinition {

 int get vocabularyId; String get term; String get definition; bool get isCollected;
/// Create a copy of VocabularyDefinition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VocabularyDefinitionCopyWith<VocabularyDefinition> get copyWith => _$VocabularyDefinitionCopyWithImpl<VocabularyDefinition>(this as VocabularyDefinition, _$identity);

  /// Serializes this VocabularyDefinition to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as VocabularyDefinition;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VocabularyDefinition&&(identical(other.vocabularyId, _this.vocabularyId) || other.vocabularyId == _this.vocabularyId)&&(identical(other.term, _this.term) || other.term == _this.term)&&(identical(other.definition, _this.definition) || other.definition == _this.definition)&&(identical(other.isCollected, _this.isCollected) || other.isCollected == _this.isCollected));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as VocabularyDefinition;
  return Object.hash(runtimeType,_this.vocabularyId,_this.term,_this.definition,_this.isCollected);
}

@override
String toString() {
  final _this = this as VocabularyDefinition;
  return 'VocabularyDefinition(vocabularyId: ${_this.vocabularyId}, term: ${_this.term}, definition: ${_this.definition}, isCollected: ${_this.isCollected})';
}


}

/// @nodoc
abstract mixin class $VocabularyDefinitionCopyWith<$Res>  {
  factory $VocabularyDefinitionCopyWith(VocabularyDefinition value, $Res Function(VocabularyDefinition) _then) = _$VocabularyDefinitionCopyWithImpl;
@useResult
$Res call({
 int vocabularyId, String term, String definition, bool isCollected
});




}
/// @nodoc
class _$VocabularyDefinitionCopyWithImpl<$Res>
    implements $VocabularyDefinitionCopyWith<$Res> {
  _$VocabularyDefinitionCopyWithImpl(this._self, this._then);

  final VocabularyDefinition _self;
  final $Res Function(VocabularyDefinition) _then;

/// Create a copy of VocabularyDefinition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? vocabularyId = null,Object? term = null,Object? definition = null,Object? isCollected = null,}) {
  return _then(VocabularyDefinition(
vocabularyId: null == vocabularyId ? _self.vocabularyId : vocabularyId // ignore: cast_nullable_to_non_nullable
as int,term: null == term ? _self.term : term // ignore: cast_nullable_to_non_nullable
as String,definition: null == definition ? _self.definition : definition // ignore: cast_nullable_to_non_nullable
as String,isCollected: null == isCollected ? _self.isCollected : isCollected // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [VocabularyDefinition].
extension VocabularyDefinitionPatterns on VocabularyDefinition {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VocabularyDefinition value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VocabularyDefinition() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VocabularyDefinition value)  $default,){
final _that = this;
switch (_that) {
case _VocabularyDefinition():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VocabularyDefinition value)?  $default,){
final _that = this;
switch (_that) {
case _VocabularyDefinition() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int vocabularyId,  String term,  String definition,  bool isCollected)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VocabularyDefinition() when $default != null:
return $default(_that.vocabularyId,_that.term,_that.definition,_that.isCollected);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int vocabularyId,  String term,  String definition,  bool isCollected)  $default,) {final _that = this;
switch (_that) {
case _VocabularyDefinition():
return $default(_that.vocabularyId,_that.term,_that.definition,_that.isCollected);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int vocabularyId,  String term,  String definition,  bool isCollected)?  $default,) {final _that = this;
switch (_that) {
case _VocabularyDefinition() when $default != null:
return $default(_that.vocabularyId,_that.term,_that.definition,_that.isCollected);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VocabularyDefinition implements VocabularyDefinition {
  const _VocabularyDefinition({required this.vocabularyId, required this.term, required this.definition, this.isCollected = false});
  factory _VocabularyDefinition.fromJson(Map<String, dynamic> json) => _$VocabularyDefinitionFromJson(json);

@override final  int vocabularyId;
@override final  String term;
@override final  String definition;
@override@JsonKey() final  bool isCollected;

/// Create a copy of VocabularyDefinition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VocabularyDefinitionCopyWith<_VocabularyDefinition> get copyWith => __$VocabularyDefinitionCopyWithImpl<_VocabularyDefinition>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VocabularyDefinitionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _VocabularyDefinition&&(identical(other.vocabularyId, vocabularyId) || other.vocabularyId == vocabularyId)&&(identical(other.term, term) || other.term == term)&&(identical(other.definition, definition) || other.definition == definition)&&(identical(other.isCollected, isCollected) || other.isCollected == isCollected));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,vocabularyId,term,definition,isCollected);
}

@override
String toString() {
    return 'VocabularyDefinition(vocabularyId: $vocabularyId, term: $term, definition: $definition, isCollected: $isCollected)';
}


}

/// @nodoc
abstract mixin class _$VocabularyDefinitionCopyWith<$Res> implements $VocabularyDefinitionCopyWith<$Res> {
  factory _$VocabularyDefinitionCopyWith(_VocabularyDefinition value, $Res Function(_VocabularyDefinition) _then) = __$VocabularyDefinitionCopyWithImpl;
@override @useResult
$Res call({
 int vocabularyId, String term, String definition, bool isCollected
});




}
/// @nodoc
class __$VocabularyDefinitionCopyWithImpl<$Res>
    implements _$VocabularyDefinitionCopyWith<$Res> {
  __$VocabularyDefinitionCopyWithImpl(this._self, this._then);

  final _VocabularyDefinition _self;
  final $Res Function(_VocabularyDefinition) _then;

/// Create a copy of VocabularyDefinition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? vocabularyId = null,Object? term = null,Object? definition = null,Object? isCollected = null,}) {
  return _then(_VocabularyDefinition(
vocabularyId: null == vocabularyId ? _self.vocabularyId : vocabularyId // ignore: cast_nullable_to_non_nullable
as int,term: null == term ? _self.term : term // ignore: cast_nullable_to_non_nullable
as String,definition: null == definition ? _self.definition : definition // ignore: cast_nullable_to_non_nullable
as String,isCollected: null == isCollected ? _self.isCollected : isCollected // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$NotebookEntry {

 int get entryId; int get vocabularyId; String get term; String get definition; int get storyId; String get storyTitle; int? get sceneIndex; String get collectedAt;
/// Create a copy of NotebookEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotebookEntryCopyWith<NotebookEntry> get copyWith => _$NotebookEntryCopyWithImpl<NotebookEntry>(this as NotebookEntry, _$identity);

  /// Serializes this NotebookEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as NotebookEntry;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotebookEntry&&(identical(other.entryId, _this.entryId) || other.entryId == _this.entryId)&&(identical(other.vocabularyId, _this.vocabularyId) || other.vocabularyId == _this.vocabularyId)&&(identical(other.term, _this.term) || other.term == _this.term)&&(identical(other.definition, _this.definition) || other.definition == _this.definition)&&(identical(other.storyId, _this.storyId) || other.storyId == _this.storyId)&&(identical(other.storyTitle, _this.storyTitle) || other.storyTitle == _this.storyTitle)&&(identical(other.sceneIndex, _this.sceneIndex) || other.sceneIndex == _this.sceneIndex)&&(identical(other.collectedAt, _this.collectedAt) || other.collectedAt == _this.collectedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as NotebookEntry;
  return Object.hash(runtimeType,_this.entryId,_this.vocabularyId,_this.term,_this.definition,_this.storyId,_this.storyTitle,_this.sceneIndex,_this.collectedAt);
}

@override
String toString() {
  final _this = this as NotebookEntry;
  return 'NotebookEntry(entryId: ${_this.entryId}, vocabularyId: ${_this.vocabularyId}, term: ${_this.term}, definition: ${_this.definition}, storyId: ${_this.storyId}, storyTitle: ${_this.storyTitle}, sceneIndex: ${_this.sceneIndex}, collectedAt: ${_this.collectedAt})';
}


}

/// @nodoc
abstract mixin class $NotebookEntryCopyWith<$Res>  {
  factory $NotebookEntryCopyWith(NotebookEntry value, $Res Function(NotebookEntry) _then) = _$NotebookEntryCopyWithImpl;
@useResult
$Res call({
 int entryId, int vocabularyId, String term, String definition, int storyId, String storyTitle, int? sceneIndex, String collectedAt
});




}
/// @nodoc
class _$NotebookEntryCopyWithImpl<$Res>
    implements $NotebookEntryCopyWith<$Res> {
  _$NotebookEntryCopyWithImpl(this._self, this._then);

  final NotebookEntry _self;
  final $Res Function(NotebookEntry) _then;

/// Create a copy of NotebookEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? entryId = null,Object? vocabularyId = null,Object? term = null,Object? definition = null,Object? storyId = null,Object? storyTitle = null,Object? sceneIndex = freezed,Object? collectedAt = null,}) {
  return _then(NotebookEntry(
entryId: null == entryId ? _self.entryId : entryId // ignore: cast_nullable_to_non_nullable
as int,vocabularyId: null == vocabularyId ? _self.vocabularyId : vocabularyId // ignore: cast_nullable_to_non_nullable
as int,term: null == term ? _self.term : term // ignore: cast_nullable_to_non_nullable
as String,definition: null == definition ? _self.definition : definition // ignore: cast_nullable_to_non_nullable
as String,storyId: null == storyId ? _self.storyId : storyId // ignore: cast_nullable_to_non_nullable
as int,storyTitle: null == storyTitle ? _self.storyTitle : storyTitle // ignore: cast_nullable_to_non_nullable
as String,sceneIndex: freezed == sceneIndex ? _self.sceneIndex : sceneIndex // ignore: cast_nullable_to_non_nullable
as int?,collectedAt: null == collectedAt ? _self.collectedAt : collectedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [NotebookEntry].
extension NotebookEntryPatterns on NotebookEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotebookEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotebookEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotebookEntry value)  $default,){
final _that = this;
switch (_that) {
case _NotebookEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotebookEntry value)?  $default,){
final _that = this;
switch (_that) {
case _NotebookEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int entryId,  int vocabularyId,  String term,  String definition,  int storyId,  String storyTitle,  int? sceneIndex,  String collectedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotebookEntry() when $default != null:
return $default(_that.entryId,_that.vocabularyId,_that.term,_that.definition,_that.storyId,_that.storyTitle,_that.sceneIndex,_that.collectedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int entryId,  int vocabularyId,  String term,  String definition,  int storyId,  String storyTitle,  int? sceneIndex,  String collectedAt)  $default,) {final _that = this;
switch (_that) {
case _NotebookEntry():
return $default(_that.entryId,_that.vocabularyId,_that.term,_that.definition,_that.storyId,_that.storyTitle,_that.sceneIndex,_that.collectedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int entryId,  int vocabularyId,  String term,  String definition,  int storyId,  String storyTitle,  int? sceneIndex,  String collectedAt)?  $default,) {final _that = this;
switch (_that) {
case _NotebookEntry() when $default != null:
return $default(_that.entryId,_that.vocabularyId,_that.term,_that.definition,_that.storyId,_that.storyTitle,_that.sceneIndex,_that.collectedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotebookEntry implements NotebookEntry {
  const _NotebookEntry({required this.entryId, required this.vocabularyId, required this.term, required this.definition, required this.storyId, required this.storyTitle, this.sceneIndex, required this.collectedAt});
  factory _NotebookEntry.fromJson(Map<String, dynamic> json) => _$NotebookEntryFromJson(json);

@override final  int entryId;
@override final  int vocabularyId;
@override final  String term;
@override final  String definition;
@override final  int storyId;
@override final  String storyTitle;
@override final  int? sceneIndex;
@override final  String collectedAt;

/// Create a copy of NotebookEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotebookEntryCopyWith<_NotebookEntry> get copyWith => __$NotebookEntryCopyWithImpl<_NotebookEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotebookEntryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotebookEntry&&(identical(other.entryId, entryId) || other.entryId == entryId)&&(identical(other.vocabularyId, vocabularyId) || other.vocabularyId == vocabularyId)&&(identical(other.term, term) || other.term == term)&&(identical(other.definition, definition) || other.definition == definition)&&(identical(other.storyId, storyId) || other.storyId == storyId)&&(identical(other.storyTitle, storyTitle) || other.storyTitle == storyTitle)&&(identical(other.sceneIndex, sceneIndex) || other.sceneIndex == sceneIndex)&&(identical(other.collectedAt, collectedAt) || other.collectedAt == collectedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,entryId,vocabularyId,term,definition,storyId,storyTitle,sceneIndex,collectedAt);
}

@override
String toString() {
    return 'NotebookEntry(entryId: $entryId, vocabularyId: $vocabularyId, term: $term, definition: $definition, storyId: $storyId, storyTitle: $storyTitle, sceneIndex: $sceneIndex, collectedAt: $collectedAt)';
}


}

/// @nodoc
abstract mixin class _$NotebookEntryCopyWith<$Res> implements $NotebookEntryCopyWith<$Res> {
  factory _$NotebookEntryCopyWith(_NotebookEntry value, $Res Function(_NotebookEntry) _then) = __$NotebookEntryCopyWithImpl;
@override @useResult
$Res call({
 int entryId, int vocabularyId, String term, String definition, int storyId, String storyTitle, int? sceneIndex, String collectedAt
});




}
/// @nodoc
class __$NotebookEntryCopyWithImpl<$Res>
    implements _$NotebookEntryCopyWith<$Res> {
  __$NotebookEntryCopyWithImpl(this._self, this._then);

  final _NotebookEntry _self;
  final $Res Function(_NotebookEntry) _then;

/// Create a copy of NotebookEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? entryId = null,Object? vocabularyId = null,Object? term = null,Object? definition = null,Object? storyId = null,Object? storyTitle = null,Object? sceneIndex = freezed,Object? collectedAt = null,}) {
  return _then(_NotebookEntry(
entryId: null == entryId ? _self.entryId : entryId // ignore: cast_nullable_to_non_nullable
as int,vocabularyId: null == vocabularyId ? _self.vocabularyId : vocabularyId // ignore: cast_nullable_to_non_nullable
as int,term: null == term ? _self.term : term // ignore: cast_nullable_to_non_nullable
as String,definition: null == definition ? _self.definition : definition // ignore: cast_nullable_to_non_nullable
as String,storyId: null == storyId ? _self.storyId : storyId // ignore: cast_nullable_to_non_nullable
as int,storyTitle: null == storyTitle ? _self.storyTitle : storyTitle // ignore: cast_nullable_to_non_nullable
as String,sceneIndex: freezed == sceneIndex ? _self.sceneIndex : sceneIndex // ignore: cast_nullable_to_non_nullable
as int?,collectedAt: null == collectedAt ? _self.collectedAt : collectedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ReadingFeelingResult {

 int get sessionId; String get feeling; String get label;
/// Create a copy of ReadingFeelingResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadingFeelingResultCopyWith<ReadingFeelingResult> get copyWith => _$ReadingFeelingResultCopyWithImpl<ReadingFeelingResult>(this as ReadingFeelingResult, _$identity);

  /// Serializes this ReadingFeelingResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ReadingFeelingResult;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadingFeelingResult&&(identical(other.sessionId, _this.sessionId) || other.sessionId == _this.sessionId)&&(identical(other.feeling, _this.feeling) || other.feeling == _this.feeling)&&(identical(other.label, _this.label) || other.label == _this.label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ReadingFeelingResult;
  return Object.hash(runtimeType,_this.sessionId,_this.feeling,_this.label);
}

@override
String toString() {
  final _this = this as ReadingFeelingResult;
  return 'ReadingFeelingResult(sessionId: ${_this.sessionId}, feeling: ${_this.feeling}, label: ${_this.label})';
}


}

/// @nodoc
abstract mixin class $ReadingFeelingResultCopyWith<$Res>  {
  factory $ReadingFeelingResultCopyWith(ReadingFeelingResult value, $Res Function(ReadingFeelingResult) _then) = _$ReadingFeelingResultCopyWithImpl;
@useResult
$Res call({
 int sessionId, String feeling, String label
});




}
/// @nodoc
class _$ReadingFeelingResultCopyWithImpl<$Res>
    implements $ReadingFeelingResultCopyWith<$Res> {
  _$ReadingFeelingResultCopyWithImpl(this._self, this._then);

  final ReadingFeelingResult _self;
  final $Res Function(ReadingFeelingResult) _then;

/// Create a copy of ReadingFeelingResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionId = null,Object? feeling = null,Object? label = null,}) {
  return _then(ReadingFeelingResult(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as int,feeling: null == feeling ? _self.feeling : feeling // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ReadingFeelingResult].
extension ReadingFeelingResultPatterns on ReadingFeelingResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReadingFeelingResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReadingFeelingResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReadingFeelingResult value)  $default,){
final _that = this;
switch (_that) {
case _ReadingFeelingResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReadingFeelingResult value)?  $default,){
final _that = this;
switch (_that) {
case _ReadingFeelingResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int sessionId,  String feeling,  String label)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReadingFeelingResult() when $default != null:
return $default(_that.sessionId,_that.feeling,_that.label);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int sessionId,  String feeling,  String label)  $default,) {final _that = this;
switch (_that) {
case _ReadingFeelingResult():
return $default(_that.sessionId,_that.feeling,_that.label);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int sessionId,  String feeling,  String label)?  $default,) {final _that = this;
switch (_that) {
case _ReadingFeelingResult() when $default != null:
return $default(_that.sessionId,_that.feeling,_that.label);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReadingFeelingResult implements ReadingFeelingResult {
  const _ReadingFeelingResult({required this.sessionId, required this.feeling, required this.label});
  factory _ReadingFeelingResult.fromJson(Map<String, dynamic> json) => _$ReadingFeelingResultFromJson(json);

@override final  int sessionId;
@override final  String feeling;
@override final  String label;

/// Create a copy of ReadingFeelingResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadingFeelingResultCopyWith<_ReadingFeelingResult> get copyWith => __$ReadingFeelingResultCopyWithImpl<_ReadingFeelingResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReadingFeelingResultToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReadingFeelingResult&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.feeling, feeling) || other.feeling == feeling)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,sessionId,feeling,label);
}

@override
String toString() {
    return 'ReadingFeelingResult(sessionId: $sessionId, feeling: $feeling, label: $label)';
}


}

/// @nodoc
abstract mixin class _$ReadingFeelingResultCopyWith<$Res> implements $ReadingFeelingResultCopyWith<$Res> {
  factory _$ReadingFeelingResultCopyWith(_ReadingFeelingResult value, $Res Function(_ReadingFeelingResult) _then) = __$ReadingFeelingResultCopyWithImpl;
@override @useResult
$Res call({
 int sessionId, String feeling, String label
});




}
/// @nodoc
class __$ReadingFeelingResultCopyWithImpl<$Res>
    implements _$ReadingFeelingResultCopyWith<$Res> {
  __$ReadingFeelingResultCopyWithImpl(this._self, this._then);

  final _ReadingFeelingResult _self;
  final $Res Function(_ReadingFeelingResult) _then;

/// Create a copy of ReadingFeelingResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionId = null,Object? feeling = null,Object? label = null,}) {
  return _then(_ReadingFeelingResult(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as int,feeling: null == feeling ? _self.feeling : feeling // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ChildQuizItem {

 int get quizItemId; String get type; String get question; List<String>? get choices;
/// Create a copy of ChildQuizItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChildQuizItemCopyWith<ChildQuizItem> get copyWith => _$ChildQuizItemCopyWithImpl<ChildQuizItem>(this as ChildQuizItem, _$identity);

  /// Serializes this ChildQuizItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ChildQuizItem;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChildQuizItem&&(identical(other.quizItemId, _this.quizItemId) || other.quizItemId == _this.quizItemId)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.question, _this.question) || other.question == _this.question)&&const DeepCollectionEquality().equals(other.choices, _this.choices));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChildQuizItem;
  return Object.hash(runtimeType,_this.quizItemId,_this.type,_this.question,const DeepCollectionEquality().hash(_this.choices));
}

@override
String toString() {
  final _this = this as ChildQuizItem;
  return 'ChildQuizItem(quizItemId: ${_this.quizItemId}, type: ${_this.type}, question: ${_this.question}, choices: ${_this.choices})';
}


}

/// @nodoc
abstract mixin class $ChildQuizItemCopyWith<$Res>  {
  factory $ChildQuizItemCopyWith(ChildQuizItem value, $Res Function(ChildQuizItem) _then) = _$ChildQuizItemCopyWithImpl;
@useResult
$Res call({
 int quizItemId, String type, String question, List<String>? choices
});




}
/// @nodoc
class _$ChildQuizItemCopyWithImpl<$Res>
    implements $ChildQuizItemCopyWith<$Res> {
  _$ChildQuizItemCopyWithImpl(this._self, this._then);

  final ChildQuizItem _self;
  final $Res Function(ChildQuizItem) _then;

/// Create a copy of ChildQuizItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? quizItemId = null,Object? type = null,Object? question = null,Object? choices = freezed,}) {
  return _then(ChildQuizItem(
quizItemId: null == quizItemId ? _self.quizItemId : quizItemId // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,choices: freezed == choices ? _self.choices : choices // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChildQuizItem].
extension ChildQuizItemPatterns on ChildQuizItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChildQuizItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChildQuizItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChildQuizItem value)  $default,){
final _that = this;
switch (_that) {
case _ChildQuizItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChildQuizItem value)?  $default,){
final _that = this;
switch (_that) {
case _ChildQuizItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int quizItemId,  String type,  String question,  List<String>? choices)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChildQuizItem() when $default != null:
return $default(_that.quizItemId,_that.type,_that.question,_that.choices);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int quizItemId,  String type,  String question,  List<String>? choices)  $default,) {final _that = this;
switch (_that) {
case _ChildQuizItem():
return $default(_that.quizItemId,_that.type,_that.question,_that.choices);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int quizItemId,  String type,  String question,  List<String>? choices)?  $default,) {final _that = this;
switch (_that) {
case _ChildQuizItem() when $default != null:
return $default(_that.quizItemId,_that.type,_that.question,_that.choices);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChildQuizItem implements ChildQuizItem {
  const _ChildQuizItem({required this.quizItemId, this.type = 'MultipleChoice', required this.question,  List<String>? choices}): _choices = choices;
  factory _ChildQuizItem.fromJson(Map<String, dynamic> json) => _$ChildQuizItemFromJson(json);

@override final  int quizItemId;
@override@JsonKey() final  String type;
@override final  String question;
 final  List<String>? _choices;
@override List<String>? get choices {
  final value = _choices;
  if (value == null) return null;
  if (_choices is EqualUnmodifiableListView) return _choices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of ChildQuizItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChildQuizItemCopyWith<_ChildQuizItem> get copyWith => __$ChildQuizItemCopyWithImpl<_ChildQuizItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChildQuizItemToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChildQuizItem&&(identical(other.quizItemId, quizItemId) || other.quizItemId == quizItemId)&&(identical(other.type, type) || other.type == type)&&(identical(other.question, question) || other.question == question)&&const DeepCollectionEquality().equals(other.choices, _choices));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,quizItemId,type,question,const DeepCollectionEquality().hash(_choices));
}

@override
String toString() {
    return 'ChildQuizItem(quizItemId: $quizItemId, type: $type, question: $question, choices: $choices)';
}


}

/// @nodoc
abstract mixin class _$ChildQuizItemCopyWith<$Res> implements $ChildQuizItemCopyWith<$Res> {
  factory _$ChildQuizItemCopyWith(_ChildQuizItem value, $Res Function(_ChildQuizItem) _then) = __$ChildQuizItemCopyWithImpl;
@override @useResult
$Res call({
 int quizItemId, String type, String question, List<String>? choices
});




}
/// @nodoc
class __$ChildQuizItemCopyWithImpl<$Res>
    implements _$ChildQuizItemCopyWith<$Res> {
  __$ChildQuizItemCopyWithImpl(this._self, this._then);

  final _ChildQuizItem _self;
  final $Res Function(_ChildQuizItem) _then;

/// Create a copy of ChildQuizItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? quizItemId = null,Object? type = null,Object? question = null,Object? choices = freezed,}) {
  return _then(_ChildQuizItem(
quizItemId: null == quizItemId ? _self.quizItemId : quizItemId // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,choices: freezed == choices ? _self._choices : choices // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}


/// @nodoc
mixin _$ChildQuiz {

 int get sessionId; int get totalQuestions; int? get bestPercent; List<ChildQuizItem> get questions;
/// Create a copy of ChildQuiz
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChildQuizCopyWith<ChildQuiz> get copyWith => _$ChildQuizCopyWithImpl<ChildQuiz>(this as ChildQuiz, _$identity);

  /// Serializes this ChildQuiz to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ChildQuiz;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChildQuiz&&(identical(other.sessionId, _this.sessionId) || other.sessionId == _this.sessionId)&&(identical(other.totalQuestions, _this.totalQuestions) || other.totalQuestions == _this.totalQuestions)&&(identical(other.bestPercent, _this.bestPercent) || other.bestPercent == _this.bestPercent)&&const DeepCollectionEquality().equals(other.questions, _this.questions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChildQuiz;
  return Object.hash(runtimeType,_this.sessionId,_this.totalQuestions,_this.bestPercent,const DeepCollectionEquality().hash(_this.questions));
}

@override
String toString() {
  final _this = this as ChildQuiz;
  return 'ChildQuiz(sessionId: ${_this.sessionId}, totalQuestions: ${_this.totalQuestions}, bestPercent: ${_this.bestPercent}, questions: ${_this.questions})';
}


}

/// @nodoc
abstract mixin class $ChildQuizCopyWith<$Res>  {
  factory $ChildQuizCopyWith(ChildQuiz value, $Res Function(ChildQuiz) _then) = _$ChildQuizCopyWithImpl;
@useResult
$Res call({
 int sessionId, int totalQuestions, int? bestPercent, List<ChildQuizItem> questions
});




}
/// @nodoc
class _$ChildQuizCopyWithImpl<$Res>
    implements $ChildQuizCopyWith<$Res> {
  _$ChildQuizCopyWithImpl(this._self, this._then);

  final ChildQuiz _self;
  final $Res Function(ChildQuiz) _then;

/// Create a copy of ChildQuiz
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionId = null,Object? totalQuestions = null,Object? bestPercent = freezed,Object? questions = null,}) {
  return _then(ChildQuiz(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as int,totalQuestions: null == totalQuestions ? _self.totalQuestions : totalQuestions // ignore: cast_nullable_to_non_nullable
as int,bestPercent: freezed == bestPercent ? _self.bestPercent : bestPercent // ignore: cast_nullable_to_non_nullable
as int?,questions: null == questions ? _self.questions : questions // ignore: cast_nullable_to_non_nullable
as List<ChildQuizItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [ChildQuiz].
extension ChildQuizPatterns on ChildQuiz {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChildQuiz value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChildQuiz() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChildQuiz value)  $default,){
final _that = this;
switch (_that) {
case _ChildQuiz():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChildQuiz value)?  $default,){
final _that = this;
switch (_that) {
case _ChildQuiz() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int sessionId,  int totalQuestions,  int? bestPercent,  List<ChildQuizItem> questions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChildQuiz() when $default != null:
return $default(_that.sessionId,_that.totalQuestions,_that.bestPercent,_that.questions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int sessionId,  int totalQuestions,  int? bestPercent,  List<ChildQuizItem> questions)  $default,) {final _that = this;
switch (_that) {
case _ChildQuiz():
return $default(_that.sessionId,_that.totalQuestions,_that.bestPercent,_that.questions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int sessionId,  int totalQuestions,  int? bestPercent,  List<ChildQuizItem> questions)?  $default,) {final _that = this;
switch (_that) {
case _ChildQuiz() when $default != null:
return $default(_that.sessionId,_that.totalQuestions,_that.bestPercent,_that.questions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChildQuiz implements ChildQuiz {
  const _ChildQuiz({required this.sessionId, this.totalQuestions = 0, this.bestPercent,  List<ChildQuizItem> questions = const <ChildQuizItem>[]}): _questions = questions;
  factory _ChildQuiz.fromJson(Map<String, dynamic> json) => _$ChildQuizFromJson(json);

@override final  int sessionId;
@override@JsonKey() final  int totalQuestions;
@override final  int? bestPercent;
 final  List<ChildQuizItem> _questions;
@override@JsonKey() List<ChildQuizItem> get questions {
  if (_questions is EqualUnmodifiableListView) return _questions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_questions);
}


/// Create a copy of ChildQuiz
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChildQuizCopyWith<_ChildQuiz> get copyWith => __$ChildQuizCopyWithImpl<_ChildQuiz>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChildQuizToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChildQuiz&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.totalQuestions, totalQuestions) || other.totalQuestions == totalQuestions)&&(identical(other.bestPercent, bestPercent) || other.bestPercent == bestPercent)&&const DeepCollectionEquality().equals(other.questions, _questions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,sessionId,totalQuestions,bestPercent,const DeepCollectionEquality().hash(_questions));
}

@override
String toString() {
    return 'ChildQuiz(sessionId: $sessionId, totalQuestions: $totalQuestions, bestPercent: $bestPercent, questions: $questions)';
}


}

/// @nodoc
abstract mixin class _$ChildQuizCopyWith<$Res> implements $ChildQuizCopyWith<$Res> {
  factory _$ChildQuizCopyWith(_ChildQuiz value, $Res Function(_ChildQuiz) _then) = __$ChildQuizCopyWithImpl;
@override @useResult
$Res call({
 int sessionId, int totalQuestions, int? bestPercent, List<ChildQuizItem> questions
});




}
/// @nodoc
class __$ChildQuizCopyWithImpl<$Res>
    implements _$ChildQuizCopyWith<$Res> {
  __$ChildQuizCopyWithImpl(this._self, this._then);

  final _ChildQuiz _self;
  final $Res Function(_ChildQuiz) _then;

/// Create a copy of ChildQuiz
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionId = null,Object? totalQuestions = null,Object? bestPercent = freezed,Object? questions = null,}) {
  return _then(_ChildQuiz(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as int,totalQuestions: null == totalQuestions ? _self.totalQuestions : totalQuestions // ignore: cast_nullable_to_non_nullable
as int,bestPercent: freezed == bestPercent ? _self.bestPercent : bestPercent // ignore: cast_nullable_to_non_nullable
as int?,questions: null == questions ? _self._questions : questions // ignore: cast_nullable_to_non_nullable
as List<ChildQuizItem>,
  ));
}


}


/// @nodoc
mixin _$QuizAnswerResult {

 int get quizItemId; bool get isCorrect; String get feedback; int get expGained; List<String> get newBadges; bool get runCompleted; int get currentPercent; int? get bestPercent;
/// Create a copy of QuizAnswerResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuizAnswerResultCopyWith<QuizAnswerResult> get copyWith => _$QuizAnswerResultCopyWithImpl<QuizAnswerResult>(this as QuizAnswerResult, _$identity);

  /// Serializes this QuizAnswerResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as QuizAnswerResult;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuizAnswerResult&&(identical(other.quizItemId, _this.quizItemId) || other.quizItemId == _this.quizItemId)&&(identical(other.isCorrect, _this.isCorrect) || other.isCorrect == _this.isCorrect)&&(identical(other.feedback, _this.feedback) || other.feedback == _this.feedback)&&(identical(other.expGained, _this.expGained) || other.expGained == _this.expGained)&&const DeepCollectionEquality().equals(other.newBadges, _this.newBadges)&&(identical(other.runCompleted, _this.runCompleted) || other.runCompleted == _this.runCompleted)&&(identical(other.currentPercent, _this.currentPercent) || other.currentPercent == _this.currentPercent)&&(identical(other.bestPercent, _this.bestPercent) || other.bestPercent == _this.bestPercent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as QuizAnswerResult;
  return Object.hash(runtimeType,_this.quizItemId,_this.isCorrect,_this.feedback,_this.expGained,const DeepCollectionEquality().hash(_this.newBadges),_this.runCompleted,_this.currentPercent,_this.bestPercent);
}

@override
String toString() {
  final _this = this as QuizAnswerResult;
  return 'QuizAnswerResult(quizItemId: ${_this.quizItemId}, isCorrect: ${_this.isCorrect}, feedback: ${_this.feedback}, expGained: ${_this.expGained}, newBadges: ${_this.newBadges}, runCompleted: ${_this.runCompleted}, currentPercent: ${_this.currentPercent}, bestPercent: ${_this.bestPercent})';
}


}

/// @nodoc
abstract mixin class $QuizAnswerResultCopyWith<$Res>  {
  factory $QuizAnswerResultCopyWith(QuizAnswerResult value, $Res Function(QuizAnswerResult) _then) = _$QuizAnswerResultCopyWithImpl;
@useResult
$Res call({
 int quizItemId, bool isCorrect, String feedback, int expGained, List<String> newBadges, bool runCompleted, int currentPercent, int? bestPercent
});




}
/// @nodoc
class _$QuizAnswerResultCopyWithImpl<$Res>
    implements $QuizAnswerResultCopyWith<$Res> {
  _$QuizAnswerResultCopyWithImpl(this._self, this._then);

  final QuizAnswerResult _self;
  final $Res Function(QuizAnswerResult) _then;

/// Create a copy of QuizAnswerResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? quizItemId = null,Object? isCorrect = null,Object? feedback = null,Object? expGained = null,Object? newBadges = null,Object? runCompleted = null,Object? currentPercent = null,Object? bestPercent = freezed,}) {
  return _then(QuizAnswerResult(
quizItemId: null == quizItemId ? _self.quizItemId : quizItemId // ignore: cast_nullable_to_non_nullable
as int,isCorrect: null == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool,feedback: null == feedback ? _self.feedback : feedback // ignore: cast_nullable_to_non_nullable
as String,expGained: null == expGained ? _self.expGained : expGained // ignore: cast_nullable_to_non_nullable
as int,newBadges: null == newBadges ? _self.newBadges : newBadges // ignore: cast_nullable_to_non_nullable
as List<String>,runCompleted: null == runCompleted ? _self.runCompleted : runCompleted // ignore: cast_nullable_to_non_nullable
as bool,currentPercent: null == currentPercent ? _self.currentPercent : currentPercent // ignore: cast_nullable_to_non_nullable
as int,bestPercent: freezed == bestPercent ? _self.bestPercent : bestPercent // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [QuizAnswerResult].
extension QuizAnswerResultPatterns on QuizAnswerResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuizAnswerResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuizAnswerResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuizAnswerResult value)  $default,){
final _that = this;
switch (_that) {
case _QuizAnswerResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuizAnswerResult value)?  $default,){
final _that = this;
switch (_that) {
case _QuizAnswerResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int quizItemId,  bool isCorrect,  String feedback,  int expGained,  List<String> newBadges,  bool runCompleted,  int currentPercent,  int? bestPercent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuizAnswerResult() when $default != null:
return $default(_that.quizItemId,_that.isCorrect,_that.feedback,_that.expGained,_that.newBadges,_that.runCompleted,_that.currentPercent,_that.bestPercent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int quizItemId,  bool isCorrect,  String feedback,  int expGained,  List<String> newBadges,  bool runCompleted,  int currentPercent,  int? bestPercent)  $default,) {final _that = this;
switch (_that) {
case _QuizAnswerResult():
return $default(_that.quizItemId,_that.isCorrect,_that.feedback,_that.expGained,_that.newBadges,_that.runCompleted,_that.currentPercent,_that.bestPercent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int quizItemId,  bool isCorrect,  String feedback,  int expGained,  List<String> newBadges,  bool runCompleted,  int currentPercent,  int? bestPercent)?  $default,) {final _that = this;
switch (_that) {
case _QuizAnswerResult() when $default != null:
return $default(_that.quizItemId,_that.isCorrect,_that.feedback,_that.expGained,_that.newBadges,_that.runCompleted,_that.currentPercent,_that.bestPercent);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuizAnswerResult implements QuizAnswerResult {
  const _QuizAnswerResult({required this.quizItemId, this.isCorrect = false, required this.feedback, this.expGained = 0,  List<String> newBadges = const <String>[], this.runCompleted = false, this.currentPercent = 0, this.bestPercent}): _newBadges = newBadges;
  factory _QuizAnswerResult.fromJson(Map<String, dynamic> json) => _$QuizAnswerResultFromJson(json);

@override final  int quizItemId;
@override@JsonKey() final  bool isCorrect;
@override final  String feedback;
@override@JsonKey() final  int expGained;
 final  List<String> _newBadges;
@override@JsonKey() List<String> get newBadges {
  if (_newBadges is EqualUnmodifiableListView) return _newBadges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_newBadges);
}

@override@JsonKey() final  bool runCompleted;
@override@JsonKey() final  int currentPercent;
@override final  int? bestPercent;

/// Create a copy of QuizAnswerResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuizAnswerResultCopyWith<_QuizAnswerResult> get copyWith => __$QuizAnswerResultCopyWithImpl<_QuizAnswerResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuizAnswerResultToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuizAnswerResult&&(identical(other.quizItemId, quizItemId) || other.quizItemId == quizItemId)&&(identical(other.isCorrect, isCorrect) || other.isCorrect == isCorrect)&&(identical(other.feedback, feedback) || other.feedback == feedback)&&(identical(other.expGained, expGained) || other.expGained == expGained)&&const DeepCollectionEquality().equals(other.newBadges, _newBadges)&&(identical(other.runCompleted, runCompleted) || other.runCompleted == runCompleted)&&(identical(other.currentPercent, currentPercent) || other.currentPercent == currentPercent)&&(identical(other.bestPercent, bestPercent) || other.bestPercent == bestPercent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,quizItemId,isCorrect,feedback,expGained,const DeepCollectionEquality().hash(_newBadges),runCompleted,currentPercent,bestPercent);
}

@override
String toString() {
    return 'QuizAnswerResult(quizItemId: $quizItemId, isCorrect: $isCorrect, feedback: $feedback, expGained: $expGained, newBadges: $newBadges, runCompleted: $runCompleted, currentPercent: $currentPercent, bestPercent: $bestPercent)';
}


}

/// @nodoc
abstract mixin class _$QuizAnswerResultCopyWith<$Res> implements $QuizAnswerResultCopyWith<$Res> {
  factory _$QuizAnswerResultCopyWith(_QuizAnswerResult value, $Res Function(_QuizAnswerResult) _then) = __$QuizAnswerResultCopyWithImpl;
@override @useResult
$Res call({
 int quizItemId, bool isCorrect, String feedback, int expGained, List<String> newBadges, bool runCompleted, int currentPercent, int? bestPercent
});




}
/// @nodoc
class __$QuizAnswerResultCopyWithImpl<$Res>
    implements _$QuizAnswerResultCopyWith<$Res> {
  __$QuizAnswerResultCopyWithImpl(this._self, this._then);

  final _QuizAnswerResult _self;
  final $Res Function(_QuizAnswerResult) _then;

/// Create a copy of QuizAnswerResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? quizItemId = null,Object? isCorrect = null,Object? feedback = null,Object? expGained = null,Object? newBadges = null,Object? runCompleted = null,Object? currentPercent = null,Object? bestPercent = freezed,}) {
  return _then(_QuizAnswerResult(
quizItemId: null == quizItemId ? _self.quizItemId : quizItemId // ignore: cast_nullable_to_non_nullable
as int,isCorrect: null == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool,feedback: null == feedback ? _self.feedback : feedback // ignore: cast_nullable_to_non_nullable
as String,expGained: null == expGained ? _self.expGained : expGained // ignore: cast_nullable_to_non_nullable
as int,newBadges: null == newBadges ? _self._newBadges : newBadges // ignore: cast_nullable_to_non_nullable
as List<String>,runCompleted: null == runCompleted ? _self.runCompleted : runCompleted // ignore: cast_nullable_to_non_nullable
as bool,currentPercent: null == currentPercent ? _self.currentPercent : currentPercent // ignore: cast_nullable_to_non_nullable
as int,bestPercent: freezed == bestPercent ? _self.bestPercent : bestPercent // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$ChildQuizResult {

 int get sessionId; int get totalQuestions; int get answered; int get correct; int get currentPercent; int? get bestPercent; bool get runCompleted;
/// Create a copy of ChildQuizResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChildQuizResultCopyWith<ChildQuizResult> get copyWith => _$ChildQuizResultCopyWithImpl<ChildQuizResult>(this as ChildQuizResult, _$identity);

  /// Serializes this ChildQuizResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ChildQuizResult;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChildQuizResult&&(identical(other.sessionId, _this.sessionId) || other.sessionId == _this.sessionId)&&(identical(other.totalQuestions, _this.totalQuestions) || other.totalQuestions == _this.totalQuestions)&&(identical(other.answered, _this.answered) || other.answered == _this.answered)&&(identical(other.correct, _this.correct) || other.correct == _this.correct)&&(identical(other.currentPercent, _this.currentPercent) || other.currentPercent == _this.currentPercent)&&(identical(other.bestPercent, _this.bestPercent) || other.bestPercent == _this.bestPercent)&&(identical(other.runCompleted, _this.runCompleted) || other.runCompleted == _this.runCompleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChildQuizResult;
  return Object.hash(runtimeType,_this.sessionId,_this.totalQuestions,_this.answered,_this.correct,_this.currentPercent,_this.bestPercent,_this.runCompleted);
}

@override
String toString() {
  final _this = this as ChildQuizResult;
  return 'ChildQuizResult(sessionId: ${_this.sessionId}, totalQuestions: ${_this.totalQuestions}, answered: ${_this.answered}, correct: ${_this.correct}, currentPercent: ${_this.currentPercent}, bestPercent: ${_this.bestPercent}, runCompleted: ${_this.runCompleted})';
}


}

/// @nodoc
abstract mixin class $ChildQuizResultCopyWith<$Res>  {
  factory $ChildQuizResultCopyWith(ChildQuizResult value, $Res Function(ChildQuizResult) _then) = _$ChildQuizResultCopyWithImpl;
@useResult
$Res call({
 int sessionId, int totalQuestions, int answered, int correct, int currentPercent, int? bestPercent, bool runCompleted
});




}
/// @nodoc
class _$ChildQuizResultCopyWithImpl<$Res>
    implements $ChildQuizResultCopyWith<$Res> {
  _$ChildQuizResultCopyWithImpl(this._self, this._then);

  final ChildQuizResult _self;
  final $Res Function(ChildQuizResult) _then;

/// Create a copy of ChildQuizResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionId = null,Object? totalQuestions = null,Object? answered = null,Object? correct = null,Object? currentPercent = null,Object? bestPercent = freezed,Object? runCompleted = null,}) {
  return _then(ChildQuizResult(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as int,totalQuestions: null == totalQuestions ? _self.totalQuestions : totalQuestions // ignore: cast_nullable_to_non_nullable
as int,answered: null == answered ? _self.answered : answered // ignore: cast_nullable_to_non_nullable
as int,correct: null == correct ? _self.correct : correct // ignore: cast_nullable_to_non_nullable
as int,currentPercent: null == currentPercent ? _self.currentPercent : currentPercent // ignore: cast_nullable_to_non_nullable
as int,bestPercent: freezed == bestPercent ? _self.bestPercent : bestPercent // ignore: cast_nullable_to_non_nullable
as int?,runCompleted: null == runCompleted ? _self.runCompleted : runCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ChildQuizResult].
extension ChildQuizResultPatterns on ChildQuizResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChildQuizResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChildQuizResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChildQuizResult value)  $default,){
final _that = this;
switch (_that) {
case _ChildQuizResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChildQuizResult value)?  $default,){
final _that = this;
switch (_that) {
case _ChildQuizResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int sessionId,  int totalQuestions,  int answered,  int correct,  int currentPercent,  int? bestPercent,  bool runCompleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChildQuizResult() when $default != null:
return $default(_that.sessionId,_that.totalQuestions,_that.answered,_that.correct,_that.currentPercent,_that.bestPercent,_that.runCompleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int sessionId,  int totalQuestions,  int answered,  int correct,  int currentPercent,  int? bestPercent,  bool runCompleted)  $default,) {final _that = this;
switch (_that) {
case _ChildQuizResult():
return $default(_that.sessionId,_that.totalQuestions,_that.answered,_that.correct,_that.currentPercent,_that.bestPercent,_that.runCompleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int sessionId,  int totalQuestions,  int answered,  int correct,  int currentPercent,  int? bestPercent,  bool runCompleted)?  $default,) {final _that = this;
switch (_that) {
case _ChildQuizResult() when $default != null:
return $default(_that.sessionId,_that.totalQuestions,_that.answered,_that.correct,_that.currentPercent,_that.bestPercent,_that.runCompleted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChildQuizResult implements ChildQuizResult {
  const _ChildQuizResult({required this.sessionId, this.totalQuestions = 0, this.answered = 0, this.correct = 0, this.currentPercent = 0, this.bestPercent, this.runCompleted = false});
  factory _ChildQuizResult.fromJson(Map<String, dynamic> json) => _$ChildQuizResultFromJson(json);

@override final  int sessionId;
@override@JsonKey() final  int totalQuestions;
@override@JsonKey() final  int answered;
@override@JsonKey() final  int correct;
@override@JsonKey() final  int currentPercent;
@override final  int? bestPercent;
@override@JsonKey() final  bool runCompleted;

/// Create a copy of ChildQuizResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChildQuizResultCopyWith<_ChildQuizResult> get copyWith => __$ChildQuizResultCopyWithImpl<_ChildQuizResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChildQuizResultToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChildQuizResult&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.totalQuestions, totalQuestions) || other.totalQuestions == totalQuestions)&&(identical(other.answered, answered) || other.answered == answered)&&(identical(other.correct, correct) || other.correct == correct)&&(identical(other.currentPercent, currentPercent) || other.currentPercent == currentPercent)&&(identical(other.bestPercent, bestPercent) || other.bestPercent == bestPercent)&&(identical(other.runCompleted, runCompleted) || other.runCompleted == runCompleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,sessionId,totalQuestions,answered,correct,currentPercent,bestPercent,runCompleted);
}

@override
String toString() {
    return 'ChildQuizResult(sessionId: $sessionId, totalQuestions: $totalQuestions, answered: $answered, correct: $correct, currentPercent: $currentPercent, bestPercent: $bestPercent, runCompleted: $runCompleted)';
}


}

/// @nodoc
abstract mixin class _$ChildQuizResultCopyWith<$Res> implements $ChildQuizResultCopyWith<$Res> {
  factory _$ChildQuizResultCopyWith(_ChildQuizResult value, $Res Function(_ChildQuizResult) _then) = __$ChildQuizResultCopyWithImpl;
@override @useResult
$Res call({
 int sessionId, int totalQuestions, int answered, int correct, int currentPercent, int? bestPercent, bool runCompleted
});




}
/// @nodoc
class __$ChildQuizResultCopyWithImpl<$Res>
    implements _$ChildQuizResultCopyWith<$Res> {
  __$ChildQuizResultCopyWithImpl(this._self, this._then);

  final _ChildQuizResult _self;
  final $Res Function(_ChildQuizResult) _then;

/// Create a copy of ChildQuizResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionId = null,Object? totalQuestions = null,Object? answered = null,Object? correct = null,Object? currentPercent = null,Object? bestPercent = freezed,Object? runCompleted = null,}) {
  return _then(_ChildQuizResult(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as int,totalQuestions: null == totalQuestions ? _self.totalQuestions : totalQuestions // ignore: cast_nullable_to_non_nullable
as int,answered: null == answered ? _self.answered : answered // ignore: cast_nullable_to_non_nullable
as int,correct: null == correct ? _self.correct : correct // ignore: cast_nullable_to_non_nullable
as int,currentPercent: null == currentPercent ? _self.currentPercent : currentPercent // ignore: cast_nullable_to_non_nullable
as int,bestPercent: freezed == bestPercent ? _self.bestPercent : bestPercent // ignore: cast_nullable_to_non_nullable
as int?,runCompleted: null == runCompleted ? _self.runCompleted : runCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$StorySummarySent {

 int get summaryId; String get message;
/// Create a copy of StorySummarySent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StorySummarySentCopyWith<StorySummarySent> get copyWith => _$StorySummarySentCopyWithImpl<StorySummarySent>(this as StorySummarySent, _$identity);

  /// Serializes this StorySummarySent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as StorySummarySent;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StorySummarySent&&(identical(other.summaryId, _this.summaryId) || other.summaryId == _this.summaryId)&&(identical(other.message, _this.message) || other.message == _this.message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as StorySummarySent;
  return Object.hash(runtimeType,_this.summaryId,_this.message);
}

@override
String toString() {
  final _this = this as StorySummarySent;
  return 'StorySummarySent(summaryId: ${_this.summaryId}, message: ${_this.message})';
}


}

/// @nodoc
abstract mixin class $StorySummarySentCopyWith<$Res>  {
  factory $StorySummarySentCopyWith(StorySummarySent value, $Res Function(StorySummarySent) _then) = _$StorySummarySentCopyWithImpl;
@useResult
$Res call({
 int summaryId, String message
});




}
/// @nodoc
class _$StorySummarySentCopyWithImpl<$Res>
    implements $StorySummarySentCopyWith<$Res> {
  _$StorySummarySentCopyWithImpl(this._self, this._then);

  final StorySummarySent _self;
  final $Res Function(StorySummarySent) _then;

/// Create a copy of StorySummarySent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? summaryId = null,Object? message = null,}) {
  return _then(StorySummarySent(
summaryId: null == summaryId ? _self.summaryId : summaryId // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [StorySummarySent].
extension StorySummarySentPatterns on StorySummarySent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StorySummarySent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StorySummarySent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StorySummarySent value)  $default,){
final _that = this;
switch (_that) {
case _StorySummarySent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StorySummarySent value)?  $default,){
final _that = this;
switch (_that) {
case _StorySummarySent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int summaryId,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StorySummarySent() when $default != null:
return $default(_that.summaryId,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int summaryId,  String message)  $default,) {final _that = this;
switch (_that) {
case _StorySummarySent():
return $default(_that.summaryId,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int summaryId,  String message)?  $default,) {final _that = this;
switch (_that) {
case _StorySummarySent() when $default != null:
return $default(_that.summaryId,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StorySummarySent implements StorySummarySent {
  const _StorySummarySent({required this.summaryId, required this.message});
  factory _StorySummarySent.fromJson(Map<String, dynamic> json) => _$StorySummarySentFromJson(json);

@override final  int summaryId;
@override final  String message;

/// Create a copy of StorySummarySent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StorySummarySentCopyWith<_StorySummarySent> get copyWith => __$StorySummarySentCopyWithImpl<_StorySummarySent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StorySummarySentToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StorySummarySent&&(identical(other.summaryId, summaryId) || other.summaryId == summaryId)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,summaryId,message);
}

@override
String toString() {
    return 'StorySummarySent(summaryId: $summaryId, message: $message)';
}


}

/// @nodoc
abstract mixin class _$StorySummarySentCopyWith<$Res> implements $StorySummarySentCopyWith<$Res> {
  factory _$StorySummarySentCopyWith(_StorySummarySent value, $Res Function(_StorySummarySent) _then) = __$StorySummarySentCopyWithImpl;
@override @useResult
$Res call({
 int summaryId, String message
});




}
/// @nodoc
class __$StorySummarySentCopyWithImpl<$Res>
    implements _$StorySummarySentCopyWith<$Res> {
  __$StorySummarySentCopyWithImpl(this._self, this._then);

  final _StorySummarySent _self;
  final $Res Function(_StorySummarySent) _then;

/// Create a copy of StorySummarySent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? summaryId = null,Object? message = null,}) {
  return _then(_StorySummarySent(
summaryId: null == summaryId ? _self.summaryId : summaryId // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
