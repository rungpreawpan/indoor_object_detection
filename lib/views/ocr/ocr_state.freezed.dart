// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ocr_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OcrState {

 bool get isLoading; OcrModel? get ocrText;
/// Create a copy of OcrState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OcrStateCopyWith<OcrState> get copyWith => _$OcrStateCopyWithImpl<OcrState>(this as OcrState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OcrState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.ocrText, ocrText) || other.ocrText == ocrText));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,ocrText);

@override
String toString() {
  return 'OcrState(isLoading: $isLoading, ocrText: $ocrText)';
}


}

/// @nodoc
abstract mixin class $OcrStateCopyWith<$Res>  {
  factory $OcrStateCopyWith(OcrState value, $Res Function(OcrState) _then) = _$OcrStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, OcrModel? ocrText
});




}
/// @nodoc
class _$OcrStateCopyWithImpl<$Res>
    implements $OcrStateCopyWith<$Res> {
  _$OcrStateCopyWithImpl(this._self, this._then);

  final OcrState _self;
  final $Res Function(OcrState) _then;

/// Create a copy of OcrState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? ocrText = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,ocrText: freezed == ocrText ? _self.ocrText : ocrText // ignore: cast_nullable_to_non_nullable
as OcrModel?,
  ));
}

}


/// Adds pattern-matching-related methods to [OcrState].
extension OcrStatePatterns on OcrState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OcrState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OcrState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OcrState value)  $default,){
final _that = this;
switch (_that) {
case _OcrState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OcrState value)?  $default,){
final _that = this;
switch (_that) {
case _OcrState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  OcrModel? ocrText)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OcrState() when $default != null:
return $default(_that.isLoading,_that.ocrText);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  OcrModel? ocrText)  $default,) {final _that = this;
switch (_that) {
case _OcrState():
return $default(_that.isLoading,_that.ocrText);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  OcrModel? ocrText)?  $default,) {final _that = this;
switch (_that) {
case _OcrState() when $default != null:
return $default(_that.isLoading,_that.ocrText);case _:
  return null;

}
}

}

/// @nodoc


class _OcrState implements OcrState {
  const _OcrState({this.isLoading = false, this.ocrText});
  

@override@JsonKey() final  bool isLoading;
@override final  OcrModel? ocrText;

/// Create a copy of OcrState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OcrStateCopyWith<_OcrState> get copyWith => __$OcrStateCopyWithImpl<_OcrState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OcrState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.ocrText, ocrText) || other.ocrText == ocrText));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,ocrText);

@override
String toString() {
  return 'OcrState(isLoading: $isLoading, ocrText: $ocrText)';
}


}

/// @nodoc
abstract mixin class _$OcrStateCopyWith<$Res> implements $OcrStateCopyWith<$Res> {
  factory _$OcrStateCopyWith(_OcrState value, $Res Function(_OcrState) _then) = __$OcrStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, OcrModel? ocrText
});




}
/// @nodoc
class __$OcrStateCopyWithImpl<$Res>
    implements _$OcrStateCopyWith<$Res> {
  __$OcrStateCopyWithImpl(this._self, this._then);

  final _OcrState _self;
  final $Res Function(_OcrState) _then;

/// Create a copy of OcrState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? ocrText = freezed,}) {
  return _then(_OcrState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,ocrText: freezed == ocrText ? _self.ocrText : ocrText // ignore: cast_nullable_to_non_nullable
as OcrModel?,
  ));
}


}

// dart format on
