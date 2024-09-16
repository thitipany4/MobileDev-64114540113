import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:requests/requests.dart';
import 'package:uquiz/home.dart';

class MemberListPage extends StatefulWidget {
  const MemberListPage({super.key});

  @override
  State<MemberListPage> createState() => _MemberState();
}

class _MemberState extends State<MemberListPage> {
  @override
  Widget build(BuildContext context) {
    final pb = PocketBase('http://127.0.0.1:8090');
    final email = 'anna@ubu.ac.th';
    final password = 'anna@dssi';
    pb.collection('users').authWithPassword(email, password);
    if (pb.authStore.isValid) {
      final members = pb.collection('members').getList(page: 1, perPage: 20);
    }
    // do login.dart
    // do members list page
    return Placeholder();
  }
}
