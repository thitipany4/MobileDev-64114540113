class User {
  final String id;
  final String email;
  final String username;

  User({
    required this.id,
    required this.email,
    required this.username,
  });

  // Factory method to create a User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
    );
  }
  
  // Method to return JSON representation of the user
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
    };
  }
}

class Member {
  String username;
  String first;
  String? last;
  String email;
  String? picture;

  Member(
      {required this.username,
      required this.first,
      this.last,
      required this.email,
      this.picture});

  factory Member.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'username': String username,
        'first': String first,
        'last': String last,
        'email': String email,
        'piture': String picture,
      } =>
        Member(
            username: username,
            first: first,
            last: last,
            email: email,
            picture: picture),
      _ => throw const FormatException('Error ผิดฟอร์ม')
    };
  }
}
