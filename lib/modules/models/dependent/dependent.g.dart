// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dependent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Dependent _$$_DependentFromJson(Map<String, dynamic> json) => _$_Dependent(
      name: json['name'] as String? ?? '',
      relationshipToInsured: json['relationshipToInsured'] as String? ?? '',
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : DateTime.parse(json['dateOfBirth'] as String),
      sharing: json['sharing'] as String? ?? '',
      revocability: json['revocability'] as String? ?? '',
    );

Map<String, dynamic> _$$_DependentToJson(_$_Dependent instance) =>
    <String, dynamic>{
      'name': instance.name,
      'relationshipToInsured': instance.relationshipToInsured,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'sharing': instance.sharing,
      'revocability': instance.revocability,
    };
