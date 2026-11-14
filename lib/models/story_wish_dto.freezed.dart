// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'story_wish_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChildWishCard {

 int get id; String get group; String get label; String get imageUrl; String? get audioUrl;
/// Create a copy of ChildWishCard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChildWishCardCopyWith<ChildWishCard> get copyWith => _$ChildWishCardCopyWithImpl<ChildWishCard>(this as ChildWishCard, _$identity);

  /// Serializes this ChildWishCard to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ChildWishCard;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChildWishCard&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.group, _this.group) || other.group == _this.group)&&(identical(other.label, _this.label) || other.label == _this.label)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl)&&(identical(other.audioUrl, _this.audioUrl) || other.audioUrl == _this.audioUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ChildWishCard;
  return Object.hash(runtimeType,_this.id,_this.group,_this.label,_this.imageUrl,_this.audioUrl);
}

@override
String toString() {
  final _this = this as ChildWishCard;
  return 'ChildWishCard(id: ${_this.id}, group: ${_this.group}, label: ${_this.label}, imageUrl: ${_this.imageUrl}, audioUrl: ${_this.audioUrl})';
}


}

/// @nodoc
abstract mixin class $ChildWishCardCopyWith<$Res>  {
  factory $ChildWishCardCopyWith(ChildWishCard value, $Res Function(ChildWishCard) _then) = _$ChildWishCardCopyWithImpl;
@useResult
$Res call({
 int id, String group, String label, String imageUrl, String? audioUrl
});




}
/// @nodoc
class _$ChildWishCardCopyWithImpl<$Res>
    implements $ChildWishCardCopyWith<$Res> {
  _$ChildWishCardCopyWithImpl(this._self, this._then);

  final ChildWishCard _self;
  final $Res Function(ChildWishCard) _then;

/// Create a copy of ChildWishCard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? group = null,Object? label = null,Object? imageUrl = null,Object? audioUrl = freezed,}) {
  return _then(ChildWishCard(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,group: null == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,audioUrl: freezed == audioUrl ? _self.audioUrl : audioUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChildWishCard].
extension ChildWishCardPatterns on ChildWishCard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChildWishCard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChildWishCard() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChildWishCard value)  $default,){
final _that = this;
switch (_that) {
case _ChildWishCard():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChildWishCard value)?  $default,){
final _that = this;
switch (_that) {
case _ChildWishCard() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String group,  String label,  String imageUrl,  String? audioUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChildWishCard() when $default != null:
return $default(_that.id,_that.group,_that.label,_that.imageUrl,_that.audioUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String group,  String label,  String imageUrl,  String? audioUrl)  $default,) {final _that = this;
switch (_that) {
case _ChildWishCard():
return $default(_that.id,_that.group,_that.label,_that.imageUrl,_that.audioUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String group,  String label,  String imageUrl,  String? audioUrl)?  $default,) {final _that = this;
switch (_that) {
case _ChildWishCard() when $default != null:
return $default(_that.id,_that.group,_that.label,_that.imageUrl,_that.audioUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChildWishCard implements ChildWishCard {
  const _ChildWishCard({required this.id, required this.group, required this.label, required this.imageUrl, this.audioUrl});
  factory _ChildWishCard.fromJson(Map<String, dynamic> json) => _$ChildWishCardFromJson(json);

@override final  int id;
@override final  String group;
@override final  String label;
@override final  String imageUrl;
@override final  String? audioUrl;

/// Create a copy of ChildWishCard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChildWishCardCopyWith<_ChildWishCard> get copyWith => __$ChildWishCardCopyWithImpl<_ChildWishCard>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChildWishCardToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChildWishCard&&(identical(other.id, id) || other.id == id)&&(identical(other.group, group) || other.group == group)&&(identical(other.label, label) || other.label == label)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.audioUrl, audioUrl) || other.audioUrl == audioUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,group,label,imageUrl,audioUrl);
}

@override
String toString() {
    return 'ChildWishCard(id: $id, group: $group, label: $label, imageUrl: $imageUrl, audioUrl: $audioUrl)';
}


}

/// @nodoc
abstract mixin class _$ChildWishCardCopyWith<$Res> implements $ChildWishCardCopyWith<$Res> {
  factory _$ChildWishCardCopyWith(_ChildWishCard value, $Res Function(_ChildWishCard) _then) = __$ChildWishCardCopyWithImpl;
@override @useResult
$Res call({
 int id, String group, String label, String imageUrl, String? audioUrl
});




}
/// @nodoc
class __$ChildWishCardCopyWithImpl<$Res>
    implements _$ChildWishCardCopyWith<$Res> {
  __$ChildWishCardCopyWithImpl(this._self, this._then);

  final _ChildWishCard _self;
  final $Res Function(_ChildWishCard) _then;

/// Create a copy of ChildWishCard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? group = null,Object? label = null,Object? imageUrl = null,Object? audioUrl = freezed,}) {
  return _then(_ChildWishCard(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,group: null == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,audioUrl: freezed == audioUrl ? _self.audioUrl : audioUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$WishSuggestion {

 int get rank; int? get storyId; int? get communitySubmissionId; String get title; String? get coverImageUrl; List<ChildWishCard> get matchedCards;
/// Create a copy of WishSuggestion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WishSuggestionCopyWith<WishSuggestion> get copyWith => _$WishSuggestionCopyWithImpl<WishSuggestion>(this as WishSuggestion, _$identity);

  /// Serializes this WishSuggestion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as WishSuggestion;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WishSuggestion&&(identical(other.rank, _this.rank) || other.rank == _this.rank)&&(identical(other.storyId, _this.storyId) || other.storyId == _this.storyId)&&(identical(other.communitySubmissionId, _this.communitySubmissionId) || other.communitySubmissionId == _this.communitySubmissionId)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.coverImageUrl, _this.coverImageUrl) || other.coverImageUrl == _this.coverImageUrl)&&const DeepCollectionEquality().equals(other.matchedCards, _this.matchedCards));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as WishSuggestion;
  return Object.hash(runtimeType,_this.rank,_this.storyId,_this.communitySubmissionId,_this.title,_this.coverImageUrl,const DeepCollectionEquality().hash(_this.matchedCards));
}

@override
String toString() {
  final _this = this as WishSuggestion;
  return 'WishSuggestion(rank: ${_this.rank}, storyId: ${_this.storyId}, communitySubmissionId: ${_this.communitySubmissionId}, title: ${_this.title}, coverImageUrl: ${_this.coverImageUrl}, matchedCards: ${_this.matchedCards})';
}


}

/// @nodoc
abstract mixin class $WishSuggestionCopyWith<$Res>  {
  factory $WishSuggestionCopyWith(WishSuggestion value, $Res Function(WishSuggestion) _then) = _$WishSuggestionCopyWithImpl;
@useResult
$Res call({
 int rank, int? storyId, int? communitySubmissionId, String title, String? coverImageUrl, List<ChildWishCard> matchedCards
});




}
/// @nodoc
class _$WishSuggestionCopyWithImpl<$Res>
    implements $WishSuggestionCopyWith<$Res> {
  _$WishSuggestionCopyWithImpl(this._self, this._then);

  final WishSuggestion _self;
  final $Res Function(WishSuggestion) _then;

/// Create a copy of WishSuggestion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rank = null,Object? storyId = freezed,Object? communitySubmissionId = freezed,Object? title = null,Object? coverImageUrl = freezed,Object? matchedCards = null,}) {
  return _then(WishSuggestion(
rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int,storyId: freezed == storyId ? _self.storyId : storyId // ignore: cast_nullable_to_non_nullable
as int?,communitySubmissionId: freezed == communitySubmissionId ? _self.communitySubmissionId : communitySubmissionId // ignore: cast_nullable_to_non_nullable
as int?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,matchedCards: null == matchedCards ? _self.matchedCards : matchedCards // ignore: cast_nullable_to_non_nullable
as List<ChildWishCard>,
  ));
}

}


/// Adds pattern-matching-related methods to [WishSuggestion].
extension WishSuggestionPatterns on WishSuggestion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WishSuggestion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WishSuggestion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WishSuggestion value)  $default,){
final _that = this;
switch (_that) {
case _WishSuggestion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WishSuggestion value)?  $default,){
final _that = this;
switch (_that) {
case _WishSuggestion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int rank,  int? storyId,  int? communitySubmissionId,  String title,  String? coverImageUrl,  List<ChildWishCard> matchedCards)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WishSuggestion() when $default != null:
return $default(_that.rank,_that.storyId,_that.communitySubmissionId,_that.title,_that.coverImageUrl,_that.matchedCards);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int rank,  int? storyId,  int? communitySubmissionId,  String title,  String? coverImageUrl,  List<ChildWishCard> matchedCards)  $default,) {final _that = this;
switch (_that) {
case _WishSuggestion():
return $default(_that.rank,_that.storyId,_that.communitySubmissionId,_that.title,_that.coverImageUrl,_that.matchedCards);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int rank,  int? storyId,  int? communitySubmissionId,  String title,  String? coverImageUrl,  List<ChildWishCard> matchedCards)?  $default,) {final _that = this;
switch (_that) {
case _WishSuggestion() when $default != null:
return $default(_that.rank,_that.storyId,_that.communitySubmissionId,_that.title,_that.coverImageUrl,_that.matchedCards);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WishSuggestion implements WishSuggestion {
  const _WishSuggestion({required this.rank, this.storyId, this.communitySubmissionId, required this.title, this.coverImageUrl,  List<ChildWishCard> matchedCards = const <ChildWishCard>[]}): _matchedCards = matchedCards;
  factory _WishSuggestion.fromJson(Map<String, dynamic> json) => _$WishSuggestionFromJson(json);

@override final  int rank;
@override final  int? storyId;
@override final  int? communitySubmissionId;
@override final  String title;
@override final  String? coverImageUrl;
 final  List<ChildWishCard> _matchedCards;
@override@JsonKey() List<ChildWishCard> get matchedCards {
  if (_matchedCards is EqualUnmodifiableListView) return _matchedCards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_matchedCards);
}


/// Create a copy of WishSuggestion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WishSuggestionCopyWith<_WishSuggestion> get copyWith => __$WishSuggestionCopyWithImpl<_WishSuggestion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WishSuggestionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _WishSuggestion&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.storyId, storyId) || other.storyId == storyId)&&(identical(other.communitySubmissionId, communitySubmissionId) || other.communitySubmissionId == communitySubmissionId)&&(identical(other.title, title) || other.title == title)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&const DeepCollectionEquality().equals(other.matchedCards, _matchedCards));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,rank,storyId,communitySubmissionId,title,coverImageUrl,const DeepCollectionEquality().hash(_matchedCards));
}

@override
String toString() {
    return 'WishSuggestion(rank: $rank, storyId: $storyId, communitySubmissionId: $communitySubmissionId, title: $title, coverImageUrl: $coverImageUrl, matchedCards: $matchedCards)';
}


}

/// @nodoc
abstract mixin class _$WishSuggestionCopyWith<$Res> implements $WishSuggestionCopyWith<$Res> {
  factory _$WishSuggestionCopyWith(_WishSuggestion value, $Res Function(_WishSuggestion) _then) = __$WishSuggestionCopyWithImpl;
@override @useResult
$Res call({
 int rank, int? storyId, int? communitySubmissionId, String title, String? coverImageUrl, List<ChildWishCard> matchedCards
});




}
/// @nodoc
class __$WishSuggestionCopyWithImpl<$Res>
    implements _$WishSuggestionCopyWith<$Res> {
  __$WishSuggestionCopyWithImpl(this._self, this._then);

  final _WishSuggestion _self;
  final $Res Function(_WishSuggestion) _then;

/// Create a copy of WishSuggestion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rank = null,Object? storyId = freezed,Object? communitySubmissionId = freezed,Object? title = null,Object? coverImageUrl = freezed,Object? matchedCards = null,}) {
  return _then(_WishSuggestion(
rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as int,storyId: freezed == storyId ? _self.storyId : storyId // ignore: cast_nullable_to_non_nullable
as int?,communitySubmissionId: freezed == communitySubmissionId ? _self.communitySubmissionId : communitySubmissionId // ignore: cast_nullable_to_non_nullable
as int?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,matchedCards: null == matchedCards ? _self._matchedCards : matchedCards // ignore: cast_nullable_to_non_nullable
as List<ChildWishCard>,
  ));
}


}


/// @nodoc
mixin _$WishDraft {

 int get wishId; bool get resumed; String get expiresAt; List<ChildWishCard> get cards; bool get lessonLeftToParent; bool get canSubmit;
/// Create a copy of WishDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WishDraftCopyWith<WishDraft> get copyWith => _$WishDraftCopyWithImpl<WishDraft>(this as WishDraft, _$identity);

  /// Serializes this WishDraft to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as WishDraft;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WishDraft&&(identical(other.wishId, _this.wishId) || other.wishId == _this.wishId)&&(identical(other.resumed, _this.resumed) || other.resumed == _this.resumed)&&(identical(other.expiresAt, _this.expiresAt) || other.expiresAt == _this.expiresAt)&&const DeepCollectionEquality().equals(other.cards, _this.cards)&&(identical(other.lessonLeftToParent, _this.lessonLeftToParent) || other.lessonLeftToParent == _this.lessonLeftToParent)&&(identical(other.canSubmit, _this.canSubmit) || other.canSubmit == _this.canSubmit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as WishDraft;
  return Object.hash(runtimeType,_this.wishId,_this.resumed,_this.expiresAt,const DeepCollectionEquality().hash(_this.cards),_this.lessonLeftToParent,_this.canSubmit);
}

@override
String toString() {
  final _this = this as WishDraft;
  return 'WishDraft(wishId: ${_this.wishId}, resumed: ${_this.resumed}, expiresAt: ${_this.expiresAt}, cards: ${_this.cards}, lessonLeftToParent: ${_this.lessonLeftToParent}, canSubmit: ${_this.canSubmit})';
}


}

/// @nodoc
abstract mixin class $WishDraftCopyWith<$Res>  {
  factory $WishDraftCopyWith(WishDraft value, $Res Function(WishDraft) _then) = _$WishDraftCopyWithImpl;
@useResult
$Res call({
 int wishId, bool resumed, String expiresAt, List<ChildWishCard> cards, bool lessonLeftToParent, bool canSubmit
});




}
/// @nodoc
class _$WishDraftCopyWithImpl<$Res>
    implements $WishDraftCopyWith<$Res> {
  _$WishDraftCopyWithImpl(this._self, this._then);

  final WishDraft _self;
  final $Res Function(WishDraft) _then;

/// Create a copy of WishDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? wishId = null,Object? resumed = null,Object? expiresAt = null,Object? cards = null,Object? lessonLeftToParent = null,Object? canSubmit = null,}) {
  return _then(WishDraft(
wishId: null == wishId ? _self.wishId : wishId // ignore: cast_nullable_to_non_nullable
as int,resumed: null == resumed ? _self.resumed : resumed // ignore: cast_nullable_to_non_nullable
as bool,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String,cards: null == cards ? _self.cards : cards // ignore: cast_nullable_to_non_nullable
as List<ChildWishCard>,lessonLeftToParent: null == lessonLeftToParent ? _self.lessonLeftToParent : lessonLeftToParent // ignore: cast_nullable_to_non_nullable
as bool,canSubmit: null == canSubmit ? _self.canSubmit : canSubmit // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [WishDraft].
extension WishDraftPatterns on WishDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WishDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WishDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WishDraft value)  $default,){
final _that = this;
switch (_that) {
case _WishDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WishDraft value)?  $default,){
final _that = this;
switch (_that) {
case _WishDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int wishId,  bool resumed,  String expiresAt,  List<ChildWishCard> cards,  bool lessonLeftToParent,  bool canSubmit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WishDraft() when $default != null:
return $default(_that.wishId,_that.resumed,_that.expiresAt,_that.cards,_that.lessonLeftToParent,_that.canSubmit);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int wishId,  bool resumed,  String expiresAt,  List<ChildWishCard> cards,  bool lessonLeftToParent,  bool canSubmit)  $default,) {final _that = this;
switch (_that) {
case _WishDraft():
return $default(_that.wishId,_that.resumed,_that.expiresAt,_that.cards,_that.lessonLeftToParent,_that.canSubmit);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int wishId,  bool resumed,  String expiresAt,  List<ChildWishCard> cards,  bool lessonLeftToParent,  bool canSubmit)?  $default,) {final _that = this;
switch (_that) {
case _WishDraft() when $default != null:
return $default(_that.wishId,_that.resumed,_that.expiresAt,_that.cards,_that.lessonLeftToParent,_that.canSubmit);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WishDraft implements WishDraft {
  const _WishDraft({required this.wishId, required this.resumed, required this.expiresAt,  List<ChildWishCard> cards = const <ChildWishCard>[], required this.lessonLeftToParent, required this.canSubmit}): _cards = cards;
  factory _WishDraft.fromJson(Map<String, dynamic> json) => _$WishDraftFromJson(json);

@override final  int wishId;
@override final  bool resumed;
@override final  String expiresAt;
 final  List<ChildWishCard> _cards;
@override@JsonKey() List<ChildWishCard> get cards {
  if (_cards is EqualUnmodifiableListView) return _cards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cards);
}

@override final  bool lessonLeftToParent;
@override final  bool canSubmit;

/// Create a copy of WishDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WishDraftCopyWith<_WishDraft> get copyWith => __$WishDraftCopyWithImpl<_WishDraft>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WishDraftToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _WishDraft&&(identical(other.wishId, wishId) || other.wishId == wishId)&&(identical(other.resumed, resumed) || other.resumed == resumed)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&const DeepCollectionEquality().equals(other.cards, _cards)&&(identical(other.lessonLeftToParent, lessonLeftToParent) || other.lessonLeftToParent == lessonLeftToParent)&&(identical(other.canSubmit, canSubmit) || other.canSubmit == canSubmit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,wishId,resumed,expiresAt,const DeepCollectionEquality().hash(_cards),lessonLeftToParent,canSubmit);
}

@override
String toString() {
    return 'WishDraft(wishId: $wishId, resumed: $resumed, expiresAt: $expiresAt, cards: $cards, lessonLeftToParent: $lessonLeftToParent, canSubmit: $canSubmit)';
}


}

/// @nodoc
abstract mixin class _$WishDraftCopyWith<$Res> implements $WishDraftCopyWith<$Res> {
  factory _$WishDraftCopyWith(_WishDraft value, $Res Function(_WishDraft) _then) = __$WishDraftCopyWithImpl;
@override @useResult
$Res call({
 int wishId, bool resumed, String expiresAt, List<ChildWishCard> cards, bool lessonLeftToParent, bool canSubmit
});




}
/// @nodoc
class __$WishDraftCopyWithImpl<$Res>
    implements _$WishDraftCopyWith<$Res> {
  __$WishDraftCopyWithImpl(this._self, this._then);

  final _WishDraft _self;
  final $Res Function(_WishDraft) _then;

/// Create a copy of WishDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? wishId = null,Object? resumed = null,Object? expiresAt = null,Object? cards = null,Object? lessonLeftToParent = null,Object? canSubmit = null,}) {
  return _then(_WishDraft(
wishId: null == wishId ? _self.wishId : wishId // ignore: cast_nullable_to_non_nullable
as int,resumed: null == resumed ? _self.resumed : resumed // ignore: cast_nullable_to_non_nullable
as bool,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String,cards: null == cards ? _self._cards : cards // ignore: cast_nullable_to_non_nullable
as List<ChildWishCard>,lessonLeftToParent: null == lessonLeftToParent ? _self.lessonLeftToParent : lessonLeftToParent // ignore: cast_nullable_to_non_nullable
as bool,canSubmit: null == canSubmit ? _self.canSubmit : canSubmit // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$StoryWish {

 int get wishId; String get kind; String get status; String get message; List<ChildWishCard> get cards; bool get lessonLeftToParent; int? get fulfilledStoryId; String? get submittedAt; List<WishSuggestion> get suggestions;
/// Create a copy of StoryWish
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoryWishCopyWith<StoryWish> get copyWith => _$StoryWishCopyWithImpl<StoryWish>(this as StoryWish, _$identity);

  /// Serializes this StoryWish to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as StoryWish;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StoryWish&&(identical(other.wishId, _this.wishId) || other.wishId == _this.wishId)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.message, _this.message) || other.message == _this.message)&&const DeepCollectionEquality().equals(other.cards, _this.cards)&&(identical(other.lessonLeftToParent, _this.lessonLeftToParent) || other.lessonLeftToParent == _this.lessonLeftToParent)&&(identical(other.fulfilledStoryId, _this.fulfilledStoryId) || other.fulfilledStoryId == _this.fulfilledStoryId)&&(identical(other.submittedAt, _this.submittedAt) || other.submittedAt == _this.submittedAt)&&const DeepCollectionEquality().equals(other.suggestions, _this.suggestions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as StoryWish;
  return Object.hash(runtimeType,_this.wishId,_this.kind,_this.status,_this.message,const DeepCollectionEquality().hash(_this.cards),_this.lessonLeftToParent,_this.fulfilledStoryId,_this.submittedAt,const DeepCollectionEquality().hash(_this.suggestions));
}

@override
String toString() {
  final _this = this as StoryWish;
  return 'StoryWish(wishId: ${_this.wishId}, kind: ${_this.kind}, status: ${_this.status}, message: ${_this.message}, cards: ${_this.cards}, lessonLeftToParent: ${_this.lessonLeftToParent}, fulfilledStoryId: ${_this.fulfilledStoryId}, submittedAt: ${_this.submittedAt}, suggestions: ${_this.suggestions})';
}


}

/// @nodoc
abstract mixin class $StoryWishCopyWith<$Res>  {
  factory $StoryWishCopyWith(StoryWish value, $Res Function(StoryWish) _then) = _$StoryWishCopyWithImpl;
@useResult
$Res call({
 int wishId, String kind, String status, String message, List<ChildWishCard> cards, bool lessonLeftToParent, int? fulfilledStoryId, String? submittedAt, List<WishSuggestion> suggestions
});




}
/// @nodoc
class _$StoryWishCopyWithImpl<$Res>
    implements $StoryWishCopyWith<$Res> {
  _$StoryWishCopyWithImpl(this._self, this._then);

  final StoryWish _self;
  final $Res Function(StoryWish) _then;

/// Create a copy of StoryWish
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? wishId = null,Object? kind = null,Object? status = null,Object? message = null,Object? cards = null,Object? lessonLeftToParent = null,Object? fulfilledStoryId = freezed,Object? submittedAt = freezed,Object? suggestions = null,}) {
  return _then(StoryWish(
wishId: null == wishId ? _self.wishId : wishId // ignore: cast_nullable_to_non_nullable
as int,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,cards: null == cards ? _self.cards : cards // ignore: cast_nullable_to_non_nullable
as List<ChildWishCard>,lessonLeftToParent: null == lessonLeftToParent ? _self.lessonLeftToParent : lessonLeftToParent // ignore: cast_nullable_to_non_nullable
as bool,fulfilledStoryId: freezed == fulfilledStoryId ? _self.fulfilledStoryId : fulfilledStoryId // ignore: cast_nullable_to_non_nullable
as int?,submittedAt: freezed == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as String?,suggestions: null == suggestions ? _self.suggestions : suggestions // ignore: cast_nullable_to_non_nullable
as List<WishSuggestion>,
  ));
}

}


/// Adds pattern-matching-related methods to [StoryWish].
extension StoryWishPatterns on StoryWish {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StoryWish value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StoryWish() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StoryWish value)  $default,){
final _that = this;
switch (_that) {
case _StoryWish():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StoryWish value)?  $default,){
final _that = this;
switch (_that) {
case _StoryWish() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int wishId,  String kind,  String status,  String message,  List<ChildWishCard> cards,  bool lessonLeftToParent,  int? fulfilledStoryId,  String? submittedAt,  List<WishSuggestion> suggestions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StoryWish() when $default != null:
return $default(_that.wishId,_that.kind,_that.status,_that.message,_that.cards,_that.lessonLeftToParent,_that.fulfilledStoryId,_that.submittedAt,_that.suggestions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int wishId,  String kind,  String status,  String message,  List<ChildWishCard> cards,  bool lessonLeftToParent,  int? fulfilledStoryId,  String? submittedAt,  List<WishSuggestion> suggestions)  $default,) {final _that = this;
switch (_that) {
case _StoryWish():
return $default(_that.wishId,_that.kind,_that.status,_that.message,_that.cards,_that.lessonLeftToParent,_that.fulfilledStoryId,_that.submittedAt,_that.suggestions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int wishId,  String kind,  String status,  String message,  List<ChildWishCard> cards,  bool lessonLeftToParent,  int? fulfilledStoryId,  String? submittedAt,  List<WishSuggestion> suggestions)?  $default,) {final _that = this;
switch (_that) {
case _StoryWish() when $default != null:
return $default(_that.wishId,_that.kind,_that.status,_that.message,_that.cards,_that.lessonLeftToParent,_that.fulfilledStoryId,_that.submittedAt,_that.suggestions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StoryWish implements StoryWish {
  const _StoryWish({required this.wishId, required this.kind, required this.status, required this.message,  List<ChildWishCard> cards = const <ChildWishCard>[], required this.lessonLeftToParent, this.fulfilledStoryId, this.submittedAt,  List<WishSuggestion> suggestions = const <WishSuggestion>[]}): _cards = cards,_suggestions = suggestions;
  factory _StoryWish.fromJson(Map<String, dynamic> json) => _$StoryWishFromJson(json);

@override final  int wishId;
@override final  String kind;
@override final  String status;
@override final  String message;
 final  List<ChildWishCard> _cards;
@override@JsonKey() List<ChildWishCard> get cards {
  if (_cards is EqualUnmodifiableListView) return _cards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cards);
}

@override final  bool lessonLeftToParent;
@override final  int? fulfilledStoryId;
@override final  String? submittedAt;
 final  List<WishSuggestion> _suggestions;
@override@JsonKey() List<WishSuggestion> get suggestions {
  if (_suggestions is EqualUnmodifiableListView) return _suggestions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_suggestions);
}


/// Create a copy of StoryWish
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StoryWishCopyWith<_StoryWish> get copyWith => __$StoryWishCopyWithImpl<_StoryWish>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StoryWishToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StoryWish&&(identical(other.wishId, wishId) || other.wishId == wishId)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.cards, _cards)&&(identical(other.lessonLeftToParent, lessonLeftToParent) || other.lessonLeftToParent == lessonLeftToParent)&&(identical(other.fulfilledStoryId, fulfilledStoryId) || other.fulfilledStoryId == fulfilledStoryId)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt)&&const DeepCollectionEquality().equals(other.suggestions, _suggestions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,wishId,kind,status,message,const DeepCollectionEquality().hash(_cards),lessonLeftToParent,fulfilledStoryId,submittedAt,const DeepCollectionEquality().hash(_suggestions));
}

@override
String toString() {
    return 'StoryWish(wishId: $wishId, kind: $kind, status: $status, message: $message, cards: $cards, lessonLeftToParent: $lessonLeftToParent, fulfilledStoryId: $fulfilledStoryId, submittedAt: $submittedAt, suggestions: $suggestions)';
}


}

/// @nodoc
abstract mixin class _$StoryWishCopyWith<$Res> implements $StoryWishCopyWith<$Res> {
  factory _$StoryWishCopyWith(_StoryWish value, $Res Function(_StoryWish) _then) = __$StoryWishCopyWithImpl;
@override @useResult
$Res call({
 int wishId, String kind, String status, String message, List<ChildWishCard> cards, bool lessonLeftToParent, int? fulfilledStoryId, String? submittedAt, List<WishSuggestion> suggestions
});




}
/// @nodoc
class __$StoryWishCopyWithImpl<$Res>
    implements _$StoryWishCopyWith<$Res> {
  __$StoryWishCopyWithImpl(this._self, this._then);

  final _StoryWish _self;
  final $Res Function(_StoryWish) _then;

/// Create a copy of StoryWish
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? wishId = null,Object? kind = null,Object? status = null,Object? message = null,Object? cards = null,Object? lessonLeftToParent = null,Object? fulfilledStoryId = freezed,Object? submittedAt = freezed,Object? suggestions = null,}) {
  return _then(_StoryWish(
wishId: null == wishId ? _self.wishId : wishId // ignore: cast_nullable_to_non_nullable
as int,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,cards: null == cards ? _self._cards : cards // ignore: cast_nullable_to_non_nullable
as List<ChildWishCard>,lessonLeftToParent: null == lessonLeftToParent ? _self.lessonLeftToParent : lessonLeftToParent // ignore: cast_nullable_to_non_nullable
as bool,fulfilledStoryId: freezed == fulfilledStoryId ? _self.fulfilledStoryId : fulfilledStoryId // ignore: cast_nullable_to_non_nullable
as int?,submittedAt: freezed == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as String?,suggestions: null == suggestions ? _self._suggestions : suggestions // ignore: cast_nullable_to_non_nullable
as List<WishSuggestion>,
  ));
}


}


/// @nodoc
mixin _$SelectWishCardRequest {

 String get group; int? get cardId; bool get leaveToParent;
/// Create a copy of SelectWishCardRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectWishCardRequestCopyWith<SelectWishCardRequest> get copyWith => _$SelectWishCardRequestCopyWithImpl<SelectWishCardRequest>(this as SelectWishCardRequest, _$identity);

  /// Serializes this SelectWishCardRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SelectWishCardRequest;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectWishCardRequest&&(identical(other.group, _this.group) || other.group == _this.group)&&(identical(other.cardId, _this.cardId) || other.cardId == _this.cardId)&&(identical(other.leaveToParent, _this.leaveToParent) || other.leaveToParent == _this.leaveToParent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SelectWishCardRequest;
  return Object.hash(runtimeType,_this.group,_this.cardId,_this.leaveToParent);
}

@override
String toString() {
  final _this = this as SelectWishCardRequest;
  return 'SelectWishCardRequest(group: ${_this.group}, cardId: ${_this.cardId}, leaveToParent: ${_this.leaveToParent})';
}


}

/// @nodoc
abstract mixin class $SelectWishCardRequestCopyWith<$Res>  {
  factory $SelectWishCardRequestCopyWith(SelectWishCardRequest value, $Res Function(SelectWishCardRequest) _then) = _$SelectWishCardRequestCopyWithImpl;
@useResult
$Res call({
 String group, int? cardId, bool leaveToParent
});




}
/// @nodoc
class _$SelectWishCardRequestCopyWithImpl<$Res>
    implements $SelectWishCardRequestCopyWith<$Res> {
  _$SelectWishCardRequestCopyWithImpl(this._self, this._then);

  final SelectWishCardRequest _self;
  final $Res Function(SelectWishCardRequest) _then;

/// Create a copy of SelectWishCardRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? group = null,Object? cardId = freezed,Object? leaveToParent = null,}) {
  return _then(SelectWishCardRequest(
group: null == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as String,cardId: freezed == cardId ? _self.cardId : cardId // ignore: cast_nullable_to_non_nullable
as int?,leaveToParent: null == leaveToParent ? _self.leaveToParent : leaveToParent // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SelectWishCardRequest].
extension SelectWishCardRequestPatterns on SelectWishCardRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SelectWishCardRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SelectWishCardRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SelectWishCardRequest value)  $default,){
final _that = this;
switch (_that) {
case _SelectWishCardRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SelectWishCardRequest value)?  $default,){
final _that = this;
switch (_that) {
case _SelectWishCardRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String group,  int? cardId,  bool leaveToParent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SelectWishCardRequest() when $default != null:
return $default(_that.group,_that.cardId,_that.leaveToParent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String group,  int? cardId,  bool leaveToParent)  $default,) {final _that = this;
switch (_that) {
case _SelectWishCardRequest():
return $default(_that.group,_that.cardId,_that.leaveToParent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String group,  int? cardId,  bool leaveToParent)?  $default,) {final _that = this;
switch (_that) {
case _SelectWishCardRequest() when $default != null:
return $default(_that.group,_that.cardId,_that.leaveToParent);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SelectWishCardRequest implements SelectWishCardRequest {
  const _SelectWishCardRequest({required this.group, this.cardId, this.leaveToParent = false});
  factory _SelectWishCardRequest.fromJson(Map<String, dynamic> json) => _$SelectWishCardRequestFromJson(json);

@override final  String group;
@override final  int? cardId;
@override@JsonKey() final  bool leaveToParent;

/// Create a copy of SelectWishCardRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectWishCardRequestCopyWith<_SelectWishCardRequest> get copyWith => __$SelectWishCardRequestCopyWithImpl<_SelectWishCardRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SelectWishCardRequestToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelectWishCardRequest&&(identical(other.group, group) || other.group == group)&&(identical(other.cardId, cardId) || other.cardId == cardId)&&(identical(other.leaveToParent, leaveToParent) || other.leaveToParent == leaveToParent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,group,cardId,leaveToParent);
}

@override
String toString() {
    return 'SelectWishCardRequest(group: $group, cardId: $cardId, leaveToParent: $leaveToParent)';
}


}

/// @nodoc
abstract mixin class _$SelectWishCardRequestCopyWith<$Res> implements $SelectWishCardRequestCopyWith<$Res> {
  factory _$SelectWishCardRequestCopyWith(_SelectWishCardRequest value, $Res Function(_SelectWishCardRequest) _then) = __$SelectWishCardRequestCopyWithImpl;
@override @useResult
$Res call({
 String group, int? cardId, bool leaveToParent
});




}
/// @nodoc
class __$SelectWishCardRequestCopyWithImpl<$Res>
    implements _$SelectWishCardRequestCopyWith<$Res> {
  __$SelectWishCardRequestCopyWithImpl(this._self, this._then);

  final _SelectWishCardRequest _self;
  final $Res Function(_SelectWishCardRequest) _then;

/// Create a copy of SelectWishCardRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? group = null,Object? cardId = freezed,Object? leaveToParent = null,}) {
  return _then(_SelectWishCardRequest(
group: null == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as String,cardId: freezed == cardId ? _self.cardId : cardId // ignore: cast_nullable_to_non_nullable
as int?,leaveToParent: null == leaveToParent ? _self.leaveToParent : leaveToParent // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
