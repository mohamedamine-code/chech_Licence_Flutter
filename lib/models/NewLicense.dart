class LicenseModel {
  final String name;
  final String expiryDate;

  LicenseModel({required this.name, required this.expiryDate});

  factory LicenseModel.fromJson(Map<String, dynamic> json) {
    return LicenseModel(
      name: json['name'],
      expiryDate: json['expiryDate'],
    );
  }
}
