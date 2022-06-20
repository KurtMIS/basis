// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Info _$$_InfoFromJson(Map<String, dynamic> json) => _$_Info(
      id: json['id'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      firstName: json['firstName'] as String? ?? '',
      middleName: json['middleName'] as String? ?? '',
      presentAddress: json['presentAddress'] as String? ?? '',
      provincialAddress: json['provincialAddress'] as String? ?? '',
      dateOfBirth: json['dateOfBirth'] as String? ?? '',
      placeOfBirth: json['placeOfBirth'] as String? ?? '',
      nationality: json['nationality'] as String? ?? '',
      gender: json['gender'] as String? ?? '',
      religion: json['religion'] as String? ?? '',
      civilStatus: json['civilStatus'] as String? ?? '',
      email: json['email'] as String? ?? '',
      mobileNumber: json['mobileNumber'] as String? ?? '',
      telNumber: json['telNumber'] as String? ?? '',
      passportNumber: json['passportNumber'] as String? ?? '',
      expiryDate: json['expiryDate'] as String? ?? '',
      sssNumber: json['sssNumber'] as String? ?? '',
      tinNumber: json['tinNumber'] as String? ?? '',
      dependents: (json['dependents'] as List<dynamic>?)
              ?.map((e) => e as Map<String, dynamic>)
              .toList() ??
          const [],
      agent: json['agent'] as String? ?? '',
      employer: json['employer'] as String? ?? '',
      address: json['address'] as String? ?? '',
      termOfContract: json['termOfContract'] as String? ?? '',
      position: json['position'] as String? ?? '',
      effectiveDate: json['effectiveDate'] as String? ?? '',
      recruitmentAgency: json['recruitmentAgency'] as String? ?? '',
      employmentContactNumber: json['employmentContactNumber'] as String? ?? '',
      natureOfBusiness: json['natureOfBusiness'] as String? ?? '',
      countryOfDeployment: json['countryOfDeployment'] as String? ?? '',
      dateOfEmployment: json['dateOfEmployment'] as String? ?? '',
      occupation: json['occupation'] as String? ?? '',
    );

Map<String, dynamic> _$$_InfoToJson(_$_Info instance) => <String, dynamic>{
      'id': instance.id,
      'lastName': instance.lastName,
      'firstName': instance.firstName,
      'middleName': instance.middleName,
      'presentAddress': instance.presentAddress,
      'provincialAddress': instance.provincialAddress,
      'dateOfBirth': instance.dateOfBirth,
      'placeOfBirth': instance.placeOfBirth,
      'nationality': instance.nationality,
      'gender': instance.gender,
      'religion': instance.religion,
      'civilStatus': instance.civilStatus,
      'email': instance.email,
      'mobileNumber': instance.mobileNumber,
      'telNumber': instance.telNumber,
      'passportNumber': instance.passportNumber,
      'expiryDate': instance.expiryDate,
      'sssNumber': instance.sssNumber,
      'tinNumber': instance.tinNumber,
      'dependents': instance.dependents,
      'agent': instance.agent,
      'employer': instance.employer,
      'address': instance.address,
      'termOfContract': instance.termOfContract,
      'position': instance.position,
      'effectiveDate': instance.effectiveDate,
      'recruitmentAgency': instance.recruitmentAgency,
      'employmentContactNumber': instance.employmentContactNumber,
      'natureOfBusiness': instance.natureOfBusiness,
      'countryOfDeployment': instance.countryOfDeployment,
      'dateOfEmployment': instance.dateOfEmployment,
      'occupation': instance.occupation,
    };
