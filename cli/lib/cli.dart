import 'package:pocketbase/pocketbase.dart';
import 'package:requests/requests.dart';

void main() async {
  const url = 'https://randomuser.me/api/?results=20';
  // dart pub add requests but you must acess to foder cli to add it
  var r = await Requests.get(url);
  // dart pub add pocketbase
  var memberData = r.json()['results'];
  final pb = PocketBase('http://127.0.0.1:8090');
  final email = 'anna@ubu.ac.th';
  final password = 'anna@dssi';
  //var authData = await pb.admins.authWithPassword(admin, password);
  var authData = await pb.collection('users').authWithPassword(email, password);
  // dart run lib/cli.dart
  print('isvalid: ${pb.authStore.isValid}');
  print('token: ${pb.authStore.token}');
  print('user.id : ${pb.authStore.model.id}');

  for (int i = 0; i < 20; i++) {
    var data = memberData[i];
    await pb.collection('members').create(body: {
      'username': data['login']['username'],
      'email': data['email'],
      'picture': data['picture']['large'],
      'first_name': data['name']['first'],
      'last_name': data['name']['last'],
    });
  }
}
