// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EventSummaryDto {

 int get id; String get title; String get slug; String get description; String? get bannerUrl; int get mainCategoryId; String? get mainCategoryName; String get targetAgeBands; String get status; String get configVersion; String get format; String get scoringMode; int get minVotesPerSubmission; int? get maxParentRegistrations; DateTime? get opensAt; DateTime? get closesAt; DateTime? get resultsFinalizedAt; int get budgetVnd; DateTime? get createdAt; DateTime? get publishedAt; DateTime? get closedAt;
/// Create a copy of EventSummaryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventSummaryDtoCopyWith<EventSummaryDto> get copyWith => _$EventSummaryDtoCopyWithImpl<EventSummaryDto>(this as EventSummaryDto, _$identity);

  /// Serializes this EventSummaryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as EventSummaryDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventSummaryDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.slug, _this.slug) || other.slug == _this.slug)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.bannerUrl, _this.bannerUrl) || other.bannerUrl == _this.bannerUrl)&&(identical(other.mainCategoryId, _this.mainCategoryId) || other.mainCategoryId == _this.mainCategoryId)&&(identical(other.mainCategoryName, _this.mainCategoryName) || other.mainCategoryName == _this.mainCategoryName)&&(identical(other.targetAgeBands, _this.targetAgeBands) || other.targetAgeBands == _this.targetAgeBands)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.configVersion, _this.configVersion) || other.configVersion == _this.configVersion)&&(identical(other.format, _this.format) || other.format == _this.format)&&(identical(other.scoringMode, _this.scoringMode) || other.scoringMode == _this.scoringMode)&&(identical(other.minVotesPerSubmission, _this.minVotesPerSubmission) || other.minVotesPerSubmission == _this.minVotesPerSubmission)&&(identical(other.maxParentRegistrations, _this.maxParentRegistrations) || other.maxParentRegistrations == _this.maxParentRegistrations)&&(identical(other.opensAt, _this.opensAt) || other.opensAt == _this.opensAt)&&(identical(other.closesAt, _this.closesAt) || other.closesAt == _this.closesAt)&&(identical(other.resultsFinalizedAt, _this.resultsFinalizedAt) || other.resultsFinalizedAt == _this.resultsFinalizedAt)&&(identical(other.budgetVnd, _this.budgetVnd) || other.budgetVnd == _this.budgetVnd)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.publishedAt, _this.publishedAt) || other.publishedAt == _this.publishedAt)&&(identical(other.closedAt, _this.closedAt) || other.closedAt == _this.closedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as EventSummaryDto;
  return Object.hashAll([runtimeType,_this.id,_this.title,_this.slug,_this.description,_this.bannerUrl,_this.mainCategoryId,_this.mainCategoryName,_this.targetAgeBands,_this.status,_this.configVersion,_this.format,_this.scoringMode,_this.minVotesPerSubmission,_this.maxParentRegistrations,_this.opensAt,_this.closesAt,_this.resultsFinalizedAt,_this.budgetVnd,_this.createdAt,_this.publishedAt,_this.closedAt]);
}

@override
String toString() {
  final _this = this as EventSummaryDto;
  return 'EventSummaryDto(id: ${_this.id}, title: ${_this.title}, slug: ${_this.slug}, description: ${_this.description}, bannerUrl: ${_this.bannerUrl}, mainCategoryId: ${_this.mainCategoryId}, mainCategoryName: ${_this.mainCategoryName}, targetAgeBands: ${_this.targetAgeBands}, status: ${_this.status}, configVersion: ${_this.configVersion}, format: ${_this.format}, scoringMode: ${_this.scoringMode}, minVotesPerSubmission: ${_this.minVotesPerSubmission}, maxParentRegistrations: ${_this.maxParentRegistrations}, opensAt: ${_this.opensAt}, closesAt: ${_this.closesAt}, resultsFinalizedAt: ${_this.resultsFinalizedAt}, budgetVnd: ${_this.budgetVnd}, createdAt: ${_this.createdAt}, publishedAt: ${_this.publishedAt}, closedAt: ${_this.closedAt})';
}


}

/// @nodoc
abstract mixin class $EventSummaryDtoCopyWith<$Res>  {
  factory $EventSummaryDtoCopyWith(EventSummaryDto value, $Res Function(EventSummaryDto) _then) = _$EventSummaryDtoCopyWithImpl;
@useResult
$Res call({
 int id, String title, String slug, String description, String? bannerUrl, int mainCategoryId, String? mainCategoryName, String targetAgeBands, String status, String configVersion, String format, String scoringMode, int minVotesPerSubmission, int? maxParentRegistrations, DateTime? opensAt, DateTime? closesAt, DateTime? resultsFinalizedAt, int budgetVnd, DateTime? createdAt, DateTime? publishedAt, DateTime? closedAt
});




}
/// @nodoc
class _$EventSummaryDtoCopyWithImpl<$Res>
    implements $EventSummaryDtoCopyWith<$Res> {
  _$EventSummaryDtoCopyWithImpl(this._self, this._then);

  final EventSummaryDto _self;
  final $Res Function(EventSummaryDto) _then;

/// Create a copy of EventSummaryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? slug = null,Object? description = null,Object? bannerUrl = freezed,Object? mainCategoryId = null,Object? mainCategoryName = freezed,Object? targetAgeBands = null,Object? status = null,Object? configVersion = null,Object? format = null,Object? scoringMode = null,Object? minVotesPerSubmission = null,Object? maxParentRegistrations = freezed,Object? opensAt = freezed,Object? closesAt = freezed,Object? resultsFinalizedAt = freezed,Object? budgetVnd = null,Object? createdAt = freezed,Object? publishedAt = freezed,Object? closedAt = freezed,}) {
  return _then(EventSummaryDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,bannerUrl: freezed == bannerUrl ? _self.bannerUrl : bannerUrl // ignore: cast_nullable_to_non_nullable
as String?,mainCategoryId: null == mainCategoryId ? _self.mainCategoryId : mainCategoryId // ignore: cast_nullable_to_non_nullable
as int,mainCategoryName: freezed == mainCategoryName ? _self.mainCategoryName : mainCategoryName // ignore: cast_nullable_to_non_nullable
as String?,targetAgeBands: null == targetAgeBands ? _self.targetAgeBands : targetAgeBands // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,configVersion: null == configVersion ? _self.configVersion : configVersion // ignore: cast_nullable_to_non_nullable
as String,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String,scoringMode: null == scoringMode ? _self.scoringMode : scoringMode // ignore: cast_nullable_to_non_nullable
as String,minVotesPerSubmission: null == minVotesPerSubmission ? _self.minVotesPerSubmission : minVotesPerSubmission // ignore: cast_nullable_to_non_nullable
as int,maxParentRegistrations: freezed == maxParentRegistrations ? _self.maxParentRegistrations : maxParentRegistrations // ignore: cast_nullable_to_non_nullable
as int?,opensAt: freezed == opensAt ? _self.opensAt : opensAt // ignore: cast_nullable_to_non_nullable
as DateTime?,closesAt: freezed == closesAt ? _self.closesAt : closesAt // ignore: cast_nullable_to_non_nullable
as DateTime?,resultsFinalizedAt: freezed == resultsFinalizedAt ? _self.resultsFinalizedAt : resultsFinalizedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,budgetVnd: null == budgetVnd ? _self.budgetVnd : budgetVnd // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,publishedAt: freezed == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,closedAt: freezed == closedAt ? _self.closedAt : closedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [EventSummaryDto].
extension EventSummaryDtoPatterns on EventSummaryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventSummaryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventSummaryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventSummaryDto value)  $default,){
final _that = this;
switch (_that) {
case _EventSummaryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventSummaryDto value)?  $default,){
final _that = this;
switch (_that) {
case _EventSummaryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String slug,  String description,  String? bannerUrl,  int mainCategoryId,  String? mainCategoryName,  String targetAgeBands,  String status,  String configVersion,  String format,  String scoringMode,  int minVotesPerSubmission,  int? maxParentRegistrations,  DateTime? opensAt,  DateTime? closesAt,  DateTime? resultsFinalizedAt,  int budgetVnd,  DateTime? createdAt,  DateTime? publishedAt,  DateTime? closedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventSummaryDto() when $default != null:
return $default(_that.id,_that.title,_that.slug,_that.description,_that.bannerUrl,_that.mainCategoryId,_that.mainCategoryName,_that.targetAgeBands,_that.status,_that.configVersion,_that.format,_that.scoringMode,_that.minVotesPerSubmission,_that.maxParentRegistrations,_that.opensAt,_that.closesAt,_that.resultsFinalizedAt,_that.budgetVnd,_that.createdAt,_that.publishedAt,_that.closedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String slug,  String description,  String? bannerUrl,  int mainCategoryId,  String? mainCategoryName,  String targetAgeBands,  String status,  String configVersion,  String format,  String scoringMode,  int minVotesPerSubmission,  int? maxParentRegistrations,  DateTime? opensAt,  DateTime? closesAt,  DateTime? resultsFinalizedAt,  int budgetVnd,  DateTime? createdAt,  DateTime? publishedAt,  DateTime? closedAt)  $default,) {final _that = this;
switch (_that) {
case _EventSummaryDto():
return $default(_that.id,_that.title,_that.slug,_that.description,_that.bannerUrl,_that.mainCategoryId,_that.mainCategoryName,_that.targetAgeBands,_that.status,_that.configVersion,_that.format,_that.scoringMode,_that.minVotesPerSubmission,_that.maxParentRegistrations,_that.opensAt,_that.closesAt,_that.resultsFinalizedAt,_that.budgetVnd,_that.createdAt,_that.publishedAt,_that.closedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String slug,  String description,  String? bannerUrl,  int mainCategoryId,  String? mainCategoryName,  String targetAgeBands,  String status,  String configVersion,  String format,  String scoringMode,  int minVotesPerSubmission,  int? maxParentRegistrations,  DateTime? opensAt,  DateTime? closesAt,  DateTime? resultsFinalizedAt,  int budgetVnd,  DateTime? createdAt,  DateTime? publishedAt,  DateTime? closedAt)?  $default,) {final _that = this;
switch (_that) {
case _EventSummaryDto() when $default != null:
return $default(_that.id,_that.title,_that.slug,_that.description,_that.bannerUrl,_that.mainCategoryId,_that.mainCategoryName,_that.targetAgeBands,_that.status,_that.configVersion,_that.format,_that.scoringMode,_that.minVotesPerSubmission,_that.maxParentRegistrations,_that.opensAt,_that.closesAt,_that.resultsFinalizedAt,_that.budgetVnd,_that.createdAt,_that.publishedAt,_that.closedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventSummaryDto implements EventSummaryDto {
  const _EventSummaryDto({required this.id, this.title = '', this.slug = '', this.description = '', this.bannerUrl, this.mainCategoryId = 0, this.mainCategoryName, this.targetAgeBands = '', this.status = '', this.configVersion = '', this.format = '', this.scoringMode = '', this.minVotesPerSubmission = 0, this.maxParentRegistrations, this.opensAt, this.closesAt, this.resultsFinalizedAt, this.budgetVnd = 0, this.createdAt, this.publishedAt, this.closedAt});
  factory _EventSummaryDto.fromJson(Map<String, dynamic> json) => _$EventSummaryDtoFromJson(json);

@override final  int id;
@override@JsonKey() final  String title;
@override@JsonKey() final  String slug;
@override@JsonKey() final  String description;
@override final  String? bannerUrl;
@override@JsonKey() final  int mainCategoryId;
@override final  String? mainCategoryName;
@override@JsonKey() final  String targetAgeBands;
@override@JsonKey() final  String status;
@override@JsonKey() final  String configVersion;
@override@JsonKey() final  String format;
@override@JsonKey() final  String scoringMode;
@override@JsonKey() final  int minVotesPerSubmission;
@override final  int? maxParentRegistrations;
@override final  DateTime? opensAt;
@override final  DateTime? closesAt;
@override final  DateTime? resultsFinalizedAt;
@override@JsonKey() final  int budgetVnd;
@override final  DateTime? createdAt;
@override final  DateTime? publishedAt;
@override final  DateTime? closedAt;

/// Create a copy of EventSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventSummaryDtoCopyWith<_EventSummaryDto> get copyWith => __$EventSummaryDtoCopyWithImpl<_EventSummaryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventSummaryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventSummaryDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.description, description) || other.description == description)&&(identical(other.bannerUrl, bannerUrl) || other.bannerUrl == bannerUrl)&&(identical(other.mainCategoryId, mainCategoryId) || other.mainCategoryId == mainCategoryId)&&(identical(other.mainCategoryName, mainCategoryName) || other.mainCategoryName == mainCategoryName)&&(identical(other.targetAgeBands, targetAgeBands) || other.targetAgeBands == targetAgeBands)&&(identical(other.status, status) || other.status == status)&&(identical(other.configVersion, configVersion) || other.configVersion == configVersion)&&(identical(other.format, format) || other.format == format)&&(identical(other.scoringMode, scoringMode) || other.scoringMode == scoringMode)&&(identical(other.minVotesPerSubmission, minVotesPerSubmission) || other.minVotesPerSubmission == minVotesPerSubmission)&&(identical(other.maxParentRegistrations, maxParentRegistrations) || other.maxParentRegistrations == maxParentRegistrations)&&(identical(other.opensAt, opensAt) || other.opensAt == opensAt)&&(identical(other.closesAt, closesAt) || other.closesAt == closesAt)&&(identical(other.resultsFinalizedAt, resultsFinalizedAt) || other.resultsFinalizedAt == resultsFinalizedAt)&&(identical(other.budgetVnd, budgetVnd) || other.budgetVnd == budgetVnd)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.closedAt, closedAt) || other.closedAt == closedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,id,title,slug,description,bannerUrl,mainCategoryId,mainCategoryName,targetAgeBands,status,configVersion,format,scoringMode,minVotesPerSubmission,maxParentRegistrations,opensAt,closesAt,resultsFinalizedAt,budgetVnd,createdAt,publishedAt,closedAt]);
}

@override
String toString() {
    return 'EventSummaryDto(id: $id, title: $title, slug: $slug, description: $description, bannerUrl: $bannerUrl, mainCategoryId: $mainCategoryId, mainCategoryName: $mainCategoryName, targetAgeBands: $targetAgeBands, status: $status, configVersion: $configVersion, format: $format, scoringMode: $scoringMode, minVotesPerSubmission: $minVotesPerSubmission, maxParentRegistrations: $maxParentRegistrations, opensAt: $opensAt, closesAt: $closesAt, resultsFinalizedAt: $resultsFinalizedAt, budgetVnd: $budgetVnd, createdAt: $createdAt, publishedAt: $publishedAt, closedAt: $closedAt)';
}


}

/// @nodoc
abstract mixin class _$EventSummaryDtoCopyWith<$Res> implements $EventSummaryDtoCopyWith<$Res> {
  factory _$EventSummaryDtoCopyWith(_EventSummaryDto value, $Res Function(_EventSummaryDto) _then) = __$EventSummaryDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String slug, String description, String? bannerUrl, int mainCategoryId, String? mainCategoryName, String targetAgeBands, String status, String configVersion, String format, String scoringMode, int minVotesPerSubmission, int? maxParentRegistrations, DateTime? opensAt, DateTime? closesAt, DateTime? resultsFinalizedAt, int budgetVnd, DateTime? createdAt, DateTime? publishedAt, DateTime? closedAt
});




}
/// @nodoc
class __$EventSummaryDtoCopyWithImpl<$Res>
    implements _$EventSummaryDtoCopyWith<$Res> {
  __$EventSummaryDtoCopyWithImpl(this._self, this._then);

  final _EventSummaryDto _self;
  final $Res Function(_EventSummaryDto) _then;

/// Create a copy of EventSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? slug = null,Object? description = null,Object? bannerUrl = freezed,Object? mainCategoryId = null,Object? mainCategoryName = freezed,Object? targetAgeBands = null,Object? status = null,Object? configVersion = null,Object? format = null,Object? scoringMode = null,Object? minVotesPerSubmission = null,Object? maxParentRegistrations = freezed,Object? opensAt = freezed,Object? closesAt = freezed,Object? resultsFinalizedAt = freezed,Object? budgetVnd = null,Object? createdAt = freezed,Object? publishedAt = freezed,Object? closedAt = freezed,}) {
  return _then(_EventSummaryDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,bannerUrl: freezed == bannerUrl ? _self.bannerUrl : bannerUrl // ignore: cast_nullable_to_non_nullable
as String?,mainCategoryId: null == mainCategoryId ? _self.mainCategoryId : mainCategoryId // ignore: cast_nullable_to_non_nullable
as int,mainCategoryName: freezed == mainCategoryName ? _self.mainCategoryName : mainCategoryName // ignore: cast_nullable_to_non_nullable
as String?,targetAgeBands: null == targetAgeBands ? _self.targetAgeBands : targetAgeBands // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,configVersion: null == configVersion ? _self.configVersion : configVersion // ignore: cast_nullable_to_non_nullable
as String,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String,scoringMode: null == scoringMode ? _self.scoringMode : scoringMode // ignore: cast_nullable_to_non_nullable
as String,minVotesPerSubmission: null == minVotesPerSubmission ? _self.minVotesPerSubmission : minVotesPerSubmission // ignore: cast_nullable_to_non_nullable
as int,maxParentRegistrations: freezed == maxParentRegistrations ? _self.maxParentRegistrations : maxParentRegistrations // ignore: cast_nullable_to_non_nullable
as int?,opensAt: freezed == opensAt ? _self.opensAt : opensAt // ignore: cast_nullable_to_non_nullable
as DateTime?,closesAt: freezed == closesAt ? _self.closesAt : closesAt // ignore: cast_nullable_to_non_nullable
as DateTime?,resultsFinalizedAt: freezed == resultsFinalizedAt ? _self.resultsFinalizedAt : resultsFinalizedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,budgetVnd: null == budgetVnd ? _self.budgetVnd : budgetVnd // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,publishedAt: freezed == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,closedAt: freezed == closedAt ? _self.closedAt : closedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$EventDetailDto {

 int get id; String get title; String get slug; String get description; String? get bannerUrl; int get mainCategoryId; String? get mainCategoryName; String get targetAgeBands; String get status; String get configVersion; String get format; String get scoringMode; int get minVotesPerSubmission; int? get maxParentRegistrations; DateTime? get opensAt; DateTime? get closesAt; DateTime? get resultsFinalizedAt; int get budgetVnd; DateTime? get createdAt; DateTime? get publishedAt; DateTime? get closedAt; List<EventTrackDto> get tracks; List<EventActivityDto> get activities; List<EventActivityUserStateDto> get myActivityStates; EventRuleVersionDto? get activeRule; List<EventAwardSlotDto> get awards; int get eventStoriesCount;
/// Create a copy of EventDetailDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventDetailDtoCopyWith<EventDetailDto> get copyWith => _$EventDetailDtoCopyWithImpl<EventDetailDto>(this as EventDetailDto, _$identity);

  /// Serializes this EventDetailDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as EventDetailDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventDetailDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.slug, _this.slug) || other.slug == _this.slug)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.bannerUrl, _this.bannerUrl) || other.bannerUrl == _this.bannerUrl)&&(identical(other.mainCategoryId, _this.mainCategoryId) || other.mainCategoryId == _this.mainCategoryId)&&(identical(other.mainCategoryName, _this.mainCategoryName) || other.mainCategoryName == _this.mainCategoryName)&&(identical(other.targetAgeBands, _this.targetAgeBands) || other.targetAgeBands == _this.targetAgeBands)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.configVersion, _this.configVersion) || other.configVersion == _this.configVersion)&&(identical(other.format, _this.format) || other.format == _this.format)&&(identical(other.scoringMode, _this.scoringMode) || other.scoringMode == _this.scoringMode)&&(identical(other.minVotesPerSubmission, _this.minVotesPerSubmission) || other.minVotesPerSubmission == _this.minVotesPerSubmission)&&(identical(other.maxParentRegistrations, _this.maxParentRegistrations) || other.maxParentRegistrations == _this.maxParentRegistrations)&&(identical(other.opensAt, _this.opensAt) || other.opensAt == _this.opensAt)&&(identical(other.closesAt, _this.closesAt) || other.closesAt == _this.closesAt)&&(identical(other.resultsFinalizedAt, _this.resultsFinalizedAt) || other.resultsFinalizedAt == _this.resultsFinalizedAt)&&(identical(other.budgetVnd, _this.budgetVnd) || other.budgetVnd == _this.budgetVnd)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.publishedAt, _this.publishedAt) || other.publishedAt == _this.publishedAt)&&(identical(other.closedAt, _this.closedAt) || other.closedAt == _this.closedAt)&&const DeepCollectionEquality().equals(other.tracks, _this.tracks)&&const DeepCollectionEquality().equals(other.activities, _this.activities)&&const DeepCollectionEquality().equals(other.myActivityStates, _this.myActivityStates)&&(identical(other.activeRule, _this.activeRule) || other.activeRule == _this.activeRule)&&const DeepCollectionEquality().equals(other.awards, _this.awards)&&(identical(other.eventStoriesCount, _this.eventStoriesCount) || other.eventStoriesCount == _this.eventStoriesCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as EventDetailDto;
  return Object.hashAll([runtimeType,_this.id,_this.title,_this.slug,_this.description,_this.bannerUrl,_this.mainCategoryId,_this.mainCategoryName,_this.targetAgeBands,_this.status,_this.configVersion,_this.format,_this.scoringMode,_this.minVotesPerSubmission,_this.maxParentRegistrations,_this.opensAt,_this.closesAt,_this.resultsFinalizedAt,_this.budgetVnd,_this.createdAt,_this.publishedAt,_this.closedAt,const DeepCollectionEquality().hash(_this.tracks),const DeepCollectionEquality().hash(_this.activities),const DeepCollectionEquality().hash(_this.myActivityStates),_this.activeRule,const DeepCollectionEquality().hash(_this.awards),_this.eventStoriesCount]);
}

@override
String toString() {
  final _this = this as EventDetailDto;
  return 'EventDetailDto(id: ${_this.id}, title: ${_this.title}, slug: ${_this.slug}, description: ${_this.description}, bannerUrl: ${_this.bannerUrl}, mainCategoryId: ${_this.mainCategoryId}, mainCategoryName: ${_this.mainCategoryName}, targetAgeBands: ${_this.targetAgeBands}, status: ${_this.status}, configVersion: ${_this.configVersion}, format: ${_this.format}, scoringMode: ${_this.scoringMode}, minVotesPerSubmission: ${_this.minVotesPerSubmission}, maxParentRegistrations: ${_this.maxParentRegistrations}, opensAt: ${_this.opensAt}, closesAt: ${_this.closesAt}, resultsFinalizedAt: ${_this.resultsFinalizedAt}, budgetVnd: ${_this.budgetVnd}, createdAt: ${_this.createdAt}, publishedAt: ${_this.publishedAt}, closedAt: ${_this.closedAt}, tracks: ${_this.tracks}, activities: ${_this.activities}, myActivityStates: ${_this.myActivityStates}, activeRule: ${_this.activeRule}, awards: ${_this.awards}, eventStoriesCount: ${_this.eventStoriesCount})';
}


}

/// @nodoc
abstract mixin class $EventDetailDtoCopyWith<$Res>  {
  factory $EventDetailDtoCopyWith(EventDetailDto value, $Res Function(EventDetailDto) _then) = _$EventDetailDtoCopyWithImpl;
@useResult
$Res call({
 int id, String title, String slug, String description, String? bannerUrl, int mainCategoryId, String? mainCategoryName, String targetAgeBands, String status, String configVersion, String format, String scoringMode, int minVotesPerSubmission, int? maxParentRegistrations, DateTime? opensAt, DateTime? closesAt, DateTime? resultsFinalizedAt, int budgetVnd, DateTime? createdAt, DateTime? publishedAt, DateTime? closedAt, List<EventTrackDto> tracks, List<EventActivityDto> activities, List<EventActivityUserStateDto> myActivityStates, EventRuleVersionDto? activeRule, List<EventAwardSlotDto> awards, int eventStoriesCount
});


$EventRuleVersionDtoCopyWith<$Res>? get activeRule;

}
/// @nodoc
class _$EventDetailDtoCopyWithImpl<$Res>
    implements $EventDetailDtoCopyWith<$Res> {
  _$EventDetailDtoCopyWithImpl(this._self, this._then);

  final EventDetailDto _self;
  final $Res Function(EventDetailDto) _then;

/// Create a copy of EventDetailDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? slug = null,Object? description = null,Object? bannerUrl = freezed,Object? mainCategoryId = null,Object? mainCategoryName = freezed,Object? targetAgeBands = null,Object? status = null,Object? configVersion = null,Object? format = null,Object? scoringMode = null,Object? minVotesPerSubmission = null,Object? maxParentRegistrations = freezed,Object? opensAt = freezed,Object? closesAt = freezed,Object? resultsFinalizedAt = freezed,Object? budgetVnd = null,Object? createdAt = freezed,Object? publishedAt = freezed,Object? closedAt = freezed,Object? tracks = null,Object? activities = null,Object? myActivityStates = null,Object? activeRule = freezed,Object? awards = null,Object? eventStoriesCount = null,}) {
  return _then(EventDetailDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,bannerUrl: freezed == bannerUrl ? _self.bannerUrl : bannerUrl // ignore: cast_nullable_to_non_nullable
as String?,mainCategoryId: null == mainCategoryId ? _self.mainCategoryId : mainCategoryId // ignore: cast_nullable_to_non_nullable
as int,mainCategoryName: freezed == mainCategoryName ? _self.mainCategoryName : mainCategoryName // ignore: cast_nullable_to_non_nullable
as String?,targetAgeBands: null == targetAgeBands ? _self.targetAgeBands : targetAgeBands // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,configVersion: null == configVersion ? _self.configVersion : configVersion // ignore: cast_nullable_to_non_nullable
as String,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String,scoringMode: null == scoringMode ? _self.scoringMode : scoringMode // ignore: cast_nullable_to_non_nullable
as String,minVotesPerSubmission: null == minVotesPerSubmission ? _self.minVotesPerSubmission : minVotesPerSubmission // ignore: cast_nullable_to_non_nullable
as int,maxParentRegistrations: freezed == maxParentRegistrations ? _self.maxParentRegistrations : maxParentRegistrations // ignore: cast_nullable_to_non_nullable
as int?,opensAt: freezed == opensAt ? _self.opensAt : opensAt // ignore: cast_nullable_to_non_nullable
as DateTime?,closesAt: freezed == closesAt ? _self.closesAt : closesAt // ignore: cast_nullable_to_non_nullable
as DateTime?,resultsFinalizedAt: freezed == resultsFinalizedAt ? _self.resultsFinalizedAt : resultsFinalizedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,budgetVnd: null == budgetVnd ? _self.budgetVnd : budgetVnd // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,publishedAt: freezed == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,closedAt: freezed == closedAt ? _self.closedAt : closedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,tracks: null == tracks ? _self.tracks : tracks // ignore: cast_nullable_to_non_nullable
as List<EventTrackDto>,activities: null == activities ? _self.activities : activities // ignore: cast_nullable_to_non_nullable
as List<EventActivityDto>,myActivityStates: null == myActivityStates ? _self.myActivityStates : myActivityStates // ignore: cast_nullable_to_non_nullable
as List<EventActivityUserStateDto>,activeRule: freezed == activeRule ? _self.activeRule : activeRule // ignore: cast_nullable_to_non_nullable
as EventRuleVersionDto?,awards: null == awards ? _self.awards : awards // ignore: cast_nullable_to_non_nullable
as List<EventAwardSlotDto>,eventStoriesCount: null == eventStoriesCount ? _self.eventStoriesCount : eventStoriesCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of EventDetailDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventRuleVersionDtoCopyWith<$Res>? get activeRule {
    if (_self.activeRule == null) {
    return null;
  }

  return $EventRuleVersionDtoCopyWith<$Res>(_self.activeRule!, (value) {
    return _then(_self.copyWith(activeRule: value));
  });
}
}


/// Adds pattern-matching-related methods to [EventDetailDto].
extension EventDetailDtoPatterns on EventDetailDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventDetailDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventDetailDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventDetailDto value)  $default,){
final _that = this;
switch (_that) {
case _EventDetailDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventDetailDto value)?  $default,){
final _that = this;
switch (_that) {
case _EventDetailDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String slug,  String description,  String? bannerUrl,  int mainCategoryId,  String? mainCategoryName,  String targetAgeBands,  String status,  String configVersion,  String format,  String scoringMode,  int minVotesPerSubmission,  int? maxParentRegistrations,  DateTime? opensAt,  DateTime? closesAt,  DateTime? resultsFinalizedAt,  int budgetVnd,  DateTime? createdAt,  DateTime? publishedAt,  DateTime? closedAt,  List<EventTrackDto> tracks,  List<EventActivityDto> activities,  List<EventActivityUserStateDto> myActivityStates,  EventRuleVersionDto? activeRule,  List<EventAwardSlotDto> awards,  int eventStoriesCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventDetailDto() when $default != null:
return $default(_that.id,_that.title,_that.slug,_that.description,_that.bannerUrl,_that.mainCategoryId,_that.mainCategoryName,_that.targetAgeBands,_that.status,_that.configVersion,_that.format,_that.scoringMode,_that.minVotesPerSubmission,_that.maxParentRegistrations,_that.opensAt,_that.closesAt,_that.resultsFinalizedAt,_that.budgetVnd,_that.createdAt,_that.publishedAt,_that.closedAt,_that.tracks,_that.activities,_that.myActivityStates,_that.activeRule,_that.awards,_that.eventStoriesCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String slug,  String description,  String? bannerUrl,  int mainCategoryId,  String? mainCategoryName,  String targetAgeBands,  String status,  String configVersion,  String format,  String scoringMode,  int minVotesPerSubmission,  int? maxParentRegistrations,  DateTime? opensAt,  DateTime? closesAt,  DateTime? resultsFinalizedAt,  int budgetVnd,  DateTime? createdAt,  DateTime? publishedAt,  DateTime? closedAt,  List<EventTrackDto> tracks,  List<EventActivityDto> activities,  List<EventActivityUserStateDto> myActivityStates,  EventRuleVersionDto? activeRule,  List<EventAwardSlotDto> awards,  int eventStoriesCount)  $default,) {final _that = this;
switch (_that) {
case _EventDetailDto():
return $default(_that.id,_that.title,_that.slug,_that.description,_that.bannerUrl,_that.mainCategoryId,_that.mainCategoryName,_that.targetAgeBands,_that.status,_that.configVersion,_that.format,_that.scoringMode,_that.minVotesPerSubmission,_that.maxParentRegistrations,_that.opensAt,_that.closesAt,_that.resultsFinalizedAt,_that.budgetVnd,_that.createdAt,_that.publishedAt,_that.closedAt,_that.tracks,_that.activities,_that.myActivityStates,_that.activeRule,_that.awards,_that.eventStoriesCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String slug,  String description,  String? bannerUrl,  int mainCategoryId,  String? mainCategoryName,  String targetAgeBands,  String status,  String configVersion,  String format,  String scoringMode,  int minVotesPerSubmission,  int? maxParentRegistrations,  DateTime? opensAt,  DateTime? closesAt,  DateTime? resultsFinalizedAt,  int budgetVnd,  DateTime? createdAt,  DateTime? publishedAt,  DateTime? closedAt,  List<EventTrackDto> tracks,  List<EventActivityDto> activities,  List<EventActivityUserStateDto> myActivityStates,  EventRuleVersionDto? activeRule,  List<EventAwardSlotDto> awards,  int eventStoriesCount)?  $default,) {final _that = this;
switch (_that) {
case _EventDetailDto() when $default != null:
return $default(_that.id,_that.title,_that.slug,_that.description,_that.bannerUrl,_that.mainCategoryId,_that.mainCategoryName,_that.targetAgeBands,_that.status,_that.configVersion,_that.format,_that.scoringMode,_that.minVotesPerSubmission,_that.maxParentRegistrations,_that.opensAt,_that.closesAt,_that.resultsFinalizedAt,_that.budgetVnd,_that.createdAt,_that.publishedAt,_that.closedAt,_that.tracks,_that.activities,_that.myActivityStates,_that.activeRule,_that.awards,_that.eventStoriesCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventDetailDto implements EventDetailDto {
  const _EventDetailDto({required this.id, this.title = '', this.slug = '', this.description = '', this.bannerUrl, this.mainCategoryId = 0, this.mainCategoryName, this.targetAgeBands = '', this.status = '', this.configVersion = '', this.format = '', this.scoringMode = '', this.minVotesPerSubmission = 0, this.maxParentRegistrations, this.opensAt, this.closesAt, this.resultsFinalizedAt, this.budgetVnd = 0, this.createdAt, this.publishedAt, this.closedAt,  List<EventTrackDto> tracks = const <EventTrackDto>[],  List<EventActivityDto> activities = const <EventActivityDto>[],  List<EventActivityUserStateDto> myActivityStates = const <EventActivityUserStateDto>[], this.activeRule,  List<EventAwardSlotDto> awards = const <EventAwardSlotDto>[], this.eventStoriesCount = 0}): _tracks = tracks,_activities = activities,_myActivityStates = myActivityStates,_awards = awards;
  factory _EventDetailDto.fromJson(Map<String, dynamic> json) => _$EventDetailDtoFromJson(json);

@override final  int id;
@override@JsonKey() final  String title;
@override@JsonKey() final  String slug;
@override@JsonKey() final  String description;
@override final  String? bannerUrl;
@override@JsonKey() final  int mainCategoryId;
@override final  String? mainCategoryName;
@override@JsonKey() final  String targetAgeBands;
@override@JsonKey() final  String status;
@override@JsonKey() final  String configVersion;
@override@JsonKey() final  String format;
@override@JsonKey() final  String scoringMode;
@override@JsonKey() final  int minVotesPerSubmission;
@override final  int? maxParentRegistrations;
@override final  DateTime? opensAt;
@override final  DateTime? closesAt;
@override final  DateTime? resultsFinalizedAt;
@override@JsonKey() final  int budgetVnd;
@override final  DateTime? createdAt;
@override final  DateTime? publishedAt;
@override final  DateTime? closedAt;
 final  List<EventTrackDto> _tracks;
@override@JsonKey() List<EventTrackDto> get tracks {
  if (_tracks is EqualUnmodifiableListView) return _tracks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tracks);
}

 final  List<EventActivityDto> _activities;
@override@JsonKey() List<EventActivityDto> get activities {
  if (_activities is EqualUnmodifiableListView) return _activities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_activities);
}

 final  List<EventActivityUserStateDto> _myActivityStates;
@override@JsonKey() List<EventActivityUserStateDto> get myActivityStates {
  if (_myActivityStates is EqualUnmodifiableListView) return _myActivityStates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_myActivityStates);
}

@override final  EventRuleVersionDto? activeRule;
 final  List<EventAwardSlotDto> _awards;
@override@JsonKey() List<EventAwardSlotDto> get awards {
  if (_awards is EqualUnmodifiableListView) return _awards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_awards);
}

@override@JsonKey() final  int eventStoriesCount;

/// Create a copy of EventDetailDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventDetailDtoCopyWith<_EventDetailDto> get copyWith => __$EventDetailDtoCopyWithImpl<_EventDetailDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventDetailDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventDetailDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.description, description) || other.description == description)&&(identical(other.bannerUrl, bannerUrl) || other.bannerUrl == bannerUrl)&&(identical(other.mainCategoryId, mainCategoryId) || other.mainCategoryId == mainCategoryId)&&(identical(other.mainCategoryName, mainCategoryName) || other.mainCategoryName == mainCategoryName)&&(identical(other.targetAgeBands, targetAgeBands) || other.targetAgeBands == targetAgeBands)&&(identical(other.status, status) || other.status == status)&&(identical(other.configVersion, configVersion) || other.configVersion == configVersion)&&(identical(other.format, format) || other.format == format)&&(identical(other.scoringMode, scoringMode) || other.scoringMode == scoringMode)&&(identical(other.minVotesPerSubmission, minVotesPerSubmission) || other.minVotesPerSubmission == minVotesPerSubmission)&&(identical(other.maxParentRegistrations, maxParentRegistrations) || other.maxParentRegistrations == maxParentRegistrations)&&(identical(other.opensAt, opensAt) || other.opensAt == opensAt)&&(identical(other.closesAt, closesAt) || other.closesAt == closesAt)&&(identical(other.resultsFinalizedAt, resultsFinalizedAt) || other.resultsFinalizedAt == resultsFinalizedAt)&&(identical(other.budgetVnd, budgetVnd) || other.budgetVnd == budgetVnd)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.closedAt, closedAt) || other.closedAt == closedAt)&&const DeepCollectionEquality().equals(other.tracks, _tracks)&&const DeepCollectionEquality().equals(other.activities, _activities)&&const DeepCollectionEquality().equals(other.myActivityStates, _myActivityStates)&&(identical(other.activeRule, activeRule) || other.activeRule == activeRule)&&const DeepCollectionEquality().equals(other.awards, _awards)&&(identical(other.eventStoriesCount, eventStoriesCount) || other.eventStoriesCount == eventStoriesCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,id,title,slug,description,bannerUrl,mainCategoryId,mainCategoryName,targetAgeBands,status,configVersion,format,scoringMode,minVotesPerSubmission,maxParentRegistrations,opensAt,closesAt,resultsFinalizedAt,budgetVnd,createdAt,publishedAt,closedAt,const DeepCollectionEquality().hash(_tracks),const DeepCollectionEquality().hash(_activities),const DeepCollectionEquality().hash(_myActivityStates),activeRule,const DeepCollectionEquality().hash(_awards),eventStoriesCount]);
}

@override
String toString() {
    return 'EventDetailDto(id: $id, title: $title, slug: $slug, description: $description, bannerUrl: $bannerUrl, mainCategoryId: $mainCategoryId, mainCategoryName: $mainCategoryName, targetAgeBands: $targetAgeBands, status: $status, configVersion: $configVersion, format: $format, scoringMode: $scoringMode, minVotesPerSubmission: $minVotesPerSubmission, maxParentRegistrations: $maxParentRegistrations, opensAt: $opensAt, closesAt: $closesAt, resultsFinalizedAt: $resultsFinalizedAt, budgetVnd: $budgetVnd, createdAt: $createdAt, publishedAt: $publishedAt, closedAt: $closedAt, tracks: $tracks, activities: $activities, myActivityStates: $myActivityStates, activeRule: $activeRule, awards: $awards, eventStoriesCount: $eventStoriesCount)';
}


}

/// @nodoc
abstract mixin class _$EventDetailDtoCopyWith<$Res> implements $EventDetailDtoCopyWith<$Res> {
  factory _$EventDetailDtoCopyWith(_EventDetailDto value, $Res Function(_EventDetailDto) _then) = __$EventDetailDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String slug, String description, String? bannerUrl, int mainCategoryId, String? mainCategoryName, String targetAgeBands, String status, String configVersion, String format, String scoringMode, int minVotesPerSubmission, int? maxParentRegistrations, DateTime? opensAt, DateTime? closesAt, DateTime? resultsFinalizedAt, int budgetVnd, DateTime? createdAt, DateTime? publishedAt, DateTime? closedAt, List<EventTrackDto> tracks, List<EventActivityDto> activities, List<EventActivityUserStateDto> myActivityStates, EventRuleVersionDto? activeRule, List<EventAwardSlotDto> awards, int eventStoriesCount
});


@override $EventRuleVersionDtoCopyWith<$Res>? get activeRule;

}
/// @nodoc
class __$EventDetailDtoCopyWithImpl<$Res>
    implements _$EventDetailDtoCopyWith<$Res> {
  __$EventDetailDtoCopyWithImpl(this._self, this._then);

  final _EventDetailDto _self;
  final $Res Function(_EventDetailDto) _then;

/// Create a copy of EventDetailDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? slug = null,Object? description = null,Object? bannerUrl = freezed,Object? mainCategoryId = null,Object? mainCategoryName = freezed,Object? targetAgeBands = null,Object? status = null,Object? configVersion = null,Object? format = null,Object? scoringMode = null,Object? minVotesPerSubmission = null,Object? maxParentRegistrations = freezed,Object? opensAt = freezed,Object? closesAt = freezed,Object? resultsFinalizedAt = freezed,Object? budgetVnd = null,Object? createdAt = freezed,Object? publishedAt = freezed,Object? closedAt = freezed,Object? tracks = null,Object? activities = null,Object? myActivityStates = null,Object? activeRule = freezed,Object? awards = null,Object? eventStoriesCount = null,}) {
  return _then(_EventDetailDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,bannerUrl: freezed == bannerUrl ? _self.bannerUrl : bannerUrl // ignore: cast_nullable_to_non_nullable
as String?,mainCategoryId: null == mainCategoryId ? _self.mainCategoryId : mainCategoryId // ignore: cast_nullable_to_non_nullable
as int,mainCategoryName: freezed == mainCategoryName ? _self.mainCategoryName : mainCategoryName // ignore: cast_nullable_to_non_nullable
as String?,targetAgeBands: null == targetAgeBands ? _self.targetAgeBands : targetAgeBands // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,configVersion: null == configVersion ? _self.configVersion : configVersion // ignore: cast_nullable_to_non_nullable
as String,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String,scoringMode: null == scoringMode ? _self.scoringMode : scoringMode // ignore: cast_nullable_to_non_nullable
as String,minVotesPerSubmission: null == minVotesPerSubmission ? _self.minVotesPerSubmission : minVotesPerSubmission // ignore: cast_nullable_to_non_nullable
as int,maxParentRegistrations: freezed == maxParentRegistrations ? _self.maxParentRegistrations : maxParentRegistrations // ignore: cast_nullable_to_non_nullable
as int?,opensAt: freezed == opensAt ? _self.opensAt : opensAt // ignore: cast_nullable_to_non_nullable
as DateTime?,closesAt: freezed == closesAt ? _self.closesAt : closesAt // ignore: cast_nullable_to_non_nullable
as DateTime?,resultsFinalizedAt: freezed == resultsFinalizedAt ? _self.resultsFinalizedAt : resultsFinalizedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,budgetVnd: null == budgetVnd ? _self.budgetVnd : budgetVnd // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,publishedAt: freezed == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,closedAt: freezed == closedAt ? _self.closedAt : closedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,tracks: null == tracks ? _self._tracks : tracks // ignore: cast_nullable_to_non_nullable
as List<EventTrackDto>,activities: null == activities ? _self._activities : activities // ignore: cast_nullable_to_non_nullable
as List<EventActivityDto>,myActivityStates: null == myActivityStates ? _self._myActivityStates : myActivityStates // ignore: cast_nullable_to_non_nullable
as List<EventActivityUserStateDto>,activeRule: freezed == activeRule ? _self.activeRule : activeRule // ignore: cast_nullable_to_non_nullable
as EventRuleVersionDto?,awards: null == awards ? _self._awards : awards // ignore: cast_nullable_to_non_nullable
as List<EventAwardSlotDto>,eventStoriesCount: null == eventStoriesCount ? _self.eventStoriesCount : eventStoriesCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of EventDetailDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventRuleVersionDtoCopyWith<$Res>? get activeRule {
    if (_self.activeRule == null) {
    return null;
  }

  return $EventRuleVersionDtoCopyWith<$Res>(_self.activeRule!, (value) {
    return _then(_self.copyWith(activeRule: value));
  });
}
}


/// @nodoc
mixin _$EventTrackDto {

 int get id; String get trackType; DateTime? get registrationStartAt; DateTime? get registrationEndAt; DateTime? get executionStartAt; DateTime? get executionEndAt; int get maxSubmissionsPerUser; int get grantAiCredits; int get grantSubmitCredits; bool get waiveWeeklyLibraryLimit; int get claimWindowHours; bool get awardAllMissionCompleters;
/// Create a copy of EventTrackDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventTrackDtoCopyWith<EventTrackDto> get copyWith => _$EventTrackDtoCopyWithImpl<EventTrackDto>(this as EventTrackDto, _$identity);

  /// Serializes this EventTrackDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as EventTrackDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventTrackDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.trackType, _this.trackType) || other.trackType == _this.trackType)&&(identical(other.registrationStartAt, _this.registrationStartAt) || other.registrationStartAt == _this.registrationStartAt)&&(identical(other.registrationEndAt, _this.registrationEndAt) || other.registrationEndAt == _this.registrationEndAt)&&(identical(other.executionStartAt, _this.executionStartAt) || other.executionStartAt == _this.executionStartAt)&&(identical(other.executionEndAt, _this.executionEndAt) || other.executionEndAt == _this.executionEndAt)&&(identical(other.maxSubmissionsPerUser, _this.maxSubmissionsPerUser) || other.maxSubmissionsPerUser == _this.maxSubmissionsPerUser)&&(identical(other.grantAiCredits, _this.grantAiCredits) || other.grantAiCredits == _this.grantAiCredits)&&(identical(other.grantSubmitCredits, _this.grantSubmitCredits) || other.grantSubmitCredits == _this.grantSubmitCredits)&&(identical(other.waiveWeeklyLibraryLimit, _this.waiveWeeklyLibraryLimit) || other.waiveWeeklyLibraryLimit == _this.waiveWeeklyLibraryLimit)&&(identical(other.claimWindowHours, _this.claimWindowHours) || other.claimWindowHours == _this.claimWindowHours)&&(identical(other.awardAllMissionCompleters, _this.awardAllMissionCompleters) || other.awardAllMissionCompleters == _this.awardAllMissionCompleters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as EventTrackDto;
  return Object.hash(runtimeType,_this.id,_this.trackType,_this.registrationStartAt,_this.registrationEndAt,_this.executionStartAt,_this.executionEndAt,_this.maxSubmissionsPerUser,_this.grantAiCredits,_this.grantSubmitCredits,_this.waiveWeeklyLibraryLimit,_this.claimWindowHours,_this.awardAllMissionCompleters);
}

@override
String toString() {
  final _this = this as EventTrackDto;
  return 'EventTrackDto(id: ${_this.id}, trackType: ${_this.trackType}, registrationStartAt: ${_this.registrationStartAt}, registrationEndAt: ${_this.registrationEndAt}, executionStartAt: ${_this.executionStartAt}, executionEndAt: ${_this.executionEndAt}, maxSubmissionsPerUser: ${_this.maxSubmissionsPerUser}, grantAiCredits: ${_this.grantAiCredits}, grantSubmitCredits: ${_this.grantSubmitCredits}, waiveWeeklyLibraryLimit: ${_this.waiveWeeklyLibraryLimit}, claimWindowHours: ${_this.claimWindowHours}, awardAllMissionCompleters: ${_this.awardAllMissionCompleters})';
}


}

/// @nodoc
abstract mixin class $EventTrackDtoCopyWith<$Res>  {
  factory $EventTrackDtoCopyWith(EventTrackDto value, $Res Function(EventTrackDto) _then) = _$EventTrackDtoCopyWithImpl;
@useResult
$Res call({
 int id, String trackType, DateTime? registrationStartAt, DateTime? registrationEndAt, DateTime? executionStartAt, DateTime? executionEndAt, int maxSubmissionsPerUser, int grantAiCredits, int grantSubmitCredits, bool waiveWeeklyLibraryLimit, int claimWindowHours, bool awardAllMissionCompleters
});




}
/// @nodoc
class _$EventTrackDtoCopyWithImpl<$Res>
    implements $EventTrackDtoCopyWith<$Res> {
  _$EventTrackDtoCopyWithImpl(this._self, this._then);

  final EventTrackDto _self;
  final $Res Function(EventTrackDto) _then;

/// Create a copy of EventTrackDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? trackType = null,Object? registrationStartAt = freezed,Object? registrationEndAt = freezed,Object? executionStartAt = freezed,Object? executionEndAt = freezed,Object? maxSubmissionsPerUser = null,Object? grantAiCredits = null,Object? grantSubmitCredits = null,Object? waiveWeeklyLibraryLimit = null,Object? claimWindowHours = null,Object? awardAllMissionCompleters = null,}) {
  return _then(EventTrackDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,trackType: null == trackType ? _self.trackType : trackType // ignore: cast_nullable_to_non_nullable
as String,registrationStartAt: freezed == registrationStartAt ? _self.registrationStartAt : registrationStartAt // ignore: cast_nullable_to_non_nullable
as DateTime?,registrationEndAt: freezed == registrationEndAt ? _self.registrationEndAt : registrationEndAt // ignore: cast_nullable_to_non_nullable
as DateTime?,executionStartAt: freezed == executionStartAt ? _self.executionStartAt : executionStartAt // ignore: cast_nullable_to_non_nullable
as DateTime?,executionEndAt: freezed == executionEndAt ? _self.executionEndAt : executionEndAt // ignore: cast_nullable_to_non_nullable
as DateTime?,maxSubmissionsPerUser: null == maxSubmissionsPerUser ? _self.maxSubmissionsPerUser : maxSubmissionsPerUser // ignore: cast_nullable_to_non_nullable
as int,grantAiCredits: null == grantAiCredits ? _self.grantAiCredits : grantAiCredits // ignore: cast_nullable_to_non_nullable
as int,grantSubmitCredits: null == grantSubmitCredits ? _self.grantSubmitCredits : grantSubmitCredits // ignore: cast_nullable_to_non_nullable
as int,waiveWeeklyLibraryLimit: null == waiveWeeklyLibraryLimit ? _self.waiveWeeklyLibraryLimit : waiveWeeklyLibraryLimit // ignore: cast_nullable_to_non_nullable
as bool,claimWindowHours: null == claimWindowHours ? _self.claimWindowHours : claimWindowHours // ignore: cast_nullable_to_non_nullable
as int,awardAllMissionCompleters: null == awardAllMissionCompleters ? _self.awardAllMissionCompleters : awardAllMissionCompleters // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [EventTrackDto].
extension EventTrackDtoPatterns on EventTrackDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventTrackDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventTrackDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventTrackDto value)  $default,){
final _that = this;
switch (_that) {
case _EventTrackDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventTrackDto value)?  $default,){
final _that = this;
switch (_that) {
case _EventTrackDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String trackType,  DateTime? registrationStartAt,  DateTime? registrationEndAt,  DateTime? executionStartAt,  DateTime? executionEndAt,  int maxSubmissionsPerUser,  int grantAiCredits,  int grantSubmitCredits,  bool waiveWeeklyLibraryLimit,  int claimWindowHours,  bool awardAllMissionCompleters)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventTrackDto() when $default != null:
return $default(_that.id,_that.trackType,_that.registrationStartAt,_that.registrationEndAt,_that.executionStartAt,_that.executionEndAt,_that.maxSubmissionsPerUser,_that.grantAiCredits,_that.grantSubmitCredits,_that.waiveWeeklyLibraryLimit,_that.claimWindowHours,_that.awardAllMissionCompleters);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String trackType,  DateTime? registrationStartAt,  DateTime? registrationEndAt,  DateTime? executionStartAt,  DateTime? executionEndAt,  int maxSubmissionsPerUser,  int grantAiCredits,  int grantSubmitCredits,  bool waiveWeeklyLibraryLimit,  int claimWindowHours,  bool awardAllMissionCompleters)  $default,) {final _that = this;
switch (_that) {
case _EventTrackDto():
return $default(_that.id,_that.trackType,_that.registrationStartAt,_that.registrationEndAt,_that.executionStartAt,_that.executionEndAt,_that.maxSubmissionsPerUser,_that.grantAiCredits,_that.grantSubmitCredits,_that.waiveWeeklyLibraryLimit,_that.claimWindowHours,_that.awardAllMissionCompleters);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String trackType,  DateTime? registrationStartAt,  DateTime? registrationEndAt,  DateTime? executionStartAt,  DateTime? executionEndAt,  int maxSubmissionsPerUser,  int grantAiCredits,  int grantSubmitCredits,  bool waiveWeeklyLibraryLimit,  int claimWindowHours,  bool awardAllMissionCompleters)?  $default,) {final _that = this;
switch (_that) {
case _EventTrackDto() when $default != null:
return $default(_that.id,_that.trackType,_that.registrationStartAt,_that.registrationEndAt,_that.executionStartAt,_that.executionEndAt,_that.maxSubmissionsPerUser,_that.grantAiCredits,_that.grantSubmitCredits,_that.waiveWeeklyLibraryLimit,_that.claimWindowHours,_that.awardAllMissionCompleters);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventTrackDto implements EventTrackDto {
  const _EventTrackDto({required this.id, this.trackType = '', this.registrationStartAt, this.registrationEndAt, this.executionStartAt, this.executionEndAt, this.maxSubmissionsPerUser = 0, this.grantAiCredits = 0, this.grantSubmitCredits = 0, this.waiveWeeklyLibraryLimit = false, this.claimWindowHours = 0, this.awardAllMissionCompleters = false});
  factory _EventTrackDto.fromJson(Map<String, dynamic> json) => _$EventTrackDtoFromJson(json);

@override final  int id;
@override@JsonKey() final  String trackType;
@override final  DateTime? registrationStartAt;
@override final  DateTime? registrationEndAt;
@override final  DateTime? executionStartAt;
@override final  DateTime? executionEndAt;
@override@JsonKey() final  int maxSubmissionsPerUser;
@override@JsonKey() final  int grantAiCredits;
@override@JsonKey() final  int grantSubmitCredits;
@override@JsonKey() final  bool waiveWeeklyLibraryLimit;
@override@JsonKey() final  int claimWindowHours;
@override@JsonKey() final  bool awardAllMissionCompleters;

/// Create a copy of EventTrackDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventTrackDtoCopyWith<_EventTrackDto> get copyWith => __$EventTrackDtoCopyWithImpl<_EventTrackDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventTrackDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventTrackDto&&(identical(other.id, id) || other.id == id)&&(identical(other.trackType, trackType) || other.trackType == trackType)&&(identical(other.registrationStartAt, registrationStartAt) || other.registrationStartAt == registrationStartAt)&&(identical(other.registrationEndAt, registrationEndAt) || other.registrationEndAt == registrationEndAt)&&(identical(other.executionStartAt, executionStartAt) || other.executionStartAt == executionStartAt)&&(identical(other.executionEndAt, executionEndAt) || other.executionEndAt == executionEndAt)&&(identical(other.maxSubmissionsPerUser, maxSubmissionsPerUser) || other.maxSubmissionsPerUser == maxSubmissionsPerUser)&&(identical(other.grantAiCredits, grantAiCredits) || other.grantAiCredits == grantAiCredits)&&(identical(other.grantSubmitCredits, grantSubmitCredits) || other.grantSubmitCredits == grantSubmitCredits)&&(identical(other.waiveWeeklyLibraryLimit, waiveWeeklyLibraryLimit) || other.waiveWeeklyLibraryLimit == waiveWeeklyLibraryLimit)&&(identical(other.claimWindowHours, claimWindowHours) || other.claimWindowHours == claimWindowHours)&&(identical(other.awardAllMissionCompleters, awardAllMissionCompleters) || other.awardAllMissionCompleters == awardAllMissionCompleters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,trackType,registrationStartAt,registrationEndAt,executionStartAt,executionEndAt,maxSubmissionsPerUser,grantAiCredits,grantSubmitCredits,waiveWeeklyLibraryLimit,claimWindowHours,awardAllMissionCompleters);
}

@override
String toString() {
    return 'EventTrackDto(id: $id, trackType: $trackType, registrationStartAt: $registrationStartAt, registrationEndAt: $registrationEndAt, executionStartAt: $executionStartAt, executionEndAt: $executionEndAt, maxSubmissionsPerUser: $maxSubmissionsPerUser, grantAiCredits: $grantAiCredits, grantSubmitCredits: $grantSubmitCredits, waiveWeeklyLibraryLimit: $waiveWeeklyLibraryLimit, claimWindowHours: $claimWindowHours, awardAllMissionCompleters: $awardAllMissionCompleters)';
}


}

/// @nodoc
abstract mixin class _$EventTrackDtoCopyWith<$Res> implements $EventTrackDtoCopyWith<$Res> {
  factory _$EventTrackDtoCopyWith(_EventTrackDto value, $Res Function(_EventTrackDto) _then) = __$EventTrackDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String trackType, DateTime? registrationStartAt, DateTime? registrationEndAt, DateTime? executionStartAt, DateTime? executionEndAt, int maxSubmissionsPerUser, int grantAiCredits, int grantSubmitCredits, bool waiveWeeklyLibraryLimit, int claimWindowHours, bool awardAllMissionCompleters
});




}
/// @nodoc
class __$EventTrackDtoCopyWithImpl<$Res>
    implements _$EventTrackDtoCopyWith<$Res> {
  __$EventTrackDtoCopyWithImpl(this._self, this._then);

  final _EventTrackDto _self;
  final $Res Function(_EventTrackDto) _then;

/// Create a copy of EventTrackDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? trackType = null,Object? registrationStartAt = freezed,Object? registrationEndAt = freezed,Object? executionStartAt = freezed,Object? executionEndAt = freezed,Object? maxSubmissionsPerUser = null,Object? grantAiCredits = null,Object? grantSubmitCredits = null,Object? waiveWeeklyLibraryLimit = null,Object? claimWindowHours = null,Object? awardAllMissionCompleters = null,}) {
  return _then(_EventTrackDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,trackType: null == trackType ? _self.trackType : trackType // ignore: cast_nullable_to_non_nullable
as String,registrationStartAt: freezed == registrationStartAt ? _self.registrationStartAt : registrationStartAt // ignore: cast_nullable_to_non_nullable
as DateTime?,registrationEndAt: freezed == registrationEndAt ? _self.registrationEndAt : registrationEndAt // ignore: cast_nullable_to_non_nullable
as DateTime?,executionStartAt: freezed == executionStartAt ? _self.executionStartAt : executionStartAt // ignore: cast_nullable_to_non_nullable
as DateTime?,executionEndAt: freezed == executionEndAt ? _self.executionEndAt : executionEndAt // ignore: cast_nullable_to_non_nullable
as DateTime?,maxSubmissionsPerUser: null == maxSubmissionsPerUser ? _self.maxSubmissionsPerUser : maxSubmissionsPerUser // ignore: cast_nullable_to_non_nullable
as int,grantAiCredits: null == grantAiCredits ? _self.grantAiCredits : grantAiCredits // ignore: cast_nullable_to_non_nullable
as int,grantSubmitCredits: null == grantSubmitCredits ? _self.grantSubmitCredits : grantSubmitCredits // ignore: cast_nullable_to_non_nullable
as int,waiveWeeklyLibraryLimit: null == waiveWeeklyLibraryLimit ? _self.waiveWeeklyLibraryLimit : waiveWeeklyLibraryLimit // ignore: cast_nullable_to_non_nullable
as bool,claimWindowHours: null == claimWindowHours ? _self.claimWindowHours : claimWindowHours // ignore: cast_nullable_to_non_nullable
as int,awardAllMissionCompleters: null == awardAllMissionCompleters ? _self.awardAllMissionCompleters : awardAllMissionCompleters // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$EventActivityDto {

 int get id; String get activityType; String get allowedAudience; DateTime? get registrationStartAt; DateTime? get registrationEndAt; DateTime? get startAt; DateTime? get endAt; DateTime? get reviewCutoffAt; int get grantAiCredits; int? get maxSubmissionsPerUser; int? get maxRegistrations; bool get waiveWeeklyLibraryLimit; String get storySource; int get minVotesPerSubmission; int get claimWindowHours; bool get awardAllMissionCompleters;
/// Create a copy of EventActivityDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventActivityDtoCopyWith<EventActivityDto> get copyWith => _$EventActivityDtoCopyWithImpl<EventActivityDto>(this as EventActivityDto, _$identity);

  /// Serializes this EventActivityDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as EventActivityDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventActivityDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.activityType, _this.activityType) || other.activityType == _this.activityType)&&(identical(other.allowedAudience, _this.allowedAudience) || other.allowedAudience == _this.allowedAudience)&&(identical(other.registrationStartAt, _this.registrationStartAt) || other.registrationStartAt == _this.registrationStartAt)&&(identical(other.registrationEndAt, _this.registrationEndAt) || other.registrationEndAt == _this.registrationEndAt)&&(identical(other.startAt, _this.startAt) || other.startAt == _this.startAt)&&(identical(other.endAt, _this.endAt) || other.endAt == _this.endAt)&&(identical(other.reviewCutoffAt, _this.reviewCutoffAt) || other.reviewCutoffAt == _this.reviewCutoffAt)&&(identical(other.grantAiCredits, _this.grantAiCredits) || other.grantAiCredits == _this.grantAiCredits)&&(identical(other.maxSubmissionsPerUser, _this.maxSubmissionsPerUser) || other.maxSubmissionsPerUser == _this.maxSubmissionsPerUser)&&(identical(other.maxRegistrations, _this.maxRegistrations) || other.maxRegistrations == _this.maxRegistrations)&&(identical(other.waiveWeeklyLibraryLimit, _this.waiveWeeklyLibraryLimit) || other.waiveWeeklyLibraryLimit == _this.waiveWeeklyLibraryLimit)&&(identical(other.storySource, _this.storySource) || other.storySource == _this.storySource)&&(identical(other.minVotesPerSubmission, _this.minVotesPerSubmission) || other.minVotesPerSubmission == _this.minVotesPerSubmission)&&(identical(other.claimWindowHours, _this.claimWindowHours) || other.claimWindowHours == _this.claimWindowHours)&&(identical(other.awardAllMissionCompleters, _this.awardAllMissionCompleters) || other.awardAllMissionCompleters == _this.awardAllMissionCompleters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as EventActivityDto;
  return Object.hash(runtimeType,_this.id,_this.activityType,_this.allowedAudience,_this.registrationStartAt,_this.registrationEndAt,_this.startAt,_this.endAt,_this.reviewCutoffAt,_this.grantAiCredits,_this.maxSubmissionsPerUser,_this.maxRegistrations,_this.waiveWeeklyLibraryLimit,_this.storySource,_this.minVotesPerSubmission,_this.claimWindowHours,_this.awardAllMissionCompleters);
}

@override
String toString() {
  final _this = this as EventActivityDto;
  return 'EventActivityDto(id: ${_this.id}, activityType: ${_this.activityType}, allowedAudience: ${_this.allowedAudience}, registrationStartAt: ${_this.registrationStartAt}, registrationEndAt: ${_this.registrationEndAt}, startAt: ${_this.startAt}, endAt: ${_this.endAt}, reviewCutoffAt: ${_this.reviewCutoffAt}, grantAiCredits: ${_this.grantAiCredits}, maxSubmissionsPerUser: ${_this.maxSubmissionsPerUser}, maxRegistrations: ${_this.maxRegistrations}, waiveWeeklyLibraryLimit: ${_this.waiveWeeklyLibraryLimit}, storySource: ${_this.storySource}, minVotesPerSubmission: ${_this.minVotesPerSubmission}, claimWindowHours: ${_this.claimWindowHours}, awardAllMissionCompleters: ${_this.awardAllMissionCompleters})';
}


}

/// @nodoc
abstract mixin class $EventActivityDtoCopyWith<$Res>  {
  factory $EventActivityDtoCopyWith(EventActivityDto value, $Res Function(EventActivityDto) _then) = _$EventActivityDtoCopyWithImpl;
@useResult
$Res call({
 int id, String activityType, String allowedAudience, DateTime? registrationStartAt, DateTime? registrationEndAt, DateTime? startAt, DateTime? endAt, DateTime? reviewCutoffAt, int grantAiCredits, int? maxSubmissionsPerUser, int? maxRegistrations, bool waiveWeeklyLibraryLimit, String storySource, int minVotesPerSubmission, int claimWindowHours, bool awardAllMissionCompleters
});




}
/// @nodoc
class _$EventActivityDtoCopyWithImpl<$Res>
    implements $EventActivityDtoCopyWith<$Res> {
  _$EventActivityDtoCopyWithImpl(this._self, this._then);

  final EventActivityDto _self;
  final $Res Function(EventActivityDto) _then;

/// Create a copy of EventActivityDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? activityType = null,Object? allowedAudience = null,Object? registrationStartAt = freezed,Object? registrationEndAt = freezed,Object? startAt = freezed,Object? endAt = freezed,Object? reviewCutoffAt = freezed,Object? grantAiCredits = null,Object? maxSubmissionsPerUser = freezed,Object? maxRegistrations = freezed,Object? waiveWeeklyLibraryLimit = null,Object? storySource = null,Object? minVotesPerSubmission = null,Object? claimWindowHours = null,Object? awardAllMissionCompleters = null,}) {
  return _then(EventActivityDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,activityType: null == activityType ? _self.activityType : activityType // ignore: cast_nullable_to_non_nullable
as String,allowedAudience: null == allowedAudience ? _self.allowedAudience : allowedAudience // ignore: cast_nullable_to_non_nullable
as String,registrationStartAt: freezed == registrationStartAt ? _self.registrationStartAt : registrationStartAt // ignore: cast_nullable_to_non_nullable
as DateTime?,registrationEndAt: freezed == registrationEndAt ? _self.registrationEndAt : registrationEndAt // ignore: cast_nullable_to_non_nullable
as DateTime?,startAt: freezed == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as DateTime?,endAt: freezed == endAt ? _self.endAt : endAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reviewCutoffAt: freezed == reviewCutoffAt ? _self.reviewCutoffAt : reviewCutoffAt // ignore: cast_nullable_to_non_nullable
as DateTime?,grantAiCredits: null == grantAiCredits ? _self.grantAiCredits : grantAiCredits // ignore: cast_nullable_to_non_nullable
as int,maxSubmissionsPerUser: freezed == maxSubmissionsPerUser ? _self.maxSubmissionsPerUser : maxSubmissionsPerUser // ignore: cast_nullable_to_non_nullable
as int?,maxRegistrations: freezed == maxRegistrations ? _self.maxRegistrations : maxRegistrations // ignore: cast_nullable_to_non_nullable
as int?,waiveWeeklyLibraryLimit: null == waiveWeeklyLibraryLimit ? _self.waiveWeeklyLibraryLimit : waiveWeeklyLibraryLimit // ignore: cast_nullable_to_non_nullable
as bool,storySource: null == storySource ? _self.storySource : storySource // ignore: cast_nullable_to_non_nullable
as String,minVotesPerSubmission: null == minVotesPerSubmission ? _self.minVotesPerSubmission : minVotesPerSubmission // ignore: cast_nullable_to_non_nullable
as int,claimWindowHours: null == claimWindowHours ? _self.claimWindowHours : claimWindowHours // ignore: cast_nullable_to_non_nullable
as int,awardAllMissionCompleters: null == awardAllMissionCompleters ? _self.awardAllMissionCompleters : awardAllMissionCompleters // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [EventActivityDto].
extension EventActivityDtoPatterns on EventActivityDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventActivityDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventActivityDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventActivityDto value)  $default,){
final _that = this;
switch (_that) {
case _EventActivityDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventActivityDto value)?  $default,){
final _that = this;
switch (_that) {
case _EventActivityDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String activityType,  String allowedAudience,  DateTime? registrationStartAt,  DateTime? registrationEndAt,  DateTime? startAt,  DateTime? endAt,  DateTime? reviewCutoffAt,  int grantAiCredits,  int? maxSubmissionsPerUser,  int? maxRegistrations,  bool waiveWeeklyLibraryLimit,  String storySource,  int minVotesPerSubmission,  int claimWindowHours,  bool awardAllMissionCompleters)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventActivityDto() when $default != null:
return $default(_that.id,_that.activityType,_that.allowedAudience,_that.registrationStartAt,_that.registrationEndAt,_that.startAt,_that.endAt,_that.reviewCutoffAt,_that.grantAiCredits,_that.maxSubmissionsPerUser,_that.maxRegistrations,_that.waiveWeeklyLibraryLimit,_that.storySource,_that.minVotesPerSubmission,_that.claimWindowHours,_that.awardAllMissionCompleters);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String activityType,  String allowedAudience,  DateTime? registrationStartAt,  DateTime? registrationEndAt,  DateTime? startAt,  DateTime? endAt,  DateTime? reviewCutoffAt,  int grantAiCredits,  int? maxSubmissionsPerUser,  int? maxRegistrations,  bool waiveWeeklyLibraryLimit,  String storySource,  int minVotesPerSubmission,  int claimWindowHours,  bool awardAllMissionCompleters)  $default,) {final _that = this;
switch (_that) {
case _EventActivityDto():
return $default(_that.id,_that.activityType,_that.allowedAudience,_that.registrationStartAt,_that.registrationEndAt,_that.startAt,_that.endAt,_that.reviewCutoffAt,_that.grantAiCredits,_that.maxSubmissionsPerUser,_that.maxRegistrations,_that.waiveWeeklyLibraryLimit,_that.storySource,_that.minVotesPerSubmission,_that.claimWindowHours,_that.awardAllMissionCompleters);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String activityType,  String allowedAudience,  DateTime? registrationStartAt,  DateTime? registrationEndAt,  DateTime? startAt,  DateTime? endAt,  DateTime? reviewCutoffAt,  int grantAiCredits,  int? maxSubmissionsPerUser,  int? maxRegistrations,  bool waiveWeeklyLibraryLimit,  String storySource,  int minVotesPerSubmission,  int claimWindowHours,  bool awardAllMissionCompleters)?  $default,) {final _that = this;
switch (_that) {
case _EventActivityDto() when $default != null:
return $default(_that.id,_that.activityType,_that.allowedAudience,_that.registrationStartAt,_that.registrationEndAt,_that.startAt,_that.endAt,_that.reviewCutoffAt,_that.grantAiCredits,_that.maxSubmissionsPerUser,_that.maxRegistrations,_that.waiveWeeklyLibraryLimit,_that.storySource,_that.minVotesPerSubmission,_that.claimWindowHours,_that.awardAllMissionCompleters);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventActivityDto implements EventActivityDto {
  const _EventActivityDto({required this.id, this.activityType = '', this.allowedAudience = '', this.registrationStartAt, this.registrationEndAt, this.startAt, this.endAt, this.reviewCutoffAt, this.grantAiCredits = 0, this.maxSubmissionsPerUser, this.maxRegistrations, this.waiveWeeklyLibraryLimit = false, this.storySource = '', this.minVotesPerSubmission = 0, this.claimWindowHours = 0, this.awardAllMissionCompleters = false});
  factory _EventActivityDto.fromJson(Map<String, dynamic> json) => _$EventActivityDtoFromJson(json);

@override final  int id;
@override@JsonKey() final  String activityType;
@override@JsonKey() final  String allowedAudience;
@override final  DateTime? registrationStartAt;
@override final  DateTime? registrationEndAt;
@override final  DateTime? startAt;
@override final  DateTime? endAt;
@override final  DateTime? reviewCutoffAt;
@override@JsonKey() final  int grantAiCredits;
@override final  int? maxSubmissionsPerUser;
@override final  int? maxRegistrations;
@override@JsonKey() final  bool waiveWeeklyLibraryLimit;
@override@JsonKey() final  String storySource;
@override@JsonKey() final  int minVotesPerSubmission;
@override@JsonKey() final  int claimWindowHours;
@override@JsonKey() final  bool awardAllMissionCompleters;

/// Create a copy of EventActivityDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventActivityDtoCopyWith<_EventActivityDto> get copyWith => __$EventActivityDtoCopyWithImpl<_EventActivityDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventActivityDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventActivityDto&&(identical(other.id, id) || other.id == id)&&(identical(other.activityType, activityType) || other.activityType == activityType)&&(identical(other.allowedAudience, allowedAudience) || other.allowedAudience == allowedAudience)&&(identical(other.registrationStartAt, registrationStartAt) || other.registrationStartAt == registrationStartAt)&&(identical(other.registrationEndAt, registrationEndAt) || other.registrationEndAt == registrationEndAt)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.endAt, endAt) || other.endAt == endAt)&&(identical(other.reviewCutoffAt, reviewCutoffAt) || other.reviewCutoffAt == reviewCutoffAt)&&(identical(other.grantAiCredits, grantAiCredits) || other.grantAiCredits == grantAiCredits)&&(identical(other.maxSubmissionsPerUser, maxSubmissionsPerUser) || other.maxSubmissionsPerUser == maxSubmissionsPerUser)&&(identical(other.maxRegistrations, maxRegistrations) || other.maxRegistrations == maxRegistrations)&&(identical(other.waiveWeeklyLibraryLimit, waiveWeeklyLibraryLimit) || other.waiveWeeklyLibraryLimit == waiveWeeklyLibraryLimit)&&(identical(other.storySource, storySource) || other.storySource == storySource)&&(identical(other.minVotesPerSubmission, minVotesPerSubmission) || other.minVotesPerSubmission == minVotesPerSubmission)&&(identical(other.claimWindowHours, claimWindowHours) || other.claimWindowHours == claimWindowHours)&&(identical(other.awardAllMissionCompleters, awardAllMissionCompleters) || other.awardAllMissionCompleters == awardAllMissionCompleters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,activityType,allowedAudience,registrationStartAt,registrationEndAt,startAt,endAt,reviewCutoffAt,grantAiCredits,maxSubmissionsPerUser,maxRegistrations,waiveWeeklyLibraryLimit,storySource,minVotesPerSubmission,claimWindowHours,awardAllMissionCompleters);
}

@override
String toString() {
    return 'EventActivityDto(id: $id, activityType: $activityType, allowedAudience: $allowedAudience, registrationStartAt: $registrationStartAt, registrationEndAt: $registrationEndAt, startAt: $startAt, endAt: $endAt, reviewCutoffAt: $reviewCutoffAt, grantAiCredits: $grantAiCredits, maxSubmissionsPerUser: $maxSubmissionsPerUser, maxRegistrations: $maxRegistrations, waiveWeeklyLibraryLimit: $waiveWeeklyLibraryLimit, storySource: $storySource, minVotesPerSubmission: $minVotesPerSubmission, claimWindowHours: $claimWindowHours, awardAllMissionCompleters: $awardAllMissionCompleters)';
}


}

/// @nodoc
abstract mixin class _$EventActivityDtoCopyWith<$Res> implements $EventActivityDtoCopyWith<$Res> {
  factory _$EventActivityDtoCopyWith(_EventActivityDto value, $Res Function(_EventActivityDto) _then) = __$EventActivityDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String activityType, String allowedAudience, DateTime? registrationStartAt, DateTime? registrationEndAt, DateTime? startAt, DateTime? endAt, DateTime? reviewCutoffAt, int grantAiCredits, int? maxSubmissionsPerUser, int? maxRegistrations, bool waiveWeeklyLibraryLimit, String storySource, int minVotesPerSubmission, int claimWindowHours, bool awardAllMissionCompleters
});




}
/// @nodoc
class __$EventActivityDtoCopyWithImpl<$Res>
    implements _$EventActivityDtoCopyWith<$Res> {
  __$EventActivityDtoCopyWithImpl(this._self, this._then);

  final _EventActivityDto _self;
  final $Res Function(_EventActivityDto) _then;

/// Create a copy of EventActivityDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? activityType = null,Object? allowedAudience = null,Object? registrationStartAt = freezed,Object? registrationEndAt = freezed,Object? startAt = freezed,Object? endAt = freezed,Object? reviewCutoffAt = freezed,Object? grantAiCredits = null,Object? maxSubmissionsPerUser = freezed,Object? maxRegistrations = freezed,Object? waiveWeeklyLibraryLimit = null,Object? storySource = null,Object? minVotesPerSubmission = null,Object? claimWindowHours = null,Object? awardAllMissionCompleters = null,}) {
  return _then(_EventActivityDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,activityType: null == activityType ? _self.activityType : activityType // ignore: cast_nullable_to_non_nullable
as String,allowedAudience: null == allowedAudience ? _self.allowedAudience : allowedAudience // ignore: cast_nullable_to_non_nullable
as String,registrationStartAt: freezed == registrationStartAt ? _self.registrationStartAt : registrationStartAt // ignore: cast_nullable_to_non_nullable
as DateTime?,registrationEndAt: freezed == registrationEndAt ? _self.registrationEndAt : registrationEndAt // ignore: cast_nullable_to_non_nullable
as DateTime?,startAt: freezed == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as DateTime?,endAt: freezed == endAt ? _self.endAt : endAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reviewCutoffAt: freezed == reviewCutoffAt ? _self.reviewCutoffAt : reviewCutoffAt // ignore: cast_nullable_to_non_nullable
as DateTime?,grantAiCredits: null == grantAiCredits ? _self.grantAiCredits : grantAiCredits // ignore: cast_nullable_to_non_nullable
as int,maxSubmissionsPerUser: freezed == maxSubmissionsPerUser ? _self.maxSubmissionsPerUser : maxSubmissionsPerUser // ignore: cast_nullable_to_non_nullable
as int?,maxRegistrations: freezed == maxRegistrations ? _self.maxRegistrations : maxRegistrations // ignore: cast_nullable_to_non_nullable
as int?,waiveWeeklyLibraryLimit: null == waiveWeeklyLibraryLimit ? _self.waiveWeeklyLibraryLimit : waiveWeeklyLibraryLimit // ignore: cast_nullable_to_non_nullable
as bool,storySource: null == storySource ? _self.storySource : storySource // ignore: cast_nullable_to_non_nullable
as String,minVotesPerSubmission: null == minVotesPerSubmission ? _self.minVotesPerSubmission : minVotesPerSubmission // ignore: cast_nullable_to_non_nullable
as int,claimWindowHours: null == claimWindowHours ? _self.claimWindowHours : claimWindowHours // ignore: cast_nullable_to_non_nullable
as int,awardAllMissionCompleters: null == awardAllMissionCompleters ? _self.awardAllMissionCompleters : awardAllMissionCompleters // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$EventActivityUserStateDto {

 int get activityId; String get activityType; String get allowedAudience;/// NotOpen | Open | Ended
 String get lifecycleStatus; bool get isEligible; bool get isRegistered; int? get participationId; String? get participationStatus; DateTime? get appealDeadlineAt; bool get canRegister; bool get canSubmit; bool get canDoMissions; bool get canVote; int get submissionsCount; int? get maxSubmissionsPerUser;
/// Create a copy of EventActivityUserStateDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventActivityUserStateDtoCopyWith<EventActivityUserStateDto> get copyWith => _$EventActivityUserStateDtoCopyWithImpl<EventActivityUserStateDto>(this as EventActivityUserStateDto, _$identity);

  /// Serializes this EventActivityUserStateDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as EventActivityUserStateDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventActivityUserStateDto&&(identical(other.activityId, _this.activityId) || other.activityId == _this.activityId)&&(identical(other.activityType, _this.activityType) || other.activityType == _this.activityType)&&(identical(other.allowedAudience, _this.allowedAudience) || other.allowedAudience == _this.allowedAudience)&&(identical(other.lifecycleStatus, _this.lifecycleStatus) || other.lifecycleStatus == _this.lifecycleStatus)&&(identical(other.isEligible, _this.isEligible) || other.isEligible == _this.isEligible)&&(identical(other.isRegistered, _this.isRegistered) || other.isRegistered == _this.isRegistered)&&(identical(other.participationId, _this.participationId) || other.participationId == _this.participationId)&&(identical(other.participationStatus, _this.participationStatus) || other.participationStatus == _this.participationStatus)&&(identical(other.appealDeadlineAt, _this.appealDeadlineAt) || other.appealDeadlineAt == _this.appealDeadlineAt)&&(identical(other.canRegister, _this.canRegister) || other.canRegister == _this.canRegister)&&(identical(other.canSubmit, _this.canSubmit) || other.canSubmit == _this.canSubmit)&&(identical(other.canDoMissions, _this.canDoMissions) || other.canDoMissions == _this.canDoMissions)&&(identical(other.canVote, _this.canVote) || other.canVote == _this.canVote)&&(identical(other.submissionsCount, _this.submissionsCount) || other.submissionsCount == _this.submissionsCount)&&(identical(other.maxSubmissionsPerUser, _this.maxSubmissionsPerUser) || other.maxSubmissionsPerUser == _this.maxSubmissionsPerUser));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as EventActivityUserStateDto;
  return Object.hash(runtimeType,_this.activityId,_this.activityType,_this.allowedAudience,_this.lifecycleStatus,_this.isEligible,_this.isRegistered,_this.participationId,_this.participationStatus,_this.appealDeadlineAt,_this.canRegister,_this.canSubmit,_this.canDoMissions,_this.canVote,_this.submissionsCount,_this.maxSubmissionsPerUser);
}

@override
String toString() {
  final _this = this as EventActivityUserStateDto;
  return 'EventActivityUserStateDto(activityId: ${_this.activityId}, activityType: ${_this.activityType}, allowedAudience: ${_this.allowedAudience}, lifecycleStatus: ${_this.lifecycleStatus}, isEligible: ${_this.isEligible}, isRegistered: ${_this.isRegistered}, participationId: ${_this.participationId}, participationStatus: ${_this.participationStatus}, appealDeadlineAt: ${_this.appealDeadlineAt}, canRegister: ${_this.canRegister}, canSubmit: ${_this.canSubmit}, canDoMissions: ${_this.canDoMissions}, canVote: ${_this.canVote}, submissionsCount: ${_this.submissionsCount}, maxSubmissionsPerUser: ${_this.maxSubmissionsPerUser})';
}


}

/// @nodoc
abstract mixin class $EventActivityUserStateDtoCopyWith<$Res>  {
  factory $EventActivityUserStateDtoCopyWith(EventActivityUserStateDto value, $Res Function(EventActivityUserStateDto) _then) = _$EventActivityUserStateDtoCopyWithImpl;
@useResult
$Res call({
 int activityId, String activityType, String allowedAudience, String lifecycleStatus, bool isEligible, bool isRegistered, int? participationId, String? participationStatus, DateTime? appealDeadlineAt, bool canRegister, bool canSubmit, bool canDoMissions, bool canVote, int submissionsCount, int? maxSubmissionsPerUser
});




}
/// @nodoc
class _$EventActivityUserStateDtoCopyWithImpl<$Res>
    implements $EventActivityUserStateDtoCopyWith<$Res> {
  _$EventActivityUserStateDtoCopyWithImpl(this._self, this._then);

  final EventActivityUserStateDto _self;
  final $Res Function(EventActivityUserStateDto) _then;

/// Create a copy of EventActivityUserStateDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? activityId = null,Object? activityType = null,Object? allowedAudience = null,Object? lifecycleStatus = null,Object? isEligible = null,Object? isRegistered = null,Object? participationId = freezed,Object? participationStatus = freezed,Object? appealDeadlineAt = freezed,Object? canRegister = null,Object? canSubmit = null,Object? canDoMissions = null,Object? canVote = null,Object? submissionsCount = null,Object? maxSubmissionsPerUser = freezed,}) {
  return _then(EventActivityUserStateDto(
activityId: null == activityId ? _self.activityId : activityId // ignore: cast_nullable_to_non_nullable
as int,activityType: null == activityType ? _self.activityType : activityType // ignore: cast_nullable_to_non_nullable
as String,allowedAudience: null == allowedAudience ? _self.allowedAudience : allowedAudience // ignore: cast_nullable_to_non_nullable
as String,lifecycleStatus: null == lifecycleStatus ? _self.lifecycleStatus : lifecycleStatus // ignore: cast_nullable_to_non_nullable
as String,isEligible: null == isEligible ? _self.isEligible : isEligible // ignore: cast_nullable_to_non_nullable
as bool,isRegistered: null == isRegistered ? _self.isRegistered : isRegistered // ignore: cast_nullable_to_non_nullable
as bool,participationId: freezed == participationId ? _self.participationId : participationId // ignore: cast_nullable_to_non_nullable
as int?,participationStatus: freezed == participationStatus ? _self.participationStatus : participationStatus // ignore: cast_nullable_to_non_nullable
as String?,appealDeadlineAt: freezed == appealDeadlineAt ? _self.appealDeadlineAt : appealDeadlineAt // ignore: cast_nullable_to_non_nullable
as DateTime?,canRegister: null == canRegister ? _self.canRegister : canRegister // ignore: cast_nullable_to_non_nullable
as bool,canSubmit: null == canSubmit ? _self.canSubmit : canSubmit // ignore: cast_nullable_to_non_nullable
as bool,canDoMissions: null == canDoMissions ? _self.canDoMissions : canDoMissions // ignore: cast_nullable_to_non_nullable
as bool,canVote: null == canVote ? _self.canVote : canVote // ignore: cast_nullable_to_non_nullable
as bool,submissionsCount: null == submissionsCount ? _self.submissionsCount : submissionsCount // ignore: cast_nullable_to_non_nullable
as int,maxSubmissionsPerUser: freezed == maxSubmissionsPerUser ? _self.maxSubmissionsPerUser : maxSubmissionsPerUser // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [EventActivityUserStateDto].
extension EventActivityUserStateDtoPatterns on EventActivityUserStateDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventActivityUserStateDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventActivityUserStateDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventActivityUserStateDto value)  $default,){
final _that = this;
switch (_that) {
case _EventActivityUserStateDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventActivityUserStateDto value)?  $default,){
final _that = this;
switch (_that) {
case _EventActivityUserStateDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int activityId,  String activityType,  String allowedAudience,  String lifecycleStatus,  bool isEligible,  bool isRegistered,  int? participationId,  String? participationStatus,  DateTime? appealDeadlineAt,  bool canRegister,  bool canSubmit,  bool canDoMissions,  bool canVote,  int submissionsCount,  int? maxSubmissionsPerUser)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventActivityUserStateDto() when $default != null:
return $default(_that.activityId,_that.activityType,_that.allowedAudience,_that.lifecycleStatus,_that.isEligible,_that.isRegistered,_that.participationId,_that.participationStatus,_that.appealDeadlineAt,_that.canRegister,_that.canSubmit,_that.canDoMissions,_that.canVote,_that.submissionsCount,_that.maxSubmissionsPerUser);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int activityId,  String activityType,  String allowedAudience,  String lifecycleStatus,  bool isEligible,  bool isRegistered,  int? participationId,  String? participationStatus,  DateTime? appealDeadlineAt,  bool canRegister,  bool canSubmit,  bool canDoMissions,  bool canVote,  int submissionsCount,  int? maxSubmissionsPerUser)  $default,) {final _that = this;
switch (_that) {
case _EventActivityUserStateDto():
return $default(_that.activityId,_that.activityType,_that.allowedAudience,_that.lifecycleStatus,_that.isEligible,_that.isRegistered,_that.participationId,_that.participationStatus,_that.appealDeadlineAt,_that.canRegister,_that.canSubmit,_that.canDoMissions,_that.canVote,_that.submissionsCount,_that.maxSubmissionsPerUser);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int activityId,  String activityType,  String allowedAudience,  String lifecycleStatus,  bool isEligible,  bool isRegistered,  int? participationId,  String? participationStatus,  DateTime? appealDeadlineAt,  bool canRegister,  bool canSubmit,  bool canDoMissions,  bool canVote,  int submissionsCount,  int? maxSubmissionsPerUser)?  $default,) {final _that = this;
switch (_that) {
case _EventActivityUserStateDto() when $default != null:
return $default(_that.activityId,_that.activityType,_that.allowedAudience,_that.lifecycleStatus,_that.isEligible,_that.isRegistered,_that.participationId,_that.participationStatus,_that.appealDeadlineAt,_that.canRegister,_that.canSubmit,_that.canDoMissions,_that.canVote,_that.submissionsCount,_that.maxSubmissionsPerUser);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventActivityUserStateDto implements EventActivityUserStateDto {
  const _EventActivityUserStateDto({required this.activityId, this.activityType = '', this.allowedAudience = '', this.lifecycleStatus = 'NotOpen', this.isEligible = false, this.isRegistered = false, this.participationId, this.participationStatus, this.appealDeadlineAt, this.canRegister = false, this.canSubmit = false, this.canDoMissions = false, this.canVote = false, this.submissionsCount = 0, this.maxSubmissionsPerUser});
  factory _EventActivityUserStateDto.fromJson(Map<String, dynamic> json) => _$EventActivityUserStateDtoFromJson(json);

@override final  int activityId;
@override@JsonKey() final  String activityType;
@override@JsonKey() final  String allowedAudience;
/// NotOpen | Open | Ended
@override@JsonKey() final  String lifecycleStatus;
@override@JsonKey() final  bool isEligible;
@override@JsonKey() final  bool isRegistered;
@override final  int? participationId;
@override final  String? participationStatus;
@override final  DateTime? appealDeadlineAt;
@override@JsonKey() final  bool canRegister;
@override@JsonKey() final  bool canSubmit;
@override@JsonKey() final  bool canDoMissions;
@override@JsonKey() final  bool canVote;
@override@JsonKey() final  int submissionsCount;
@override final  int? maxSubmissionsPerUser;

/// Create a copy of EventActivityUserStateDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventActivityUserStateDtoCopyWith<_EventActivityUserStateDto> get copyWith => __$EventActivityUserStateDtoCopyWithImpl<_EventActivityUserStateDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventActivityUserStateDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventActivityUserStateDto&&(identical(other.activityId, activityId) || other.activityId == activityId)&&(identical(other.activityType, activityType) || other.activityType == activityType)&&(identical(other.allowedAudience, allowedAudience) || other.allowedAudience == allowedAudience)&&(identical(other.lifecycleStatus, lifecycleStatus) || other.lifecycleStatus == lifecycleStatus)&&(identical(other.isEligible, isEligible) || other.isEligible == isEligible)&&(identical(other.isRegistered, isRegistered) || other.isRegistered == isRegistered)&&(identical(other.participationId, participationId) || other.participationId == participationId)&&(identical(other.participationStatus, participationStatus) || other.participationStatus == participationStatus)&&(identical(other.appealDeadlineAt, appealDeadlineAt) || other.appealDeadlineAt == appealDeadlineAt)&&(identical(other.canRegister, canRegister) || other.canRegister == canRegister)&&(identical(other.canSubmit, canSubmit) || other.canSubmit == canSubmit)&&(identical(other.canDoMissions, canDoMissions) || other.canDoMissions == canDoMissions)&&(identical(other.canVote, canVote) || other.canVote == canVote)&&(identical(other.submissionsCount, submissionsCount) || other.submissionsCount == submissionsCount)&&(identical(other.maxSubmissionsPerUser, maxSubmissionsPerUser) || other.maxSubmissionsPerUser == maxSubmissionsPerUser));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,activityId,activityType,allowedAudience,lifecycleStatus,isEligible,isRegistered,participationId,participationStatus,appealDeadlineAt,canRegister,canSubmit,canDoMissions,canVote,submissionsCount,maxSubmissionsPerUser);
}

@override
String toString() {
    return 'EventActivityUserStateDto(activityId: $activityId, activityType: $activityType, allowedAudience: $allowedAudience, lifecycleStatus: $lifecycleStatus, isEligible: $isEligible, isRegistered: $isRegistered, participationId: $participationId, participationStatus: $participationStatus, appealDeadlineAt: $appealDeadlineAt, canRegister: $canRegister, canSubmit: $canSubmit, canDoMissions: $canDoMissions, canVote: $canVote, submissionsCount: $submissionsCount, maxSubmissionsPerUser: $maxSubmissionsPerUser)';
}


}

/// @nodoc
abstract mixin class _$EventActivityUserStateDtoCopyWith<$Res> implements $EventActivityUserStateDtoCopyWith<$Res> {
  factory _$EventActivityUserStateDtoCopyWith(_EventActivityUserStateDto value, $Res Function(_EventActivityUserStateDto) _then) = __$EventActivityUserStateDtoCopyWithImpl;
@override @useResult
$Res call({
 int activityId, String activityType, String allowedAudience, String lifecycleStatus, bool isEligible, bool isRegistered, int? participationId, String? participationStatus, DateTime? appealDeadlineAt, bool canRegister, bool canSubmit, bool canDoMissions, bool canVote, int submissionsCount, int? maxSubmissionsPerUser
});




}
/// @nodoc
class __$EventActivityUserStateDtoCopyWithImpl<$Res>
    implements _$EventActivityUserStateDtoCopyWith<$Res> {
  __$EventActivityUserStateDtoCopyWithImpl(this._self, this._then);

  final _EventActivityUserStateDto _self;
  final $Res Function(_EventActivityUserStateDto) _then;

/// Create a copy of EventActivityUserStateDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? activityId = null,Object? activityType = null,Object? allowedAudience = null,Object? lifecycleStatus = null,Object? isEligible = null,Object? isRegistered = null,Object? participationId = freezed,Object? participationStatus = freezed,Object? appealDeadlineAt = freezed,Object? canRegister = null,Object? canSubmit = null,Object? canDoMissions = null,Object? canVote = null,Object? submissionsCount = null,Object? maxSubmissionsPerUser = freezed,}) {
  return _then(_EventActivityUserStateDto(
activityId: null == activityId ? _self.activityId : activityId // ignore: cast_nullable_to_non_nullable
as int,activityType: null == activityType ? _self.activityType : activityType // ignore: cast_nullable_to_non_nullable
as String,allowedAudience: null == allowedAudience ? _self.allowedAudience : allowedAudience // ignore: cast_nullable_to_non_nullable
as String,lifecycleStatus: null == lifecycleStatus ? _self.lifecycleStatus : lifecycleStatus // ignore: cast_nullable_to_non_nullable
as String,isEligible: null == isEligible ? _self.isEligible : isEligible // ignore: cast_nullable_to_non_nullable
as bool,isRegistered: null == isRegistered ? _self.isRegistered : isRegistered // ignore: cast_nullable_to_non_nullable
as bool,participationId: freezed == participationId ? _self.participationId : participationId // ignore: cast_nullable_to_non_nullable
as int?,participationStatus: freezed == participationStatus ? _self.participationStatus : participationStatus // ignore: cast_nullable_to_non_nullable
as String?,appealDeadlineAt: freezed == appealDeadlineAt ? _self.appealDeadlineAt : appealDeadlineAt // ignore: cast_nullable_to_non_nullable
as DateTime?,canRegister: null == canRegister ? _self.canRegister : canRegister // ignore: cast_nullable_to_non_nullable
as bool,canSubmit: null == canSubmit ? _self.canSubmit : canSubmit // ignore: cast_nullable_to_non_nullable
as bool,canDoMissions: null == canDoMissions ? _self.canDoMissions : canDoMissions // ignore: cast_nullable_to_non_nullable
as bool,canVote: null == canVote ? _self.canVote : canVote // ignore: cast_nullable_to_non_nullable
as bool,submissionsCount: null == submissionsCount ? _self.submissionsCount : submissionsCount // ignore: cast_nullable_to_non_nullable
as int,maxSubmissionsPerUser: freezed == maxSubmissionsPerUser ? _self.maxSubmissionsPerUser : maxSubmissionsPerUser // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$EventRuleVersionDto {

 int get id; int get versionNo; String get rulesText; String? get rewardEligibilityText; String get completionMode; int? get requiredTaskCount; int? get requiredPoints; bool get isActive; List<EventTaskDefinitionDto> get tasks;
/// Create a copy of EventRuleVersionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventRuleVersionDtoCopyWith<EventRuleVersionDto> get copyWith => _$EventRuleVersionDtoCopyWithImpl<EventRuleVersionDto>(this as EventRuleVersionDto, _$identity);

  /// Serializes this EventRuleVersionDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as EventRuleVersionDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventRuleVersionDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.versionNo, _this.versionNo) || other.versionNo == _this.versionNo)&&(identical(other.rulesText, _this.rulesText) || other.rulesText == _this.rulesText)&&(identical(other.rewardEligibilityText, _this.rewardEligibilityText) || other.rewardEligibilityText == _this.rewardEligibilityText)&&(identical(other.completionMode, _this.completionMode) || other.completionMode == _this.completionMode)&&(identical(other.requiredTaskCount, _this.requiredTaskCount) || other.requiredTaskCount == _this.requiredTaskCount)&&(identical(other.requiredPoints, _this.requiredPoints) || other.requiredPoints == _this.requiredPoints)&&(identical(other.isActive, _this.isActive) || other.isActive == _this.isActive)&&const DeepCollectionEquality().equals(other.tasks, _this.tasks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as EventRuleVersionDto;
  return Object.hash(runtimeType,_this.id,_this.versionNo,_this.rulesText,_this.rewardEligibilityText,_this.completionMode,_this.requiredTaskCount,_this.requiredPoints,_this.isActive,const DeepCollectionEquality().hash(_this.tasks));
}

@override
String toString() {
  final _this = this as EventRuleVersionDto;
  return 'EventRuleVersionDto(id: ${_this.id}, versionNo: ${_this.versionNo}, rulesText: ${_this.rulesText}, rewardEligibilityText: ${_this.rewardEligibilityText}, completionMode: ${_this.completionMode}, requiredTaskCount: ${_this.requiredTaskCount}, requiredPoints: ${_this.requiredPoints}, isActive: ${_this.isActive}, tasks: ${_this.tasks})';
}


}

/// @nodoc
abstract mixin class $EventRuleVersionDtoCopyWith<$Res>  {
  factory $EventRuleVersionDtoCopyWith(EventRuleVersionDto value, $Res Function(EventRuleVersionDto) _then) = _$EventRuleVersionDtoCopyWithImpl;
@useResult
$Res call({
 int id, int versionNo, String rulesText, String? rewardEligibilityText, String completionMode, int? requiredTaskCount, int? requiredPoints, bool isActive, List<EventTaskDefinitionDto> tasks
});




}
/// @nodoc
class _$EventRuleVersionDtoCopyWithImpl<$Res>
    implements $EventRuleVersionDtoCopyWith<$Res> {
  _$EventRuleVersionDtoCopyWithImpl(this._self, this._then);

  final EventRuleVersionDto _self;
  final $Res Function(EventRuleVersionDto) _then;

/// Create a copy of EventRuleVersionDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? versionNo = null,Object? rulesText = null,Object? rewardEligibilityText = freezed,Object? completionMode = null,Object? requiredTaskCount = freezed,Object? requiredPoints = freezed,Object? isActive = null,Object? tasks = null,}) {
  return _then(EventRuleVersionDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,versionNo: null == versionNo ? _self.versionNo : versionNo // ignore: cast_nullable_to_non_nullable
as int,rulesText: null == rulesText ? _self.rulesText : rulesText // ignore: cast_nullable_to_non_nullable
as String,rewardEligibilityText: freezed == rewardEligibilityText ? _self.rewardEligibilityText : rewardEligibilityText // ignore: cast_nullable_to_non_nullable
as String?,completionMode: null == completionMode ? _self.completionMode : completionMode // ignore: cast_nullable_to_non_nullable
as String,requiredTaskCount: freezed == requiredTaskCount ? _self.requiredTaskCount : requiredTaskCount // ignore: cast_nullable_to_non_nullable
as int?,requiredPoints: freezed == requiredPoints ? _self.requiredPoints : requiredPoints // ignore: cast_nullable_to_non_nullable
as int?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,tasks: null == tasks ? _self.tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<EventTaskDefinitionDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [EventRuleVersionDto].
extension EventRuleVersionDtoPatterns on EventRuleVersionDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventRuleVersionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventRuleVersionDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventRuleVersionDto value)  $default,){
final _that = this;
switch (_that) {
case _EventRuleVersionDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventRuleVersionDto value)?  $default,){
final _that = this;
switch (_that) {
case _EventRuleVersionDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int versionNo,  String rulesText,  String? rewardEligibilityText,  String completionMode,  int? requiredTaskCount,  int? requiredPoints,  bool isActive,  List<EventTaskDefinitionDto> tasks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventRuleVersionDto() when $default != null:
return $default(_that.id,_that.versionNo,_that.rulesText,_that.rewardEligibilityText,_that.completionMode,_that.requiredTaskCount,_that.requiredPoints,_that.isActive,_that.tasks);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int versionNo,  String rulesText,  String? rewardEligibilityText,  String completionMode,  int? requiredTaskCount,  int? requiredPoints,  bool isActive,  List<EventTaskDefinitionDto> tasks)  $default,) {final _that = this;
switch (_that) {
case _EventRuleVersionDto():
return $default(_that.id,_that.versionNo,_that.rulesText,_that.rewardEligibilityText,_that.completionMode,_that.requiredTaskCount,_that.requiredPoints,_that.isActive,_that.tasks);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int versionNo,  String rulesText,  String? rewardEligibilityText,  String completionMode,  int? requiredTaskCount,  int? requiredPoints,  bool isActive,  List<EventTaskDefinitionDto> tasks)?  $default,) {final _that = this;
switch (_that) {
case _EventRuleVersionDto() when $default != null:
return $default(_that.id,_that.versionNo,_that.rulesText,_that.rewardEligibilityText,_that.completionMode,_that.requiredTaskCount,_that.requiredPoints,_that.isActive,_that.tasks);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventRuleVersionDto implements EventRuleVersionDto {
  const _EventRuleVersionDto({required this.id, this.versionNo = 0, this.rulesText = '', this.rewardEligibilityText, this.completionMode = '', this.requiredTaskCount, this.requiredPoints, this.isActive = false,  List<EventTaskDefinitionDto> tasks = const <EventTaskDefinitionDto>[]}): _tasks = tasks;
  factory _EventRuleVersionDto.fromJson(Map<String, dynamic> json) => _$EventRuleVersionDtoFromJson(json);

@override final  int id;
@override@JsonKey() final  int versionNo;
@override@JsonKey() final  String rulesText;
@override final  String? rewardEligibilityText;
@override@JsonKey() final  String completionMode;
@override final  int? requiredTaskCount;
@override final  int? requiredPoints;
@override@JsonKey() final  bool isActive;
 final  List<EventTaskDefinitionDto> _tasks;
@override@JsonKey() List<EventTaskDefinitionDto> get tasks {
  if (_tasks is EqualUnmodifiableListView) return _tasks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tasks);
}


/// Create a copy of EventRuleVersionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventRuleVersionDtoCopyWith<_EventRuleVersionDto> get copyWith => __$EventRuleVersionDtoCopyWithImpl<_EventRuleVersionDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventRuleVersionDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventRuleVersionDto&&(identical(other.id, id) || other.id == id)&&(identical(other.versionNo, versionNo) || other.versionNo == versionNo)&&(identical(other.rulesText, rulesText) || other.rulesText == rulesText)&&(identical(other.rewardEligibilityText, rewardEligibilityText) || other.rewardEligibilityText == rewardEligibilityText)&&(identical(other.completionMode, completionMode) || other.completionMode == completionMode)&&(identical(other.requiredTaskCount, requiredTaskCount) || other.requiredTaskCount == requiredTaskCount)&&(identical(other.requiredPoints, requiredPoints) || other.requiredPoints == requiredPoints)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&const DeepCollectionEquality().equals(other.tasks, _tasks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,versionNo,rulesText,rewardEligibilityText,completionMode,requiredTaskCount,requiredPoints,isActive,const DeepCollectionEquality().hash(_tasks));
}

@override
String toString() {
    return 'EventRuleVersionDto(id: $id, versionNo: $versionNo, rulesText: $rulesText, rewardEligibilityText: $rewardEligibilityText, completionMode: $completionMode, requiredTaskCount: $requiredTaskCount, requiredPoints: $requiredPoints, isActive: $isActive, tasks: $tasks)';
}


}

/// @nodoc
abstract mixin class _$EventRuleVersionDtoCopyWith<$Res> implements $EventRuleVersionDtoCopyWith<$Res> {
  factory _$EventRuleVersionDtoCopyWith(_EventRuleVersionDto value, $Res Function(_EventRuleVersionDto) _then) = __$EventRuleVersionDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, int versionNo, String rulesText, String? rewardEligibilityText, String completionMode, int? requiredTaskCount, int? requiredPoints, bool isActive, List<EventTaskDefinitionDto> tasks
});




}
/// @nodoc
class __$EventRuleVersionDtoCopyWithImpl<$Res>
    implements _$EventRuleVersionDtoCopyWith<$Res> {
  __$EventRuleVersionDtoCopyWithImpl(this._self, this._then);

  final _EventRuleVersionDto _self;
  final $Res Function(_EventRuleVersionDto) _then;

/// Create a copy of EventRuleVersionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? versionNo = null,Object? rulesText = null,Object? rewardEligibilityText = freezed,Object? completionMode = null,Object? requiredTaskCount = freezed,Object? requiredPoints = freezed,Object? isActive = null,Object? tasks = null,}) {
  return _then(_EventRuleVersionDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,versionNo: null == versionNo ? _self.versionNo : versionNo // ignore: cast_nullable_to_non_nullable
as int,rulesText: null == rulesText ? _self.rulesText : rulesText // ignore: cast_nullable_to_non_nullable
as String,rewardEligibilityText: freezed == rewardEligibilityText ? _self.rewardEligibilityText : rewardEligibilityText // ignore: cast_nullable_to_non_nullable
as String?,completionMode: null == completionMode ? _self.completionMode : completionMode // ignore: cast_nullable_to_non_nullable
as String,requiredTaskCount: freezed == requiredTaskCount ? _self.requiredTaskCount : requiredTaskCount // ignore: cast_nullable_to_non_nullable
as int?,requiredPoints: freezed == requiredPoints ? _self.requiredPoints : requiredPoints // ignore: cast_nullable_to_non_nullable
as int?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,tasks: null == tasks ? _self._tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<EventTaskDefinitionDto>,
  ));
}


}


/// @nodoc
mixin _$EventTaskDefinitionDto {

 int get id; String get taskCode; String? get targetTrackType; String get title; String get description; int get sortOrder; String get verifierType; int get targetValue; String? get configJson; bool get isMandatory; int get points; bool get allowMultiplePerStory;
/// Create a copy of EventTaskDefinitionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventTaskDefinitionDtoCopyWith<EventTaskDefinitionDto> get copyWith => _$EventTaskDefinitionDtoCopyWithImpl<EventTaskDefinitionDto>(this as EventTaskDefinitionDto, _$identity);

  /// Serializes this EventTaskDefinitionDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as EventTaskDefinitionDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventTaskDefinitionDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.taskCode, _this.taskCode) || other.taskCode == _this.taskCode)&&(identical(other.targetTrackType, _this.targetTrackType) || other.targetTrackType == _this.targetTrackType)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.sortOrder, _this.sortOrder) || other.sortOrder == _this.sortOrder)&&(identical(other.verifierType, _this.verifierType) || other.verifierType == _this.verifierType)&&(identical(other.targetValue, _this.targetValue) || other.targetValue == _this.targetValue)&&(identical(other.configJson, _this.configJson) || other.configJson == _this.configJson)&&(identical(other.isMandatory, _this.isMandatory) || other.isMandatory == _this.isMandatory)&&(identical(other.points, _this.points) || other.points == _this.points)&&(identical(other.allowMultiplePerStory, _this.allowMultiplePerStory) || other.allowMultiplePerStory == _this.allowMultiplePerStory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as EventTaskDefinitionDto;
  return Object.hash(runtimeType,_this.id,_this.taskCode,_this.targetTrackType,_this.title,_this.description,_this.sortOrder,_this.verifierType,_this.targetValue,_this.configJson,_this.isMandatory,_this.points,_this.allowMultiplePerStory);
}

@override
String toString() {
  final _this = this as EventTaskDefinitionDto;
  return 'EventTaskDefinitionDto(id: ${_this.id}, taskCode: ${_this.taskCode}, targetTrackType: ${_this.targetTrackType}, title: ${_this.title}, description: ${_this.description}, sortOrder: ${_this.sortOrder}, verifierType: ${_this.verifierType}, targetValue: ${_this.targetValue}, configJson: ${_this.configJson}, isMandatory: ${_this.isMandatory}, points: ${_this.points}, allowMultiplePerStory: ${_this.allowMultiplePerStory})';
}


}

/// @nodoc
abstract mixin class $EventTaskDefinitionDtoCopyWith<$Res>  {
  factory $EventTaskDefinitionDtoCopyWith(EventTaskDefinitionDto value, $Res Function(EventTaskDefinitionDto) _then) = _$EventTaskDefinitionDtoCopyWithImpl;
@useResult
$Res call({
 int id, String taskCode, String? targetTrackType, String title, String description, int sortOrder, String verifierType, int targetValue, String? configJson, bool isMandatory, int points, bool allowMultiplePerStory
});




}
/// @nodoc
class _$EventTaskDefinitionDtoCopyWithImpl<$Res>
    implements $EventTaskDefinitionDtoCopyWith<$Res> {
  _$EventTaskDefinitionDtoCopyWithImpl(this._self, this._then);

  final EventTaskDefinitionDto _self;
  final $Res Function(EventTaskDefinitionDto) _then;

/// Create a copy of EventTaskDefinitionDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? taskCode = null,Object? targetTrackType = freezed,Object? title = null,Object? description = null,Object? sortOrder = null,Object? verifierType = null,Object? targetValue = null,Object? configJson = freezed,Object? isMandatory = null,Object? points = null,Object? allowMultiplePerStory = null,}) {
  return _then(EventTaskDefinitionDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,taskCode: null == taskCode ? _self.taskCode : taskCode // ignore: cast_nullable_to_non_nullable
as String,targetTrackType: freezed == targetTrackType ? _self.targetTrackType : targetTrackType // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,verifierType: null == verifierType ? _self.verifierType : verifierType // ignore: cast_nullable_to_non_nullable
as String,targetValue: null == targetValue ? _self.targetValue : targetValue // ignore: cast_nullable_to_non_nullable
as int,configJson: freezed == configJson ? _self.configJson : configJson // ignore: cast_nullable_to_non_nullable
as String?,isMandatory: null == isMandatory ? _self.isMandatory : isMandatory // ignore: cast_nullable_to_non_nullable
as bool,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,allowMultiplePerStory: null == allowMultiplePerStory ? _self.allowMultiplePerStory : allowMultiplePerStory // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [EventTaskDefinitionDto].
extension EventTaskDefinitionDtoPatterns on EventTaskDefinitionDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventTaskDefinitionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventTaskDefinitionDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventTaskDefinitionDto value)  $default,){
final _that = this;
switch (_that) {
case _EventTaskDefinitionDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventTaskDefinitionDto value)?  $default,){
final _that = this;
switch (_that) {
case _EventTaskDefinitionDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String taskCode,  String? targetTrackType,  String title,  String description,  int sortOrder,  String verifierType,  int targetValue,  String? configJson,  bool isMandatory,  int points,  bool allowMultiplePerStory)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventTaskDefinitionDto() when $default != null:
return $default(_that.id,_that.taskCode,_that.targetTrackType,_that.title,_that.description,_that.sortOrder,_that.verifierType,_that.targetValue,_that.configJson,_that.isMandatory,_that.points,_that.allowMultiplePerStory);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String taskCode,  String? targetTrackType,  String title,  String description,  int sortOrder,  String verifierType,  int targetValue,  String? configJson,  bool isMandatory,  int points,  bool allowMultiplePerStory)  $default,) {final _that = this;
switch (_that) {
case _EventTaskDefinitionDto():
return $default(_that.id,_that.taskCode,_that.targetTrackType,_that.title,_that.description,_that.sortOrder,_that.verifierType,_that.targetValue,_that.configJson,_that.isMandatory,_that.points,_that.allowMultiplePerStory);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String taskCode,  String? targetTrackType,  String title,  String description,  int sortOrder,  String verifierType,  int targetValue,  String? configJson,  bool isMandatory,  int points,  bool allowMultiplePerStory)?  $default,) {final _that = this;
switch (_that) {
case _EventTaskDefinitionDto() when $default != null:
return $default(_that.id,_that.taskCode,_that.targetTrackType,_that.title,_that.description,_that.sortOrder,_that.verifierType,_that.targetValue,_that.configJson,_that.isMandatory,_that.points,_that.allowMultiplePerStory);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventTaskDefinitionDto implements EventTaskDefinitionDto {
  const _EventTaskDefinitionDto({required this.id, this.taskCode = '', this.targetTrackType, this.title = '', this.description = '', this.sortOrder = 0, this.verifierType = '', this.targetValue = 0, this.configJson, this.isMandatory = false, this.points = 0, this.allowMultiplePerStory = false});
  factory _EventTaskDefinitionDto.fromJson(Map<String, dynamic> json) => _$EventTaskDefinitionDtoFromJson(json);

@override final  int id;
@override@JsonKey() final  String taskCode;
@override final  String? targetTrackType;
@override@JsonKey() final  String title;
@override@JsonKey() final  String description;
@override@JsonKey() final  int sortOrder;
@override@JsonKey() final  String verifierType;
@override@JsonKey() final  int targetValue;
@override final  String? configJson;
@override@JsonKey() final  bool isMandatory;
@override@JsonKey() final  int points;
@override@JsonKey() final  bool allowMultiplePerStory;

/// Create a copy of EventTaskDefinitionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventTaskDefinitionDtoCopyWith<_EventTaskDefinitionDto> get copyWith => __$EventTaskDefinitionDtoCopyWithImpl<_EventTaskDefinitionDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventTaskDefinitionDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventTaskDefinitionDto&&(identical(other.id, id) || other.id == id)&&(identical(other.taskCode, taskCode) || other.taskCode == taskCode)&&(identical(other.targetTrackType, targetTrackType) || other.targetTrackType == targetTrackType)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.verifierType, verifierType) || other.verifierType == verifierType)&&(identical(other.targetValue, targetValue) || other.targetValue == targetValue)&&(identical(other.configJson, configJson) || other.configJson == configJson)&&(identical(other.isMandatory, isMandatory) || other.isMandatory == isMandatory)&&(identical(other.points, points) || other.points == points)&&(identical(other.allowMultiplePerStory, allowMultiplePerStory) || other.allowMultiplePerStory == allowMultiplePerStory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,taskCode,targetTrackType,title,description,sortOrder,verifierType,targetValue,configJson,isMandatory,points,allowMultiplePerStory);
}

@override
String toString() {
    return 'EventTaskDefinitionDto(id: $id, taskCode: $taskCode, targetTrackType: $targetTrackType, title: $title, description: $description, sortOrder: $sortOrder, verifierType: $verifierType, targetValue: $targetValue, configJson: $configJson, isMandatory: $isMandatory, points: $points, allowMultiplePerStory: $allowMultiplePerStory)';
}


}

/// @nodoc
abstract mixin class _$EventTaskDefinitionDtoCopyWith<$Res> implements $EventTaskDefinitionDtoCopyWith<$Res> {
  factory _$EventTaskDefinitionDtoCopyWith(_EventTaskDefinitionDto value, $Res Function(_EventTaskDefinitionDto) _then) = __$EventTaskDefinitionDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String taskCode, String? targetTrackType, String title, String description, int sortOrder, String verifierType, int targetValue, String? configJson, bool isMandatory, int points, bool allowMultiplePerStory
});




}
/// @nodoc
class __$EventTaskDefinitionDtoCopyWithImpl<$Res>
    implements _$EventTaskDefinitionDtoCopyWith<$Res> {
  __$EventTaskDefinitionDtoCopyWithImpl(this._self, this._then);

  final _EventTaskDefinitionDto _self;
  final $Res Function(_EventTaskDefinitionDto) _then;

/// Create a copy of EventTaskDefinitionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? taskCode = null,Object? targetTrackType = freezed,Object? title = null,Object? description = null,Object? sortOrder = null,Object? verifierType = null,Object? targetValue = null,Object? configJson = freezed,Object? isMandatory = null,Object? points = null,Object? allowMultiplePerStory = null,}) {
  return _then(_EventTaskDefinitionDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,taskCode: null == taskCode ? _self.taskCode : taskCode // ignore: cast_nullable_to_non_nullable
as String,targetTrackType: freezed == targetTrackType ? _self.targetTrackType : targetTrackType // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,verifierType: null == verifierType ? _self.verifierType : verifierType // ignore: cast_nullable_to_non_nullable
as String,targetValue: null == targetValue ? _self.targetValue : targetValue // ignore: cast_nullable_to_non_nullable
as int,configJson: freezed == configJson ? _self.configJson : configJson // ignore: cast_nullable_to_non_nullable
as String?,isMandatory: null == isMandatory ? _self.isMandatory : isMandatory // ignore: cast_nullable_to_non_nullable
as bool,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,allowMultiplePerStory: null == allowMultiplePerStory ? _self.allowMultiplePerStory : allowMultiplePerStory // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$EventAwardSlotDto {

 int get id; int? get trackId; int? get eventActivityId; String? get activityType; String? get resultSource; String? get targetAudience; String get rankOrTier; int get slotIndex; String get rewardType; String get rewardName; int get unitValueVnd; int get creditGrantAmount; int get submitCreditGrantAmount; int? get participationId; String get status; DateTime? get claimDeadlineAt; bool get notificationFailed;
/// Create a copy of EventAwardSlotDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventAwardSlotDtoCopyWith<EventAwardSlotDto> get copyWith => _$EventAwardSlotDtoCopyWithImpl<EventAwardSlotDto>(this as EventAwardSlotDto, _$identity);

  /// Serializes this EventAwardSlotDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as EventAwardSlotDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventAwardSlotDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.trackId, _this.trackId) || other.trackId == _this.trackId)&&(identical(other.eventActivityId, _this.eventActivityId) || other.eventActivityId == _this.eventActivityId)&&(identical(other.activityType, _this.activityType) || other.activityType == _this.activityType)&&(identical(other.resultSource, _this.resultSource) || other.resultSource == _this.resultSource)&&(identical(other.targetAudience, _this.targetAudience) || other.targetAudience == _this.targetAudience)&&(identical(other.rankOrTier, _this.rankOrTier) || other.rankOrTier == _this.rankOrTier)&&(identical(other.slotIndex, _this.slotIndex) || other.slotIndex == _this.slotIndex)&&(identical(other.rewardType, _this.rewardType) || other.rewardType == _this.rewardType)&&(identical(other.rewardName, _this.rewardName) || other.rewardName == _this.rewardName)&&(identical(other.unitValueVnd, _this.unitValueVnd) || other.unitValueVnd == _this.unitValueVnd)&&(identical(other.creditGrantAmount, _this.creditGrantAmount) || other.creditGrantAmount == _this.creditGrantAmount)&&(identical(other.submitCreditGrantAmount, _this.submitCreditGrantAmount) || other.submitCreditGrantAmount == _this.submitCreditGrantAmount)&&(identical(other.participationId, _this.participationId) || other.participationId == _this.participationId)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.claimDeadlineAt, _this.claimDeadlineAt) || other.claimDeadlineAt == _this.claimDeadlineAt)&&(identical(other.notificationFailed, _this.notificationFailed) || other.notificationFailed == _this.notificationFailed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as EventAwardSlotDto;
  return Object.hash(runtimeType,_this.id,_this.trackId,_this.eventActivityId,_this.activityType,_this.resultSource,_this.targetAudience,_this.rankOrTier,_this.slotIndex,_this.rewardType,_this.rewardName,_this.unitValueVnd,_this.creditGrantAmount,_this.submitCreditGrantAmount,_this.participationId,_this.status,_this.claimDeadlineAt,_this.notificationFailed);
}

@override
String toString() {
  final _this = this as EventAwardSlotDto;
  return 'EventAwardSlotDto(id: ${_this.id}, trackId: ${_this.trackId}, eventActivityId: ${_this.eventActivityId}, activityType: ${_this.activityType}, resultSource: ${_this.resultSource}, targetAudience: ${_this.targetAudience}, rankOrTier: ${_this.rankOrTier}, slotIndex: ${_this.slotIndex}, rewardType: ${_this.rewardType}, rewardName: ${_this.rewardName}, unitValueVnd: ${_this.unitValueVnd}, creditGrantAmount: ${_this.creditGrantAmount}, submitCreditGrantAmount: ${_this.submitCreditGrantAmount}, participationId: ${_this.participationId}, status: ${_this.status}, claimDeadlineAt: ${_this.claimDeadlineAt}, notificationFailed: ${_this.notificationFailed})';
}


}

/// @nodoc
abstract mixin class $EventAwardSlotDtoCopyWith<$Res>  {
  factory $EventAwardSlotDtoCopyWith(EventAwardSlotDto value, $Res Function(EventAwardSlotDto) _then) = _$EventAwardSlotDtoCopyWithImpl;
@useResult
$Res call({
 int id, int? trackId, int? eventActivityId, String? activityType, String? resultSource, String? targetAudience, String rankOrTier, int slotIndex, String rewardType, String rewardName, int unitValueVnd, int creditGrantAmount, int submitCreditGrantAmount, int? participationId, String status, DateTime? claimDeadlineAt, bool notificationFailed
});




}
/// @nodoc
class _$EventAwardSlotDtoCopyWithImpl<$Res>
    implements $EventAwardSlotDtoCopyWith<$Res> {
  _$EventAwardSlotDtoCopyWithImpl(this._self, this._then);

  final EventAwardSlotDto _self;
  final $Res Function(EventAwardSlotDto) _then;

/// Create a copy of EventAwardSlotDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? trackId = freezed,Object? eventActivityId = freezed,Object? activityType = freezed,Object? resultSource = freezed,Object? targetAudience = freezed,Object? rankOrTier = null,Object? slotIndex = null,Object? rewardType = null,Object? rewardName = null,Object? unitValueVnd = null,Object? creditGrantAmount = null,Object? submitCreditGrantAmount = null,Object? participationId = freezed,Object? status = null,Object? claimDeadlineAt = freezed,Object? notificationFailed = null,}) {
  return _then(EventAwardSlotDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,trackId: freezed == trackId ? _self.trackId : trackId // ignore: cast_nullable_to_non_nullable
as int?,eventActivityId: freezed == eventActivityId ? _self.eventActivityId : eventActivityId // ignore: cast_nullable_to_non_nullable
as int?,activityType: freezed == activityType ? _self.activityType : activityType // ignore: cast_nullable_to_non_nullable
as String?,resultSource: freezed == resultSource ? _self.resultSource : resultSource // ignore: cast_nullable_to_non_nullable
as String?,targetAudience: freezed == targetAudience ? _self.targetAudience : targetAudience // ignore: cast_nullable_to_non_nullable
as String?,rankOrTier: null == rankOrTier ? _self.rankOrTier : rankOrTier // ignore: cast_nullable_to_non_nullable
as String,slotIndex: null == slotIndex ? _self.slotIndex : slotIndex // ignore: cast_nullable_to_non_nullable
as int,rewardType: null == rewardType ? _self.rewardType : rewardType // ignore: cast_nullable_to_non_nullable
as String,rewardName: null == rewardName ? _self.rewardName : rewardName // ignore: cast_nullable_to_non_nullable
as String,unitValueVnd: null == unitValueVnd ? _self.unitValueVnd : unitValueVnd // ignore: cast_nullable_to_non_nullable
as int,creditGrantAmount: null == creditGrantAmount ? _self.creditGrantAmount : creditGrantAmount // ignore: cast_nullable_to_non_nullable
as int,submitCreditGrantAmount: null == submitCreditGrantAmount ? _self.submitCreditGrantAmount : submitCreditGrantAmount // ignore: cast_nullable_to_non_nullable
as int,participationId: freezed == participationId ? _self.participationId : participationId // ignore: cast_nullable_to_non_nullable
as int?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,claimDeadlineAt: freezed == claimDeadlineAt ? _self.claimDeadlineAt : claimDeadlineAt // ignore: cast_nullable_to_non_nullable
as DateTime?,notificationFailed: null == notificationFailed ? _self.notificationFailed : notificationFailed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [EventAwardSlotDto].
extension EventAwardSlotDtoPatterns on EventAwardSlotDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventAwardSlotDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventAwardSlotDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventAwardSlotDto value)  $default,){
final _that = this;
switch (_that) {
case _EventAwardSlotDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventAwardSlotDto value)?  $default,){
final _that = this;
switch (_that) {
case _EventAwardSlotDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int? trackId,  int? eventActivityId,  String? activityType,  String? resultSource,  String? targetAudience,  String rankOrTier,  int slotIndex,  String rewardType,  String rewardName,  int unitValueVnd,  int creditGrantAmount,  int submitCreditGrantAmount,  int? participationId,  String status,  DateTime? claimDeadlineAt,  bool notificationFailed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventAwardSlotDto() when $default != null:
return $default(_that.id,_that.trackId,_that.eventActivityId,_that.activityType,_that.resultSource,_that.targetAudience,_that.rankOrTier,_that.slotIndex,_that.rewardType,_that.rewardName,_that.unitValueVnd,_that.creditGrantAmount,_that.submitCreditGrantAmount,_that.participationId,_that.status,_that.claimDeadlineAt,_that.notificationFailed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int? trackId,  int? eventActivityId,  String? activityType,  String? resultSource,  String? targetAudience,  String rankOrTier,  int slotIndex,  String rewardType,  String rewardName,  int unitValueVnd,  int creditGrantAmount,  int submitCreditGrantAmount,  int? participationId,  String status,  DateTime? claimDeadlineAt,  bool notificationFailed)  $default,) {final _that = this;
switch (_that) {
case _EventAwardSlotDto():
return $default(_that.id,_that.trackId,_that.eventActivityId,_that.activityType,_that.resultSource,_that.targetAudience,_that.rankOrTier,_that.slotIndex,_that.rewardType,_that.rewardName,_that.unitValueVnd,_that.creditGrantAmount,_that.submitCreditGrantAmount,_that.participationId,_that.status,_that.claimDeadlineAt,_that.notificationFailed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int? trackId,  int? eventActivityId,  String? activityType,  String? resultSource,  String? targetAudience,  String rankOrTier,  int slotIndex,  String rewardType,  String rewardName,  int unitValueVnd,  int creditGrantAmount,  int submitCreditGrantAmount,  int? participationId,  String status,  DateTime? claimDeadlineAt,  bool notificationFailed)?  $default,) {final _that = this;
switch (_that) {
case _EventAwardSlotDto() when $default != null:
return $default(_that.id,_that.trackId,_that.eventActivityId,_that.activityType,_that.resultSource,_that.targetAudience,_that.rankOrTier,_that.slotIndex,_that.rewardType,_that.rewardName,_that.unitValueVnd,_that.creditGrantAmount,_that.submitCreditGrantAmount,_that.participationId,_that.status,_that.claimDeadlineAt,_that.notificationFailed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventAwardSlotDto implements EventAwardSlotDto {
  const _EventAwardSlotDto({required this.id, this.trackId, this.eventActivityId, this.activityType, this.resultSource, this.targetAudience, this.rankOrTier = '', this.slotIndex = 0, this.rewardType = '', this.rewardName = '', this.unitValueVnd = 0, this.creditGrantAmount = 0, this.submitCreditGrantAmount = 0, this.participationId, this.status = '', this.claimDeadlineAt, this.notificationFailed = false});
  factory _EventAwardSlotDto.fromJson(Map<String, dynamic> json) => _$EventAwardSlotDtoFromJson(json);

@override final  int id;
@override final  int? trackId;
@override final  int? eventActivityId;
@override final  String? activityType;
@override final  String? resultSource;
@override final  String? targetAudience;
@override@JsonKey() final  String rankOrTier;
@override@JsonKey() final  int slotIndex;
@override@JsonKey() final  String rewardType;
@override@JsonKey() final  String rewardName;
@override@JsonKey() final  int unitValueVnd;
@override@JsonKey() final  int creditGrantAmount;
@override@JsonKey() final  int submitCreditGrantAmount;
@override final  int? participationId;
@override@JsonKey() final  String status;
@override final  DateTime? claimDeadlineAt;
@override@JsonKey() final  bool notificationFailed;

/// Create a copy of EventAwardSlotDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventAwardSlotDtoCopyWith<_EventAwardSlotDto> get copyWith => __$EventAwardSlotDtoCopyWithImpl<_EventAwardSlotDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventAwardSlotDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventAwardSlotDto&&(identical(other.id, id) || other.id == id)&&(identical(other.trackId, trackId) || other.trackId == trackId)&&(identical(other.eventActivityId, eventActivityId) || other.eventActivityId == eventActivityId)&&(identical(other.activityType, activityType) || other.activityType == activityType)&&(identical(other.resultSource, resultSource) || other.resultSource == resultSource)&&(identical(other.targetAudience, targetAudience) || other.targetAudience == targetAudience)&&(identical(other.rankOrTier, rankOrTier) || other.rankOrTier == rankOrTier)&&(identical(other.slotIndex, slotIndex) || other.slotIndex == slotIndex)&&(identical(other.rewardType, rewardType) || other.rewardType == rewardType)&&(identical(other.rewardName, rewardName) || other.rewardName == rewardName)&&(identical(other.unitValueVnd, unitValueVnd) || other.unitValueVnd == unitValueVnd)&&(identical(other.creditGrantAmount, creditGrantAmount) || other.creditGrantAmount == creditGrantAmount)&&(identical(other.submitCreditGrantAmount, submitCreditGrantAmount) || other.submitCreditGrantAmount == submitCreditGrantAmount)&&(identical(other.participationId, participationId) || other.participationId == participationId)&&(identical(other.status, status) || other.status == status)&&(identical(other.claimDeadlineAt, claimDeadlineAt) || other.claimDeadlineAt == claimDeadlineAt)&&(identical(other.notificationFailed, notificationFailed) || other.notificationFailed == notificationFailed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,trackId,eventActivityId,activityType,resultSource,targetAudience,rankOrTier,slotIndex,rewardType,rewardName,unitValueVnd,creditGrantAmount,submitCreditGrantAmount,participationId,status,claimDeadlineAt,notificationFailed);
}

@override
String toString() {
    return 'EventAwardSlotDto(id: $id, trackId: $trackId, eventActivityId: $eventActivityId, activityType: $activityType, resultSource: $resultSource, targetAudience: $targetAudience, rankOrTier: $rankOrTier, slotIndex: $slotIndex, rewardType: $rewardType, rewardName: $rewardName, unitValueVnd: $unitValueVnd, creditGrantAmount: $creditGrantAmount, submitCreditGrantAmount: $submitCreditGrantAmount, participationId: $participationId, status: $status, claimDeadlineAt: $claimDeadlineAt, notificationFailed: $notificationFailed)';
}


}

/// @nodoc
abstract mixin class _$EventAwardSlotDtoCopyWith<$Res> implements $EventAwardSlotDtoCopyWith<$Res> {
  factory _$EventAwardSlotDtoCopyWith(_EventAwardSlotDto value, $Res Function(_EventAwardSlotDto) _then) = __$EventAwardSlotDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, int? trackId, int? eventActivityId, String? activityType, String? resultSource, String? targetAudience, String rankOrTier, int slotIndex, String rewardType, String rewardName, int unitValueVnd, int creditGrantAmount, int submitCreditGrantAmount, int? participationId, String status, DateTime? claimDeadlineAt, bool notificationFailed
});




}
/// @nodoc
class __$EventAwardSlotDtoCopyWithImpl<$Res>
    implements _$EventAwardSlotDtoCopyWith<$Res> {
  __$EventAwardSlotDtoCopyWithImpl(this._self, this._then);

  final _EventAwardSlotDto _self;
  final $Res Function(_EventAwardSlotDto) _then;

/// Create a copy of EventAwardSlotDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? trackId = freezed,Object? eventActivityId = freezed,Object? activityType = freezed,Object? resultSource = freezed,Object? targetAudience = freezed,Object? rankOrTier = null,Object? slotIndex = null,Object? rewardType = null,Object? rewardName = null,Object? unitValueVnd = null,Object? creditGrantAmount = null,Object? submitCreditGrantAmount = null,Object? participationId = freezed,Object? status = null,Object? claimDeadlineAt = freezed,Object? notificationFailed = null,}) {
  return _then(_EventAwardSlotDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,trackId: freezed == trackId ? _self.trackId : trackId // ignore: cast_nullable_to_non_nullable
as int?,eventActivityId: freezed == eventActivityId ? _self.eventActivityId : eventActivityId // ignore: cast_nullable_to_non_nullable
as int?,activityType: freezed == activityType ? _self.activityType : activityType // ignore: cast_nullable_to_non_nullable
as String?,resultSource: freezed == resultSource ? _self.resultSource : resultSource // ignore: cast_nullable_to_non_nullable
as String?,targetAudience: freezed == targetAudience ? _self.targetAudience : targetAudience // ignore: cast_nullable_to_non_nullable
as String?,rankOrTier: null == rankOrTier ? _self.rankOrTier : rankOrTier // ignore: cast_nullable_to_non_nullable
as String,slotIndex: null == slotIndex ? _self.slotIndex : slotIndex // ignore: cast_nullable_to_non_nullable
as int,rewardType: null == rewardType ? _self.rewardType : rewardType // ignore: cast_nullable_to_non_nullable
as String,rewardName: null == rewardName ? _self.rewardName : rewardName // ignore: cast_nullable_to_non_nullable
as String,unitValueVnd: null == unitValueVnd ? _self.unitValueVnd : unitValueVnd // ignore: cast_nullable_to_non_nullable
as int,creditGrantAmount: null == creditGrantAmount ? _self.creditGrantAmount : creditGrantAmount // ignore: cast_nullable_to_non_nullable
as int,submitCreditGrantAmount: null == submitCreditGrantAmount ? _self.submitCreditGrantAmount : submitCreditGrantAmount // ignore: cast_nullable_to_non_nullable
as int,participationId: freezed == participationId ? _self.participationId : participationId // ignore: cast_nullable_to_non_nullable
as int?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,claimDeadlineAt: freezed == claimDeadlineAt ? _self.claimDeadlineAt : claimDeadlineAt // ignore: cast_nullable_to_non_nullable
as DateTime?,notificationFailed: null == notificationFailed ? _self.notificationFailed : notificationFailed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$EventParticipationDto {

 int get id; int get eventId; int? get trackId; String get trackType; int? get eventActivityId; String? get activityType; int get userId; int get acceptedRuleVersionId; String get status; DateTime? get missionCompletedAt; DateTime? get verifiedAt; DateTime? get appealDeadlineAt; String? get safetyWarning;
/// Create a copy of EventParticipationDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventParticipationDtoCopyWith<EventParticipationDto> get copyWith => _$EventParticipationDtoCopyWithImpl<EventParticipationDto>(this as EventParticipationDto, _$identity);

  /// Serializes this EventParticipationDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as EventParticipationDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventParticipationDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.eventId, _this.eventId) || other.eventId == _this.eventId)&&(identical(other.trackId, _this.trackId) || other.trackId == _this.trackId)&&(identical(other.trackType, _this.trackType) || other.trackType == _this.trackType)&&(identical(other.eventActivityId, _this.eventActivityId) || other.eventActivityId == _this.eventActivityId)&&(identical(other.activityType, _this.activityType) || other.activityType == _this.activityType)&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.acceptedRuleVersionId, _this.acceptedRuleVersionId) || other.acceptedRuleVersionId == _this.acceptedRuleVersionId)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.missionCompletedAt, _this.missionCompletedAt) || other.missionCompletedAt == _this.missionCompletedAt)&&(identical(other.verifiedAt, _this.verifiedAt) || other.verifiedAt == _this.verifiedAt)&&(identical(other.appealDeadlineAt, _this.appealDeadlineAt) || other.appealDeadlineAt == _this.appealDeadlineAt)&&(identical(other.safetyWarning, _this.safetyWarning) || other.safetyWarning == _this.safetyWarning));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as EventParticipationDto;
  return Object.hash(runtimeType,_this.id,_this.eventId,_this.trackId,_this.trackType,_this.eventActivityId,_this.activityType,_this.userId,_this.acceptedRuleVersionId,_this.status,_this.missionCompletedAt,_this.verifiedAt,_this.appealDeadlineAt,_this.safetyWarning);
}

@override
String toString() {
  final _this = this as EventParticipationDto;
  return 'EventParticipationDto(id: ${_this.id}, eventId: ${_this.eventId}, trackId: ${_this.trackId}, trackType: ${_this.trackType}, eventActivityId: ${_this.eventActivityId}, activityType: ${_this.activityType}, userId: ${_this.userId}, acceptedRuleVersionId: ${_this.acceptedRuleVersionId}, status: ${_this.status}, missionCompletedAt: ${_this.missionCompletedAt}, verifiedAt: ${_this.verifiedAt}, appealDeadlineAt: ${_this.appealDeadlineAt}, safetyWarning: ${_this.safetyWarning})';
}


}

/// @nodoc
abstract mixin class $EventParticipationDtoCopyWith<$Res>  {
  factory $EventParticipationDtoCopyWith(EventParticipationDto value, $Res Function(EventParticipationDto) _then) = _$EventParticipationDtoCopyWithImpl;
@useResult
$Res call({
 int id, int eventId, int? trackId, String trackType, int? eventActivityId, String? activityType, int userId, int acceptedRuleVersionId, String status, DateTime? missionCompletedAt, DateTime? verifiedAt, DateTime? appealDeadlineAt, String? safetyWarning
});




}
/// @nodoc
class _$EventParticipationDtoCopyWithImpl<$Res>
    implements $EventParticipationDtoCopyWith<$Res> {
  _$EventParticipationDtoCopyWithImpl(this._self, this._then);

  final EventParticipationDto _self;
  final $Res Function(EventParticipationDto) _then;

/// Create a copy of EventParticipationDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? eventId = null,Object? trackId = freezed,Object? trackType = null,Object? eventActivityId = freezed,Object? activityType = freezed,Object? userId = null,Object? acceptedRuleVersionId = null,Object? status = null,Object? missionCompletedAt = freezed,Object? verifiedAt = freezed,Object? appealDeadlineAt = freezed,Object? safetyWarning = freezed,}) {
  return _then(EventParticipationDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as int,trackId: freezed == trackId ? _self.trackId : trackId // ignore: cast_nullable_to_non_nullable
as int?,trackType: null == trackType ? _self.trackType : trackType // ignore: cast_nullable_to_non_nullable
as String,eventActivityId: freezed == eventActivityId ? _self.eventActivityId : eventActivityId // ignore: cast_nullable_to_non_nullable
as int?,activityType: freezed == activityType ? _self.activityType : activityType // ignore: cast_nullable_to_non_nullable
as String?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,acceptedRuleVersionId: null == acceptedRuleVersionId ? _self.acceptedRuleVersionId : acceptedRuleVersionId // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,missionCompletedAt: freezed == missionCompletedAt ? _self.missionCompletedAt : missionCompletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,verifiedAt: freezed == verifiedAt ? _self.verifiedAt : verifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,appealDeadlineAt: freezed == appealDeadlineAt ? _self.appealDeadlineAt : appealDeadlineAt // ignore: cast_nullable_to_non_nullable
as DateTime?,safetyWarning: freezed == safetyWarning ? _self.safetyWarning : safetyWarning // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EventParticipationDto].
extension EventParticipationDtoPatterns on EventParticipationDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventParticipationDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventParticipationDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventParticipationDto value)  $default,){
final _that = this;
switch (_that) {
case _EventParticipationDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventParticipationDto value)?  $default,){
final _that = this;
switch (_that) {
case _EventParticipationDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int eventId,  int? trackId,  String trackType,  int? eventActivityId,  String? activityType,  int userId,  int acceptedRuleVersionId,  String status,  DateTime? missionCompletedAt,  DateTime? verifiedAt,  DateTime? appealDeadlineAt,  String? safetyWarning)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventParticipationDto() when $default != null:
return $default(_that.id,_that.eventId,_that.trackId,_that.trackType,_that.eventActivityId,_that.activityType,_that.userId,_that.acceptedRuleVersionId,_that.status,_that.missionCompletedAt,_that.verifiedAt,_that.appealDeadlineAt,_that.safetyWarning);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int eventId,  int? trackId,  String trackType,  int? eventActivityId,  String? activityType,  int userId,  int acceptedRuleVersionId,  String status,  DateTime? missionCompletedAt,  DateTime? verifiedAt,  DateTime? appealDeadlineAt,  String? safetyWarning)  $default,) {final _that = this;
switch (_that) {
case _EventParticipationDto():
return $default(_that.id,_that.eventId,_that.trackId,_that.trackType,_that.eventActivityId,_that.activityType,_that.userId,_that.acceptedRuleVersionId,_that.status,_that.missionCompletedAt,_that.verifiedAt,_that.appealDeadlineAt,_that.safetyWarning);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int eventId,  int? trackId,  String trackType,  int? eventActivityId,  String? activityType,  int userId,  int acceptedRuleVersionId,  String status,  DateTime? missionCompletedAt,  DateTime? verifiedAt,  DateTime? appealDeadlineAt,  String? safetyWarning)?  $default,) {final _that = this;
switch (_that) {
case _EventParticipationDto() when $default != null:
return $default(_that.id,_that.eventId,_that.trackId,_that.trackType,_that.eventActivityId,_that.activityType,_that.userId,_that.acceptedRuleVersionId,_that.status,_that.missionCompletedAt,_that.verifiedAt,_that.appealDeadlineAt,_that.safetyWarning);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventParticipationDto implements EventParticipationDto {
  const _EventParticipationDto({required this.id, required this.eventId, this.trackId, this.trackType = '', this.eventActivityId, this.activityType, this.userId = 0, this.acceptedRuleVersionId = 0, this.status = '', this.missionCompletedAt, this.verifiedAt, this.appealDeadlineAt, this.safetyWarning});
  factory _EventParticipationDto.fromJson(Map<String, dynamic> json) => _$EventParticipationDtoFromJson(json);

@override final  int id;
@override final  int eventId;
@override final  int? trackId;
@override@JsonKey() final  String trackType;
@override final  int? eventActivityId;
@override final  String? activityType;
@override@JsonKey() final  int userId;
@override@JsonKey() final  int acceptedRuleVersionId;
@override@JsonKey() final  String status;
@override final  DateTime? missionCompletedAt;
@override final  DateTime? verifiedAt;
@override final  DateTime? appealDeadlineAt;
@override final  String? safetyWarning;

/// Create a copy of EventParticipationDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventParticipationDtoCopyWith<_EventParticipationDto> get copyWith => __$EventParticipationDtoCopyWithImpl<_EventParticipationDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventParticipationDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventParticipationDto&&(identical(other.id, id) || other.id == id)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.trackId, trackId) || other.trackId == trackId)&&(identical(other.trackType, trackType) || other.trackType == trackType)&&(identical(other.eventActivityId, eventActivityId) || other.eventActivityId == eventActivityId)&&(identical(other.activityType, activityType) || other.activityType == activityType)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.acceptedRuleVersionId, acceptedRuleVersionId) || other.acceptedRuleVersionId == acceptedRuleVersionId)&&(identical(other.status, status) || other.status == status)&&(identical(other.missionCompletedAt, missionCompletedAt) || other.missionCompletedAt == missionCompletedAt)&&(identical(other.verifiedAt, verifiedAt) || other.verifiedAt == verifiedAt)&&(identical(other.appealDeadlineAt, appealDeadlineAt) || other.appealDeadlineAt == appealDeadlineAt)&&(identical(other.safetyWarning, safetyWarning) || other.safetyWarning == safetyWarning));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,eventId,trackId,trackType,eventActivityId,activityType,userId,acceptedRuleVersionId,status,missionCompletedAt,verifiedAt,appealDeadlineAt,safetyWarning);
}

@override
String toString() {
    return 'EventParticipationDto(id: $id, eventId: $eventId, trackId: $trackId, trackType: $trackType, eventActivityId: $eventActivityId, activityType: $activityType, userId: $userId, acceptedRuleVersionId: $acceptedRuleVersionId, status: $status, missionCompletedAt: $missionCompletedAt, verifiedAt: $verifiedAt, appealDeadlineAt: $appealDeadlineAt, safetyWarning: $safetyWarning)';
}


}

/// @nodoc
abstract mixin class _$EventParticipationDtoCopyWith<$Res> implements $EventParticipationDtoCopyWith<$Res> {
  factory _$EventParticipationDtoCopyWith(_EventParticipationDto value, $Res Function(_EventParticipationDto) _then) = __$EventParticipationDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, int eventId, int? trackId, String trackType, int? eventActivityId, String? activityType, int userId, int acceptedRuleVersionId, String status, DateTime? missionCompletedAt, DateTime? verifiedAt, DateTime? appealDeadlineAt, String? safetyWarning
});




}
/// @nodoc
class __$EventParticipationDtoCopyWithImpl<$Res>
    implements _$EventParticipationDtoCopyWith<$Res> {
  __$EventParticipationDtoCopyWithImpl(this._self, this._then);

  final _EventParticipationDto _self;
  final $Res Function(_EventParticipationDto) _then;

/// Create a copy of EventParticipationDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? eventId = null,Object? trackId = freezed,Object? trackType = null,Object? eventActivityId = freezed,Object? activityType = freezed,Object? userId = null,Object? acceptedRuleVersionId = null,Object? status = null,Object? missionCompletedAt = freezed,Object? verifiedAt = freezed,Object? appealDeadlineAt = freezed,Object? safetyWarning = freezed,}) {
  return _then(_EventParticipationDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as int,trackId: freezed == trackId ? _self.trackId : trackId // ignore: cast_nullable_to_non_nullable
as int?,trackType: null == trackType ? _self.trackType : trackType // ignore: cast_nullable_to_non_nullable
as String,eventActivityId: freezed == eventActivityId ? _self.eventActivityId : eventActivityId // ignore: cast_nullable_to_non_nullable
as int?,activityType: freezed == activityType ? _self.activityType : activityType // ignore: cast_nullable_to_non_nullable
as String?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,acceptedRuleVersionId: null == acceptedRuleVersionId ? _self.acceptedRuleVersionId : acceptedRuleVersionId // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,missionCompletedAt: freezed == missionCompletedAt ? _self.missionCompletedAt : missionCompletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,verifiedAt: freezed == verifiedAt ? _self.verifiedAt : verifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,appealDeadlineAt: freezed == appealDeadlineAt ? _self.appealDeadlineAt : appealDeadlineAt // ignore: cast_nullable_to_non_nullable
as DateTime?,safetyWarning: freezed == safetyWarning ? _self.safetyWarning : safetyWarning // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$EventMissionDashboardDto {

 EventParticipationDto? get participation; String get completionMode; int? get requiredTaskCount; int? get requiredPoints; int get completedTasksCount; int get earnedPoints; bool get allRequirementsMet; List<EventTaskProgressItemDto> get tasks; List<EventStoryLibraryItemDto> get stories; List<EventStoryLibraryItemDto> get votingStories;
/// Create a copy of EventMissionDashboardDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventMissionDashboardDtoCopyWith<EventMissionDashboardDto> get copyWith => _$EventMissionDashboardDtoCopyWithImpl<EventMissionDashboardDto>(this as EventMissionDashboardDto, _$identity);

  /// Serializes this EventMissionDashboardDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as EventMissionDashboardDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventMissionDashboardDto&&(identical(other.participation, _this.participation) || other.participation == _this.participation)&&(identical(other.completionMode, _this.completionMode) || other.completionMode == _this.completionMode)&&(identical(other.requiredTaskCount, _this.requiredTaskCount) || other.requiredTaskCount == _this.requiredTaskCount)&&(identical(other.requiredPoints, _this.requiredPoints) || other.requiredPoints == _this.requiredPoints)&&(identical(other.completedTasksCount, _this.completedTasksCount) || other.completedTasksCount == _this.completedTasksCount)&&(identical(other.earnedPoints, _this.earnedPoints) || other.earnedPoints == _this.earnedPoints)&&(identical(other.allRequirementsMet, _this.allRequirementsMet) || other.allRequirementsMet == _this.allRequirementsMet)&&const DeepCollectionEquality().equals(other.tasks, _this.tasks)&&const DeepCollectionEquality().equals(other.stories, _this.stories)&&const DeepCollectionEquality().equals(other.votingStories, _this.votingStories));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as EventMissionDashboardDto;
  return Object.hash(runtimeType,_this.participation,_this.completionMode,_this.requiredTaskCount,_this.requiredPoints,_this.completedTasksCount,_this.earnedPoints,_this.allRequirementsMet,const DeepCollectionEquality().hash(_this.tasks),const DeepCollectionEquality().hash(_this.stories),const DeepCollectionEquality().hash(_this.votingStories));
}

@override
String toString() {
  final _this = this as EventMissionDashboardDto;
  return 'EventMissionDashboardDto(participation: ${_this.participation}, completionMode: ${_this.completionMode}, requiredTaskCount: ${_this.requiredTaskCount}, requiredPoints: ${_this.requiredPoints}, completedTasksCount: ${_this.completedTasksCount}, earnedPoints: ${_this.earnedPoints}, allRequirementsMet: ${_this.allRequirementsMet}, tasks: ${_this.tasks}, stories: ${_this.stories}, votingStories: ${_this.votingStories})';
}


}

/// @nodoc
abstract mixin class $EventMissionDashboardDtoCopyWith<$Res>  {
  factory $EventMissionDashboardDtoCopyWith(EventMissionDashboardDto value, $Res Function(EventMissionDashboardDto) _then) = _$EventMissionDashboardDtoCopyWithImpl;
@useResult
$Res call({
 EventParticipationDto? participation, String completionMode, int? requiredTaskCount, int? requiredPoints, int completedTasksCount, int earnedPoints, bool allRequirementsMet, List<EventTaskProgressItemDto> tasks, List<EventStoryLibraryItemDto> stories, List<EventStoryLibraryItemDto> votingStories
});


$EventParticipationDtoCopyWith<$Res>? get participation;

}
/// @nodoc
class _$EventMissionDashboardDtoCopyWithImpl<$Res>
    implements $EventMissionDashboardDtoCopyWith<$Res> {
  _$EventMissionDashboardDtoCopyWithImpl(this._self, this._then);

  final EventMissionDashboardDto _self;
  final $Res Function(EventMissionDashboardDto) _then;

/// Create a copy of EventMissionDashboardDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? participation = freezed,Object? completionMode = null,Object? requiredTaskCount = freezed,Object? requiredPoints = freezed,Object? completedTasksCount = null,Object? earnedPoints = null,Object? allRequirementsMet = null,Object? tasks = null,Object? stories = null,Object? votingStories = null,}) {
  return _then(EventMissionDashboardDto(
participation: freezed == participation ? _self.participation : participation // ignore: cast_nullable_to_non_nullable
as EventParticipationDto?,completionMode: null == completionMode ? _self.completionMode : completionMode // ignore: cast_nullable_to_non_nullable
as String,requiredTaskCount: freezed == requiredTaskCount ? _self.requiredTaskCount : requiredTaskCount // ignore: cast_nullable_to_non_nullable
as int?,requiredPoints: freezed == requiredPoints ? _self.requiredPoints : requiredPoints // ignore: cast_nullable_to_non_nullable
as int?,completedTasksCount: null == completedTasksCount ? _self.completedTasksCount : completedTasksCount // ignore: cast_nullable_to_non_nullable
as int,earnedPoints: null == earnedPoints ? _self.earnedPoints : earnedPoints // ignore: cast_nullable_to_non_nullable
as int,allRequirementsMet: null == allRequirementsMet ? _self.allRequirementsMet : allRequirementsMet // ignore: cast_nullable_to_non_nullable
as bool,tasks: null == tasks ? _self.tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<EventTaskProgressItemDto>,stories: null == stories ? _self.stories : stories // ignore: cast_nullable_to_non_nullable
as List<EventStoryLibraryItemDto>,votingStories: null == votingStories ? _self.votingStories : votingStories // ignore: cast_nullable_to_non_nullable
as List<EventStoryLibraryItemDto>,
  ));
}
/// Create a copy of EventMissionDashboardDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventParticipationDtoCopyWith<$Res>? get participation {
    if (_self.participation == null) {
    return null;
  }

  return $EventParticipationDtoCopyWith<$Res>(_self.participation!, (value) {
    return _then(_self.copyWith(participation: value));
  });
}
}


/// Adds pattern-matching-related methods to [EventMissionDashboardDto].
extension EventMissionDashboardDtoPatterns on EventMissionDashboardDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventMissionDashboardDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventMissionDashboardDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventMissionDashboardDto value)  $default,){
final _that = this;
switch (_that) {
case _EventMissionDashboardDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventMissionDashboardDto value)?  $default,){
final _that = this;
switch (_that) {
case _EventMissionDashboardDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EventParticipationDto? participation,  String completionMode,  int? requiredTaskCount,  int? requiredPoints,  int completedTasksCount,  int earnedPoints,  bool allRequirementsMet,  List<EventTaskProgressItemDto> tasks,  List<EventStoryLibraryItemDto> stories,  List<EventStoryLibraryItemDto> votingStories)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventMissionDashboardDto() when $default != null:
return $default(_that.participation,_that.completionMode,_that.requiredTaskCount,_that.requiredPoints,_that.completedTasksCount,_that.earnedPoints,_that.allRequirementsMet,_that.tasks,_that.stories,_that.votingStories);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EventParticipationDto? participation,  String completionMode,  int? requiredTaskCount,  int? requiredPoints,  int completedTasksCount,  int earnedPoints,  bool allRequirementsMet,  List<EventTaskProgressItemDto> tasks,  List<EventStoryLibraryItemDto> stories,  List<EventStoryLibraryItemDto> votingStories)  $default,) {final _that = this;
switch (_that) {
case _EventMissionDashboardDto():
return $default(_that.participation,_that.completionMode,_that.requiredTaskCount,_that.requiredPoints,_that.completedTasksCount,_that.earnedPoints,_that.allRequirementsMet,_that.tasks,_that.stories,_that.votingStories);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EventParticipationDto? participation,  String completionMode,  int? requiredTaskCount,  int? requiredPoints,  int completedTasksCount,  int earnedPoints,  bool allRequirementsMet,  List<EventTaskProgressItemDto> tasks,  List<EventStoryLibraryItemDto> stories,  List<EventStoryLibraryItemDto> votingStories)?  $default,) {final _that = this;
switch (_that) {
case _EventMissionDashboardDto() when $default != null:
return $default(_that.participation,_that.completionMode,_that.requiredTaskCount,_that.requiredPoints,_that.completedTasksCount,_that.earnedPoints,_that.allRequirementsMet,_that.tasks,_that.stories,_that.votingStories);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventMissionDashboardDto implements EventMissionDashboardDto {
  const _EventMissionDashboardDto({this.participation, this.completionMode = '', this.requiredTaskCount, this.requiredPoints, this.completedTasksCount = 0, this.earnedPoints = 0, this.allRequirementsMet = false,  List<EventTaskProgressItemDto> tasks = const <EventTaskProgressItemDto>[],  List<EventStoryLibraryItemDto> stories = const <EventStoryLibraryItemDto>[],  List<EventStoryLibraryItemDto> votingStories = const <EventStoryLibraryItemDto>[]}): _tasks = tasks,_stories = stories,_votingStories = votingStories;
  factory _EventMissionDashboardDto.fromJson(Map<String, dynamic> json) => _$EventMissionDashboardDtoFromJson(json);

@override final  EventParticipationDto? participation;
@override@JsonKey() final  String completionMode;
@override final  int? requiredTaskCount;
@override final  int? requiredPoints;
@override@JsonKey() final  int completedTasksCount;
@override@JsonKey() final  int earnedPoints;
@override@JsonKey() final  bool allRequirementsMet;
 final  List<EventTaskProgressItemDto> _tasks;
@override@JsonKey() List<EventTaskProgressItemDto> get tasks {
  if (_tasks is EqualUnmodifiableListView) return _tasks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tasks);
}

 final  List<EventStoryLibraryItemDto> _stories;
@override@JsonKey() List<EventStoryLibraryItemDto> get stories {
  if (_stories is EqualUnmodifiableListView) return _stories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stories);
}

 final  List<EventStoryLibraryItemDto> _votingStories;
@override@JsonKey() List<EventStoryLibraryItemDto> get votingStories {
  if (_votingStories is EqualUnmodifiableListView) return _votingStories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_votingStories);
}


/// Create a copy of EventMissionDashboardDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventMissionDashboardDtoCopyWith<_EventMissionDashboardDto> get copyWith => __$EventMissionDashboardDtoCopyWithImpl<_EventMissionDashboardDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventMissionDashboardDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventMissionDashboardDto&&(identical(other.participation, participation) || other.participation == participation)&&(identical(other.completionMode, completionMode) || other.completionMode == completionMode)&&(identical(other.requiredTaskCount, requiredTaskCount) || other.requiredTaskCount == requiredTaskCount)&&(identical(other.requiredPoints, requiredPoints) || other.requiredPoints == requiredPoints)&&(identical(other.completedTasksCount, completedTasksCount) || other.completedTasksCount == completedTasksCount)&&(identical(other.earnedPoints, earnedPoints) || other.earnedPoints == earnedPoints)&&(identical(other.allRequirementsMet, allRequirementsMet) || other.allRequirementsMet == allRequirementsMet)&&const DeepCollectionEquality().equals(other.tasks, _tasks)&&const DeepCollectionEquality().equals(other.stories, _stories)&&const DeepCollectionEquality().equals(other.votingStories, _votingStories));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,participation,completionMode,requiredTaskCount,requiredPoints,completedTasksCount,earnedPoints,allRequirementsMet,const DeepCollectionEquality().hash(_tasks),const DeepCollectionEquality().hash(_stories),const DeepCollectionEquality().hash(_votingStories));
}

@override
String toString() {
    return 'EventMissionDashboardDto(participation: $participation, completionMode: $completionMode, requiredTaskCount: $requiredTaskCount, requiredPoints: $requiredPoints, completedTasksCount: $completedTasksCount, earnedPoints: $earnedPoints, allRequirementsMet: $allRequirementsMet, tasks: $tasks, stories: $stories, votingStories: $votingStories)';
}


}

/// @nodoc
abstract mixin class _$EventMissionDashboardDtoCopyWith<$Res> implements $EventMissionDashboardDtoCopyWith<$Res> {
  factory _$EventMissionDashboardDtoCopyWith(_EventMissionDashboardDto value, $Res Function(_EventMissionDashboardDto) _then) = __$EventMissionDashboardDtoCopyWithImpl;
@override @useResult
$Res call({
 EventParticipationDto? participation, String completionMode, int? requiredTaskCount, int? requiredPoints, int completedTasksCount, int earnedPoints, bool allRequirementsMet, List<EventTaskProgressItemDto> tasks, List<EventStoryLibraryItemDto> stories, List<EventStoryLibraryItemDto> votingStories
});


@override $EventParticipationDtoCopyWith<$Res>? get participation;

}
/// @nodoc
class __$EventMissionDashboardDtoCopyWithImpl<$Res>
    implements _$EventMissionDashboardDtoCopyWith<$Res> {
  __$EventMissionDashboardDtoCopyWithImpl(this._self, this._then);

  final _EventMissionDashboardDto _self;
  final $Res Function(_EventMissionDashboardDto) _then;

/// Create a copy of EventMissionDashboardDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? participation = freezed,Object? completionMode = null,Object? requiredTaskCount = freezed,Object? requiredPoints = freezed,Object? completedTasksCount = null,Object? earnedPoints = null,Object? allRequirementsMet = null,Object? tasks = null,Object? stories = null,Object? votingStories = null,}) {
  return _then(_EventMissionDashboardDto(
participation: freezed == participation ? _self.participation : participation // ignore: cast_nullable_to_non_nullable
as EventParticipationDto?,completionMode: null == completionMode ? _self.completionMode : completionMode // ignore: cast_nullable_to_non_nullable
as String,requiredTaskCount: freezed == requiredTaskCount ? _self.requiredTaskCount : requiredTaskCount // ignore: cast_nullable_to_non_nullable
as int?,requiredPoints: freezed == requiredPoints ? _self.requiredPoints : requiredPoints // ignore: cast_nullable_to_non_nullable
as int?,completedTasksCount: null == completedTasksCount ? _self.completedTasksCount : completedTasksCount // ignore: cast_nullable_to_non_nullable
as int,earnedPoints: null == earnedPoints ? _self.earnedPoints : earnedPoints // ignore: cast_nullable_to_non_nullable
as int,allRequirementsMet: null == allRequirementsMet ? _self.allRequirementsMet : allRequirementsMet // ignore: cast_nullable_to_non_nullable
as bool,tasks: null == tasks ? _self._tasks : tasks // ignore: cast_nullable_to_non_nullable
as List<EventTaskProgressItemDto>,stories: null == stories ? _self._stories : stories // ignore: cast_nullable_to_non_nullable
as List<EventStoryLibraryItemDto>,votingStories: null == votingStories ? _self._votingStories : votingStories // ignore: cast_nullable_to_non_nullable
as List<EventStoryLibraryItemDto>,
  ));
}

/// Create a copy of EventMissionDashboardDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EventParticipationDtoCopyWith<$Res>? get participation {
    if (_self.participation == null) {
    return null;
  }

  return $EventParticipationDtoCopyWith<$Res>(_self.participation!, (value) {
    return _then(_self.copyWith(participation: value));
  });
}
}


/// @nodoc
mixin _$EventTaskProgressItemDto {

 int get taskDefinitionId; String get taskCode; String get title; String get description; String get verifierType; int get targetValue; int get currentValue; bool get isCompleted; bool get isMandatory; int get points;
/// Create a copy of EventTaskProgressItemDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventTaskProgressItemDtoCopyWith<EventTaskProgressItemDto> get copyWith => _$EventTaskProgressItemDtoCopyWithImpl<EventTaskProgressItemDto>(this as EventTaskProgressItemDto, _$identity);

  /// Serializes this EventTaskProgressItemDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as EventTaskProgressItemDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventTaskProgressItemDto&&(identical(other.taskDefinitionId, _this.taskDefinitionId) || other.taskDefinitionId == _this.taskDefinitionId)&&(identical(other.taskCode, _this.taskCode) || other.taskCode == _this.taskCode)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.verifierType, _this.verifierType) || other.verifierType == _this.verifierType)&&(identical(other.targetValue, _this.targetValue) || other.targetValue == _this.targetValue)&&(identical(other.currentValue, _this.currentValue) || other.currentValue == _this.currentValue)&&(identical(other.isCompleted, _this.isCompleted) || other.isCompleted == _this.isCompleted)&&(identical(other.isMandatory, _this.isMandatory) || other.isMandatory == _this.isMandatory)&&(identical(other.points, _this.points) || other.points == _this.points));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as EventTaskProgressItemDto;
  return Object.hash(runtimeType,_this.taskDefinitionId,_this.taskCode,_this.title,_this.description,_this.verifierType,_this.targetValue,_this.currentValue,_this.isCompleted,_this.isMandatory,_this.points);
}

@override
String toString() {
  final _this = this as EventTaskProgressItemDto;
  return 'EventTaskProgressItemDto(taskDefinitionId: ${_this.taskDefinitionId}, taskCode: ${_this.taskCode}, title: ${_this.title}, description: ${_this.description}, verifierType: ${_this.verifierType}, targetValue: ${_this.targetValue}, currentValue: ${_this.currentValue}, isCompleted: ${_this.isCompleted}, isMandatory: ${_this.isMandatory}, points: ${_this.points})';
}


}

/// @nodoc
abstract mixin class $EventTaskProgressItemDtoCopyWith<$Res>  {
  factory $EventTaskProgressItemDtoCopyWith(EventTaskProgressItemDto value, $Res Function(EventTaskProgressItemDto) _then) = _$EventTaskProgressItemDtoCopyWithImpl;
@useResult
$Res call({
 int taskDefinitionId, String taskCode, String title, String description, String verifierType, int targetValue, int currentValue, bool isCompleted, bool isMandatory, int points
});




}
/// @nodoc
class _$EventTaskProgressItemDtoCopyWithImpl<$Res>
    implements $EventTaskProgressItemDtoCopyWith<$Res> {
  _$EventTaskProgressItemDtoCopyWithImpl(this._self, this._then);

  final EventTaskProgressItemDto _self;
  final $Res Function(EventTaskProgressItemDto) _then;

/// Create a copy of EventTaskProgressItemDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? taskDefinitionId = null,Object? taskCode = null,Object? title = null,Object? description = null,Object? verifierType = null,Object? targetValue = null,Object? currentValue = null,Object? isCompleted = null,Object? isMandatory = null,Object? points = null,}) {
  return _then(EventTaskProgressItemDto(
taskDefinitionId: null == taskDefinitionId ? _self.taskDefinitionId : taskDefinitionId // ignore: cast_nullable_to_non_nullable
as int,taskCode: null == taskCode ? _self.taskCode : taskCode // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,verifierType: null == verifierType ? _self.verifierType : verifierType // ignore: cast_nullable_to_non_nullable
as String,targetValue: null == targetValue ? _self.targetValue : targetValue // ignore: cast_nullable_to_non_nullable
as int,currentValue: null == currentValue ? _self.currentValue : currentValue // ignore: cast_nullable_to_non_nullable
as int,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,isMandatory: null == isMandatory ? _self.isMandatory : isMandatory // ignore: cast_nullable_to_non_nullable
as bool,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [EventTaskProgressItemDto].
extension EventTaskProgressItemDtoPatterns on EventTaskProgressItemDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventTaskProgressItemDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventTaskProgressItemDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventTaskProgressItemDto value)  $default,){
final _that = this;
switch (_that) {
case _EventTaskProgressItemDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventTaskProgressItemDto value)?  $default,){
final _that = this;
switch (_that) {
case _EventTaskProgressItemDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int taskDefinitionId,  String taskCode,  String title,  String description,  String verifierType,  int targetValue,  int currentValue,  bool isCompleted,  bool isMandatory,  int points)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventTaskProgressItemDto() when $default != null:
return $default(_that.taskDefinitionId,_that.taskCode,_that.title,_that.description,_that.verifierType,_that.targetValue,_that.currentValue,_that.isCompleted,_that.isMandatory,_that.points);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int taskDefinitionId,  String taskCode,  String title,  String description,  String verifierType,  int targetValue,  int currentValue,  bool isCompleted,  bool isMandatory,  int points)  $default,) {final _that = this;
switch (_that) {
case _EventTaskProgressItemDto():
return $default(_that.taskDefinitionId,_that.taskCode,_that.title,_that.description,_that.verifierType,_that.targetValue,_that.currentValue,_that.isCompleted,_that.isMandatory,_that.points);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int taskDefinitionId,  String taskCode,  String title,  String description,  String verifierType,  int targetValue,  int currentValue,  bool isCompleted,  bool isMandatory,  int points)?  $default,) {final _that = this;
switch (_that) {
case _EventTaskProgressItemDto() when $default != null:
return $default(_that.taskDefinitionId,_that.taskCode,_that.title,_that.description,_that.verifierType,_that.targetValue,_that.currentValue,_that.isCompleted,_that.isMandatory,_that.points);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventTaskProgressItemDto implements EventTaskProgressItemDto {
  const _EventTaskProgressItemDto({required this.taskDefinitionId, this.taskCode = '', this.title = '', this.description = '', this.verifierType = '', this.targetValue = 0, this.currentValue = 0, this.isCompleted = false, this.isMandatory = false, this.points = 0});
  factory _EventTaskProgressItemDto.fromJson(Map<String, dynamic> json) => _$EventTaskProgressItemDtoFromJson(json);

@override final  int taskDefinitionId;
@override@JsonKey() final  String taskCode;
@override@JsonKey() final  String title;
@override@JsonKey() final  String description;
@override@JsonKey() final  String verifierType;
@override@JsonKey() final  int targetValue;
@override@JsonKey() final  int currentValue;
@override@JsonKey() final  bool isCompleted;
@override@JsonKey() final  bool isMandatory;
@override@JsonKey() final  int points;

/// Create a copy of EventTaskProgressItemDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventTaskProgressItemDtoCopyWith<_EventTaskProgressItemDto> get copyWith => __$EventTaskProgressItemDtoCopyWithImpl<_EventTaskProgressItemDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventTaskProgressItemDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventTaskProgressItemDto&&(identical(other.taskDefinitionId, taskDefinitionId) || other.taskDefinitionId == taskDefinitionId)&&(identical(other.taskCode, taskCode) || other.taskCode == taskCode)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.verifierType, verifierType) || other.verifierType == verifierType)&&(identical(other.targetValue, targetValue) || other.targetValue == targetValue)&&(identical(other.currentValue, currentValue) || other.currentValue == currentValue)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.isMandatory, isMandatory) || other.isMandatory == isMandatory)&&(identical(other.points, points) || other.points == points));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,taskDefinitionId,taskCode,title,description,verifierType,targetValue,currentValue,isCompleted,isMandatory,points);
}

@override
String toString() {
    return 'EventTaskProgressItemDto(taskDefinitionId: $taskDefinitionId, taskCode: $taskCode, title: $title, description: $description, verifierType: $verifierType, targetValue: $targetValue, currentValue: $currentValue, isCompleted: $isCompleted, isMandatory: $isMandatory, points: $points)';
}


}

/// @nodoc
abstract mixin class _$EventTaskProgressItemDtoCopyWith<$Res> implements $EventTaskProgressItemDtoCopyWith<$Res> {
  factory _$EventTaskProgressItemDtoCopyWith(_EventTaskProgressItemDto value, $Res Function(_EventTaskProgressItemDto) _then) = __$EventTaskProgressItemDtoCopyWithImpl;
@override @useResult
$Res call({
 int taskDefinitionId, String taskCode, String title, String description, String verifierType, int targetValue, int currentValue, bool isCompleted, bool isMandatory, int points
});




}
/// @nodoc
class __$EventTaskProgressItemDtoCopyWithImpl<$Res>
    implements _$EventTaskProgressItemDtoCopyWith<$Res> {
  __$EventTaskProgressItemDtoCopyWithImpl(this._self, this._then);

  final _EventTaskProgressItemDto _self;
  final $Res Function(_EventTaskProgressItemDto) _then;

/// Create a copy of EventTaskProgressItemDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? taskDefinitionId = null,Object? taskCode = null,Object? title = null,Object? description = null,Object? verifierType = null,Object? targetValue = null,Object? currentValue = null,Object? isCompleted = null,Object? isMandatory = null,Object? points = null,}) {
  return _then(_EventTaskProgressItemDto(
taskDefinitionId: null == taskDefinitionId ? _self.taskDefinitionId : taskDefinitionId // ignore: cast_nullable_to_non_nullable
as int,taskCode: null == taskCode ? _self.taskCode : taskCode // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,verifierType: null == verifierType ? _self.verifierType : verifierType // ignore: cast_nullable_to_non_nullable
as String,targetValue: null == targetValue ? _self.targetValue : targetValue // ignore: cast_nullable_to_non_nullable
as int,currentValue: null == currentValue ? _self.currentValue : currentValue // ignore: cast_nullable_to_non_nullable
as int,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,isMandatory: null == isMandatory ? _self.isMandatory : isMandatory // ignore: cast_nullable_to_non_nullable
as bool,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$EventStoryLibraryItemDto {

 int get storyId; int get storyVersionId; String get title; String get description; String get ageBand; String get genre; String get source; bool get hasFamilyRead; int? get myVoteStars;
/// Create a copy of EventStoryLibraryItemDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventStoryLibraryItemDtoCopyWith<EventStoryLibraryItemDto> get copyWith => _$EventStoryLibraryItemDtoCopyWithImpl<EventStoryLibraryItemDto>(this as EventStoryLibraryItemDto, _$identity);

  /// Serializes this EventStoryLibraryItemDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as EventStoryLibraryItemDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventStoryLibraryItemDto&&(identical(other.storyId, _this.storyId) || other.storyId == _this.storyId)&&(identical(other.storyVersionId, _this.storyVersionId) || other.storyVersionId == _this.storyVersionId)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.ageBand, _this.ageBand) || other.ageBand == _this.ageBand)&&(identical(other.genre, _this.genre) || other.genre == _this.genre)&&(identical(other.source, _this.source) || other.source == _this.source)&&(identical(other.hasFamilyRead, _this.hasFamilyRead) || other.hasFamilyRead == _this.hasFamilyRead)&&(identical(other.myVoteStars, _this.myVoteStars) || other.myVoteStars == _this.myVoteStars));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as EventStoryLibraryItemDto;
  return Object.hash(runtimeType,_this.storyId,_this.storyVersionId,_this.title,_this.description,_this.ageBand,_this.genre,_this.source,_this.hasFamilyRead,_this.myVoteStars);
}

@override
String toString() {
  final _this = this as EventStoryLibraryItemDto;
  return 'EventStoryLibraryItemDto(storyId: ${_this.storyId}, storyVersionId: ${_this.storyVersionId}, title: ${_this.title}, description: ${_this.description}, ageBand: ${_this.ageBand}, genre: ${_this.genre}, source: ${_this.source}, hasFamilyRead: ${_this.hasFamilyRead}, myVoteStars: ${_this.myVoteStars})';
}


}

/// @nodoc
abstract mixin class $EventStoryLibraryItemDtoCopyWith<$Res>  {
  factory $EventStoryLibraryItemDtoCopyWith(EventStoryLibraryItemDto value, $Res Function(EventStoryLibraryItemDto) _then) = _$EventStoryLibraryItemDtoCopyWithImpl;
@useResult
$Res call({
 int storyId, int storyVersionId, String title, String description, String ageBand, String genre, String source, bool hasFamilyRead, int? myVoteStars
});




}
/// @nodoc
class _$EventStoryLibraryItemDtoCopyWithImpl<$Res>
    implements $EventStoryLibraryItemDtoCopyWith<$Res> {
  _$EventStoryLibraryItemDtoCopyWithImpl(this._self, this._then);

  final EventStoryLibraryItemDto _self;
  final $Res Function(EventStoryLibraryItemDto) _then;

/// Create a copy of EventStoryLibraryItemDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? storyId = null,Object? storyVersionId = null,Object? title = null,Object? description = null,Object? ageBand = null,Object? genre = null,Object? source = null,Object? hasFamilyRead = null,Object? myVoteStars = freezed,}) {
  return _then(EventStoryLibraryItemDto(
storyId: null == storyId ? _self.storyId : storyId // ignore: cast_nullable_to_non_nullable
as int,storyVersionId: null == storyVersionId ? _self.storyVersionId : storyVersionId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,ageBand: null == ageBand ? _self.ageBand : ageBand // ignore: cast_nullable_to_non_nullable
as String,genre: null == genre ? _self.genre : genre // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,hasFamilyRead: null == hasFamilyRead ? _self.hasFamilyRead : hasFamilyRead // ignore: cast_nullable_to_non_nullable
as bool,myVoteStars: freezed == myVoteStars ? _self.myVoteStars : myVoteStars // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [EventStoryLibraryItemDto].
extension EventStoryLibraryItemDtoPatterns on EventStoryLibraryItemDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventStoryLibraryItemDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventStoryLibraryItemDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventStoryLibraryItemDto value)  $default,){
final _that = this;
switch (_that) {
case _EventStoryLibraryItemDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventStoryLibraryItemDto value)?  $default,){
final _that = this;
switch (_that) {
case _EventStoryLibraryItemDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int storyId,  int storyVersionId,  String title,  String description,  String ageBand,  String genre,  String source,  bool hasFamilyRead,  int? myVoteStars)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventStoryLibraryItemDto() when $default != null:
return $default(_that.storyId,_that.storyVersionId,_that.title,_that.description,_that.ageBand,_that.genre,_that.source,_that.hasFamilyRead,_that.myVoteStars);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int storyId,  int storyVersionId,  String title,  String description,  String ageBand,  String genre,  String source,  bool hasFamilyRead,  int? myVoteStars)  $default,) {final _that = this;
switch (_that) {
case _EventStoryLibraryItemDto():
return $default(_that.storyId,_that.storyVersionId,_that.title,_that.description,_that.ageBand,_that.genre,_that.source,_that.hasFamilyRead,_that.myVoteStars);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int storyId,  int storyVersionId,  String title,  String description,  String ageBand,  String genre,  String source,  bool hasFamilyRead,  int? myVoteStars)?  $default,) {final _that = this;
switch (_that) {
case _EventStoryLibraryItemDto() when $default != null:
return $default(_that.storyId,_that.storyVersionId,_that.title,_that.description,_that.ageBand,_that.genre,_that.source,_that.hasFamilyRead,_that.myVoteStars);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventStoryLibraryItemDto implements EventStoryLibraryItemDto {
  const _EventStoryLibraryItemDto({required this.storyId, this.storyVersionId = 0, this.title = '', this.description = '', this.ageBand = '', this.genre = '', this.source = '', this.hasFamilyRead = false, this.myVoteStars});
  factory _EventStoryLibraryItemDto.fromJson(Map<String, dynamic> json) => _$EventStoryLibraryItemDtoFromJson(json);

@override final  int storyId;
@override@JsonKey() final  int storyVersionId;
@override@JsonKey() final  String title;
@override@JsonKey() final  String description;
@override@JsonKey() final  String ageBand;
@override@JsonKey() final  String genre;
@override@JsonKey() final  String source;
@override@JsonKey() final  bool hasFamilyRead;
@override final  int? myVoteStars;

/// Create a copy of EventStoryLibraryItemDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventStoryLibraryItemDtoCopyWith<_EventStoryLibraryItemDto> get copyWith => __$EventStoryLibraryItemDtoCopyWithImpl<_EventStoryLibraryItemDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventStoryLibraryItemDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventStoryLibraryItemDto&&(identical(other.storyId, storyId) || other.storyId == storyId)&&(identical(other.storyVersionId, storyVersionId) || other.storyVersionId == storyVersionId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.ageBand, ageBand) || other.ageBand == ageBand)&&(identical(other.genre, genre) || other.genre == genre)&&(identical(other.source, source) || other.source == source)&&(identical(other.hasFamilyRead, hasFamilyRead) || other.hasFamilyRead == hasFamilyRead)&&(identical(other.myVoteStars, myVoteStars) || other.myVoteStars == myVoteStars));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,storyId,storyVersionId,title,description,ageBand,genre,source,hasFamilyRead,myVoteStars);
}

@override
String toString() {
    return 'EventStoryLibraryItemDto(storyId: $storyId, storyVersionId: $storyVersionId, title: $title, description: $description, ageBand: $ageBand, genre: $genre, source: $source, hasFamilyRead: $hasFamilyRead, myVoteStars: $myVoteStars)';
}


}

/// @nodoc
abstract mixin class _$EventStoryLibraryItemDtoCopyWith<$Res> implements $EventStoryLibraryItemDtoCopyWith<$Res> {
  factory _$EventStoryLibraryItemDtoCopyWith(_EventStoryLibraryItemDto value, $Res Function(_EventStoryLibraryItemDto) _then) = __$EventStoryLibraryItemDtoCopyWithImpl;
@override @useResult
$Res call({
 int storyId, int storyVersionId, String title, String description, String ageBand, String genre, String source, bool hasFamilyRead, int? myVoteStars
});




}
/// @nodoc
class __$EventStoryLibraryItemDtoCopyWithImpl<$Res>
    implements _$EventStoryLibraryItemDtoCopyWith<$Res> {
  __$EventStoryLibraryItemDtoCopyWithImpl(this._self, this._then);

  final _EventStoryLibraryItemDto _self;
  final $Res Function(_EventStoryLibraryItemDto) _then;

/// Create a copy of EventStoryLibraryItemDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? storyId = null,Object? storyVersionId = null,Object? title = null,Object? description = null,Object? ageBand = null,Object? genre = null,Object? source = null,Object? hasFamilyRead = null,Object? myVoteStars = freezed,}) {
  return _then(_EventStoryLibraryItemDto(
storyId: null == storyId ? _self.storyId : storyId // ignore: cast_nullable_to_non_nullable
as int,storyVersionId: null == storyVersionId ? _self.storyVersionId : storyVersionId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,ageBand: null == ageBand ? _self.ageBand : ageBand // ignore: cast_nullable_to_non_nullable
as String,genre: null == genre ? _self.genre : genre // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,hasFamilyRead: null == hasFamilyRead ? _self.hasFamilyRead : hasFamilyRead // ignore: cast_nullable_to_non_nullable
as bool,myVoteStars: freezed == myVoteStars ? _self.myVoteStars : myVoteStars // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
