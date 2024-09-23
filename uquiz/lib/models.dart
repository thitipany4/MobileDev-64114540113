import 'dart:math';

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
