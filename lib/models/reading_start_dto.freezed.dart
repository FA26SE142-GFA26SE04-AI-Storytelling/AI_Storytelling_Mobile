// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reading_start_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReadingStartedDto {

 int get sessionId; int get storyId; bool get resumed; int get lastPage; String? get lastReadingMode; bool get isBookmarked; bool get isFavorited; bool? get listenOnly;
/// Create a copy of ReadingStartedDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadingStartedDtoCopyWith<ReadingStartedDto> get copyWith => _$ReadingStartedDtoCopyWithImpl<ReadingStartedDto>(this as ReadingStartedDto, _$identity);

  /// Serializes this ReadingStartedDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ReadingStartedDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadingStartedDto&&(identical(other.sessionId, _this.sessionId) || other.sessionId == _this.sessionId)&&(identical(other.storyId, _this.storyId) || other.storyId == _this.storyId)&&(identical(other.resumed, _this.resumed) || other.resumed == _this.resumed)&&(identical(other.lastPage, _this.lastPage) || other.lastPage == _this.lastPage)&&(identical(other.lastReadingMode, _this.lastReadingMode) || other.lastReadingMode == _this.lastReadingMode)&&(identical(other.isBookmarked, _this.isBookmarked) || other.isBookmarked == _this.isBookmarked)&&(identical(other.isFavorited, _this.isFavorited) || other.isFavorited == _this.isFavorited)&&(identical(other.listenOnly, _this.listenOnly) || other.listenOnly == _this.listenOnly));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ReadingStartedDto;
  return Object.hash(runtimeType,_this.sessionId,_this.storyId,_this.resumed,_this.lastPage,_this.lastReadingMode,_this.isBookmarked,_this.isFavorited,_this.listenOnly);
}

@override
String toString() {
  final _this = this as ReadingStartedDto;
  return 'ReadingStartedDto(sessionId: ${_this.sessionId}, storyId: ${_this.storyId}, resumed: ${_this.resumed}, lastPage: ${_this.lastPage}, lastReadingMode: ${_this.lastReadingMode}, isBookmarked: ${_this.isBookmarked}, isFavorited: ${_this.isFavorited}, listenOnly: ${_this.listenOnly})';
}


}

/// @nodoc
abstract mixin class $ReadingStartedDtoCopyWith<$Res>  {
  factory $ReadingStartedDtoCopyWith(ReadingStartedDto value, $Res Function(ReadingStartedDto) _then) = _$ReadingStartedDtoCopyWithImpl;
@useResult
$Res call({
 int sessionId, int storyId, bool resumed, int lastPage, String? lastReadingMode, bool isBookmarked, bool isFavorited, bool? listenOnly
});




}
/// @nodoc
class _$ReadingStartedDtoCopyWithImpl<$Res>
    implements $ReadingStartedDtoCopyWith<$Res> {
  _$ReadingStartedDtoCopyWithImpl(this._self, this._then);

  final ReadingStartedDto _self;
  final $Res Function(ReadingStartedDto) _then;

/// Create a copy of ReadingStartedDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionId = null,Object? storyId = null,Object? resumed = null,Object? lastPage = null,Object? lastReadingMode = freezed,Object? isBookmarked = null,Object? isFavorited = null,Object? listenOnly = freezed,}) {
  return _then(ReadingStartedDto(
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


/// Adds pattern-matching-related methods to [ReadingStartedDto].
extension ReadingStartedDtoPatterns on ReadingStartedDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReadingStartedDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReadingStartedDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReadingStartedDto value)  $default,){
final _that = this;
switch (_that) {
case _ReadingStartedDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReadingStartedDto value)?  $default,){
final _that = this;
switch (_that) {
case _ReadingStartedDto() when $default != null:
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
case _ReadingStartedDto() when $default != null:
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
case _ReadingStartedDto():
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
case _ReadingStartedDto() when $default != null:
return $default(_that.sessionId,_that.storyId,_that.resumed,_that.lastPage,_that.lastReadingMode,_that.isBookmarked,_that.isFavorited,_that.listenOnly);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReadingStartedDto implements ReadingStartedDto {
  const _ReadingStartedDto({required this.sessionId, required this.storyId, this.resumed = false, this.lastPage = 1, this.lastReadingMode, this.isBookmarked = false, this.isFavorited = false, this.listenOnly});
  factory _ReadingStartedDto.fromJson(Map<String, dynamic> json) => _$ReadingStartedDtoFromJson(json);

@override final  int sessionId;
@override final  int storyId;
@override@JsonKey() final  bool resumed;
@override@JsonKey() final  int lastPage;
@override final  String? lastReadingMode;
@override@JsonKey() final  bool isBookmarked;
@override@JsonKey() final  bool isFavorited;
@override final  bool? listenOnly;

/// Create a copy of ReadingStartedDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadingStartedDtoCopyWith<_ReadingStartedDto> get copyWith => __$ReadingStartedDtoCopyWithImpl<_ReadingStartedDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReadingStartedDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReadingStartedDto&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.storyId, storyId) || other.storyId == storyId)&&(identical(other.resumed, resumed) || other.resumed == resumed)&&(identical(other.lastPage, lastPage) || other.lastPage == lastPage)&&(identical(other.lastReadingMode, lastReadingMode) || other.lastReadingMode == lastReadingMode)&&(identical(other.isBookmarked, isBookmarked) || other.isBookmarked == isBookmarked)&&(identical(other.isFavorited, isFavorited) || other.isFavorited == isFavorited)&&(identical(other.listenOnly, listenOnly) || other.listenOnly == listenOnly));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,sessionId,storyId,resumed,lastPage,lastReadingMode,isBookmarked,isFavorited,listenOnly);
}

@override
String toString() {
    return 'ReadingStartedDto(sessionId: $sessionId, storyId: $storyId, resumed: $resumed, lastPage: $lastPage, lastReadingMode: $lastReadingMode, isBookmarked: $isBookmarked, isFavorited: $isFavorited, listenOnly: $listenOnly)';
}


}

/// @nodoc
abstract mixin class _$ReadingStartedDtoCopyWith<$Res> implements $ReadingStartedDtoCopyWith<$Res> {
  factory _$ReadingStartedDtoCopyWith(_ReadingStartedDto value, $Res Function(_ReadingStartedDto) _then) = __$ReadingStartedDtoCopyWithImpl;
@override @useResult
$Res call({
 int sessionId, int storyId, bool resumed, int lastPage, String? lastReadingMode, bool isBookmarked, bool isFavorited, bool? listenOnly
});




}
/// @nodoc
class __$ReadingStartedDtoCopyWithImpl<$Res>
    implements _$ReadingStartedDtoCopyWith<$Res> {
  __$ReadingStartedDtoCopyWithImpl(this._self, this._then);

  final _ReadingStartedDto _self;
  final $Res Function(_ReadingStartedDto) _then;

/// Create a copy of ReadingStartedDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionId = null,Object? storyId = null,Object? resumed = null,Object? lastPage = null,Object? lastReadingMode = freezed,Object? isBookmarked = null,Object? isFavorited = null,Object? listenOnly = freezed,}) {
  return _then(_ReadingStartedDto(
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
mixin _$ReadingFlagsDto {

 bool get isBookmarked; bool get isFavorited; bool? get listenOnly;
/// Create a copy of ReadingFlagsDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadingFlagsDtoCopyWith<ReadingFlagsDto> get copyWith => _$ReadingFlagsDtoCopyWithImpl<ReadingFlagsDto>(this as ReadingFlagsDto, _$identity);

  /// Serializes this ReadingFlagsDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ReadingFlagsDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadingFlagsDto&&(identical(other.isBookmarked, _this.isBookmarked) || other.isBookmarked == _this.isBookmarked)&&(identical(other.isFavorited, _this.isFavorited) || other.isFavorited == _this.isFavorited)&&(identical(other.listenOnly, _this.listenOnly) || other.listenOnly == _this.listenOnly));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ReadingFlagsDto;
  return Object.hash(runtimeType,_this.isBookmarked,_this.isFavorited,_this.listenOnly);
}

@override
String toString() {
  final _this = this as ReadingFlagsDto;
  return 'ReadingFlagsDto(isBookmarked: ${_this.isBookmarked}, isFavorited: ${_this.isFavorited}, listenOnly: ${_this.listenOnly})';
}


}

/// @nodoc
abstract mixin class $ReadingFlagsDtoCopyWith<$Res>  {
  factory $ReadingFlagsDtoCopyWith(ReadingFlagsDto value, $Res Function(ReadingFlagsDto) _then) = _$ReadingFlagsDtoCopyWithImpl;
@useResult
$Res call({
 bool isBookmarked, bool isFavorited, bool? listenOnly
});




}
/// @nodoc
class _$ReadingFlagsDtoCopyWithImpl<$Res>
    implements $ReadingFlagsDtoCopyWith<$Res> {
  _$ReadingFlagsDtoCopyWithImpl(this._self, this._then);

  final ReadingFlagsDto _self;
  final $Res Function(ReadingFlagsDto) _then;

/// Create a copy of ReadingFlagsDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isBookmarked = null,Object? isFavorited = null,Object? listenOnly = freezed,}) {
  return _then(ReadingFlagsDto(
isBookmarked: null == isBookmarked ? _self.isBookmarked : isBookmarked // ignore: cast_nullable_to_non_nullable
as bool,isFavorited: null == isFavorited ? _self.isFavorited : isFavorited // ignore: cast_nullable_to_non_nullable
as bool,listenOnly: freezed == listenOnly ? _self.listenOnly : listenOnly // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReadingFlagsDto].
extension ReadingFlagsDtoPatterns on ReadingFlagsDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReadingFlagsDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReadingFlagsDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReadingFlagsDto value)  $default,){
final _that = this;
switch (_that) {
case _ReadingFlagsDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReadingFlagsDto value)?  $default,){
final _that = this;
switch (_that) {
case _ReadingFlagsDto() when $default != null:
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
case _ReadingFlagsDto() when $default != null:
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
case _ReadingFlagsDto():
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
case _ReadingFlagsDto() when $default != null:
return $default(_that.isBookmarked,_that.isFavorited,_that.listenOnly);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReadingFlagsDto implements ReadingFlagsDto {
  const _ReadingFlagsDto({this.isBookmarked = false, this.isFavorited = false, this.listenOnly});
  factory _ReadingFlagsDto.fromJson(Map<String, dynamic> json) => _$ReadingFlagsDtoFromJson(json);

@override@JsonKey() final  bool isBookmarked;
@override@JsonKey() final  bool isFavorited;
@override final  bool? listenOnly;

/// Create a copy of ReadingFlagsDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadingFlagsDtoCopyWith<_ReadingFlagsDto> get copyWith => __$ReadingFlagsDtoCopyWithImpl<_ReadingFlagsDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReadingFlagsDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReadingFlagsDto&&(identical(other.isBookmarked, isBookmarked) || other.isBookmarked == isBookmarked)&&(identical(other.isFavorited, isFavorited) || other.isFavorited == isFavorited)&&(identical(other.listenOnly, listenOnly) || other.listenOnly == listenOnly));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,isBookmarked,isFavorited,listenOnly);
}

@override
String toString() {
    return 'ReadingFlagsDto(isBookmarked: $isBookmarked, isFavorited: $isFavorited, listenOnly: $listenOnly)';
}


}

/// @nodoc
abstract mixin class _$ReadingFlagsDtoCopyWith<$Res> implements $ReadingFlagsDtoCopyWith<$Res> {
  factory _$ReadingFlagsDtoCopyWith(_ReadingFlagsDto value, $Res Function(_ReadingFlagsDto) _then) = __$ReadingFlagsDtoCopyWithImpl;
@override @useResult
$Res call({
 bool isBookmarked, bool isFavorited, bool? listenOnly
});




}
/// @nodoc
class __$ReadingFlagsDtoCopyWithImpl<$Res>
    implements _$ReadingFlagsDtoCopyWith<$Res> {
  __$ReadingFlagsDtoCopyWithImpl(this._self, this._then);

  final _ReadingFlagsDto _self;
  final $Res Function(_ReadingFlagsDto) _then;

/// Create a copy of ReadingFlagsDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isBookmarked = null,Object? isFavorited = null,Object? listenOnly = freezed,}) {
  return _then(_ReadingFlagsDto(
isBookmarked: null == isBookmarked ? _self.isBookmarked : isBookmarked // ignore: cast_nullable_to_non_nullable
as bool,isFavorited: null == isFavorited ? _self.isFavorited : isFavorited // ignore: cast_nullable_to_non_nullable
as bool,listenOnly: freezed == listenOnly ? _self.listenOnly : listenOnly // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}


/// @nodoc
mixin _$ReadingProgressDto {

 int get sessionId; int get page; String? get readingMode; int get timeSpentSeconds;
/// Create a copy of ReadingProgressDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadingProgressDtoCopyWith<ReadingProgressDto> get copyWith => _$ReadingProgressDtoCopyWithImpl<ReadingProgressDto>(this as ReadingProgressDto, _$identity);

  /// Serializes this ReadingProgressDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ReadingProgressDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadingProgressDto&&(identical(other.sessionId, _this.sessionId) || other.sessionId == _this.sessionId)&&(identical(other.page, _this.page) || other.page == _this.page)&&(identical(other.readingMode, _this.readingMode) || other.readingMode == _this.readingMode)&&(identical(other.timeSpentSeconds, _this.timeSpentSeconds) || other.timeSpentSeconds == _this.timeSpentSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ReadingProgressDto;
  return Object.hash(runtimeType,_this.sessionId,_this.page,_this.readingMode,_this.timeSpentSeconds);
}

@override
String toString() {
  final _this = this as ReadingProgressDto;
  return 'ReadingProgressDto(sessionId: ${_this.sessionId}, page: ${_this.page}, readingMode: ${_this.readingMode}, timeSpentSeconds: ${_this.timeSpentSeconds})';
}


}

/// @nodoc
abstract mixin class $ReadingProgressDtoCopyWith<$Res>  {
  factory $ReadingProgressDtoCopyWith(ReadingProgressDto value, $Res Function(ReadingProgressDto) _then) = _$ReadingProgressDtoCopyWithImpl;
@useResult
$Res call({
 int sessionId, int page, String? readingMode, int timeSpentSeconds
});




}
/// @nodoc
class _$ReadingProgressDtoCopyWithImpl<$Res>
    implements $ReadingProgressDtoCopyWith<$Res> {
  _$ReadingProgressDtoCopyWithImpl(this._self, this._then);

  final ReadingProgressDto _self;
  final $Res Function(ReadingProgressDto) _then;

/// Create a copy of ReadingProgressDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionId = null,Object? page = null,Object? readingMode = freezed,Object? timeSpentSeconds = null,}) {
  return _then(ReadingProgressDto(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,readingMode: freezed == readingMode ? _self.readingMode : readingMode // ignore: cast_nullable_to_non_nullable
as String?,timeSpentSeconds: null == timeSpentSeconds ? _self.timeSpentSeconds : timeSpentSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ReadingProgressDto].
extension ReadingProgressDtoPatterns on ReadingProgressDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReadingProgressDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReadingProgressDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReadingProgressDto value)  $default,){
final _that = this;
switch (_that) {
case _ReadingProgressDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReadingProgressDto value)?  $default,){
final _that = this;
switch (_that) {
case _ReadingProgressDto() when $default != null:
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
case _ReadingProgressDto() when $default != null:
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
case _ReadingProgressDto():
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
case _ReadingProgressDto() when $default != null:
return $default(_that.sessionId,_that.page,_that.readingMode,_that.timeSpentSeconds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReadingProgressDto implements ReadingProgressDto {
  const _ReadingProgressDto({required this.sessionId, required this.page, this.readingMode, this.timeSpentSeconds = 0});
  factory _ReadingProgressDto.fromJson(Map<String, dynamic> json) => _$ReadingProgressDtoFromJson(json);

@override final  int sessionId;
@override final  int page;
@override final  String? readingMode;
@override@JsonKey() final  int timeSpentSeconds;

/// Create a copy of ReadingProgressDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadingProgressDtoCopyWith<_ReadingProgressDto> get copyWith => __$ReadingProgressDtoCopyWithImpl<_ReadingProgressDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReadingProgressDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReadingProgressDto&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.page, page) || other.page == page)&&(identical(other.readingMode, readingMode) || other.readingMode == readingMode)&&(identical(other.timeSpentSeconds, timeSpentSeconds) || other.timeSpentSeconds == timeSpentSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,sessionId,page,readingMode,timeSpentSeconds);
}

@override
String toString() {
    return 'ReadingProgressDto(sessionId: $sessionId, page: $page, readingMode: $readingMode, timeSpentSeconds: $timeSpentSeconds)';
}


}

/// @nodoc
abstract mixin class _$ReadingProgressDtoCopyWith<$Res> implements $ReadingProgressDtoCopyWith<$Res> {
  factory _$ReadingProgressDtoCopyWith(_ReadingProgressDto value, $Res Function(_ReadingProgressDto) _then) = __$ReadingProgressDtoCopyWithImpl;
@override @useResult
$Res call({
 int sessionId, int page, String? readingMode, int timeSpentSeconds
});




}
/// @nodoc
class __$ReadingProgressDtoCopyWithImpl<$Res>
    implements _$ReadingProgressDtoCopyWith<$Res> {
  __$ReadingProgressDtoCopyWithImpl(this._self, this._then);

  final _ReadingProgressDto _self;
  final $Res Function(_ReadingProgressDto) _then;

/// Create a copy of ReadingProgressDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionId = null,Object? page = null,Object? readingMode = freezed,Object? timeSpentSeconds = null,}) {
  return _then(_ReadingProgressDto(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,readingMode: freezed == readingMode ? _self.readingMode : readingMode // ignore: cast_nullable_to_non_nullable
as String?,timeSpentSeconds: null == timeSpentSeconds ? _self.timeSpentSeconds : timeSpentSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ReadingCompletedDto {

 int get sessionId; int get storyId; bool get isRetake; bool get roadmapStepCompleted; int get expGained; List<String> get newBadges;
/// Create a copy of ReadingCompletedDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadingCompletedDtoCopyWith<ReadingCompletedDto> get copyWith => _$ReadingCompletedDtoCopyWithImpl<ReadingCompletedDto>(this as ReadingCompletedDto, _$identity);

  /// Serializes this ReadingCompletedDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ReadingCompletedDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadingCompletedDto&&(identical(other.sessionId, _this.sessionId) || other.sessionId == _this.sessionId)&&(identical(other.storyId, _this.storyId) || other.storyId == _this.storyId)&&(identical(other.isRetake, _this.isRetake) || other.isRetake == _this.isRetake)&&(identical(other.roadmapStepCompleted, _this.roadmapStepCompleted) || other.roadmapStepCompleted == _this.roadmapStepCompleted)&&(identical(other.expGained, _this.expGained) || other.expGained == _this.expGained)&&const DeepCollectionEquality().equals(other.newBadges, _this.newBadges));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ReadingCompletedDto;
  return Object.hash(runtimeType,_this.sessionId,_this.storyId,_this.isRetake,_this.roadmapStepCompleted,_this.expGained,const DeepCollectionEquality().hash(_this.newBadges));
}

@override
String toString() {
  final _this = this as ReadingCompletedDto;
  return 'ReadingCompletedDto(sessionId: ${_this.sessionId}, storyId: ${_this.storyId}, isRetake: ${_this.isRetake}, roadmapStepCompleted: ${_this.roadmapStepCompleted}, expGained: ${_this.expGained}, newBadges: ${_this.newBadges})';
}


}

/// @nodoc
abstract mixin class $ReadingCompletedDtoCopyWith<$Res>  {
  factory $ReadingCompletedDtoCopyWith(ReadingCompletedDto value, $Res Function(ReadingCompletedDto) _then) = _$ReadingCompletedDtoCopyWithImpl;
@useResult
$Res call({
 int sessionId, int storyId, bool isRetake, bool roadmapStepCompleted, int expGained, List<String> newBadges
});




}
/// @nodoc
class _$ReadingCompletedDtoCopyWithImpl<$Res>
    implements $ReadingCompletedDtoCopyWith<$Res> {
  _$ReadingCompletedDtoCopyWithImpl(this._self, this._then);

  final ReadingCompletedDto _self;
  final $Res Function(ReadingCompletedDto) _then;

/// Create a copy of ReadingCompletedDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionId = null,Object? storyId = null,Object? isRetake = null,Object? roadmapStepCompleted = null,Object? expGained = null,Object? newBadges = null,}) {
  return _then(ReadingCompletedDto(
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


/// Adds pattern-matching-related methods to [ReadingCompletedDto].
extension ReadingCompletedDtoPatterns on ReadingCompletedDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReadingCompletedDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReadingCompletedDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReadingCompletedDto value)  $default,){
final _that = this;
switch (_that) {
case _ReadingCompletedDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReadingCompletedDto value)?  $default,){
final _that = this;
switch (_that) {
case _ReadingCompletedDto() when $default != null:
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
case _ReadingCompletedDto() when $default != null:
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
case _ReadingCompletedDto():
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
case _ReadingCompletedDto() when $default != null:
return $default(_that.sessionId,_that.storyId,_that.isRetake,_that.roadmapStepCompleted,_that.expGained,_that.newBadges);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReadingCompletedDto implements ReadingCompletedDto {
  const _ReadingCompletedDto({required this.sessionId, required this.storyId, this.isRetake = false, this.roadmapStepCompleted = false, this.expGained = 0,  List<String> newBadges = const <String>[]}): _newBadges = newBadges;
  factory _ReadingCompletedDto.fromJson(Map<String, dynamic> json) => _$ReadingCompletedDtoFromJson(json);

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


/// Create a copy of ReadingCompletedDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadingCompletedDtoCopyWith<_ReadingCompletedDto> get copyWith => __$ReadingCompletedDtoCopyWithImpl<_ReadingCompletedDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReadingCompletedDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReadingCompletedDto&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.storyId, storyId) || other.storyId == storyId)&&(identical(other.isRetake, isRetake) || other.isRetake == isRetake)&&(identical(other.roadmapStepCompleted, roadmapStepCompleted) || other.roadmapStepCompleted == roadmapStepCompleted)&&(identical(other.expGained, expGained) || other.expGained == expGained)&&const DeepCollectionEquality().equals(other.newBadges, _newBadges));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,sessionId,storyId,isRetake,roadmapStepCompleted,expGained,const DeepCollectionEquality().hash(_newBadges));
}

@override
String toString() {
    return 'ReadingCompletedDto(sessionId: $sessionId, storyId: $storyId, isRetake: $isRetake, roadmapStepCompleted: $roadmapStepCompleted, expGained: $expGained, newBadges: $newBadges)';
}


}

/// @nodoc
abstract mixin class _$ReadingCompletedDtoCopyWith<$Res> implements $ReadingCompletedDtoCopyWith<$Res> {
  factory _$ReadingCompletedDtoCopyWith(_ReadingCompletedDto value, $Res Function(_ReadingCompletedDto) _then) = __$ReadingCompletedDtoCopyWithImpl;
@override @useResult
$Res call({
 int sessionId, int storyId, bool isRetake, bool roadmapStepCompleted, int expGained, List<String> newBadges
});




}
/// @nodoc
class __$ReadingCompletedDtoCopyWithImpl<$Res>
    implements _$ReadingCompletedDtoCopyWith<$Res> {
  __$ReadingCompletedDtoCopyWithImpl(this._self, this._then);

  final _ReadingCompletedDto _self;
  final $Res Function(_ReadingCompletedDto) _then;

/// Create a copy of ReadingCompletedDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionId = null,Object? storyId = null,Object? isRetake = null,Object? roadmapStepCompleted = null,Object? expGained = null,Object? newBadges = null,}) {
  return _then(_ReadingCompletedDto(
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
mixin _$ReadingSignalDto {

 bool get shouldExit; String? get returnTo; String? get message; String? get sessionStatus;
/// Create a copy of ReadingSignalDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadingSignalDtoCopyWith<ReadingSignalDto> get copyWith => _$ReadingSignalDtoCopyWithImpl<ReadingSignalDto>(this as ReadingSignalDto, _$identity);

  /// Serializes this ReadingSignalDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ReadingSignalDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadingSignalDto&&(identical(other.shouldExit, _this.shouldExit) || other.shouldExit == _this.shouldExit)&&(identical(other.returnTo, _this.returnTo) || other.returnTo == _this.returnTo)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.sessionStatus, _this.sessionStatus) || other.sessionStatus == _this.sessionStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ReadingSignalDto;
  return Object.hash(runtimeType,_this.shouldExit,_this.returnTo,_this.message,_this.sessionStatus);
}

@override
String toString() {
  final _this = this as ReadingSignalDto;
  return 'ReadingSignalDto(shouldExit: ${_this.shouldExit}, returnTo: ${_this.returnTo}, message: ${_this.message}, sessionStatus: ${_this.sessionStatus})';
}


}

/// @nodoc
abstract mixin class $ReadingSignalDtoCopyWith<$Res>  {
  factory $ReadingSignalDtoCopyWith(ReadingSignalDto value, $Res Function(ReadingSignalDto) _then) = _$ReadingSignalDtoCopyWithImpl;
@useResult
$Res call({
 bool shouldExit, String? returnTo, String? message, String? sessionStatus
});




}
/// @nodoc
class _$ReadingSignalDtoCopyWithImpl<$Res>
    implements $ReadingSignalDtoCopyWith<$Res> {
  _$ReadingSignalDtoCopyWithImpl(this._self, this._then);

  final ReadingSignalDto _self;
  final $Res Function(ReadingSignalDto) _then;

/// Create a copy of ReadingSignalDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? shouldExit = null,Object? returnTo = freezed,Object? message = freezed,Object? sessionStatus = freezed,}) {
  return _then(ReadingSignalDto(
shouldExit: null == shouldExit ? _self.shouldExit : shouldExit // ignore: cast_nullable_to_non_nullable
as bool,returnTo: freezed == returnTo ? _self.returnTo : returnTo // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,sessionStatus: freezed == sessionStatus ? _self.sessionStatus : sessionStatus // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReadingSignalDto].
extension ReadingSignalDtoPatterns on ReadingSignalDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReadingSignalDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReadingSignalDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReadingSignalDto value)  $default,){
final _that = this;
switch (_that) {
case _ReadingSignalDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReadingSignalDto value)?  $default,){
final _that = this;
switch (_that) {
case _ReadingSignalDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool shouldExit,  String? returnTo,  String? message,  String? sessionStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReadingSignalDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool shouldExit,  String? returnTo,  String? message,  String? sessionStatus)  $default,) {final _that = this;
switch (_that) {
case _ReadingSignalDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool shouldExit,  String? returnTo,  String? message,  String? sessionStatus)?  $default,) {final _that = this;
switch (_that) {
case _ReadingSignalDto() when $default != null:
return $default(_that.shouldExit,_that.returnTo,_that.message,_that.sessionStatus);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReadingSignalDto implements ReadingSignalDto {
  const _ReadingSignalDto({this.shouldExit = false, this.returnTo, this.message, this.sessionStatus});
  factory _ReadingSignalDto.fromJson(Map<String, dynamic> json) => _$ReadingSignalDtoFromJson(json);

@override@JsonKey() final  bool shouldExit;
@override final  String? returnTo;
@override final  String? message;
@override final  String? sessionStatus;

/// Create a copy of ReadingSignalDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadingSignalDtoCopyWith<_ReadingSignalDto> get copyWith => __$ReadingSignalDtoCopyWithImpl<_ReadingSignalDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReadingSignalDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReadingSignalDto&&(identical(other.shouldExit, shouldExit) || other.shouldExit == shouldExit)&&(identical(other.returnTo, returnTo) || other.returnTo == returnTo)&&(identical(other.message, message) || other.message == message)&&(identical(other.sessionStatus, sessionStatus) || other.sessionStatus == sessionStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,shouldExit,returnTo,message,sessionStatus);
}

@override
String toString() {
    return 'ReadingSignalDto(shouldExit: $shouldExit, returnTo: $returnTo, message: $message, sessionStatus: $sessionStatus)';
}


}

/// @nodoc
abstract mixin class _$ReadingSignalDtoCopyWith<$Res> implements $ReadingSignalDtoCopyWith<$Res> {
  factory _$ReadingSignalDtoCopyWith(_ReadingSignalDto value, $Res Function(_ReadingSignalDto) _then) = __$ReadingSignalDtoCopyWithImpl;
@override @useResult
$Res call({
 bool shouldExit, String? returnTo, String? message, String? sessionStatus
});




}
/// @nodoc
class __$ReadingSignalDtoCopyWithImpl<$Res>
    implements _$ReadingSignalDtoCopyWith<$Res> {
  __$ReadingSignalDtoCopyWithImpl(this._self, this._then);

  final _ReadingSignalDto _self;
  final $Res Function(_ReadingSignalDto) _then;

/// Create a copy of ReadingSignalDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? shouldExit = null,Object? returnTo = freezed,Object? message = freezed,Object? sessionStatus = freezed,}) {
  return _then(_ReadingSignalDto(
shouldExit: null == shouldExit ? _self.shouldExit : shouldExit // ignore: cast_nullable_to_non_nullable
as bool,returnTo: freezed == returnTo ? _self.returnTo : returnTo // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,sessionStatus: freezed == sessionStatus ? _self.sessionStatus : sessionStatus // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$VocabularyDefinitionDto {

 int get vocabularyId; String get term; String get definition; bool get isCollected;
/// Create a copy of VocabularyDefinitionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VocabularyDefinitionDtoCopyWith<VocabularyDefinitionDto> get copyWith => _$VocabularyDefinitionDtoCopyWithImpl<VocabularyDefinitionDto>(this as VocabularyDefinitionDto, _$identity);

  /// Serializes this VocabularyDefinitionDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as VocabularyDefinitionDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VocabularyDefinitionDto&&(identical(other.vocabularyId, _this.vocabularyId) || other.vocabularyId == _this.vocabularyId)&&(identical(other.term, _this.term) || other.term == _this.term)&&(identical(other.definition, _this.definition) || other.definition == _this.definition)&&(identical(other.isCollected, _this.isCollected) || other.isCollected == _this.isCollected));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as VocabularyDefinitionDto;
  return Object.hash(runtimeType,_this.vocabularyId,_this.term,_this.definition,_this.isCollected);
}

@override
String toString() {
  final _this = this as VocabularyDefinitionDto;
  return 'VocabularyDefinitionDto(vocabularyId: ${_this.vocabularyId}, term: ${_this.term}, definition: ${_this.definition}, isCollected: ${_this.isCollected})';
}


}

/// @nodoc
abstract mixin class $VocabularyDefinitionDtoCopyWith<$Res>  {
  factory $VocabularyDefinitionDtoCopyWith(VocabularyDefinitionDto value, $Res Function(VocabularyDefinitionDto) _then) = _$VocabularyDefinitionDtoCopyWithImpl;
@useResult
$Res call({
 int vocabularyId, String term, String definition, bool isCollected
});




}
/// @nodoc
class _$VocabularyDefinitionDtoCopyWithImpl<$Res>
    implements $VocabularyDefinitionDtoCopyWith<$Res> {
  _$VocabularyDefinitionDtoCopyWithImpl(this._self, this._then);

  final VocabularyDefinitionDto _self;
  final $Res Function(VocabularyDefinitionDto) _then;

/// Create a copy of VocabularyDefinitionDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? vocabularyId = null,Object? term = null,Object? definition = null,Object? isCollected = null,}) {
  return _then(VocabularyDefinitionDto(
vocabularyId: null == vocabularyId ? _self.vocabularyId : vocabularyId // ignore: cast_nullable_to_non_nullable
as int,term: null == term ? _self.term : term // ignore: cast_nullable_to_non_nullable
as String,definition: null == definition ? _self.definition : definition // ignore: cast_nullable_to_non_nullable
as String,isCollected: null == isCollected ? _self.isCollected : isCollected // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [VocabularyDefinitionDto].
extension VocabularyDefinitionDtoPatterns on VocabularyDefinitionDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VocabularyDefinitionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VocabularyDefinitionDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VocabularyDefinitionDto value)  $default,){
final _that = this;
switch (_that) {
case _VocabularyDefinitionDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VocabularyDefinitionDto value)?  $default,){
final _that = this;
switch (_that) {
case _VocabularyDefinitionDto() when $default != null:
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
case _VocabularyDefinitionDto() when $default != null:
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
case _VocabularyDefinitionDto():
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
case _VocabularyDefinitionDto() when $default != null:
return $default(_that.vocabularyId,_that.term,_that.definition,_that.isCollected);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VocabularyDefinitionDto implements VocabularyDefinitionDto {
  const _VocabularyDefinitionDto({required this.vocabularyId, required this.term, this.definition = '', this.isCollected = false});
  factory _VocabularyDefinitionDto.fromJson(Map<String, dynamic> json) => _$VocabularyDefinitionDtoFromJson(json);

@override final  int vocabularyId;
@override final  String term;
@override@JsonKey() final  String definition;
@override@JsonKey() final  bool isCollected;

/// Create a copy of VocabularyDefinitionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VocabularyDefinitionDtoCopyWith<_VocabularyDefinitionDto> get copyWith => __$VocabularyDefinitionDtoCopyWithImpl<_VocabularyDefinitionDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VocabularyDefinitionDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _VocabularyDefinitionDto&&(identical(other.vocabularyId, vocabularyId) || other.vocabularyId == vocabularyId)&&(identical(other.term, term) || other.term == term)&&(identical(other.definition, definition) || other.definition == definition)&&(identical(other.isCollected, isCollected) || other.isCollected == isCollected));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,vocabularyId,term,definition,isCollected);
}

@override
String toString() {
    return 'VocabularyDefinitionDto(vocabularyId: $vocabularyId, term: $term, definition: $definition, isCollected: $isCollected)';
}


}

/// @nodoc
abstract mixin class _$VocabularyDefinitionDtoCopyWith<$Res> implements $VocabularyDefinitionDtoCopyWith<$Res> {
  factory _$VocabularyDefinitionDtoCopyWith(_VocabularyDefinitionDto value, $Res Function(_VocabularyDefinitionDto) _then) = __$VocabularyDefinitionDtoCopyWithImpl;
@override @useResult
$Res call({
 int vocabularyId, String term, String definition, bool isCollected
});




}
/// @nodoc
class __$VocabularyDefinitionDtoCopyWithImpl<$Res>
    implements _$VocabularyDefinitionDtoCopyWith<$Res> {
  __$VocabularyDefinitionDtoCopyWithImpl(this._self, this._then);

  final _VocabularyDefinitionDto _self;
  final $Res Function(_VocabularyDefinitionDto) _then;

/// Create a copy of VocabularyDefinitionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? vocabularyId = null,Object? term = null,Object? definition = null,Object? isCollected = null,}) {
  return _then(_VocabularyDefinitionDto(
vocabularyId: null == vocabularyId ? _self.vocabularyId : vocabularyId // ignore: cast_nullable_to_non_nullable
as int,term: null == term ? _self.term : term // ignore: cast_nullable_to_non_nullable
as String,definition: null == definition ? _self.definition : definition // ignore: cast_nullable_to_non_nullable
as String,isCollected: null == isCollected ? _self.isCollected : isCollected // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
