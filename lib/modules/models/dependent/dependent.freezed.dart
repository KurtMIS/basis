// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'dependent.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Dependent _$DependentFromJson(Map<String, dynamic> json) {
  return _Dependent.fromJson(json);
}

/// @nodoc
mixin _$Dependent {
  String get name => throw _privateConstructorUsedError;
  String get relationshipToInsured => throw _privateConstructorUsedError;
  DateTime? get dateOfBirth => throw _privateConstructorUsedError;
  String get sharing => throw _privateConstructorUsedError;
  String get revocability => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DependentCopyWith<Dependent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DependentCopyWith<$Res> {
  factory $DependentCopyWith(Dependent value, $Res Function(Dependent) then) =
      _$DependentCopyWithImpl<$Res>;
  $Res call(
      {String name,
      String relationshipToInsured,
      DateTime? dateOfBirth,
      String sharing,
      String revocability});
}

/// @nodoc
class _$DependentCopyWithImpl<$Res> implements $DependentCopyWith<$Res> {
  _$DependentCopyWithImpl(this._value, this._then);

  final Dependent _value;
  // ignore: unused_field
  final $Res Function(Dependent) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? relationshipToInsured = freezed,
    Object? dateOfBirth = freezed,
    Object? sharing = freezed,
    Object? revocability = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      relationshipToInsured: relationshipToInsured == freezed
          ? _value.relationshipToInsured
          : relationshipToInsured // ignore: cast_nullable_to_non_nullable
              as String,
      dateOfBirth: dateOfBirth == freezed
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      sharing: sharing == freezed
          ? _value.sharing
          : sharing // ignore: cast_nullable_to_non_nullable
              as String,
      revocability: revocability == freezed
          ? _value.revocability
          : revocability // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_DependentCopyWith<$Res> implements $DependentCopyWith<$Res> {
  factory _$$_DependentCopyWith(
          _$_Dependent value, $Res Function(_$_Dependent) then) =
      __$$_DependentCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      String relationshipToInsured,
      DateTime? dateOfBirth,
      String sharing,
      String revocability});
}

/// @nodoc
class __$$_DependentCopyWithImpl<$Res> extends _$DependentCopyWithImpl<$Res>
    implements _$$_DependentCopyWith<$Res> {
  __$$_DependentCopyWithImpl(
      _$_Dependent _value, $Res Function(_$_Dependent) _then)
      : super(_value, (v) => _then(v as _$_Dependent));

  @override
  _$_Dependent get _value => super._value as _$_Dependent;

  @override
  $Res call({
    Object? name = freezed,
    Object? relationshipToInsured = freezed,
    Object? dateOfBirth = freezed,
    Object? sharing = freezed,
    Object? revocability = freezed,
  }) {
    return _then(_$_Dependent(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      relationshipToInsured: relationshipToInsured == freezed
          ? _value.relationshipToInsured
          : relationshipToInsured // ignore: cast_nullable_to_non_nullable
              as String,
      dateOfBirth: dateOfBirth == freezed
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      sharing: sharing == freezed
          ? _value.sharing
          : sharing // ignore: cast_nullable_to_non_nullable
              as String,
      revocability: revocability == freezed
          ? _value.revocability
          : revocability // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Dependent with DiagnosticableTreeMixin implements _Dependent {
  _$_Dependent(
      {this.name = '',
      this.relationshipToInsured = '',
      this.dateOfBirth,
      this.sharing = '',
      this.revocability = ''});

  factory _$_Dependent.fromJson(Map<String, dynamic> json) =>
      _$$_DependentFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String relationshipToInsured;
  @override
  final DateTime? dateOfBirth;
  @override
  @JsonKey()
  final String sharing;
  @override
  @JsonKey()
  final String revocability;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Dependent(name: $name, relationshipToInsured: $relationshipToInsured, dateOfBirth: $dateOfBirth, sharing: $sharing, revocability: $revocability)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Dependent'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('relationshipToInsured', relationshipToInsured))
      ..add(DiagnosticsProperty('dateOfBirth', dateOfBirth))
      ..add(DiagnosticsProperty('sharing', sharing))
      ..add(DiagnosticsProperty('revocability', revocability));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Dependent &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.relationshipToInsured, relationshipToInsured) &&
            const DeepCollectionEquality()
                .equals(other.dateOfBirth, dateOfBirth) &&
            const DeepCollectionEquality().equals(other.sharing, sharing) &&
            const DeepCollectionEquality()
                .equals(other.revocability, revocability));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(relationshipToInsured),
      const DeepCollectionEquality().hash(dateOfBirth),
      const DeepCollectionEquality().hash(sharing),
      const DeepCollectionEquality().hash(revocability));

  @JsonKey(ignore: true)
  @override
  _$$_DependentCopyWith<_$_Dependent> get copyWith =>
      __$$_DependentCopyWithImpl<_$_Dependent>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DependentToJson(this);
  }
}

abstract class _Dependent implements Dependent {
  factory _Dependent(
      {final String name,
      final String relationshipToInsured,
      final DateTime? dateOfBirth,
      final String sharing,
      final String revocability}) = _$_Dependent;

  factory _Dependent.fromJson(Map<String, dynamic> json) =
      _$_Dependent.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get relationshipToInsured => throw _privateConstructorUsedError;
  @override
  DateTime? get dateOfBirth => throw _privateConstructorUsedError;
  @override
  String get sharing => throw _privateConstructorUsedError;
  @override
  String get revocability => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_DependentCopyWith<_$_Dependent> get copyWith =>
      throw _privateConstructorUsedError;
}
