class usermodel {
  String? uid;
  int? phonenumber;
  String? email;
  String? address;
  String? firstname;
  String? lastname;

  usermodel(
      {this.uid,
      this.email,
      this.firstname,
      this.phonenumber,
      this.address,
      this.lastname});
  //receiving data from server
  factory usermodel.fromMap(Map) {
    return usermodel(
      uid: Map['uid'],
      email: Map['email'],
      firstname: Map['firstname'],
      lastname: Map['firstname'],
      phonenumber: Map['phonenumber'],
      address: Map['address'],
    );
  }
  //sending data to our server
  Map<String, dynamic> toMap() {
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
