class UserModel {
  late final String sId;
  late final String email;
  late final String firstName;
  late final String lastName;
  late final String mobile;
  late final String createdDate;

  UserModel({
    required this.sId,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.createdDate
  });

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
      sId: jsonData['_id'] ?? '',
      email: jsonData['email'] ?? '',
      firstName: jsonData['firstName'] ?? '',
      lastName: jsonData['lastName'] ?? '',
      mobile: jsonData['mobile'] ?? '',
      createdDate: jsonData['createdDate'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'mobile': mobile,
      'createdDate': createdDate
    };
  }
}
