import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'info.freezed.dart';
part 'info.g.dart';

@freezed
class Info with _$Info {
  factory Info({
    @Default('') String id,
    @Default('') String lastName,
    @Default('') String firstName,
    @Default('') String middleName,
    @Default('') String presentAddress,
    @Default('') String provincialAddress,
    @Default('') String dateOfBirth,
    @Default('') String placeOfBirth,
    @Default('') String nationality,
    @Default('') String gender,
    @Default('') String religion,
    @Default('') String civilStatus,
    @Default('') String email,
    @Default('') String mobileNumber,
    @Default('') String telNumber,
    @Default('') String passportNumber,
    @Default('') String expiryDate,
    @Default('') String sssNumber,
    @Default('') String tinNumber,
    @Default([]) List<Map<String, dynamic>> dependents,
    @Default('') String agent,
    @Default('') String employer,
    @Default('') String address,
    @Default('') String termOfContract,
    @Default('') String position,
    @Default('') String effectiveDate,
    @Default('') String recruitmentAgency,
    @Default('') String employmentContactNumber,
    @Default('') String natureOfBusiness,
    @Default('') String countryOfDeployment,
    @Default('') String dateOfEmployment,
    @Default('') String occupation,
    @Default(false) bool isPaid,
    @Default(false) bool isDone,
    @Default('') String paymentMethod,
    @Default('') String annualPremium,
    @Default('') String passportImagePath,
    @Default('') String receiptImagePath,
    @Default('') String submissionDate,
    @Default('') String processedDate,
  }) = _Info;

  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);
}
