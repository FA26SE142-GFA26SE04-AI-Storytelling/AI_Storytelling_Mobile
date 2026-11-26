// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'child_read_aloud_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReadAloudWord {

 int get index; String get text; String get status; String? get hint;
/// Create a copy of ReadAloudWord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadAloudWordCopyWith<ReadAloudWord> get copyWith => _$ReadAloudWordCopyWithImpl<ReadAloudWord>(this as ReadAloudWord, _$identity);

  /// Serializes this ReadAloudWord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ReadAloudWord;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadAloudWord&&(identical(other.index, _this.index) || other.index == _this.index)&&(identical(other.text, _this.text) || other.text == _this.text)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.hint, _this.hint) || other.hint == _this.hint));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ReadAloudWord;
  return Object.hash(runtimeType,_this.index,_this.text,_this.status,_this.hint);
}

@override
String toString() {
  final _this = this as ReadAloudWord;
  return 'ReadAloudWord(index: ${_this.index}, text: ${_this.text}, status: ${_this.status}, hint: ${_this.hint})';
}


}

/// @nodoc
abstract mixin class $ReadAloudWordCopyWith<$Res>  {
  factory $ReadAloudWordCopyWith(ReadAloudWord value, $Res Function(ReadAloudWord) _then) = _$ReadAloudWordCopyWithImpl;
@useResult
$Res call({
 int index, String text, String status, String? hint
});




}
/// @nodoc
class _$ReadAloudWordCopyWithImpl<$Res>
    implements $ReadAloudWordCopyWith<$Res> {
  _$ReadAloudWordCopyWithImpl(this._self, this._then);

  final ReadAloudWord _self;
  final $Res Function(ReadAloudWord) _then;

/// Create a copy of ReadAloudWord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? index = null,Object? text = null,Object? status = null,Object? hint = freezed,}) {
  return _then(ReadAloudWord(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,hint: freezed == hint ? _self.hint : hint // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReadAloudWord].
extension ReadAloudWordPatterns on ReadAloudWord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReadAloudWord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReadAloudWord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReadAloudWord value)  $default,){
final _that = this;
switch (_that) {
case _ReadAloudWord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReadAloudWord value)?  $default,){
final _that = this;
switch (_that) {
case _ReadAloudWord() when $default != null:
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
case _ReadAloudWord() when $default != null:
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
case _ReadAloudWord():
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
case _ReadAloudWord() when $default != null:
return $default(_that.index,_that.text,_that.status,_that.hint);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReadAloudWord implements ReadAloudWord {
  const _ReadAloudWord({required this.index, this.text = '', this.status = 'good', this.hint});
  factory _ReadAloudWord.fromJson(Map<String, dynamic> json) => _$ReadAloudWordFromJson(json);

@override final  int index;
@override@JsonKey() final  String text;
@override@JsonKey() final  String status;
@override final  String? hint;

/// Create a copy of ReadAloudWord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadAloudWordCopyWith<_ReadAloudWord> get copyWith => __$ReadAloudWordCopyWithImpl<_ReadAloudWord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReadAloudWordToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReadAloudWord&&(identical(other.index, index) || other.index == index)&&(identical(other.text, text) || other.text == text)&&(identical(other.status, status) || other.status == status)&&(identical(other.hint, hint) || other.hint == hint));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,index,text,status,hint);
}

@override
String toString() {
    return 'ReadAloudWord(index: $index, text: $text, status: $status, hint: $hint)';
}


}

/// @nodoc
abstract mixin class _$ReadAloudWordCopyWith<$Res> implements $ReadAloudWordCopyWith<$Res> {
  factory _$ReadAloudWordCopyWith(_ReadAloudWord value, $Res Function(_ReadAloudWord) _then) = __$ReadAloudWordCopyWithImpl;
@override @useResult
$Res call({
 int index, String text, String status, String? hint
});




}
/// @nodoc
class __$ReadAloudWordCopyWithImpl<$Res>
    implements _$ReadAloudWordCopyWith<$Res> {
  __$ReadAloudWordCopyWithImpl(this._self, this._then);

  final _ReadAloudWord _self;
  final $Res Function(_ReadAloudWord) _then;

/// Create a copy of ReadAloudWord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? index = null,Object? text = null,Object? status = null,Object? hint = freezed,}) {
  return _then(_ReadAloudWord(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,hint: freezed == hint ? _self.hint : hint // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ReadAloudResult {

 int get sessionId; int? get segmentId; int? get interactionId; List<ReadAloudWord> get words; int get goodCount; int get retryCount; int get skippedCount; int get totalCount; String get message;
/// Create a copy of ReadAloudResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadAloudResultCopyWith<ReadAloudResult> get copyWith => _$ReadAloudResultCopyWithImpl<ReadAloudResult>(this as ReadAloudResult, _$identity);

  /// Serializes this ReadAloudResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ReadAloudResult;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadAloudResult&&(identical(other.sessionId, _this.sessionId) || other.sessionId == _this.sessionId)&&(identical(other.segmentId, _this.segmentId) || other.segmentId == _this.segmentId)&&(identical(other.interactionId, _this.interactionId) || other.interactionId == _this.interactionId)&&const DeepCollectionEquality().equals(other.words, _this.words)&&(identical(other.goodCount, _this.goodCount) || other.goodCount == _this.goodCount)&&(identical(other.retryCount, _this.retryCount) || other.retryCount == _this.retryCount)&&(identical(other.skippedCount, _this.skippedCount) || other.skippedCount == _this.skippedCount)&&(identical(other.totalCount, _this.totalCount) || other.totalCount == _this.totalCount)&&(identical(other.message, _this.message) || other.message == _this.message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ReadAloudResult;
  return Object.hash(runtimeType,_this.sessionId,_this.segmentId,_this.interactionId,const DeepCollectionEquality().hash(_this.words),_this.goodCount,_this.retryCount,_this.skippedCount,_this.totalCount,_this.message);
}

@override
String toString() {
  final _this = this as ReadAloudResult;
  return 'ReadAloudResult(sessionId: ${_this.sessionId}, segmentId: ${_this.segmentId}, interactionId: ${_this.interactionId}, words: ${_this.words}, goodCount: ${_this.goodCount}, retryCount: ${_this.retryCount}, skippedCount: ${_this.skippedCount}, totalCount: ${_this.totalCount}, message: ${_this.message})';
}


}

/// @nodoc
abstract mixin class $ReadAloudResultCopyWith<$Res>  {
  factory $ReadAloudResultCopyWith(ReadAloudResult value, $Res Function(ReadAloudResult) _then) = _$ReadAloudResultCopyWithImpl;
@useResult
$Res call({
 int sessionId, int? segmentId, int? interactionId, List<ReadAloudWord> words, int goodCount, int retryCount, int skippedCount, int totalCount, String message
});




}
/// @nodoc
class _$ReadAloudResultCopyWithImpl<$Res>
    implements $ReadAloudResultCopyWith<$Res> {
  _$ReadAloudResultCopyWithImpl(this._self, this._then);

  final ReadAloudResult _self;
  final $Res Function(ReadAloudResult) _then;

/// Create a copy of ReadAloudResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionId = null,Object? segmentId = freezed,Object? interactionId = freezed,Object? words = null,Object? goodCount = null,Object? retryCount = null,Object? skippedCount = null,Object? totalCount = null,Object? message = null,}) {
  return _then(ReadAloudResult(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as int,segmentId: freezed == segmentId ? _self.segmentId : segmentId // ignore: cast_nullable_to_non_nullable
as int?,interactionId: freezed == interactionId ? _self.interactionId : interactionId // ignore: cast_nullable_to_non_nullable
as int?,words: null == words ? _self.words : words // ignore: cast_nullable_to_non_nullable
as List<ReadAloudWord>,goodCount: null == goodCount ? _self.goodCount : goodCount // ignore: cast_nullable_to_non_nullable
as int,retryCount: null == retryCount ? _self.retryCount : retryCount // ignore: cast_nullable_to_non_nullable
as int,skippedCount: null == skippedCount ? _self.skippedCount : skippedCount // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ReadAloudResult].
extension ReadAloudResultPatterns on ReadAloudResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReadAloudResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReadAloudResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReadAloudResult value)  $default,){
final _that = this;
switch (_that) {
case _ReadAloudResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReadAloudResult value)?  $default,){
final _that = this;
switch (_that) {
case _ReadAloudResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int sessionId,  int? segmentId,  int? interactionId,  List<ReadAloudWord> words,  int goodCount,  int retryCount,  int skippedCount,  int totalCount,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReadAloudResult() when $default != null:
return $default(_that.sessionId,_that.segmentId,_that.interactionId,_that.words,_that.goodCount,_that.retryCount,_that.skippedCount,_that.totalCount,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int sessionId,  int? segmentId,  int? interactionId,  List<ReadAloudWord> words,  int goodCount,  int retryCount,  int skippedCount,  int totalCount,  String message)  $default,) {final _that = this;
switch (_that) {
case _ReadAloudResult():
return $default(_that.sessionId,_that.segmentId,_that.interactionId,_that.words,_that.goodCount,_that.retryCount,_that.skippedCount,_that.totalCount,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int sessionId,  int? segmentId,  int? interactionId,  List<ReadAloudWord> words,  int goodCount,  int retryCount,  int skippedCount,  int totalCount,  String message)?  $default,) {final _that = this;
switch (_that) {
case _ReadAloudResult() when $default != null:
return $default(_that.sessionId,_that.segmentId,_that.interactionId,_that.words,_that.goodCount,_that.retryCount,_that.skippedCount,_that.totalCount,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReadAloudResult implements ReadAloudResult {
  const _ReadAloudResult({required this.sessionId, this.segmentId, this.interactionId,  List<ReadAloudWord> words = const <ReadAloudWord>[], this.goodCount = 0, this.retryCount = 0, this.skippedCount = 0, this.totalCount = 0, this.message = ''}): _words = words;
  factory _ReadAloudResult.fromJson(Map<String, dynamic> json) => _$ReadAloudResultFromJson(json);

@override final  int sessionId;
@override final  int? segmentId;
@override final  int? interactionId;
 final  List<ReadAloudWord> _words;
@override@JsonKey() List<ReadAloudWord> get words {
  if (_words is EqualUnmodifiableListView) return _words;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_words);
}

@override@JsonKey() final  int goodCount;
@override@JsonKey() final  int retryCount;
@override@JsonKey() final  int skippedCount;
@override@JsonKey() final  int totalCount;
@override@JsonKey() final  String message;

/// Create a copy of ReadAloudResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadAloudResultCopyWith<_ReadAloudResult> get copyWith => __$ReadAloudResultCopyWithImpl<_ReadAloudResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReadAloudResultToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReadAloudResult&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.segmentId, segmentId) || other.segmentId == segmentId)&&(identical(other.interactionId, interactionId) || other.interactionId == interactionId)&&const DeepCollectionEquality().equals(other.words, _words)&&(identical(other.goodCount, goodCount) || other.goodCount == goodCount)&&(identical(other.retryCount, retryCount) || other.retryCount == retryCount)&&(identical(other.skippedCount, skippedCount) || other.skippedCount == skippedCount)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,sessionId,segmentId,interactionId,const DeepCollectionEquality().hash(_words),goodCount,retryCount,skippedCount,totalCount,message);
}

@override
String toString() {
    return 'ReadAloudResult(sessionId: $sessionId, segmentId: $segmentId, interactionId: $interactionId, words: $words, goodCount: $goodCount, retryCount: $retryCount, skippedCount: $skippedCount, totalCount: $totalCount, message: $message)';
}


}

/// @nodoc
abstract mixin class _$ReadAloudResultCopyWith<$Res> implements $ReadAloudResultCopyWith<$Res> {
  factory _$ReadAloudResultCopyWith(_ReadAloudResult value, $Res Function(_ReadAloudResult) _then) = __$ReadAloudResultCopyWithImpl;
@override @useResult
$Res call({
 int sessionId, int? segmentId, int? interactionId, List<ReadAloudWord> words, int goodCount, int retryCount, int skippedCount, int totalCount, String message
});




}
/// @nodoc
class __$ReadAloudResultCopyWithImpl<$Res>
    implements _$ReadAloudResultCopyWith<$Res> {
  __$ReadAloudResultCopyWithImpl(this._self, this._then);

  final _ReadAloudResult _self;
  final $Res Function(_ReadAloudResult) _then;

/// Create a copy of ReadAloudResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionId = null,Object? segmentId = freezed,Object? interactionId = freezed,Object? words = null,Object? goodCount = null,Object? retryCount = null,Object? skippedCount = null,Object? totalCount = null,Object? message = null,}) {
  return _then(_ReadAloudResult(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as int,segmentId: freezed == segmentId ? _self.segmentId : segmentId // ignore: cast_nullable_to_non_nullable
as int?,interactionId: freezed == interactionId ? _self.interactionId : interactionId // ignore: cast_nullable_to_non_nullable
as int?,words: null == words ? _self._words : words // ignore: cast_nullable_to_non_nullable
as List<ReadAloudWord>,goodCount: null == goodCount ? _self.goodCount : goodCount // ignore: cast_nullable_to_non_nullable
as int,retryCount: null == retryCount ? _self.retryCount : retryCount // ignore: cast_nullable_to_non_nullable
as int,skippedCount: null == skippedCount ? _self.skippedCount : skippedCount // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
