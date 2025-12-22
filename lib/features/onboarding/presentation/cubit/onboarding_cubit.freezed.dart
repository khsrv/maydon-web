// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OnboardingState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingState()';
}


}

/// @nodoc
class $OnboardingStateCopyWith<$Res>  {
$OnboardingStateCopyWith(OnboardingState _, $Res Function(OnboardingState) __);
}


/// Adds pattern-matching-related methods to [OnboardingState].
extension OnboardingStatePatterns on OnboardingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Loading value)?  loading,TResult Function( _Needs value)?  needs,TResult Function( _Skipped value)?  skipped,TResult Function( _Completed value)?  completed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Loading() when loading != null:
return loading(_that);case _Needs() when needs != null:
return needs(_that);case _Skipped() when skipped != null:
return skipped(_that);case _Completed() when completed != null:
return completed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Loading value)  loading,required TResult Function( _Needs value)  needs,required TResult Function( _Skipped value)  skipped,required TResult Function( _Completed value)  completed,}){
final _that = this;
switch (_that) {
case _Loading():
return loading(_that);case _Needs():
return needs(_that);case _Skipped():
return skipped(_that);case _Completed():
return completed(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Loading value)?  loading,TResult? Function( _Needs value)?  needs,TResult? Function( _Skipped value)?  skipped,TResult? Function( _Completed value)?  completed,}){
final _that = this;
switch (_that) {
case _Loading() when loading != null:
return loading(_that);case _Needs() when needs != null:
return needs(_that);case _Skipped() when skipped != null:
return skipped(_that);case _Completed() when completed != null:
return completed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function()?  needs,TResult Function()?  skipped,TResult Function()?  completed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Loading() when loading != null:
return loading();case _Needs() when needs != null:
return needs();case _Skipped() when skipped != null:
return skipped();case _Completed() when completed != null:
return completed();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function()  needs,required TResult Function()  skipped,required TResult Function()  completed,}) {final _that = this;
switch (_that) {
case _Loading():
return loading();case _Needs():
return needs();case _Skipped():
return skipped();case _Completed():
return completed();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function()?  needs,TResult? Function()?  skipped,TResult? Function()?  completed,}) {final _that = this;
switch (_that) {
case _Loading() when loading != null:
return loading();case _Needs() when needs != null:
return needs();case _Skipped() when skipped != null:
return skipped();case _Completed() when completed != null:
return completed();case _:
  return null;

}
}

}

/// @nodoc


class _Loading implements OnboardingState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingState.loading()';
}


}




/// @nodoc


class _Needs implements OnboardingState {
  const _Needs();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Needs);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingState.needs()';
}


}




/// @nodoc


class _Skipped implements OnboardingState {
  const _Skipped();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Skipped);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingState.skipped()';
}


}




/// @nodoc


class _Completed implements OnboardingState {
  const _Completed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Completed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingState.completed()';
}


}




// dart format on
