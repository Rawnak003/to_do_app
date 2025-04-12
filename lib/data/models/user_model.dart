class UserModel {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String mobile;
  final String createdDate;
  final String photo;

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.createdDate,
    required this.photo,
  });

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(id: jsonData['_id'] ?? '',
        email: jsonData['email'] ?? '',
        firstName: jsonData['firstName'] ?? '',
        lastName: jsonData['lastName'] ?? '',
        mobile: jsonData['mobile'] ?? '',
        createdDate: jsonData['createdDate'] ?? '',
        photo: jsonData['photo'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'mobile': mobile,
      'createdDate': createdDate,
    };
  }

  String get fullName {
    return '$firstName $lastName';
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    String? mobile,
    String? createdDate,
    String? photo,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      mobile: mobile ?? this.mobile,
      createdDate: createdDate ?? this.createdDate,
      photo: photo ?? this.photo,
    );
  }
}
