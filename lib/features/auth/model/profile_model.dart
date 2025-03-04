class ProfileModel {
  String? sId;
  String? firstName;
  String? lastName;
  String? email;
  bool? emailVerified;
  String? phone;
  bool? phoneVerified;
  Null avatarUrl;
  String? city;
  int? role;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ProfileModel(
      {this.sId,
      this.firstName,
      this.lastName,
      this.email,
      this.emailVerified,
      this.phone,
      this.phoneVerified,
      this.avatarUrl,
      this.city,
      this.role,
      this.createdAt,
      this.updatedAt,
      this.iV});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    emailVerified = json['email_verified'];
    phone = json['phone'];
    phoneVerified = json['phone_verified'];
    avatarUrl = json['avatar_url'];
    city = json['city'];
    role = json['role'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['email_verified'] = emailVerified;
    data['phone'] = phone;
    data['phone_verified'] = phoneVerified;
    data['avatar_url'] = avatarUrl;
    data['city'] = city;
    data['role'] = role;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
