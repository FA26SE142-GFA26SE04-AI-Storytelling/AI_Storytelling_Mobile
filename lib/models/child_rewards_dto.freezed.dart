// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'child_rewards_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RewardBadge {

 String get code; String get name; String get description; bool get earned; String? get earnedAt;
/// Create a copy of RewardBadge
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RewardBadgeCopyWith<RewardBadge> get copyWith => _$RewardBadgeCopyWithImpl<RewardBadge>(this as RewardBadge, _$identity);

  /// Serializes this RewardBadge to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RewardBadge;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RewardBadge&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.earned, _this.earned) || other.earned == _this.earned)&&(identical(other.earnedAt, _this.earnedAt) || other.earnedAt == _this.earnedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RewardBadge;
  return Object.hash(runtimeType,_this.code,_this.name,_this.description,_this.earned,_this.earnedAt);
}

@override
String toString() {
  final _this = this as RewardBadge;
  return 'RewardBadge(code: ${_this.code}, name: ${_this.name}, description: ${_this.description}, earned: ${_this.earned}, earnedAt: ${_this.earnedAt})';
}


}

/// @nodoc
abstract mixin class $RewardBadgeCopyWith<$Res>  {
  factory $RewardBadgeCopyWith(RewardBadge value, $Res Function(RewardBadge) _then) = _$RewardBadgeCopyWithImpl;
@useResult
$Res call({
 String code, String name, String description, bool earned, String? earnedAt
});




}
/// @nodoc
class _$RewardBadgeCopyWithImpl<$Res>
    implements $RewardBadgeCopyWith<$Res> {
  _$RewardBadgeCopyWithImpl(this._self, this._then);

  final RewardBadge _self;
  final $Res Function(RewardBadge) _then;

/// Create a copy of RewardBadge
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? name = null,Object? description = null,Object? earned = null,Object? earnedAt = freezed,}) {
  return _then(RewardBadge(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,earned: null == earned ? _self.earned : earned // ignore: cast_nullable_to_non_nullable
as bool,earnedAt: freezed == earnedAt ? _self.earnedAt : earnedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RewardBadge].
extension RewardBadgePatterns on RewardBadge {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RewardBadge value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RewardBadge() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RewardBadge value)  $default,){
final _that = this;
switch (_that) {
case _RewardBadge():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RewardBadge value)?  $default,){
final _that = this;
switch (_that) {
case _RewardBadge() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String name,  String description,  bool earned,  String? earnedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RewardBadge() when $default != null:
return $default(_that.code,_that.name,_that.description,_that.earned,_that.earnedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String name,  String description,  bool earned,  String? earnedAt)  $default,) {final _that = this;
switch (_that) {
case _RewardBadge():
return $default(_that.code,_that.name,_that.description,_that.earned,_that.earnedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String name,  String description,  bool earned,  String? earnedAt)?  $default,) {final _that = this;
switch (_that) {
case _RewardBadge() when $default != null:
return $default(_that.code,_that.name,_that.description,_that.earned,_that.earnedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RewardBadge implements RewardBadge {
  const _RewardBadge({required this.code, required this.name, this.description = '', this.earned = false, this.earnedAt});
  factory _RewardBadge.fromJson(Map<String, dynamic> json) => _$RewardBadgeFromJson(json);

@override final  String code;
@override final  String name;
@override@JsonKey() final  String description;
@override@JsonKey() final  bool earned;
@override final  String? earnedAt;

/// Create a copy of RewardBadge
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RewardBadgeCopyWith<_RewardBadge> get copyWith => __$RewardBadgeCopyWithImpl<_RewardBadge>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RewardBadgeToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RewardBadge&&(identical(other.code, code) || other.code == code)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.earned, earned) || other.earned == earned)&&(identical(other.earnedAt, earnedAt) || other.earnedAt == earnedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,code,name,description,earned,earnedAt);
}

@override
String toString() {
    return 'RewardBadge(code: $code, name: $name, description: $description, earned: $earned, earnedAt: $earnedAt)';
}


}

/// @nodoc
abstract mixin class _$RewardBadgeCopyWith<$Res> implements $RewardBadgeCopyWith<$Res> {
  factory _$RewardBadgeCopyWith(_RewardBadge value, $Res Function(_RewardBadge) _then) = __$RewardBadgeCopyWithImpl;
@override @useResult
$Res call({
 String code, String name, String description, bool earned, String? earnedAt
});




}
/// @nodoc
class __$RewardBadgeCopyWithImpl<$Res>
    implements _$RewardBadgeCopyWith<$Res> {
  __$RewardBadgeCopyWithImpl(this._self, this._then);

  final _RewardBadge _self;
  final $Res Function(_RewardBadge) _then;

/// Create a copy of RewardBadge
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? name = null,Object? description = null,Object? earned = null,Object? earnedAt = freezed,}) {
  return _then(_RewardBadge(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,earned: null == earned ? _self.earned : earned // ignore: cast_nullable_to_non_nullable
as bool,earnedAt: freezed == earnedAt ? _self.earnedAt : earnedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$KnowledgeTree {

/// stage là mã chuỗi SEED, SPROUT, SAPLING, GROWN, FLOWERING
 String get stage; String get stageName; int get currentTreeExp; int? get nextStageAt; int get flowerAt; int get floweredTreeCount; int get expToWater;
/// Create a copy of KnowledgeTree
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KnowledgeTreeCopyWith<KnowledgeTree> get copyWith => _$KnowledgeTreeCopyWithImpl<KnowledgeTree>(this as KnowledgeTree, _$identity);

  /// Serializes this KnowledgeTree to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as KnowledgeTree;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KnowledgeTree&&(identical(other.stage, _this.stage) || other.stage == _this.stage)&&(identical(other.stageName, _this.stageName) || other.stageName == _this.stageName)&&(identical(other.currentTreeExp, _this.currentTreeExp) || other.currentTreeExp == _this.currentTreeExp)&&(identical(other.nextStageAt, _this.nextStageAt) || other.nextStageAt == _this.nextStageAt)&&(identical(other.flowerAt, _this.flowerAt) || other.flowerAt == _this.flowerAt)&&(identical(other.floweredTreeCount, _this.floweredTreeCount) || other.floweredTreeCount == _this.floweredTreeCount)&&(identical(other.expToWater, _this.expToWater) || other.expToWater == _this.expToWater));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as KnowledgeTree;
  return Object.hash(runtimeType,_this.stage,_this.stageName,_this.currentTreeExp,_this.nextStageAt,_this.flowerAt,_this.floweredTreeCount,_this.expToWater);
}

@override
String toString() {
  final _this = this as KnowledgeTree;
  return 'KnowledgeTree(stage: ${_this.stage}, stageName: ${_this.stageName}, currentTreeExp: ${_this.currentTreeExp}, nextStageAt: ${_this.nextStageAt}, flowerAt: ${_this.flowerAt}, floweredTreeCount: ${_this.floweredTreeCount}, expToWater: ${_this.expToWater})';
}


}

/// @nodoc
abstract mixin class $KnowledgeTreeCopyWith<$Res>  {
  factory $KnowledgeTreeCopyWith(KnowledgeTree value, $Res Function(KnowledgeTree) _then) = _$KnowledgeTreeCopyWithImpl;
@useResult
$Res call({
 String stage, String stageName, int currentTreeExp, int? nextStageAt, int flowerAt, int floweredTreeCount, int expToWater
});




}
/// @nodoc
class _$KnowledgeTreeCopyWithImpl<$Res>
    implements $KnowledgeTreeCopyWith<$Res> {
  _$KnowledgeTreeCopyWithImpl(this._self, this._then);

  final KnowledgeTree _self;
  final $Res Function(KnowledgeTree) _then;

/// Create a copy of KnowledgeTree
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stage = null,Object? stageName = null,Object? currentTreeExp = null,Object? nextStageAt = freezed,Object? flowerAt = null,Object? floweredTreeCount = null,Object? expToWater = null,}) {
  return _then(KnowledgeTree(
stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as String,stageName: null == stageName ? _self.stageName : stageName // ignore: cast_nullable_to_non_nullable
as String,currentTreeExp: null == currentTreeExp ? _self.currentTreeExp : currentTreeExp // ignore: cast_nullable_to_non_nullable
as int,nextStageAt: freezed == nextStageAt ? _self.nextStageAt : nextStageAt // ignore: cast_nullable_to_non_nullable
as int?,flowerAt: null == flowerAt ? _self.flowerAt : flowerAt // ignore: cast_nullable_to_non_nullable
as int,floweredTreeCount: null == floweredTreeCount ? _self.floweredTreeCount : floweredTreeCount // ignore: cast_nullable_to_non_nullable
as int,expToWater: null == expToWater ? _self.expToWater : expToWater // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [KnowledgeTree].
extension KnowledgeTreePatterns on KnowledgeTree {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KnowledgeTree value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KnowledgeTree() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KnowledgeTree value)  $default,){
final _that = this;
switch (_that) {
case _KnowledgeTree():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KnowledgeTree value)?  $default,){
final _that = this;
switch (_that) {
case _KnowledgeTree() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String stage,  String stageName,  int currentTreeExp,  int? nextStageAt,  int flowerAt,  int floweredTreeCount,  int expToWater)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KnowledgeTree() when $default != null:
return $default(_that.stage,_that.stageName,_that.currentTreeExp,_that.nextStageAt,_that.flowerAt,_that.floweredTreeCount,_that.expToWater);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String stage,  String stageName,  int currentTreeExp,  int? nextStageAt,  int flowerAt,  int floweredTreeCount,  int expToWater)  $default,) {final _that = this;
switch (_that) {
case _KnowledgeTree():
return $default(_that.stage,_that.stageName,_that.currentTreeExp,_that.nextStageAt,_that.flowerAt,_that.floweredTreeCount,_that.expToWater);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String stage,  String stageName,  int currentTreeExp,  int? nextStageAt,  int flowerAt,  int floweredTreeCount,  int expToWater)?  $default,) {final _that = this;
switch (_that) {
case _KnowledgeTree() when $default != null:
return $default(_that.stage,_that.stageName,_that.currentTreeExp,_that.nextStageAt,_that.flowerAt,_that.floweredTreeCount,_that.expToWater);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _KnowledgeTree implements KnowledgeTree {
  const _KnowledgeTree({required this.stage, required this.stageName, this.currentTreeExp = 0, this.nextStageAt, this.flowerAt = 0, this.floweredTreeCount = 0, this.expToWater = 0});
  factory _KnowledgeTree.fromJson(Map<String, dynamic> json) => _$KnowledgeTreeFromJson(json);

/// stage là mã chuỗi SEED, SPROUT, SAPLING, GROWN, FLOWERING
@override final  String stage;
@override final  String stageName;
@override@JsonKey() final  int currentTreeExp;
@override final  int? nextStageAt;
@override@JsonKey() final  int flowerAt;
@override@JsonKey() final  int floweredTreeCount;
@override@JsonKey() final  int expToWater;

/// Create a copy of KnowledgeTree
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KnowledgeTreeCopyWith<_KnowledgeTree> get copyWith => __$KnowledgeTreeCopyWithImpl<_KnowledgeTree>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KnowledgeTreeToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _KnowledgeTree&&(identical(other.stage, stage) || other.stage == stage)&&(identical(other.stageName, stageName) || other.stageName == stageName)&&(identical(other.currentTreeExp, currentTreeExp) || other.currentTreeExp == currentTreeExp)&&(identical(other.nextStageAt, nextStageAt) || other.nextStageAt == nextStageAt)&&(identical(other.flowerAt, flowerAt) || other.flowerAt == flowerAt)&&(identical(other.floweredTreeCount, floweredTreeCount) || other.floweredTreeCount == floweredTreeCount)&&(identical(other.expToWater, expToWater) || other.expToWater == expToWater));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,stage,stageName,currentTreeExp,nextStageAt,flowerAt,floweredTreeCount,expToWater);
}

@override
String toString() {
    return 'KnowledgeTree(stage: $stage, stageName: $stageName, currentTreeExp: $currentTreeExp, nextStageAt: $nextStageAt, flowerAt: $flowerAt, floweredTreeCount: $floweredTreeCount, expToWater: $expToWater)';
}


}

/// @nodoc
abstract mixin class _$KnowledgeTreeCopyWith<$Res> implements $KnowledgeTreeCopyWith<$Res> {
  factory _$KnowledgeTreeCopyWith(_KnowledgeTree value, $Res Function(_KnowledgeTree) _then) = __$KnowledgeTreeCopyWithImpl;
@override @useResult
$Res call({
 String stage, String stageName, int currentTreeExp, int? nextStageAt, int flowerAt, int floweredTreeCount, int expToWater
});




}
/// @nodoc
class __$KnowledgeTreeCopyWithImpl<$Res>
    implements _$KnowledgeTreeCopyWith<$Res> {
  __$KnowledgeTreeCopyWithImpl(this._self, this._then);

  final _KnowledgeTree _self;
  final $Res Function(_KnowledgeTree) _then;

/// Create a copy of KnowledgeTree
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stage = null,Object? stageName = null,Object? currentTreeExp = null,Object? nextStageAt = freezed,Object? flowerAt = null,Object? floweredTreeCount = null,Object? expToWater = null,}) {
  return _then(_KnowledgeTree(
stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as String,stageName: null == stageName ? _self.stageName : stageName // ignore: cast_nullable_to_non_nullable
as String,currentTreeExp: null == currentTreeExp ? _self.currentTreeExp : currentTreeExp // ignore: cast_nullable_to_non_nullable
as int,nextStageAt: freezed == nextStageAt ? _self.nextStageAt : nextStageAt // ignore: cast_nullable_to_non_nullable
as int?,flowerAt: null == flowerAt ? _self.flowerAt : flowerAt // ignore: cast_nullable_to_non_nullable
as int,floweredTreeCount: null == floweredTreeCount ? _self.floweredTreeCount : floweredTreeCount // ignore: cast_nullable_to_non_nullable
as int,expToWater: null == expToWater ? _self.expToWater : expToWater // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ChildRewards {

 int get expTotal; int get streakDays; KnowledgeTree get knowledgeTree; List<RewardBadge> get badges;
/// Create a copy of ChildRewards
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChildRewardsCopyWith<ChildRewards> get copyWith => _$ChildRewardsCopyWithImpl<ChildRewards>(this as ChildRewards, _$identity);

  /// Serializes this ChildRewards to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ChildRewards;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChildRewards&&(identical(other.expTotal, _this.expTotal) || other.expTotal == _this.expTotal)&&(identical(other.streakDays, _this.streakDays) || other.streakDays == _this.streakDays)&&(identical(other.knowledgeTree, _this.knowledgeTree) || other.knowledgeTree == _this.knowledgeTree)&&const DeepCollectionEquality().equals(other.badges, _this.badges));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChildRewards;
  return Object.hash(runtimeType,_this.expTotal,_this.streakDays,_this.knowledgeTree,const DeepCollectionEquality().hash(_this.badges));
}

@override
String toString() {
  final _this = this as ChildRewards;
  return 'ChildRewards(expTotal: ${_this.expTotal}, streakDays: ${_this.streakDays}, knowledgeTree: ${_this.knowledgeTree}, badges: ${_this.badges})';
}


}

/// @nodoc
abstract mixin class $ChildRewardsCopyWith<$Res>  {
  factory $ChildRewardsCopyWith(ChildRewards value, $Res Function(ChildRewards) _then) = _$ChildRewardsCopyWithImpl;
@useResult
$Res call({
 int expTotal, int streakDays, KnowledgeTree knowledgeTree, List<RewardBadge> badges
});


$KnowledgeTreeCopyWith<$Res> get knowledgeTree;

}
/// @nodoc
class _$ChildRewardsCopyWithImpl<$Res>
    implements $ChildRewardsCopyWith<$Res> {
  _$ChildRewardsCopyWithImpl(this._self, this._then);

  final ChildRewards _self;
  final $Res Function(ChildRewards) _then;

/// Create a copy of ChildRewards
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? expTotal = null,Object? streakDays = null,Object? knowledgeTree = null,Object? badges = null,}) {
  return _then(ChildRewards(
expTotal: null == expTotal ? _self.expTotal : expTotal // ignore: cast_nullable_to_non_nullable
as int,streakDays: null == streakDays ? _self.streakDays : streakDays // ignore: cast_nullable_to_non_nullable
as int,knowledgeTree: null == knowledgeTree ? _self.knowledgeTree : knowledgeTree // ignore: cast_nullable_to_non_nullable
as KnowledgeTree,badges: null == badges ? _self.badges : badges // ignore: cast_nullable_to_non_nullable
as List<RewardBadge>,
  ));
}
/// Create a copy of ChildRewards
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KnowledgeTreeCopyWith<$Res> get knowledgeTree {
  
  return $KnowledgeTreeCopyWith<$Res>(_self.knowledgeTree, (value) {
    return _then(_self.copyWith(knowledgeTree: value));
  });
}
}


/// Adds pattern-matching-related methods to [ChildRewards].
extension ChildRewardsPatterns on ChildRewards {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChildRewards value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChildRewards() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChildRewards value)  $default,){
final _that = this;
switch (_that) {
case _ChildRewards():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChildRewards value)?  $default,){
final _that = this;
switch (_that) {
case _ChildRewards() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int expTotal,  int streakDays,  KnowledgeTree knowledgeTree,  List<RewardBadge> badges)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChildRewards() when $default != null:
return $default(_that.expTotal,_that.streakDays,_that.knowledgeTree,_that.badges);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int expTotal,  int streakDays,  KnowledgeTree knowledgeTree,  List<RewardBadge> badges)  $default,) {final _that = this;
switch (_that) {
case _ChildRewards():
return $default(_that.expTotal,_that.streakDays,_that.knowledgeTree,_that.badges);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int expTotal,  int streakDays,  KnowledgeTree knowledgeTree,  List<RewardBadge> badges)?  $default,) {final _that = this;
switch (_that) {
case _ChildRewards() when $default != null:
return $default(_that.expTotal,_that.streakDays,_that.knowledgeTree,_that.badges);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChildRewards implements ChildRewards {
  const _ChildRewards({this.expTotal = 0, this.streakDays = 0, required this.knowledgeTree,  List<RewardBadge> badges = const <RewardBadge>[]}): _badges = badges;
  factory _ChildRewards.fromJson(Map<String, dynamic> json) => _$ChildRewardsFromJson(json);

@override@JsonKey() final  int expTotal;
@override@JsonKey() final  int streakDays;
@override final  KnowledgeTree knowledgeTree;
 final  List<RewardBadge> _badges;
@override@JsonKey() List<RewardBadge> get badges {
  if (_badges is EqualUnmodifiableListView) return _badges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_badges);
}


/// Create a copy of ChildRewards
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChildRewardsCopyWith<_ChildRewards> get copyWith => __$ChildRewardsCopyWithImpl<_ChildRewards>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChildRewardsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChildRewards&&(identical(other.expTotal, expTotal) || other.expTotal == expTotal)&&(identical(other.streakDays, streakDays) || other.streakDays == streakDays)&&(identical(other.knowledgeTree, knowledgeTree) || other.knowledgeTree == knowledgeTree)&&const DeepCollectionEquality().equals(other.badges, _badges));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,expTotal,streakDays,knowledgeTree,const DeepCollectionEquality().hash(_badges));
}

@override
String toString() {
    return 'ChildRewards(expTotal: $expTotal, streakDays: $streakDays, knowledgeTree: $knowledgeTree, badges: $badges)';
}


}

/// @nodoc
abstract mixin class _$ChildRewardsCopyWith<$Res> implements $ChildRewardsCopyWith<$Res> {
  factory _$ChildRewardsCopyWith(_ChildRewards value, $Res Function(_ChildRewards) _then) = __$ChildRewardsCopyWithImpl;
@override @useResult
$Res call({
 int expTotal, int streakDays, KnowledgeTree knowledgeTree, List<RewardBadge> badges
});


@override $KnowledgeTreeCopyWith<$Res> get knowledgeTree;

}
/// @nodoc
class __$ChildRewardsCopyWithImpl<$Res>
    implements _$ChildRewardsCopyWith<$Res> {
  __$ChildRewardsCopyWithImpl(this._self, this._then);

  final _ChildRewards _self;
  final $Res Function(_ChildRewards) _then;

/// Create a copy of ChildRewards
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? expTotal = null,Object? streakDays = null,Object? knowledgeTree = null,Object? badges = null,}) {
  return _then(_ChildRewards(
expTotal: null == expTotal ? _self.expTotal : expTotal // ignore: cast_nullable_to_non_nullable
as int,streakDays: null == streakDays ? _self.streakDays : streakDays // ignore: cast_nullable_to_non_nullable
as int,knowledgeTree: null == knowledgeTree ? _self.knowledgeTree : knowledgeTree // ignore: cast_nullable_to_non_nullable
as KnowledgeTree,badges: null == badges ? _self._badges : badges // ignore: cast_nullable_to_non_nullable
as List<RewardBadge>,
  ));
}

/// Create a copy of ChildRewards
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KnowledgeTreeCopyWith<$Res> get knowledgeTree {
  
  return $KnowledgeTreeCopyWith<$Res>(_self.knowledgeTree, (value) {
    return _then(_self.copyWith(knowledgeTree: value));
  });
}
}


/// @nodoc
mixin _$KnowledgeTreeWaterResult {

 int get expPoured; bool get newTreePlanted; String? get previousStage; KnowledgeTree get tree;
/// Create a copy of KnowledgeTreeWaterResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KnowledgeTreeWaterResultCopyWith<KnowledgeTreeWaterResult> get copyWith => _$KnowledgeTreeWaterResultCopyWithImpl<KnowledgeTreeWaterResult>(this as KnowledgeTreeWaterResult, _$identity);

  /// Serializes this KnowledgeTreeWaterResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as KnowledgeTreeWaterResult;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KnowledgeTreeWaterResult&&(identical(other.expPoured, _this.expPoured) || other.expPoured == _this.expPoured)&&(identical(other.newTreePlanted, _this.newTreePlanted) || other.newTreePlanted == _this.newTreePlanted)&&(identical(other.previousStage, _this.previousStage) || other.previousStage == _this.previousStage)&&(identical(other.tree, _this.tree) || other.tree == _this.tree));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as KnowledgeTreeWaterResult;
  return Object.hash(runtimeType,_this.expPoured,_this.newTreePlanted,_this.previousStage,_this.tree);
}

@override
String toString() {
  final _this = this as KnowledgeTreeWaterResult;
  return 'KnowledgeTreeWaterResult(expPoured: ${_this.expPoured}, newTreePlanted: ${_this.newTreePlanted}, previousStage: ${_this.previousStage}, tree: ${_this.tree})';
}


}

/// @nodoc
abstract mixin class $KnowledgeTreeWaterResultCopyWith<$Res>  {
  factory $KnowledgeTreeWaterResultCopyWith(KnowledgeTreeWaterResult value, $Res Function(KnowledgeTreeWaterResult) _then) = _$KnowledgeTreeWaterResultCopyWithImpl;
@useResult
$Res call({
 int expPoured, bool newTreePlanted, String? previousStage, KnowledgeTree tree
});


$KnowledgeTreeCopyWith<$Res> get tree;

}
/// @nodoc
class _$KnowledgeTreeWaterResultCopyWithImpl<$Res>
    implements $KnowledgeTreeWaterResultCopyWith<$Res> {
  _$KnowledgeTreeWaterResultCopyWithImpl(this._self, this._then);

  final KnowledgeTreeWaterResult _self;
  final $Res Function(KnowledgeTreeWaterResult) _then;

/// Create a copy of KnowledgeTreeWaterResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? expPoured = null,Object? newTreePlanted = null,Object? previousStage = freezed,Object? tree = null,}) {
  return _then(KnowledgeTreeWaterResult(
expPoured: null == expPoured ? _self.expPoured : expPoured // ignore: cast_nullable_to_non_nullable
as int,newTreePlanted: null == newTreePlanted ? _self.newTreePlanted : newTreePlanted // ignore: cast_nullable_to_non_nullable
as bool,previousStage: freezed == previousStage ? _self.previousStage : previousStage // ignore: cast_nullable_to_non_nullable
as String?,tree: null == tree ? _self.tree : tree // ignore: cast_nullable_to_non_nullable
as KnowledgeTree,
  ));
}
/// Create a copy of KnowledgeTreeWaterResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KnowledgeTreeCopyWith<$Res> get tree {
  
  return $KnowledgeTreeCopyWith<$Res>(_self.tree, (value) {
    return _then(_self.copyWith(tree: value));
  });
}
}


/// Adds pattern-matching-related methods to [KnowledgeTreeWaterResult].
extension KnowledgeTreeWaterResultPatterns on KnowledgeTreeWaterResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KnowledgeTreeWaterResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KnowledgeTreeWaterResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KnowledgeTreeWaterResult value)  $default,){
final _that = this;
switch (_that) {
case _KnowledgeTreeWaterResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KnowledgeTreeWaterResult value)?  $default,){
final _that = this;
switch (_that) {
case _KnowledgeTreeWaterResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int expPoured,  bool newTreePlanted,  String? previousStage,  KnowledgeTree tree)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KnowledgeTreeWaterResult() when $default != null:
return $default(_that.expPoured,_that.newTreePlanted,_that.previousStage,_that.tree);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int expPoured,  bool newTreePlanted,  String? previousStage,  KnowledgeTree tree)  $default,) {final _that = this;
switch (_that) {
case _KnowledgeTreeWaterResult():
return $default(_that.expPoured,_that.newTreePlanted,_that.previousStage,_that.tree);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int expPoured,  bool newTreePlanted,  String? previousStage,  KnowledgeTree tree)?  $default,) {final _that = this;
switch (_that) {
case _KnowledgeTreeWaterResult() when $default != null:
return $default(_that.expPoured,_that.newTreePlanted,_that.previousStage,_that.tree);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _KnowledgeTreeWaterResult implements KnowledgeTreeWaterResult {
  const _KnowledgeTreeWaterResult({this.expPoured = 0, this.newTreePlanted = false, this.previousStage, required this.tree});
  factory _KnowledgeTreeWaterResult.fromJson(Map<String, dynamic> json) => _$KnowledgeTreeWaterResultFromJson(json);

@override@JsonKey() final  int expPoured;
@override@JsonKey() final  bool newTreePlanted;
@override final  String? previousStage;
@override final  KnowledgeTree tree;

/// Create a copy of KnowledgeTreeWaterResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KnowledgeTreeWaterResultCopyWith<_KnowledgeTreeWaterResult> get copyWith => __$KnowledgeTreeWaterResultCopyWithImpl<_KnowledgeTreeWaterResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KnowledgeTreeWaterResultToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _KnowledgeTreeWaterResult&&(identical(other.expPoured, expPoured) || other.expPoured == expPoured)&&(identical(other.newTreePlanted, newTreePlanted) || other.newTreePlanted == newTreePlanted)&&(identical(other.previousStage, previousStage) || other.previousStage == previousStage)&&(identical(other.tree, tree) || other.tree == tree));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,expPoured,newTreePlanted,previousStage,tree);
}

@override
String toString() {
    return 'KnowledgeTreeWaterResult(expPoured: $expPoured, newTreePlanted: $newTreePlanted, previousStage: $previousStage, tree: $tree)';
}


}

/// @nodoc
abstract mixin class _$KnowledgeTreeWaterResultCopyWith<$Res> implements $KnowledgeTreeWaterResultCopyWith<$Res> {
  factory _$KnowledgeTreeWaterResultCopyWith(_KnowledgeTreeWaterResult value, $Res Function(_KnowledgeTreeWaterResult) _then) = __$KnowledgeTreeWaterResultCopyWithImpl;
@override @useResult
$Res call({
 int expPoured, bool newTreePlanted, String? previousStage, KnowledgeTree tree
});


@override $KnowledgeTreeCopyWith<$Res> get tree;

}
/// @nodoc
class __$KnowledgeTreeWaterResultCopyWithImpl<$Res>
    implements _$KnowledgeTreeWaterResultCopyWith<$Res> {
  __$KnowledgeTreeWaterResultCopyWithImpl(this._self, this._then);

  final _KnowledgeTreeWaterResult _self;
  final $Res Function(_KnowledgeTreeWaterResult) _then;

/// Create a copy of KnowledgeTreeWaterResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? expPoured = null,Object? newTreePlanted = null,Object? previousStage = freezed,Object? tree = null,}) {
  return _then(_KnowledgeTreeWaterResult(
expPoured: null == expPoured ? _self.expPoured : expPoured // ignore: cast_nullable_to_non_nullable
as int,newTreePlanted: null == newTreePlanted ? _self.newTreePlanted : newTreePlanted // ignore: cast_nullable_to_non_nullable
as bool,previousStage: freezed == previousStage ? _self.previousStage : previousStage // ignore: cast_nullable_to_non_nullable
as String?,tree: null == tree ? _self.tree : tree // ignore: cast_nullable_to_non_nullable
as KnowledgeTree,
  ));
}

/// Create a copy of KnowledgeTreeWaterResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$KnowledgeTreeCopyWith<$Res> get tree {
  
  return $KnowledgeTreeCopyWith<$Res>(_self.tree, (value) {
    return _then(_self.copyWith(tree: value));
  });
}
}

// dart format on
