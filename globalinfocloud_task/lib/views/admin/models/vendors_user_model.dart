

class VendorsUserModel {
  final bool approved;
  final String businessName;
  final String phoneNumber;
  final String email;
  final String storeImage;
  final String countryValue;
  final String stateValue;
  final String cityValue;

  final String takRegistored;
  final String takNumber;
  final String vendorId;

  VendorsUserModel(
      {required this.approved,
      required this.vendorId,
      required this.businessName,
      required this.phoneNumber,
      required this.email,
      required this.storeImage,
      required this.countryValue,
      required this.stateValue,
      required this.cityValue,
      required this.takRegistored,
      required this.takNumber});

  VendorsUserModel.fromJson(Map<String, dynamic> json)
      : this(
          vendorId: json["vendorId"],
          approved: json['approved'],
          businessName: json['businessName'],
          phoneNumber: json['phoneNumber'],
          email: json['email'],
          storeImage: json['storeImage'],
          countryValue: json['countryValue'],
          stateValue: json['stateValue'],
          cityValue: json['cityValue'],
          takRegistored: json['takRegistored'],
          takNumber: json['takNumber'],
        );

  Map<String, dynamic> toJson() {
    return {
      "vendorId":vendorId,
      'approved': approved,
      'businessName': businessName,
      'phoneNumber': phoneNumber,
      'email': email,
      'storeImage': storeImage,
      'countryValue': countryValue,
      'stateValue': stateValue,
      'cityValue': cityValue,
      'takRegistored': takRegistored,
      'takNumber': takNumber,
    };
  }
}
