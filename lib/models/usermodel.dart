class User {
  String? uid;
  String? phonenumber;
  String? email;
  String? address;
  String? firstname;
  String? lastname;

  User(
      {this.uid,
      this.email,
      this.firstname,
      this.phonenumber,
      this.address,
      this.lastname});
  //receiving data from server
  factory User.fromMap(Map) {
    return User(
      uid: Map['uid'],
      email: Map['email'],
      firstname: Map['firstname'],
      lastname: Map['firstname'],
      phonenumber: Map['phonenumber'],
      address: Map['address'],
    );
  }
  //sending data to our server
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'firstname': firstname,
      'lastname': lastname,
      'phonenumber': phonenumber,
      'address': address,
    };
  }
}
