class UserAccounts {
  int id;
  String firstName;
  String lastName;
  String dob;
  String email;
  String? phoneNumber;
  String? nationality;
  String gender;
  String profileUrl;
  String location;
  String? paymentMethod;

  UserAccounts({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.email,
    this.phoneNumber,
    this.nationality,
    required this.gender,
    required this.profileUrl,
    required this.location,
    this.paymentMethod,
  });

  factory UserAccounts.fromMap(Map<String, dynamic> map) {
    return UserAccounts(
      id: map['id'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      dob: map['dob'],
      email: map['email'],
      gender: map['gender'],
      profileUrl: map['profile_url'],
      location: map['location'],
      nationality: map['nationality'],
      paymentMethod: map['payment_method'],
      phoneNumber: map['phone_number'],
    );
  }
}
