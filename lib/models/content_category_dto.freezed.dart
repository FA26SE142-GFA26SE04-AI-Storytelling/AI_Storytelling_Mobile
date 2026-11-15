// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'content_category_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ContentCategoryDto {

 int get id; String get code; String get displayName; bool get isActive; List<String> get defaultBlockedAgeBands;
/// Create a copy of ContentCategoryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentCategoryDtoCopyWith<ContentCategoryDto> get copyWith => _$ContentCategoryDtoCopyWithImpl<ContentCategoryDto>(this as ContentCategoryDto, _$identity);

  /// Serializes this ContentCategoryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ContentCategoryDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentCategoryDto&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.isActive, _this.isActive) || other.isActive == _this.isActive)&&const DeepCollectionEquality().equals(other.defaultBlockedAgeBands, _this.defaultBlockedAgeBands));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ContentCategoryDto;
  return Object.hash(runtimeType,_this.id,_this.code,_this.displayName,_this.isActive,const DeepCollectionEquality().hash(_this.defaultBlockedAgeBands));
}

@override
String toString() {
  final _this = this as ContentCategoryDto;
  return 'ContentCategoryDto(id: ${_this.id}, code: ${_this.code}, displayName: ${_this.displayName}, isActive: ${_this.isActive}, defaultBlockedAgeBands: ${_this.defaultBlockedAgeBands})';
}


}

/// @nodoc
abstract mixin class $ContentCategoryDtoCopyWith<$Res>  {
  factory $ContentCategoryDtoCopyWith(ContentCategoryDto value, $Res Function(ContentCategoryDto) _then) = _$ContentCategoryDtoCopyWithImpl;
@useResult
$Res call({
 int id, String code, String displayName, bool isActive, List<String> defaultBlockedAgeBands
});




}
/// @nodoc
class _$ContentCategoryDtoCopyWithImpl<$Res>
    implements $ContentCategoryDtoCopyWith<$Res> {
  _$ContentCategoryDtoCopyWithImpl(this._self, this._then);

  final ContentCategoryDto _self;
  final $Res Function(ContentCategoryDto) _then;

/// Create a copy of ContentCategoryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? code = null,Object? displayName = null,Object? isActive = null,Object? defaultBlockedAgeBands = null,}) {
  return _then(ContentCategoryDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,defaultBlockedAgeBands: null == defaultBlockedAgeBands ? _self.defaultBlockedAgeBands : defaultBlockedAgeBands // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [ContentCategoryDto].
extension ContentCategoryDtoPatterns on ContentCategoryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContentCategoryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContentCategoryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContentCategoryDto value)  $default,){
final _that = this;
switch (_that) {
case _ContentCategoryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContentCategoryDto value)?  $default,){
final _that = this;
switch (_that) {
case _ContentCategoryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String code,  String displayName,  bool isActive,  List<String> defaultBlockedAgeBands)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContentCategoryDto() when $default != null:
return $default(_that.id,_that.code,_that.displayName,_that.isActive,_that.defaultBlockedAgeBands);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String code,  String displayName,  bool isActive,  List<String> defaultBlockedAgeBands)  $default,) {final _that = this;
switch (_that) {
case _ContentCategoryDto():
return $default(_that.id,_that.code,_that.displayName,_that.isActive,_that.defaultBlockedAgeBands);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String code,  String displayName,  bool isActive,  List<String> defaultBlockedAgeBands)?  $default,) {final _that = this;
switch (_that) {
case _ContentCategoryDto() when $default != null:
return $default(_that.id,_that.code,_that.displayName,_that.isActive,_that.defaultBlockedAgeBands);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContentCategoryDto implements ContentCategoryDto {
  const _ContentCategoryDto({required this.id, required this.code, required this.displayName, required this.isActive,  List<String> defaultBlockedAgeBands = const []}): _defaultBlockedAgeBands = defaultBlockedAgeBands;
  factory _ContentCategoryDto.fromJson(Map<String, dynamic> json) => _$ContentCategoryDtoFromJson(json);

@override final  int id;
@override final  String code;
@override final  String displayName;
@override final  bool isActive;
 final  List<String> _defaultBlockedAgeBands;
@override@JsonKey() List<String> get defaultBlockedAgeBands {
  if (_defaultBlockedAgeBands is EqualUnmodifiableListView) return _defaultBlockedAgeBands;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_defaultBlockedAgeBands);
}


/// Create a copy of ContentCategoryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContentCategoryDtoCopyWith<_ContentCategoryDto> get copyWith => __$ContentCategoryDtoCopyWithImpl<_ContentCategoryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContentCategoryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContentCategoryDto&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&const DeepCollectionEquality().equals(other.defaultBlockedAgeBands, _defaultBlockedAgeBands));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,code,displayName,isActive,const DeepCollectionEquality().hash(_defaultBlockedAgeBands));
}

@override
String toString() {
    return 'ContentCategoryDto(id: $id, code: $code, displayName: $displayName, isActive: $isActive, defaultBlockedAgeBands: $defaultBlockedAgeBands)';
}


}

/// @nodoc
abstract mixin class _$ContentCategoryDtoCopyWith<$Res> implements $ContentCategoryDtoCopyWith<$Res> {
  factory _$ContentCategoryDtoCopyWith(_ContentCategoryDto value, $Res Function(_ContentCategoryDto) _then) = __$ContentCategoryDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String code, String displayName, bool isActive, List<String> defaultBlockedAgeBands
});




}
/// @nodoc
class __$ContentCategoryDtoCopyWithImpl<$Res>
    implements _$ContentCategoryDtoCopyWith<$Res> {
  __$ContentCategoryDtoCopyWithImpl(this._self, this._then);

  final _ContentCategoryDto _self;
  final $Res Function(_ContentCategoryDto) _then;

/// Create a copy of ContentCategoryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? code = null,Object? displayName = null,Object? isActive = null,Object? defaultBlockedAgeBands = null,}) {
  return _then(_ContentCategoryDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,defaultBlockedAgeBands: null == defaultBlockedAgeBands ? _self._defaultBlockedAgeBands : defaultBlockedAgeBands // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
