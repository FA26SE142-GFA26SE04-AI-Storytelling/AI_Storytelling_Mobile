// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'learning_profile_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LearningTopicDto {

 String get topic; String get relation;
/// Create a copy of LearningTopicDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LearningTopicDtoCopyWith<LearningTopicDto> get copyWith => _$LearningTopicDtoCopyWithImpl<LearningTopicDto>(this as LearningTopicDto, _$identity);

  /// Serializes this LearningTopicDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as LearningTopicDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LearningTopicDto&&(identical(other.topic, _this.topic) || other.topic == _this.topic)&&(identical(other.relation, _this.relation) || other.relation == _this.relation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as LearningTopicDto;
  return Object.hash(runtimeType,_this.topic,_this.relation);
}

@override
String toString() {
  final _this = this as LearningTopicDto;
  return 'LearningTopicDto(topic: ${_this.topic}, relation: ${_this.relation})';
}


}

/// @nodoc
abstract mixin class $LearningTopicDtoCopyWith<$Res>  {
  factory $LearningTopicDtoCopyWith(LearningTopicDto value, $Res Function(LearningTopicDto) _then) = _$LearningTopicDtoCopyWithImpl;
@useResult
$Res call({
 String topic, String relation
});




}
/// @nodoc
class _$LearningTopicDtoCopyWithImpl<$Res>
    implements $LearningTopicDtoCopyWith<$Res> {
  _$LearningTopicDtoCopyWithImpl(this._self, this._then);

  final LearningTopicDto _self;
  final $Res Function(LearningTopicDto) _then;

/// Create a copy of LearningTopicDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? topic = null,Object? relation = null,}) {
  return _then(LearningTopicDto(
topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,relation: null == relation ? _self.relation : relation // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LearningTopicDto].
extension LearningTopicDtoPatterns on LearningTopicDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LearningTopicDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LearningTopicDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LearningTopicDto value)  $default,){
final _that = this;
switch (_that) {
case _LearningTopicDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LearningTopicDto value)?  $default,){
final _that = this;
switch (_that) {
case _LearningTopicDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String topic,  String relation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LearningTopicDto() when $default != null:
return $default(_that.topic,_that.relation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String topic,  String relation)  $default,) {final _that = this;
switch (_that) {
case _LearningTopicDto():
return $default(_that.topic,_that.relation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String topic,  String relation)?  $default,) {final _that = this;
switch (_that) {
case _LearningTopicDto() when $default != null:
return $default(_that.topic,_that.relation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LearningTopicDto implements LearningTopicDto {
  const _LearningTopicDto({required this.topic, required this.relation});
  factory _LearningTopicDto.fromJson(Map<String, dynamic> json) => _$LearningTopicDtoFromJson(json);

@override final  String topic;
@override final  String relation;

/// Create a copy of LearningTopicDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LearningTopicDtoCopyWith<_LearningTopicDto> get copyWith => __$LearningTopicDtoCopyWithImpl<_LearningTopicDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LearningTopicDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LearningTopicDto&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.relation, relation) || other.relation == relation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,topic,relation);
}

@override
String toString() {
    return 'LearningTopicDto(topic: $topic, relation: $relation)';
}


}

/// @nodoc
abstract mixin class _$LearningTopicDtoCopyWith<$Res> implements $LearningTopicDtoCopyWith<$Res> {
  factory _$LearningTopicDtoCopyWith(_LearningTopicDto value, $Res Function(_LearningTopicDto) _then) = __$LearningTopicDtoCopyWithImpl;
@override @useResult
$Res call({
 String topic, String relation
});




}
/// @nodoc
class __$LearningTopicDtoCopyWithImpl<$Res>
    implements _$LearningTopicDtoCopyWith<$Res> {
  __$LearningTopicDtoCopyWithImpl(this._self, this._then);

  final _LearningTopicDto _self;
  final $Res Function(_LearningTopicDto) _then;

/// Create a copy of LearningTopicDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? topic = null,Object? relation = null,}) {
  return _then(_LearningTopicDto(
topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,relation: null == relation ? _self.relation : relation // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$LearningProfileDto {

 int get id; int get childProfileId; int get readingLevel; String? get readingMode; String? get comprehensionGoal; List<LearningTopicDto> get topics;
/// Create a copy of LearningProfileDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LearningProfileDtoCopyWith<LearningProfileDto> get copyWith => _$LearningProfileDtoCopyWithImpl<LearningProfileDto>(this as LearningProfileDto, _$identity);

  /// Serializes this LearningProfileDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as LearningProfileDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LearningProfileDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.childProfileId, _this.childProfileId) || other.childProfileId == _this.childProfileId)&&(identical(other.readingLevel, _this.readingLevel) || other.readingLevel == _this.readingLevel)&&(identical(other.readingMode, _this.readingMode) || other.readingMode == _this.readingMode)&&(identical(other.comprehensionGoal, _this.comprehensionGoal) || other.comprehensionGoal == _this.comprehensionGoal)&&const DeepCollectionEquality().equals(other.topics, _this.topics));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as LearningProfileDto;
  return Object.hash(runtimeType,_this.id,_this.childProfileId,_this.readingLevel,_this.readingMode,_this.comprehensionGoal,const DeepCollectionEquality().hash(_this.topics));
}

@override
String toString() {
  final _this = this as LearningProfileDto;
  return 'LearningProfileDto(id: ${_this.id}, childProfileId: ${_this.childProfileId}, readingLevel: ${_this.readingLevel}, readingMode: ${_this.readingMode}, comprehensionGoal: ${_this.comprehensionGoal}, topics: ${_this.topics})';
}


}

/// @nodoc
abstract mixin class $LearningProfileDtoCopyWith<$Res>  {
  factory $LearningProfileDtoCopyWith(LearningProfileDto value, $Res Function(LearningProfileDto) _then) = _$LearningProfileDtoCopyWithImpl;
@useResult
$Res call({
 int id, int childProfileId, int readingLevel, String? readingMode, String? comprehensionGoal, List<LearningTopicDto> topics
});




}
/// @nodoc
class _$LearningProfileDtoCopyWithImpl<$Res>
    implements $LearningProfileDtoCopyWith<$Res> {
  _$LearningProfileDtoCopyWithImpl(this._self, this._then);

  final LearningProfileDto _self;
  final $Res Function(LearningProfileDto) _then;

/// Create a copy of LearningProfileDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? childProfileId = null,Object? readingLevel = null,Object? readingMode = freezed,Object? comprehensionGoal = freezed,Object? topics = null,}) {
  return _then(LearningProfileDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,childProfileId: null == childProfileId ? _self.childProfileId : childProfileId // ignore: cast_nullable_to_non_nullable
as int,readingLevel: null == readingLevel ? _self.readingLevel : readingLevel // ignore: cast_nullable_to_non_nullable
as int,readingMode: freezed == readingMode ? _self.readingMode : readingMode // ignore: cast_nullable_to_non_nullable
as String?,comprehensionGoal: freezed == comprehensionGoal ? _self.comprehensionGoal : comprehensionGoal // ignore: cast_nullable_to_non_nullable
as String?,topics: null == topics ? _self.topics : topics // ignore: cast_nullable_to_non_nullable
as List<LearningTopicDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [LearningProfileDto].
extension LearningProfileDtoPatterns on LearningProfileDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LearningProfileDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LearningProfileDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LearningProfileDto value)  $default,){
final _that = this;
switch (_that) {
case _LearningProfileDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LearningProfileDto value)?  $default,){
final _that = this;
switch (_that) {
case _LearningProfileDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int childProfileId,  int readingLevel,  String? readingMode,  String? comprehensionGoal,  List<LearningTopicDto> topics)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LearningProfileDto() when $default != null:
return $default(_that.id,_that.childProfileId,_that.readingLevel,_that.readingMode,_that.comprehensionGoal,_that.topics);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int childProfileId,  int readingLevel,  String? readingMode,  String? comprehensionGoal,  List<LearningTopicDto> topics)  $default,) {final _that = this;
switch (_that) {
case _LearningProfileDto():
return $default(_that.id,_that.childProfileId,_that.readingLevel,_that.readingMode,_that.comprehensionGoal,_that.topics);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int childProfileId,  int readingLevel,  String? readingMode,  String? comprehensionGoal,  List<LearningTopicDto> topics)?  $default,) {final _that = this;
switch (_that) {
case _LearningProfileDto() when $default != null:
return $default(_that.id,_that.childProfileId,_that.readingLevel,_that.readingMode,_that.comprehensionGoal,_that.topics);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LearningProfileDto implements LearningProfileDto {
  const _LearningProfileDto({required this.id, required this.childProfileId, required this.readingLevel, this.readingMode, this.comprehensionGoal,  List<LearningTopicDto> topics = const []}): _topics = topics;
  factory _LearningProfileDto.fromJson(Map<String, dynamic> json) => _$LearningProfileDtoFromJson(json);

@override final  int id;
@override final  int childProfileId;
@override final  int readingLevel;
@override final  String? readingMode;
@override final  String? comprehensionGoal;
 final  List<LearningTopicDto> _topics;
@override@JsonKey() List<LearningTopicDto> get topics {
  if (_topics is EqualUnmodifiableListView) return _topics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topics);
}


/// Create a copy of LearningProfileDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LearningProfileDtoCopyWith<_LearningProfileDto> get copyWith => __$LearningProfileDtoCopyWithImpl<_LearningProfileDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LearningProfileDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LearningProfileDto&&(identical(other.id, id) || other.id == id)&&(identical(other.childProfileId, childProfileId) || other.childProfileId == childProfileId)&&(identical(other.readingLevel, readingLevel) || other.readingLevel == readingLevel)&&(identical(other.readingMode, readingMode) || other.readingMode == readingMode)&&(identical(other.comprehensionGoal, comprehensionGoal) || other.comprehensionGoal == comprehensionGoal)&&const DeepCollectionEquality().equals(other.topics, _topics));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,childProfileId,readingLevel,readingMode,comprehensionGoal,const DeepCollectionEquality().hash(_topics));
}

@override
String toString() {
    return 'LearningProfileDto(id: $id, childProfileId: $childProfileId, readingLevel: $readingLevel, readingMode: $readingMode, comprehensionGoal: $comprehensionGoal, topics: $topics)';
}


}

/// @nodoc
abstract mixin class _$LearningProfileDtoCopyWith<$Res> implements $LearningProfileDtoCopyWith<$Res> {
  factory _$LearningProfileDtoCopyWith(_LearningProfileDto value, $Res Function(_LearningProfileDto) _then) = __$LearningProfileDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, int childProfileId, int readingLevel, String? readingMode, String? comprehensionGoal, List<LearningTopicDto> topics
});




}
/// @nodoc
class __$LearningProfileDtoCopyWithImpl<$Res>
    implements _$LearningProfileDtoCopyWith<$Res> {
  __$LearningProfileDtoCopyWithImpl(this._self, this._then);

  final _LearningProfileDto _self;
  final $Res Function(_LearningProfileDto) _then;

/// Create a copy of LearningProfileDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? childProfileId = null,Object? readingLevel = null,Object? readingMode = freezed,Object? comprehensionGoal = freezed,Object? topics = null,}) {
  return _then(_LearningProfileDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,childProfileId: null == childProfileId ? _self.childProfileId : childProfileId // ignore: cast_nullable_to_non_nullable
as int,readingLevel: null == readingLevel ? _self.readingLevel : readingLevel // ignore: cast_nullable_to_non_nullable
as int,readingMode: freezed == readingMode ? _self.readingMode : readingMode // ignore: cast_nullable_to_non_nullable
as String?,comprehensionGoal: freezed == comprehensionGoal ? _self.comprehensionGoal : comprehensionGoal // ignore: cast_nullable_to_non_nullable
as String?,topics: null == topics ? _self._topics : topics // ignore: cast_nullable_to_non_nullable
as List<LearningTopicDto>,
  ));
}


}

// dart format on
