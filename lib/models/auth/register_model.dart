class RegisterModel{
  String? firstName;
  String? lastName;
  String? email;
  String? password;

  Map<String, dynamic> toJson() =>{
    'firstName' : firstName,
    'lastName' : lastName,
    'email' : email,
    'password' : password
  };
}