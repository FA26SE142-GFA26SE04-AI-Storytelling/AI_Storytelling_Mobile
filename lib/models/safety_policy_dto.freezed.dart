// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'safety_policy_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SafetyCategoryRuleDto {

 int get contentCategoryId; String get rule;
/// Create a copy of SafetyCategoryRuleDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SafetyCategoryRuleDtoCopyWith<SafetyCategoryRuleDto> get copyWith => _$SafetyCategoryRuleDtoCopyWithImpl<SafetyCategoryRuleDto>(this as SafetyCategoryRuleDto, _$identity);

  /// Serializes this SafetyCategoryRuleDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SafetyCategoryRuleDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SafetyCategoryRuleDto&&(identical(other.contentCategoryId, _this.contentCategoryId) || other.contentCategoryId == _this.contentCategoryId)&&(identical(other.rule, _this.rule) || other.rule == _this.rule));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SafetyCategoryRuleDto;
  return Object.hash(runtimeType,_this.contentCategoryId,_this.rule);
}

@override
String toString() {
  final _this = this as SafetyCategoryRuleDto;
  return 'SafetyCategoryRuleDto(contentCategoryId: ${_this.contentCategoryId}, rule: ${_this.rule})';
}


}

/// @nodoc
abstract mixin class $SafetyCategoryRuleDtoCopyWith<$Res>  {
  factory $SafetyCategoryRuleDtoCopyWith(SafetyCategoryRuleDto value, $Res Function(SafetyCategoryRuleDto) _then) = _$SafetyCategoryRuleDtoCopyWithImpl;
@useResult
$Res call({
 int contentCategoryId, String rule
});




}
/// @nodoc
class _$SafetyCategoryRuleDtoCopyWithImpl<$Res>
    implements $SafetyCategoryRuleDtoCopyWith<$Res> {
  _$SafetyCategoryRuleDtoCopyWithImpl(this._self, this._then);

  final SafetyCategoryRuleDto _self;
  final $Res Function(SafetyCategoryRuleDto) _then;

/// Create a copy of SafetyCategoryRuleDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? contentCategoryId = null,Object? rule = null,}) {
  return _then(SafetyCategoryRuleDto(
contentCategoryId: null == contentCategoryId ? _self.contentCategoryId : contentCategoryId // ignore: cast_nullable_to_non_nullable
as int,rule: null == rule ? _self.rule : rule // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SafetyCategoryRuleDto].
extension SafetyCategoryRuleDtoPatterns on SafetyCategoryRuleDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SafetyCategoryRuleDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SafetyCategoryRuleDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SafetyCategoryRuleDto value)  $default,){
final _that = this;
switch (_that) {
case _SafetyCategoryRuleDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SafetyCategoryRuleDto value)?  $default,){
final _that = this;
switch (_that) {
case _SafetyCategoryRuleDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int contentCategoryId,  String rule)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SafetyCategoryRuleDto() when $default != null:
return $default(_that.contentCategoryId,_that.rule);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int contentCategoryId,  String rule)  $default,) {final _that = this;
switch (_that) {
case _SafetyCategoryRuleDto():
return $default(_that.contentCategoryId,_that.rule);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int contentCategoryId,  String rule)?  $default,) {final _that = this;
switch (_that) {
case _SafetyCategoryRuleDto() when $default != null:
return $default(_that.contentCategoryId,_that.rule);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SafetyCategoryRuleDto implements SafetyCategoryRuleDto {
  const _SafetyCategoryRuleDto({required this.contentCategoryId, required this.rule});
  factory _SafetyCategoryRuleDto.fromJson(Map<String, dynamic> json) => _$SafetyCategoryRuleDtoFromJson(json);

@override final  int contentCategoryId;
@override final  String rule;

/// Create a copy of SafetyCategoryRuleDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SafetyCategoryRuleDtoCopyWith<_SafetyCategoryRuleDto> get copyWith => __$SafetyCategoryRuleDtoCopyWithImpl<_SafetyCategoryRuleDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SafetyCategoryRuleDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SafetyCategoryRuleDto&&(identical(other.contentCategoryId, contentCategoryId) || other.contentCategoryId == contentCategoryId)&&(identical(other.rule, rule) || other.rule == rule));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,contentCategoryId,rule);
}

@override
String toString() {
    return 'SafetyCategoryRuleDto(contentCategoryId: $contentCategoryId, rule: $rule)';
}


}

/// @nodoc
abstract mixin class _$SafetyCategoryRuleDtoCopyWith<$Res> implements $SafetyCategoryRuleDtoCopyWith<$Res> {
  factory _$SafetyCategoryRuleDtoCopyWith(_SafetyCategoryRuleDto value, $Res Function(_SafetyCategoryRuleDto) _then) = __$SafetyCategoryRuleDtoCopyWithImpl;
@override @useResult
$Res call({
 int contentCategoryId, String rule
});




}
/// @nodoc
class __$SafetyCategoryRuleDtoCopyWithImpl<$Res>
    implements _$SafetyCategoryRuleDtoCopyWith<$Res> {
  __$SafetyCategoryRuleDtoCopyWithImpl(this._self, this._then);

  final _SafetyCategoryRuleDto _self;
  final $Res Function(_SafetyCategoryRuleDto) _then;

/// Create a copy of SafetyCategoryRuleDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? contentCategoryId = null,Object? rule = null,}) {
  return _then(_SafetyCategoryRuleDto(
contentCategoryId: null == contentCategoryId ? _self.contentCategoryId : contentCategoryId // ignore: cast_nullable_to_non_nullable
as int,rule: null == rule ? _self.rule : rule // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$SafetyPolicyDto {

 int get childProfileId; bool get parentalGateEnabled; int? get maxStoryLength; String? get requiredApprovalMode; bool? get consentRecorded; DateTime? get consentRecordedAt; int? get consentPolicyVersion; bool? get consentOutdated; double? get safetyScoreThreshold; double? get readabilityScoreThreshold; int? get comprehensionThresholdPercent; int? get comprehensionWindowSize; bool? get storyWishesEnabled; bool? get allowInteractiveStories; bool? get childCreationEnabled; String? get childCreationMode; bool? get voiceAnswersEnabled; int? get storyLengthTarget; bool? get quizEnabled; bool? get notebookEnabled; bool? get libraryBrowseEnabled; bool? get reflectionEnabled; bool? get rewardsEnabled; DateTime? get voiceConsentAt; List<SafetyCategoryRuleDto> get categories;
/// Create a copy of SafetyPolicyDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SafetyPolicyDtoCopyWith<SafetyPolicyDto> get copyWith => _$SafetyPolicyDtoCopyWithImpl<SafetyPolicyDto>(this as SafetyPolicyDto, _$identity);

  /// Serializes this SafetyPolicyDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SafetyPolicyDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SafetyPolicyDto&&(identical(other.childProfileId, _this.childProfileId) || other.childProfileId == _this.childProfileId)&&(identical(other.parentalGateEnabled, _this.parentalGateEnabled) || other.parentalGateEnabled == _this.parentalGateEnabled)&&(identical(other.maxStoryLength, _this.maxStoryLength) || other.maxStoryLength == _this.maxStoryLength)&&(identical(other.requiredApprovalMode, _this.requiredApprovalMode) || other.requiredApprovalMode == _this.requiredApprovalMode)&&(identical(other.consentRecorded, _this.consentRecorded) || other.consentRecorded == _this.consentRecorded)&&(identical(other.consentRecordedAt, _this.consentRecordedAt) || other.consentRecordedAt == _this.consentRecordedAt)&&(identical(other.consentPolicyVersion, _this.consentPolicyVersion) || other.consentPolicyVersion == _this.consentPolicyVersion)&&(identical(other.consentOutdated, _this.consentOutdated) || other.consentOutdated == _this.consentOutdated)&&(identical(other.safetyScoreThreshold, _this.safetyScoreThreshold) || other.safetyScoreThreshold == _this.safetyScoreThreshold)&&(identical(other.readabilityScoreThreshold, _this.readabilityScoreThreshold) || other.readabilityScoreThreshold == _this.readabilityScoreThreshold)&&(identical(other.comprehensionThresholdPercent, _this.comprehensionThresholdPercent) || other.comprehensionThresholdPercent == _this.comprehensionThresholdPercent)&&(identical(other.comprehensionWindowSize, _this.comprehensionWindowSize) || other.comprehensionWindowSize == _this.comprehensionWindowSize)&&(identical(other.storyWishesEnabled, _this.storyWishesEnabled) || other.storyWishesEnabled == _this.storyWishesEnabled)&&(identical(other.allowInteractiveStories, _this.allowInteractiveStories) || other.allowInteractiveStories == _this.allowInteractiveStories)&&(identical(other.childCreationEnabled, _this.childCreationEnabled) || other.childCreationEnabled == _this.childCreationEnabled)&&(identical(other.childCreationMode, _this.childCreationMode) || other.childCreationMode == _this.childCreationMode)&&(identical(other.voiceAnswersEnabled, _this.voiceAnswersEnabled) || other.voiceAnswersEnabled == _this.voiceAnswersEnabled)&&(identical(other.storyLengthTarget, _this.storyLengthTarget) || other.storyLengthTarget == _this.storyLengthTarget)&&(identical(other.quizEnabled, _this.quizEnabled) || other.quizEnabled == _this.quizEnabled)&&(identical(other.notebookEnabled, _this.notebookEnabled) || other.notebookEnabled == _this.notebookEnabled)&&(identical(other.libraryBrowseEnabled, _this.libraryBrowseEnabled) || other.libraryBrowseEnabled == _this.libraryBrowseEnabled)&&(identical(other.reflectionEnabled, _this.reflectionEnabled) || other.reflectionEnabled == _this.reflectionEnabled)&&(identical(other.rewardsEnabled, _this.rewardsEnabled) || other.rewardsEnabled == _this.rewardsEnabled)&&(identical(other.voiceConsentAt, _this.voiceConsentAt) || other.voiceConsentAt == _this.voiceConsentAt)&&const DeepCollectionEquality().equals(other.categories, _this.categories));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SafetyPolicyDto;
  return Object.hashAll([runtimeType,_this.childProfileId,_this.parentalGateEnabled,_this.maxStoryLength,_this.requiredApprovalMode,_this.consentRecorded,_this.consentRecordedAt,_this.consentPolicyVersion,_this.consentOutdated,_this.safetyScoreThreshold,_this.readabilityScoreThreshold,_this.comprehensionThresholdPercent,_this.comprehensionWindowSize,_this.storyWishesEnabled,_this.allowInteractiveStories,_this.childCreationEnabled,_this.childCreationMode,_this.voiceAnswersEnabled,_this.storyLengthTarget,_this.quizEnabled,_this.notebookEnabled,_this.libraryBrowseEnabled,_this.reflectionEnabled,_this.rewardsEnabled,_this.voiceConsentAt,const DeepCollectionEquality().hash(_this.categories)]);
}

@override
String toString() {
  final _this = this as SafetyPolicyDto;
  return 'SafetyPolicyDto(childProfileId: ${_this.childProfileId}, parentalGateEnabled: ${_this.parentalGateEnabled}, maxStoryLength: ${_this.maxStoryLength}, requiredApprovalMode: ${_this.requiredApprovalMode}, consentRecorded: ${_this.consentRecorded}, consentRecordedAt: ${_this.consentRecordedAt}, consentPolicyVersion: ${_this.consentPolicyVersion}, consentOutdated: ${_this.consentOutdated}, safetyScoreThreshold: ${_this.safetyScoreThreshold}, readabilityScoreThreshold: ${_this.readabilityScoreThreshold}, comprehensionThresholdPercent: ${_this.comprehensionThresholdPercent}, comprehensionWindowSize: ${_this.comprehensionWindowSize}, storyWishesEnabled: ${_this.storyWishesEnabled}, allowInteractiveStories: ${_this.allowInteractiveStories}, childCreationEnabled: ${_this.childCreationEnabled}, childCreationMode: ${_this.childCreationMode}, voiceAnswersEnabled: ${_this.voiceAnswersEnabled}, storyLengthTarget: ${_this.storyLengthTarget}, quizEnabled: ${_this.quizEnabled}, notebookEnabled: ${_this.notebookEnabled}, libraryBrowseEnabled: ${_this.libraryBrowseEnabled}, reflectionEnabled: ${_this.reflectionEnabled}, rewardsEnabled: ${_this.rewardsEnabled}, voiceConsentAt: ${_this.voiceConsentAt}, categories: ${_this.categories})';
}


}

/// @nodoc
abstract mixin class $SafetyPolicyDtoCopyWith<$Res>  {
  factory $SafetyPolicyDtoCopyWith(SafetyPolicyDto value, $Res Function(SafetyPolicyDto) _then) = _$SafetyPolicyDtoCopyWithImpl;
@useResult
$Res call({
 int childProfileId, bool parentalGateEnabled, int? maxStoryLength, String? requiredApprovalMode, bool? consentRecorded, DateTime? consentRecordedAt, int? consentPolicyVersion, bool? consentOutdated, double? safetyScoreThreshold, double? readabilityScoreThreshold, int? comprehensionThresholdPercent, int? comprehensionWindowSize, bool? storyWishesEnabled, bool? allowInteractiveStories, bool? childCreationEnabled, String? childCreationMode, bool? voiceAnswersEnabled, int? storyLengthTarget, bool? quizEnabled, bool? notebookEnabled, bool? libraryBrowseEnabled, bool? reflectionEnabled, bool? rewardsEnabled, DateTime? voiceConsentAt, List<SafetyCategoryRuleDto> categories
});




}
/// @nodoc
class _$SafetyPolicyDtoCopyWithImpl<$Res>
    implements $SafetyPolicyDtoCopyWith<$Res> {
  _$SafetyPolicyDtoCopyWithImpl(this._self, this._then);

  final SafetyPolicyDto _self;
  final $Res Function(SafetyPolicyDto) _then;

/// Create a copy of SafetyPolicyDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? childProfileId = null,Object? parentalGateEnabled = null,Object? maxStoryLength = freezed,Object? requiredApprovalMode = freezed,Object? consentRecorded = freezed,Object? consentRecordedAt = freezed,Object? consentPolicyVersion = freezed,Object? consentOutdated = freezed,Object? safetyScoreThreshold = freezed,Object? readabilityScoreThreshold = freezed,Object? comprehensionThresholdPercent = freezed,Object? comprehensionWindowSize = freezed,Object? storyWishesEnabled = freezed,Object? allowInteractiveStories = freezed,Object? childCreationEnabled = freezed,Object? childCreationMode = freezed,Object? voiceAnswersEnabled = freezed,Object? storyLengthTarget = freezed,Object? quizEnabled = freezed,Object? notebookEnabled = freezed,Object? libraryBrowseEnabled = freezed,Object? reflectionEnabled = freezed,Object? rewardsEnabled = freezed,Object? voiceConsentAt = freezed,Object? categories = null,}) {
  return _then(SafetyPolicyDto(
childProfileId: null == childProfileId ? _self.childProfileId : childProfileId // ignore: cast_nullable_to_non_nullable
as int,parentalGateEnabled: null == parentalGateEnabled ? _self.parentalGateEnabled : parentalGateEnabled // ignore: cast_nullable_to_non_nullable
as bool,maxStoryLength: freezed == maxStoryLength ? _self.maxStoryLength : maxStoryLength // ignore: cast_nullable_to_non_nullable
as int?,requiredApprovalMode: freezed == requiredApprovalMode ? _self.requiredApprovalMode : requiredApprovalMode // ignore: cast_nullable_to_non_nullable
as String?,consentRecorded: freezed == consentRecorded ? _self.consentRecorded : consentRecorded // ignore: cast_nullable_to_non_nullable
as bool?,consentRecordedAt: freezed == consentRecordedAt ? _self.consentRecordedAt : consentRecordedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,consentPolicyVersion: freezed == consentPolicyVersion ? _self.consentPolicyVersion : consentPolicyVersion // ignore: cast_nullable_to_non_nullable
as int?,consentOutdated: freezed == consentOutdated ? _self.consentOutdated : consentOutdated // ignore: cast_nullable_to_non_nullable
as bool?,safetyScoreThreshold: freezed == safetyScoreThreshold ? _self.safetyScoreThreshold : safetyScoreThreshold // ignore: cast_nullable_to_non_nullable
as double?,readabilityScoreThreshold: freezed == readabilityScoreThreshold ? _self.readabilityScoreThreshold : readabilityScoreThreshold // ignore: cast_nullable_to_non_nullable
as double?,comprehensionThresholdPercent: freezed == comprehensionThresholdPercent ? _self.comprehensionThresholdPercent : comprehensionThresholdPercent // ignore: cast_nullable_to_non_nullable
as int?,comprehensionWindowSize: freezed == comprehensionWindowSize ? _self.comprehensionWindowSize : comprehensionWindowSize // ignore: cast_nullable_to_non_nullable
as int?,storyWishesEnabled: freezed == storyWishesEnabled ? _self.storyWishesEnabled : storyWishesEnabled // ignore: cast_nullable_to_non_nullable
as bool?,allowInteractiveStories: freezed == allowInteractiveStories ? _self.allowInteractiveStories : allowInteractiveStories // ignore: cast_nullable_to_non_nullable
as bool?,childCreationEnabled: freezed == childCreationEnabled ? _self.childCreationEnabled : childCreationEnabled // ignore: cast_nullable_to_non_nullable
as bool?,childCreationMode: freezed == childCreationMode ? _self.childCreationMode : childCreationMode // ignore: cast_nullable_to_non_nullable
as String?,voiceAnswersEnabled: freezed == voiceAnswersEnabled ? _self.voiceAnswersEnabled : voiceAnswersEnabled // ignore: cast_nullable_to_non_nullable
as bool?,storyLengthTarget: freezed == storyLengthTarget ? _self.storyLengthTarget : storyLengthTarget // ignore: cast_nullable_to_non_nullable
as int?,quizEnabled: freezed == quizEnabled ? _self.quizEnabled : quizEnabled // ignore: cast_nullable_to_non_nullable
as bool?,notebookEnabled: freezed == notebookEnabled ? _self.notebookEnabled : notebookEnabled // ignore: cast_nullable_to_non_nullable
as bool?,libraryBrowseEnabled: freezed == libraryBrowseEnabled ? _self.libraryBrowseEnabled : libraryBrowseEnabled // ignore: cast_nullable_to_non_nullable
as bool?,reflectionEnabled: freezed == reflectionEnabled ? _self.reflectionEnabled : reflectionEnabled // ignore: cast_nullable_to_non_nullable
as bool?,rewardsEnabled: freezed == rewardsEnabled ? _self.rewardsEnabled : rewardsEnabled // ignore: cast_nullable_to_non_nullable
as bool?,voiceConsentAt: freezed == voiceConsentAt ? _self.voiceConsentAt : voiceConsentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<SafetyCategoryRuleDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [SafetyPolicyDto].
extension SafetyPolicyDtoPatterns on SafetyPolicyDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SafetyPolicyDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SafetyPolicyDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SafetyPolicyDto value)  $default,){
final _that = this;
switch (_that) {
case _SafetyPolicyDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SafetyPolicyDto value)?  $default,){
final _that = this;
switch (_that) {
case _SafetyPolicyDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int childProfileId,  bool parentalGateEnabled,  int? maxStoryLength,  String? requiredApprovalMode,  bool? consentRecorded,  DateTime? consentRecordedAt,  int? consentPolicyVersion,  bool? consentOutdated,  double? safetyScoreThreshold,  double? readabilityScoreThreshold,  int? comprehensionThresholdPercent,  int? comprehensionWindowSize,  bool? storyWishesEnabled,  bool? allowInteractiveStories,  bool? childCreationEnabled,  String? childCreationMode,  bool? voiceAnswersEnabled,  int? storyLengthTarget,  bool? quizEnabled,  bool? notebookEnabled,  bool? libraryBrowseEnabled,  bool? reflectionEnabled,  bool? rewardsEnabled,  DateTime? voiceConsentAt,  List<SafetyCategoryRuleDto> categories)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SafetyPolicyDto() when $default != null:
return $default(_that.childProfileId,_that.parentalGateEnabled,_that.maxStoryLength,_that.requiredApprovalMode,_that.consentRecorded,_that.consentRecordedAt,_that.consentPolicyVersion,_that.consentOutdated,_that.safetyScoreThreshold,_that.readabilityScoreThreshold,_that.comprehensionThresholdPercent,_that.comprehensionWindowSize,_that.storyWishesEnabled,_that.allowInteractiveStories,_that.childCreationEnabled,_that.childCreationMode,_that.voiceAnswersEnabled,_that.storyLengthTarget,_that.quizEnabled,_that.notebookEnabled,_that.libraryBrowseEnabled,_that.reflectionEnabled,_that.rewardsEnabled,_that.voiceConsentAt,_that.categories);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int childProfileId,  bool parentalGateEnabled,  int? maxStoryLength,  String? requiredApprovalMode,  bool? consentRecorded,  DateTime? consentRecordedAt,  int? consentPolicyVersion,  bool? consentOutdated,  double? safetyScoreThreshold,  double? readabilityScoreThreshold,  int? comprehensionThresholdPercent,  int? comprehensionWindowSize,  bool? storyWishesEnabled,  bool? allowInteractiveStories,  bool? childCreationEnabled,  String? childCreationMode,  bool? voiceAnswersEnabled,  int? storyLengthTarget,  bool? quizEnabled,  bool? notebookEnabled,  bool? libraryBrowseEnabled,  bool? reflectionEnabled,  bool? rewardsEnabled,  DateTime? voiceConsentAt,  List<SafetyCategoryRuleDto> categories)  $default,) {final _that = this;
switch (_that) {
case _SafetyPolicyDto():
return $default(_that.childProfileId,_that.parentalGateEnabled,_that.maxStoryLength,_that.requiredApprovalMode,_that.consentRecorded,_that.consentRecordedAt,_that.consentPolicyVersion,_that.consentOutdated,_that.safetyScoreThreshold,_that.readabilityScoreThreshold,_that.comprehensionThresholdPercent,_that.comprehensionWindowSize,_that.storyWishesEnabled,_that.allowInteractiveStories,_that.childCreationEnabled,_that.childCreationMode,_that.voiceAnswersEnabled,_that.storyLengthTarget,_that.quizEnabled,_that.notebookEnabled,_that.libraryBrowseEnabled,_that.reflectionEnabled,_that.rewardsEnabled,_that.voiceConsentAt,_that.categories);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int childProfileId,  bool parentalGateEnabled,  int? maxStoryLength,  String? requiredApprovalMode,  bool? consentRecorded,  DateTime? consentRecordedAt,  int? consentPolicyVersion,  bool? consentOutdated,  double? safetyScoreThreshold,  double? readabilityScoreThreshold,  int? comprehensionThresholdPercent,  int? comprehensionWindowSize,  bool? storyWishesEnabled,  bool? allowInteractiveStories,  bool? childCreationEnabled,  String? childCreationMode,  bool? voiceAnswersEnabled,  int? storyLengthTarget,  bool? quizEnabled,  bool? notebookEnabled,  bool? libraryBrowseEnabled,  bool? reflectionEnabled,  bool? rewardsEnabled,  DateTime? voiceConsentAt,  List<SafetyCategoryRuleDto> categories)?  $default,) {final _that = this;
switch (_that) {
case _SafetyPolicyDto() when $default != null:
return $default(_that.childProfileId,_that.parentalGateEnabled,_that.maxStoryLength,_that.requiredApprovalMode,_that.consentRecorded,_that.consentRecordedAt,_that.consentPolicyVersion,_that.consentOutdated,_that.safetyScoreThreshold,_that.readabilityScoreThreshold,_that.comprehensionThresholdPercent,_that.comprehensionWindowSize,_that.storyWishesEnabled,_that.allowInteractiveStories,_that.childCreationEnabled,_that.childCreationMode,_that.voiceAnswersEnabled,_that.storyLengthTarget,_that.quizEnabled,_that.notebookEnabled,_that.libraryBrowseEnabled,_that.reflectionEnabled,_that.rewardsEnabled,_that.voiceConsentAt,_that.categories);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SafetyPolicyDto implements SafetyPolicyDto {
  const _SafetyPolicyDto({required this.childProfileId, this.parentalGateEnabled = true, this.maxStoryLength, this.requiredApprovalMode, this.consentRecorded, this.consentRecordedAt, this.consentPolicyVersion, this.consentOutdated, this.safetyScoreThreshold, this.readabilityScoreThreshold, this.comprehensionThresholdPercent, this.comprehensionWindowSize, this.storyWishesEnabled, this.allowInteractiveStories, this.childCreationEnabled, this.childCreationMode, this.voiceAnswersEnabled, this.storyLengthTarget, this.quizEnabled, this.notebookEnabled, this.libraryBrowseEnabled, this.reflectionEnabled, this.rewardsEnabled, this.voiceConsentAt,  List<SafetyCategoryRuleDto> categories = const []}): _categories = categories;
  factory _SafetyPolicyDto.fromJson(Map<String, dynamic> json) => _$SafetyPolicyDtoFromJson(json);

@override final  int childProfileId;
@override@JsonKey() final  bool parentalGateEnabled;
@override final  int? maxStoryLength;
@override final  String? requiredApprovalMode;
@override final  bool? consentRecorded;
@override final  DateTime? consentRecordedAt;
@override final  int? consentPolicyVersion;
@override final  bool? consentOutdated;
@override final  double? safetyScoreThreshold;
@override final  double? readabilityScoreThreshold;
@override final  int? comprehensionThresholdPercent;
@override final  int? comprehensionWindowSize;
@override final  bool? storyWishesEnabled;
@override final  bool? allowInteractiveStories;
@override final  bool? childCreationEnabled;
@override final  String? childCreationMode;
@override final  bool? voiceAnswersEnabled;
@override final  int? storyLengthTarget;
@override final  bool? quizEnabled;
@override final  bool? notebookEnabled;
@override final  bool? libraryBrowseEnabled;
@override final  bool? reflectionEnabled;
@override final  bool? rewardsEnabled;
@override final  DateTime? voiceConsentAt;
 final  List<SafetyCategoryRuleDto> _categories;
@override@JsonKey() List<SafetyCategoryRuleDto> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}


/// Create a copy of SafetyPolicyDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SafetyPolicyDtoCopyWith<_SafetyPolicyDto> get copyWith => __$SafetyPolicyDtoCopyWithImpl<_SafetyPolicyDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SafetyPolicyDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SafetyPolicyDto&&(identical(other.childProfileId, childProfileId) || other.childProfileId == childProfileId)&&(identical(other.parentalGateEnabled, parentalGateEnabled) || other.parentalGateEnabled == parentalGateEnabled)&&(identical(other.maxStoryLength, maxStoryLength) || other.maxStoryLength == maxStoryLength)&&(identical(other.requiredApprovalMode, requiredApprovalMode) || other.requiredApprovalMode == requiredApprovalMode)&&(identical(other.consentRecorded, consentRecorded) || other.consentRecorded == consentRecorded)&&(identical(other.consentRecordedAt, consentRecordedAt) || other.consentRecordedAt == consentRecordedAt)&&(identical(other.consentPolicyVersion, consentPolicyVersion) || other.consentPolicyVersion == consentPolicyVersion)&&(identical(other.consentOutdated, consentOutdated) || other.consentOutdated == consentOutdated)&&(identical(other.safetyScoreThreshold, safetyScoreThreshold) || other.safetyScoreThreshold == safetyScoreThreshold)&&(identical(other.readabilityScoreThreshold, readabilityScoreThreshold) || other.readabilityScoreThreshold == readabilityScoreThreshold)&&(identical(other.comprehensionThresholdPercent, comprehensionThresholdPercent) || other.comprehensionThresholdPercent == comprehensionThresholdPercent)&&(identical(other.comprehensionWindowSize, comprehensionWindowSize) || other.comprehensionWindowSize == comprehensionWindowSize)&&(identical(other.storyWishesEnabled, storyWishesEnabled) || other.storyWishesEnabled == storyWishesEnabled)&&(identical(other.allowInteractiveStories, allowInteractiveStories) || other.allowInteractiveStories == allowInteractiveStories)&&(identical(other.childCreationEnabled, childCreationEnabled) || other.childCreationEnabled == childCreationEnabled)&&(identical(other.childCreationMode, childCreationMode) || other.childCreationMode == childCreationMode)&&(identical(other.voiceAnswersEnabled, voiceAnswersEnabled) || other.voiceAnswersEnabled == voiceAnswersEnabled)&&(identical(other.storyLengthTarget, storyLengthTarget) || other.storyLengthTarget == storyLengthTarget)&&(identical(other.quizEnabled, quizEnabled) || other.quizEnabled == quizEnabled)&&(identical(other.notebookEnabled, notebookEnabled) || other.notebookEnabled == notebookEnabled)&&(identical(other.libraryBrowseEnabled, libraryBrowseEnabled) || other.libraryBrowseEnabled == libraryBrowseEnabled)&&(identical(other.reflectionEnabled, reflectionEnabled) || other.reflectionEnabled == reflectionEnabled)&&(identical(other.rewardsEnabled, rewardsEnabled) || other.rewardsEnabled == rewardsEnabled)&&(identical(other.voiceConsentAt, voiceConsentAt) || other.voiceConsentAt == voiceConsentAt)&&const DeepCollectionEquality().equals(other.categories, _categories));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,childProfileId,parentalGateEnabled,maxStoryLength,requiredApprovalMode,consentRecorded,consentRecordedAt,consentPolicyVersion,consentOutdated,safetyScoreThreshold,readabilityScoreThreshold,comprehensionThresholdPercent,comprehensionWindowSize,storyWishesEnabled,allowInteractiveStories,childCreationEnabled,childCreationMode,voiceAnswersEnabled,storyLengthTarget,quizEnabled,notebookEnabled,libraryBrowseEnabled,reflectionEnabled,rewardsEnabled,voiceConsentAt,const DeepCollectionEquality().hash(_categories)]);
}

@override
String toString() {
    return 'SafetyPolicyDto(childProfileId: $childProfileId, parentalGateEnabled: $parentalGateEnabled, maxStoryLength: $maxStoryLength, requiredApprovalMode: $requiredApprovalMode, consentRecorded: $consentRecorded, consentRecordedAt: $consentRecordedAt, consentPolicyVersion: $consentPolicyVersion, consentOutdated: $consentOutdated, safetyScoreThreshold: $safetyScoreThreshold, readabilityScoreThreshold: $readabilityScoreThreshold, comprehensionThresholdPercent: $comprehensionThresholdPercent, comprehensionWindowSize: $comprehensionWindowSize, storyWishesEnabled: $storyWishesEnabled, allowInteractiveStories: $allowInteractiveStories, childCreationEnabled: $childCreationEnabled, childCreationMode: $childCreationMode, voiceAnswersEnabled: $voiceAnswersEnabled, storyLengthTarget: $storyLengthTarget, quizEnabled: $quizEnabled, notebookEnabled: $notebookEnabled, libraryBrowseEnabled: $libraryBrowseEnabled, reflectionEnabled: $reflectionEnabled, rewardsEnabled: $rewardsEnabled, voiceConsentAt: $voiceConsentAt, categories: $categories)';
}


}

/// @nodoc
abstract mixin class _$SafetyPolicyDtoCopyWith<$Res> implements $SafetyPolicyDtoCopyWith<$Res> {
  factory _$SafetyPolicyDtoCopyWith(_SafetyPolicyDto value, $Res Function(_SafetyPolicyDto) _then) = __$SafetyPolicyDtoCopyWithImpl;
@override @useResult
$Res call({
 int childProfileId, bool parentalGateEnabled, int? maxStoryLength, String? requiredApprovalMode, bool? consentRecorded, DateTime? consentRecordedAt, int? consentPolicyVersion, bool? consentOutdated, double? safetyScoreThreshold, double? readabilityScoreThreshold, int? comprehensionThresholdPercent, int? comprehensionWindowSize, bool? storyWishesEnabled, bool? allowInteractiveStories, bool? childCreationEnabled, String? childCreationMode, bool? voiceAnswersEnabled, int? storyLengthTarget, bool? quizEnabled, bool? notebookEnabled, bool? libraryBrowseEnabled, bool? reflectionEnabled, bool? rewardsEnabled, DateTime? voiceConsentAt, List<SafetyCategoryRuleDto> categories
});




}
/// @nodoc
class __$SafetyPolicyDtoCopyWithImpl<$Res>
    implements _$SafetyPolicyDtoCopyWith<$Res> {
  __$SafetyPolicyDtoCopyWithImpl(this._self, this._then);

  final _SafetyPolicyDto _self;
  final $Res Function(_SafetyPolicyDto) _then;

/// Create a copy of SafetyPolicyDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? childProfileId = null,Object? parentalGateEnabled = null,Object? maxStoryLength = freezed,Object? requiredApprovalMode = freezed,Object? consentRecorded = freezed,Object? consentRecordedAt = freezed,Object? consentPolicyVersion = freezed,Object? consentOutdated = freezed,Object? safetyScoreThreshold = freezed,Object? readabilityScoreThreshold = freezed,Object? comprehensionThresholdPercent = freezed,Object? comprehensionWindowSize = freezed,Object? storyWishesEnabled = freezed,Object? allowInteractiveStories = freezed,Object? childCreationEnabled = freezed,Object? childCreationMode = freezed,Object? voiceAnswersEnabled = freezed,Object? storyLengthTarget = freezed,Object? quizEnabled = freezed,Object? notebookEnabled = freezed,Object? libraryBrowseEnabled = freezed,Object? reflectionEnabled = freezed,Object? rewardsEnabled = freezed,Object? voiceConsentAt = freezed,Object? categories = null,}) {
  return _then(_SafetyPolicyDto(
childProfileId: null == childProfileId ? _self.childProfileId : childProfileId // ignore: cast_nullable_to_non_nullable
as int,parentalGateEnabled: null == parentalGateEnabled ? _self.parentalGateEnabled : parentalGateEnabled // ignore: cast_nullable_to_non_nullable
as bool,maxStoryLength: freezed == maxStoryLength ? _self.maxStoryLength : maxStoryLength // ignore: cast_nullable_to_non_nullable
as int?,requiredApprovalMode: freezed == requiredApprovalMode ? _self.requiredApprovalMode : requiredApprovalMode // ignore: cast_nullable_to_non_nullable
as String?,consentRecorded: freezed == consentRecorded ? _self.consentRecorded : consentRecorded // ignore: cast_nullable_to_non_nullable
as bool?,consentRecordedAt: freezed == consentRecordedAt ? _self.consentRecordedAt : consentRecordedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,consentPolicyVersion: freezed == consentPolicyVersion ? _self.consentPolicyVersion : consentPolicyVersion // ignore: cast_nullable_to_non_nullable
as int?,consentOutdated: freezed == consentOutdated ? _self.consentOutdated : consentOutdated // ignore: cast_nullable_to_non_nullable
as bool?,safetyScoreThreshold: freezed == safetyScoreThreshold ? _self.safetyScoreThreshold : safetyScoreThreshold // ignore: cast_nullable_to_non_nullable
as double?,readabilityScoreThreshold: freezed == readabilityScoreThreshold ? _self.readabilityScoreThreshold : readabilityScoreThreshold // ignore: cast_nullable_to_non_nullable
as double?,comprehensionThresholdPercent: freezed == comprehensionThresholdPercent ? _self.comprehensionThresholdPercent : comprehensionThresholdPercent // ignore: cast_nullable_to_non_nullable
as int?,comprehensionWindowSize: freezed == comprehensionWindowSize ? _self.comprehensionWindowSize : comprehensionWindowSize // ignore: cast_nullable_to_non_nullable
as int?,storyWishesEnabled: freezed == storyWishesEnabled ? _self.storyWishesEnabled : storyWishesEnabled // ignore: cast_nullable_to_non_nullable
as bool?,allowInteractiveStories: freezed == allowInteractiveStories ? _self.allowInteractiveStories : allowInteractiveStories // ignore: cast_nullable_to_non_nullable
as bool?,childCreationEnabled: freezed == childCreationEnabled ? _self.childCreationEnabled : childCreationEnabled // ignore: cast_nullable_to_non_nullable
as bool?,childCreationMode: freezed == childCreationMode ? _self.childCreationMode : childCreationMode // ignore: cast_nullable_to_non_nullable
as String?,voiceAnswersEnabled: freezed == voiceAnswersEnabled ? _self.voiceAnswersEnabled : voiceAnswersEnabled // ignore: cast_nullable_to_non_nullable
as bool?,storyLengthTarget: freezed == storyLengthTarget ? _self.storyLengthTarget : storyLengthTarget // ignore: cast_nullable_to_non_nullable
as int?,quizEnabled: freezed == quizEnabled ? _self.quizEnabled : quizEnabled // ignore: cast_nullable_to_non_nullable
as bool?,notebookEnabled: freezed == notebookEnabled ? _self.notebookEnabled : notebookEnabled // ignore: cast_nullable_to_non_nullable
as bool?,libraryBrowseEnabled: freezed == libraryBrowseEnabled ? _self.libraryBrowseEnabled : libraryBrowseEnabled // ignore: cast_nullable_to_non_nullable
as bool?,reflectionEnabled: freezed == reflectionEnabled ? _self.reflectionEnabled : reflectionEnabled // ignore: cast_nullable_to_non_nullable
as bool?,rewardsEnabled: freezed == rewardsEnabled ? _self.rewardsEnabled : rewardsEnabled // ignore: cast_nullable_to_non_nullable
as bool?,voiceConsentAt: freezed == voiceConsentAt ? _self.voiceConsentAt : voiceConsentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<SafetyCategoryRuleDto>,
  ));
}


}

// dart format on
