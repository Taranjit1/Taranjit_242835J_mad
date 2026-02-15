class UserDetails {
  final String email;
  final String password;

  UserDetails({required this.email, required this.password});
}

List<UserDetails> registeredUsers = [
  UserDetails(email: "test@gmail.com", password: "1234"),
  UserDetails(email: "", password: ""),
];
