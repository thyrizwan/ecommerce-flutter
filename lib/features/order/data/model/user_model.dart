class UserModel {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? city;

  UserModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.city});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phone: json['phone'],
      city: json['city'],
    );
  }
}
