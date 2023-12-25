class User {
  int? userId;
  String? status;
  String? role;
  String? username;
  String? password;
  String? email;
  String? firstName;
  String? lastName;
  String? birthOfDate;
  String? gender;
  String? city;
  String? address;
  String? regesterAt;

  User(
      {this.userId,
      this.status,
      this.role,
      this.username,
      this.password,
      this.email,
      this.firstName,
      this.lastName,
      this.birthOfDate,
      this.gender,
      this.city,
      this.address,
      this.regesterAt});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    status = json['status'];
    role = json['role'];
    username = json['username'];
    password = json['password'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    birthOfDate = json['birth_of_date'];
    gender = json['gender'];
    city = json['city'];
    address = json['address'];
    regesterAt = json['regesterAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['status'] = this.status;
    data['role'] = this.role;
    data['username'] = this.username;
    data['password'] = this.password;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['birth_of_date'] = this.birthOfDate;
    data['gender'] = this.gender;
    data['city'] = this.city;
    data['address'] = this.address;
    data['regesterAt'] = this.regesterAt;
    return data;
  }
}
