// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'read_aloud_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReadAloudWordDto {

 int get index; String get text; String get status; String? get hint;
/// Create a copy of ReadAloudWordDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadAloudWordDtoCopyWith<ReadAloudWordDto> get copyWith => _$ReadAloudWordDtoCopyWithImpl<ReadAloudWordDto>(this as ReadAloudWordDto, _$identity);

  /// Serializes this ReadAloudWordDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ReadAloudWordDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadAloudWordDto&&(identical(other.index, _this.index) || other.index == _this.index)&&(identical(other.text, _this.text) || other.text == _this.text)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.hint, _this.hint) || other.hint == _this.hint));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ReadAloudWordDto;
  return Object.hash(runtimeType,_this.index,_this.text,_this.status,_this.hint);
}

@override
String toString() {
  final _this = this as ReadAloudWordDto;
  return 'ReadAloudWordDto(index: ${_this.index}, text: ${_this.text}, status: ${_this.status}, hint: ${_this.hint})';
}


}

/// @nodoc
abstract mixin class $ReadAloudWordDtoCopyWith<$Res>  {
  factory $ReadAloudWordDtoCopyWith(ReadAloudWordDto value, $Res Function(ReadAloudWordDto) _then) = _$ReadAloudWordDtoCopyWithImpl;
@useResult
$Res call({
 int index, String text, String status, String? hint
});




}
/// @nodoc
class _$ReadAloudWordDtoCopyWithImpl<$Res>
    implements $ReadAloudWordDtoCopyWith<$Res> {
  _$ReadAloudWordDtoCopyWithImpl(this._self, this._then);

  final ReadAloudWordDto _self;
  final $Res Function(ReadAloudWordDto) _then;

/// Create a copy of ReadAloudWordDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? index = null,Object? text = null,Object? status = null,Object? hint = freezed,}) {
  return _then(ReadAloudWordDto(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,hint: freezed == hint ? _self.hint : hint // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReadAloudWordDto].
extension ReadAloudWordDtoPatterns on ReadAloudWordDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReadAloudWordDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReadAloudWordDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReadAloudWordDto value)  $default,){
final _that = this;
switch (_that) {
case _ReadAloudWordDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReadAloudWordDto value)?  $default,){
final _that = this;
switch (_that) {
case _ReadAloudWordDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int index,  String text,  String status,  String? hint)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReadAloudWordDto() when $default != null:
return $default(_that.index,_that.text,_that.status,_that.hint);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int index,  String text,  String status,  String? hint)  $default,) {final _that = this;
switch (_that) {
case _ReadAloudWordDto():
return $default(_that.index,_that.text,_that.status,_that.hint);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int index,  String text,  String status,  String? hint)?  $default,) {final _that = this;
switch (_that) {
case _ReadAloudWordDto() when $default != null:
return $default(_that.index,_that.text,_that.status,_that.hint);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReadAloudWordDto implements ReadAloudWordDto {
  const _ReadAloudWordDto({required this.index, required this.text, this.status = 'skipped', this.hint});
  factory _ReadAloudWordDto.fromJson(Map<String, dynamic> json) => _$ReadAloudWordDtoFromJson(json);

@override final  int index;
@override final  String text;
@override@JsonKey() final  String status;
@override final  String? hint;

/// Create a copy of ReadAloudWordDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadAloudWordDtoCopyWith<_ReadAloudWordDto> get copyWith => __$ReadAloudWordDtoCopyWithImpl<_ReadAloudWordDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReadAloudWordDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReadAloudWordDto&&(identical(other.index, index) || other.index == index)&&(identical(other.text, text) || other.text == text)&&(identical(other.status, status) || other.status == status)&&(identical(other.hint, hint) || other.hint == hint));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,index,text,status,hint);
}

@override
String toString() {
    return 'ReadAloudWordDto(index: $index, text: $text, status: $status, hint: $hint)';
}


}

/// @nodoc
abstract mixin class _$ReadAloudWordDtoCopyWith<$Res> implements $ReadAloudWordDtoCopyWith<$Res> {
  factory _$ReadAloudWordDtoCopyWith(_ReadAloudWordDto value, $Res Function(_ReadAloudWordDto) _then) = __$ReadAloudWordDtoCopyWithImpl;
@override @useResult
$Res call({
 int index, String text, String status, String? hint
});




}
/// @nodoc
class __$ReadAloudWordDtoCopyWithImpl<$Res>
    implements _$ReadAloudWordDtoCopyWith<$Res> {
  __$ReadAloudWordDtoCopyWithImpl(this._self, this._then);

  final _ReadAloudWordDto _self;
  final $Res Function(_ReadAloudWordDto) _then;

/// Create a copy of ReadAloudWordDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? index = null,Object? text = null,Object? status = null,Object? hint = freezed,}) {
  return _then(_ReadAloudWordDto(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,hint: freezed == hint ? _self.hint : hint // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ReadAloudResultDto {

 int get sessionId; int get segmentId; List<ReadAloudWordDto> get words; int get goodCount; int get retryCount; int get skippedCount; int get totalCount; String get message;
/// Create a copy of ReadAloudResultDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadAloudResultDtoCopyWith<ReadAloudResultDto> get copyWith => _$ReadAloudResultDtoCopyWithImpl<ReadAloudResultDto>(this as ReadAloudResultDto, _$identity);

  /// Serializes this ReadAloudResultDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ReadAloudResultDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadAloudResultDto&&(identical(other.sessionId, _this.sessionId) || other.sessionId == _this.sessionId)&&(identical(other.segmentId, _this.segmentId) || other.segmentId == _this.segmentId)&&const DeepCollectionEquality().equals(other.words, _this.words)&&(identical(other.goodCount, _this.goodCount) || other.goodCount == _this.goodCount)&&(identical(other.retryCount, _this.retryCount) || other.retryCount == _this.retryCount)&&(identical(other.skippedCount, _this.skippedCount) || other.skippedCount == _this.skippedCount)&&(identical(other.totalCount, _this.totalCount) || other.totalCount == _this.totalCount)&&(identical(other.message, _this.message) || other.message == _this.message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ReadAloudResultDto;
  return Object.hash(runtimeType,_this.sessionId,_this.segmentId,const DeepCollectionEquality().hash(_this.words),_this.goodCount,_this.retryCount,_this.skippedCount,_this.totalCount,_this.message);
}

@override
String toString() {
  final _this = this as ReadAloudResultDto;
  return 'ReadAloudResultDto(sessionId: ${_this.sessionId}, segmentId: ${_this.segmentId}, words: ${_this.words}, goodCount: ${_this.goodCount}, retryCount: ${_this.retryCount}, skippedCount: ${_this.skippedCount}, totalCount: ${_this.totalCount}, message: ${_this.message})';
}


}

/// @nodoc
abstract mixin class $ReadAloudResultDtoCopyWith<$Res>  {
  factory $ReadAloudResultDtoCopyWith(ReadAloudResultDto value, $Res Function(ReadAloudResultDto) _then) = _$ReadAloudResultDtoCopyWithImpl;
@useResult
$Res call({
 int sessionId, int segmentId, List<ReadAloudWordDto> words, int goodCount, int retryCount, int skippedCount, int totalCount, String message
});




}
/// @nodoc
class _$ReadAloudResultDtoCopyWithImpl<$Res>
    implements $ReadAloudResultDtoCopyWith<$Res> {
  _$ReadAloudResultDtoCopyWithImpl(this._self, this._then);

  final ReadAloudResultDto _self;
  final $Res Function(ReadAloudResultDto) _then;

/// Create a copy of ReadAloudResultDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionId = null,Object? segmentId = null,Object? words = null,Object? goodCount = null,Object? retryCount = null,Object? skippedCount = null,Object? totalCount = null,Object? message = null,}) {
  return _then(ReadAloudResultDto(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as int,segmentId: null == segmentId ? _self.segmentId : segmentId // ignore: cast_nullable_to_non_nullable
as int,words: null == words ? _self.words : words // ignore: cast_nullable_to_non_nullable
as List<ReadAloudWordDto>,goodCount: null == goodCount ? _self.goodCount : goodCount // ignore: cast_nullable_to_non_nullable
as int,retryCount: null == retryCount ? _self.retryCount : retryCount // ignore: cast_nullable_to_non_nullable
as int,skippedCount: null == skippedCount ? _self.skippedCount : skippedCount // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ReadAloudResultDto].
extension ReadAloudResultDtoPatterns on ReadAloudResultDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReadAloudResultDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReadAloudResultDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReadAloudResultDto value)  $default,){
final _that = this;
switch (_that) {
case _ReadAloudResultDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReadAloudResultDto value)?  $default,){
final _that = this;
switch (_that) {
case _ReadAloudResultDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int sessionId,  int segmentId,  List<ReadAloudWordDto> words,  int goodCount,  int retryCount,  int skippedCount,  int totalCount,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReadAloudResultDto() when $default != null:
return $default(_that.sessionId,_that.segmentId,_that.words,_that.goodCount,_that.retryCount,_that.skippedCount,_that.totalCount,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int sessionId,  int segmentId,  List<ReadAloudWordDto> words,  int goodCount,  int retryCount,  int skippedCount,  int totalCount,  String message)  $default,) {final _that = this;
switch (_that) {
case _ReadAloudResultDto():
return $default(_that.sessionId,_that.segmentId,_that.words,_that.goodCount,_that.retryCount,_that.skippedCount,_that.totalCount,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int sessionId,  int segmentId,  List<ReadAloudWordDto> words,  int goodCount,  int retryCount,  int skippedCount,  int totalCount,  String message)?  $default,) {final _that = this;
switch (_that) {
case _ReadAloudResultDto() when $default != null:
return $default(_that.sessionId,_that.segmentId,_that.words,_that.goodCount,_that.retryCount,_that.skippedCount,_that.totalCount,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReadAloudResultDto implements ReadAloudResultDto {
  const _ReadAloudResultDto({required this.sessionId, required this.segmentId,  List<ReadAloudWordDto> words = const <ReadAloudWordDto>[], this.goodCount = 0, this.retryCount = 0, this.skippedCount = 0, this.totalCount = 0, this.message = ''}): _words = words;
  factory _ReadAloudResultDto.fromJson(Map<String, dynamic> json) => _$ReadAloudResultDtoFromJson(json);

@override final  int sessionId;
@override final  int segmentId;
 final  List<ReadAloudWordDto> _words;
@override@JsonKey() List<ReadAloudWordDto> get words {
  if (_words is EqualUnmodifiableListView) return _words;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_words);
}

@override@JsonKey() final  int goodCount;
@override@JsonKey() final  int retryCount;
@override@JsonKey() final  int skippedCount;
@override@JsonKey() final  int totalCount;
@override@JsonKey() final  String message;

/// Create a copy of ReadAloudResultDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadAloudResultDtoCopyWith<_ReadAloudResultDto> get copyWith => __$ReadAloudResultDtoCopyWithImpl<_ReadAloudResultDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReadAloudResultDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReadAloudResultDto&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.segmentId, segmentId) || other.segmentId == segmentId)&&const DeepCollectionEquality().equals(other.words, _words)&&(identical(other.goodCount, goodCount) || other.goodCount == goodCount)&&(identical(other.retryCount, retryCount) || other.retryCount == retryCount)&&(identical(other.skippedCount, skippedCount) || other.skippedCount == skippedCount)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,sessionId,segmentId,const DeepCollectionEquality().hash(_words),goodCount,retryCount,skippedCount,totalCount,message);
}

@override
String toString() {
    return 'ReadAloudResultDto(sessionId: $sessionId, segmentId: $segmentId, words: $words, goodCount: $goodCount, retryCount: $retryCount, skippedCount: $skippedCount, totalCount: $totalCount, message: $message)';
}


}

/// @nodoc
abstract mixin class _$ReadAloudResultDtoCopyWith<$Res> implements $ReadAloudResultDtoCopyWith<$Res> {
  factory _$ReadAloudResultDtoCopyWith(_ReadAloudResultDto value, $Res Function(_ReadAloudResultDto) _then) = __$ReadAloudResultDtoCopyWithImpl;
@override @useResult
$Res call({
 int sessionId, int segmentId, List<ReadAloudWordDto> words, int goodCount, int retryCount, int skippedCount, int totalCount, String message
});




}
/// @nodoc
class __$ReadAloudResultDtoCopyWithImpl<$Res>
    implements _$ReadAloudResultDtoCopyWith<$Res> {
  __$ReadAloudResultDtoCopyWithImpl(this._self, this._then);

  final _ReadAloudResultDto _self;
  final $Res Function(_ReadAloudResultDto) _then;

/// Create a copy of ReadAloudResultDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionId = null,Object? segmentId = null,Object? words = null,Object? goodCount = null,Object? retryCount = null,Object? skippedCount = null,Object? totalCount = null,Object? message = null,}) {
  return _then(_ReadAloudResultDto(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as int,segmentId: null == segmentId ? _self.segmentId : segmentId // ignore: cast_nullable_to_non_nullable
as int,words: null == words ? _self._words : words // ignore: cast_nullable_to_non_nullable
as List<ReadAloudWordDto>,goodCount: null == goodCount ? _self.goodCount : goodCount // ignore: cast_nullable_to_non_nullable
as int,retryCount: null == retryCount ? _self.retryCount : retryCount // ignore: cast_nullable_to_non_nullable
as int,skippedCount: null == skippedCount ? _self.skippedCount : skippedCount // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
