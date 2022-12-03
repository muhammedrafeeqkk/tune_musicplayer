// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'favorites_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$FavoritesEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() favorite,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? favorite,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? favorite,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Favorite value) favorite,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Favorite value)? favorite,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Favorite value)? favorite,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoritesEventCopyWith<$Res> {
  factory $FavoritesEventCopyWith(
          FavoritesEvent value, $Res Function(FavoritesEvent) then) =
      _$FavoritesEventCopyWithImpl<$Res, FavoritesEvent>;
}

/// @nodoc
class _$FavoritesEventCopyWithImpl<$Res, $Val extends FavoritesEvent>
    implements $FavoritesEventCopyWith<$Res> {
  _$FavoritesEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$FavoriteCopyWith<$Res> {
  factory _$$FavoriteCopyWith(
          _$Favorite value, $Res Function(_$Favorite) then) =
      __$$FavoriteCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FavoriteCopyWithImpl<$Res>
    extends _$FavoritesEventCopyWithImpl<$Res, _$Favorite>
    implements _$$FavoriteCopyWith<$Res> {
  __$$FavoriteCopyWithImpl(_$Favorite _value, $Res Function(_$Favorite) _then)
      : super(_value, _then);
}

/// @nodoc

class _$Favorite implements Favorite {
  const _$Favorite();

  @override
  String toString() {
    return 'FavoritesEvent.favorite()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$Favorite);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() favorite,
  }) {
    return favorite();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? favorite,
  }) {
    return favorite?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? favorite,
    required TResult orElse(),
  }) {
    if (favorite != null) {
      return favorite();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Favorite value) favorite,
  }) {
    return favorite(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Favorite value)? favorite,
  }) {
    return favorite?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Favorite value)? favorite,
    required TResult orElse(),
  }) {
    if (favorite != null) {
      return favorite(this);
    }
    return orElse();
  }
}

abstract class Favorite implements FavoritesEvent {
  const factory Favorite() = _$Favorite;
}

/// @nodoc
mixin _$FavoritesState {
  List<DBSongs> get favoriteSongList => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FavoritesStateCopyWith<FavoritesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoritesStateCopyWith<$Res> {
  factory $FavoritesStateCopyWith(
          FavoritesState value, $Res Function(FavoritesState) then) =
      _$FavoritesStateCopyWithImpl<$Res, FavoritesState>;
  @useResult
  $Res call({List<DBSongs> favoriteSongList});
}

/// @nodoc
class _$FavoritesStateCopyWithImpl<$Res, $Val extends FavoritesState>
    implements $FavoritesStateCopyWith<$Res> {
  _$FavoritesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? favoriteSongList = null,
  }) {
    return _then(_value.copyWith(
      favoriteSongList: null == favoriteSongList
          ? _value.favoriteSongList
          : favoriteSongList // ignore: cast_nullable_to_non_nullable
              as List<DBSongs>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FavoritesStateCopyWith<$Res>
    implements $FavoritesStateCopyWith<$Res> {
  factory _$$_FavoritesStateCopyWith(
          _$_FavoritesState value, $Res Function(_$_FavoritesState) then) =
      __$$_FavoritesStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<DBSongs> favoriteSongList});
}

/// @nodoc
class __$$_FavoritesStateCopyWithImpl<$Res>
    extends _$FavoritesStateCopyWithImpl<$Res, _$_FavoritesState>
    implements _$$_FavoritesStateCopyWith<$Res> {
  __$$_FavoritesStateCopyWithImpl(
      _$_FavoritesState _value, $Res Function(_$_FavoritesState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? favoriteSongList = null,
  }) {
    return _then(_$_FavoritesState(
      favoriteSongList: null == favoriteSongList
          ? _value._favoriteSongList
          : favoriteSongList // ignore: cast_nullable_to_non_nullable
              as List<DBSongs>,
    ));
  }
}

/// @nodoc

class _$_FavoritesState implements _FavoritesState {
  const _$_FavoritesState({required final List<DBSongs> favoriteSongList})
      : _favoriteSongList = favoriteSongList;

  final List<DBSongs> _favoriteSongList;
  @override
  List<DBSongs> get favoriteSongList {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_favoriteSongList);
  }

  @override
  String toString() {
    return 'FavoritesState(favoriteSongList: $favoriteSongList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FavoritesState &&
            const DeepCollectionEquality()
                .equals(other._favoriteSongList, _favoriteSongList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_favoriteSongList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FavoritesStateCopyWith<_$_FavoritesState> get copyWith =>
      __$$_FavoritesStateCopyWithImpl<_$_FavoritesState>(this, _$identity);
}

abstract class _FavoritesState implements FavoritesState {
  const factory _FavoritesState(
      {required final List<DBSongs> favoriteSongList}) = _$_FavoritesState;

  @override
  List<DBSongs> get favoriteSongList;
  @override
  @JsonKey(ignore: true)
  _$$_FavoritesStateCopyWith<_$_FavoritesState> get copyWith =>
      throw _privateConstructorUsedError;
}
