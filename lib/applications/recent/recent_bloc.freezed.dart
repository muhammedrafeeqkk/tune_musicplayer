// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'recent_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RecentEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() recentsong,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? recentsong,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? recentsong,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Recentsong value) recentsong,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Recentsong value)? recentsong,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Recentsong value)? recentsong,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecentEventCopyWith<$Res> {
  factory $RecentEventCopyWith(
          RecentEvent value, $Res Function(RecentEvent) then) =
      _$RecentEventCopyWithImpl<$Res, RecentEvent>;
}

/// @nodoc
class _$RecentEventCopyWithImpl<$Res, $Val extends RecentEvent>
    implements $RecentEventCopyWith<$Res> {
  _$RecentEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$RecentsongCopyWith<$Res> {
  factory _$$RecentsongCopyWith(
          _$Recentsong value, $Res Function(_$Recentsong) then) =
      __$$RecentsongCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RecentsongCopyWithImpl<$Res>
    extends _$RecentEventCopyWithImpl<$Res, _$Recentsong>
    implements _$$RecentsongCopyWith<$Res> {
  __$$RecentsongCopyWithImpl(
      _$Recentsong _value, $Res Function(_$Recentsong) _then)
      : super(_value, _then);
}

/// @nodoc

class _$Recentsong with DiagnosticableTreeMixin implements Recentsong {
  const _$Recentsong();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RecentEvent.recentsong()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'RecentEvent.recentsong'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$Recentsong);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() recentsong,
  }) {
    return recentsong();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? recentsong,
  }) {
    return recentsong?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? recentsong,
    required TResult orElse(),
  }) {
    if (recentsong != null) {
      return recentsong();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Recentsong value) recentsong,
  }) {
    return recentsong(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Recentsong value)? recentsong,
  }) {
    return recentsong?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Recentsong value)? recentsong,
    required TResult orElse(),
  }) {
    if (recentsong != null) {
      return recentsong(this);
    }
    return orElse();
  }
}

abstract class Recentsong implements RecentEvent {
  const factory Recentsong() = _$Recentsong;
}

/// @nodoc
mixin _$RecentState {
  List<DBSongs> get RecentSongList => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RecentStateCopyWith<RecentState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecentStateCopyWith<$Res> {
  factory $RecentStateCopyWith(
          RecentState value, $Res Function(RecentState) then) =
      _$RecentStateCopyWithImpl<$Res, RecentState>;
  @useResult
  $Res call({List<DBSongs> RecentSongList});
}

/// @nodoc
class _$RecentStateCopyWithImpl<$Res, $Val extends RecentState>
    implements $RecentStateCopyWith<$Res> {
  _$RecentStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? RecentSongList = null,
  }) {
    return _then(_value.copyWith(
      RecentSongList: null == RecentSongList
          ? _value.RecentSongList
          : RecentSongList // ignore: cast_nullable_to_non_nullable
              as List<DBSongs>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RecentStateCopyWith<$Res>
    implements $RecentStateCopyWith<$Res> {
  factory _$$_RecentStateCopyWith(
          _$_RecentState value, $Res Function(_$_RecentState) then) =
      __$$_RecentStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<DBSongs> RecentSongList});
}

/// @nodoc
class __$$_RecentStateCopyWithImpl<$Res>
    extends _$RecentStateCopyWithImpl<$Res, _$_RecentState>
    implements _$$_RecentStateCopyWith<$Res> {
  __$$_RecentStateCopyWithImpl(
      _$_RecentState _value, $Res Function(_$_RecentState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? RecentSongList = null,
  }) {
    return _then(_$_RecentState(
      RecentSongList: null == RecentSongList
          ? _value._RecentSongList
          : RecentSongList // ignore: cast_nullable_to_non_nullable
              as List<DBSongs>,
    ));
  }
}

/// @nodoc

class _$_RecentState with DiagnosticableTreeMixin implements _RecentState {
  const _$_RecentState({required final List<DBSongs> RecentSongList})
      : _RecentSongList = RecentSongList;

  final List<DBSongs> _RecentSongList;
  @override
  List<DBSongs> get RecentSongList {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_RecentSongList);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RecentState(RecentSongList: $RecentSongList)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RecentState'))
      ..add(DiagnosticsProperty('RecentSongList', RecentSongList));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RecentState &&
            const DeepCollectionEquality()
                .equals(other._RecentSongList, _RecentSongList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_RecentSongList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RecentStateCopyWith<_$_RecentState> get copyWith =>
      __$$_RecentStateCopyWithImpl<_$_RecentState>(this, _$identity);
}

abstract class _RecentState implements RecentState {
  const factory _RecentState({required final List<DBSongs> RecentSongList}) =
      _$_RecentState;

  @override
  List<DBSongs> get RecentSongList;
  @override
  @JsonKey(ignore: true)
  _$$_RecentStateCopyWith<_$_RecentState> get copyWith =>
      throw _privateConstructorUsedError;
}
