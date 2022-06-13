import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'dependent.freezed.dart';
part 'dependent.g.dart';

@freezed
class Dependent with _$Dependent {
  factory Dependent({
    @Default('') String name,
    @Default('') String relationshipToInsured,
    DateTime? dateOfBirth,
    @Default('') String sharing,
    @Default('') String revocability,
  }) = _Dependent;

  factory Dependent.fromJson(Map<String, dynamic> json) =>
      _$DependentFromJson(json);
}
