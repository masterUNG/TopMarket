import 'dart:convert';

class EmployeeModel {

  String? id;
  String? username;
  String? password;
  String? firstname;
  String? lastname;
  String? phonenumber;
  String? email;
  String? line;
  String? address;
  String? provinename;
  String? issentlinenotify;
  EmployeeModel({
    this.id,
    this.username,
    this.password,
    this.firstname,
    this.lastname,
    this.phonenumber,
    this.email,
    this.line,
    this.address,
    this.provinename,
    this.issentlinenotify,
  });

  EmployeeModel copyWith({
    String? id,
    String? username,
    String? password,
    String? firstname,
    String? lastname,
    String? phonenumber,
    String? email,
    String? line,
    String? address,
    String? provinename,
    String? issentlinenotify,
  }) {
    return EmployeeModel(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      phonenumber: phonenumber ?? this.phonenumber,
      email: email ?? this.email,
      line: line ?? this.line,
      address: address ?? this.address,
      provinename: provinename ?? this.provinename,
      issentlinenotify: issentlinenotify ?? this.issentlinenotify,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'firstname': firstname,
      'lastname': lastname,
      'phonenumber': phonenumber,
      'email': email,
      'line': line,
      'address': address,
      'provinename': provinename,
      'issentlinenotify': issentlinenotify,
    };
  }

  factory EmployeeModel.fromMap(Map<String, dynamic> map) {
    return EmployeeModel(
      id: map['id'],
      username: map['username'],
      password: map['password'],
      firstname: map['first_name'],
      lastname: map['last_name'],
      phonenumber: map['phone_number'],
      email: map['email'],
      line: map['line'],
      address: map['address'],
      provinename: map['provinename'],
      issentlinenotify: map['is_sent_line_notify'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EmployeeModel.fromJson(String source) => EmployeeModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EmployeeModel(id: $id, username: $username, password: $password, firstname: $firstname, lastname: $lastname, phonenumber: $phonenumber, email: $email, line: $line, address: $address, provinename: $provinename, issentlinenotify: $issentlinenotify)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is EmployeeModel &&
      other.id == id &&
      other.username == username &&
      other.password == password &&
      other.firstname == firstname &&
      other.lastname == lastname &&
      other.phonenumber == phonenumber &&
      other.email == email &&
      other.line == line &&
      other.address == address &&
      other.provinename == provinename &&
      other.issentlinenotify == issentlinenotify;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      username.hashCode ^
      password.hashCode ^
      firstname.hashCode ^
      lastname.hashCode ^
      phonenumber.hashCode ^
      email.hashCode ^
      line.hashCode ^
      address.hashCode ^
      provinename.hashCode ^
      issentlinenotify.hashCode;
  }
}
