import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:uquiz/login.dart';
import 'package:uquiz/members.dart';
import 'package:uquiz/models.dart';
import 'package:uquiz/product.dart';
import 'package:uquiz/shopping.dart';
import 'package:uquiz/update_product.dart';

class UquizController extends GetxController {
  var appName = 'uQuiz'.obs;
  var token = ''.obs;
  var isLoggedIn = false.obs;
  var isAdmin = false.obs;
  var username = ''.obs;
  var email = ''.obs;
  var products = <ProductModel>[].obs;
  final pb = PocketBase('http://127.0.0.1:8090');
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordconfirmController = TextEditingController();
  final usernameController = TextEditingController();
  final nameController = TextEditingController();
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  @override
  void onInit() {
    super.onInit();
    loadToken(); // Load token on controller initialization
  }

  Future<void> authen(String email, String password) async {
    try {
      // Try admin login
      final res = await pb.admins.authWithPassword(email, password);

      if (res != null && res.admin != null) {
        isAdmin.value = true;
        String? adminEmail = res.admin?.email;  // Extracting admin's email
        String? adminId = res.admin?.id;        // Extracting admin's ID
        await setToken(pb.authStore.token, adminId!, adminEmail!);
        // Store admin details if needed or use them directly
        print("Admin Email: $adminEmail, Admin ID: $adminId");
        Get.to(() => const Shopping());
      } else {
        // Handle failed authentication
        print("Authentication failed or response is null.");
      }

      // await setToken(pb.authStore.token, adminId, adminEmail);
      await postLoginActions();
    } catch (e) {
      print('Admin login failed, trying user login...');
      await userLogin(email, password);
    }
  }

  Future<void> register(String username, String email, String name, String password, String passwordconfirm) async {
    if (username.isNotEmpty && email.isNotEmpty && name.isNotEmpty && password.isNotEmpty) {
      try {
        final body = <String, dynamic>{
          'username': username,
          'email': email,
          'name': name,
          'password': password,
          'passwordConfirm': passwordconfirm,
          'emailVisibility': true,
        };
        // สร้างผู้ใช้ใหม่ในฐานข้อมูล
        final record = await pb.collection('users').create(body: body);
        print('Record created: $record');

        // ทำการเข้าสู่ระบบผู้ใช้หลังจากการลงทะเบียนสำเร็จ
        await userLogin(email, password);

        // // ทำการดำเนินการหลังจากเข้าสู่ระบบ เช่น นำทางไปยังหน้าหลัก
        await postLoginActions();
      } catch (e) {
        // จัดการข้อผิดพลาดที่เกิดขึ้นระหว่างการลงทะเบียน
        print('Registration failed: $e');
      Get.snackbar('Register Failed', 'Incorrect email or password and password confirm dont match.');
      }
    } else {
      print('Please fill in all fields correctly.');
    }
  }
  Future<void> userLogin(String email, String password) async {
    try {
      final res = await pb.collection('users').authWithPassword(email, password);
      isAdmin.value = false;
      print('User logged in: $email');
      await postLoginActions();
    } catch (e) {
      print('User login failed: $e');
      Get.snackbar('Login Failed', 'Incorrect email or password.');
    }
  }

  Future<void> postLoginActions() async {
    if (pb.authStore.isValid) {
      var pbToken = pb.authStore.token;
      print('Token: $pbToken');

      // Save token securely for persistence
      await storage.write(key: 'auth_token', value: pbToken);

      // Fetch user details

      final members = await pb.collection('users').getList(
        filter: 'email="${emailController.text}"',
      );

      if (members.items.isNotEmpty) {
        var user = members.items[0];
        String usernameValue = user.getStringValue('username') ?? 'No username';
        String emailValue = user.getStringValue('email') ?? 'No email';
        setToken(pbToken, usernameValue, emailValue);
        Get.to(() => const Shopping());
      } else {
        print('No members found');
      }
    }
  }
  Future<void> setToken(String newToken, String newUsername, String newEmail) async {
    token.value = newToken;
    username.value = newUsername;
    email.value = newEmail;
    isLoggedIn.value = true;
    
    await storage.write(key: 'auth_token', value: newToken);
    await storage.write(key: 'username', value: newUsername);
    await storage.write(key: 'email', value: newEmail);
  }

  // Token Refresh Logic
  Future<void> refreshToken() async {
    if (!pb.authStore.isValid) {
      print('Token expired. Please login again.');
      return;
    }
    try {
      final res = await pb.collection('users').authRefresh();
      var newToken = pb.authStore.token;
      await storage.write(key: 'auth_token', value: newToken);
      print('Token refreshed: $newToken');
    } catch (e) {
      print('Token refresh failed: $e');
    }
  }

  // Load token from secure storage
  Future<void> loadToken() async {
    String? savedToken = await storage.read(key: 'auth_token');
    String? savedUsername = await storage.read(key: 'username');
    String? savedEmail = await storage.read(key: 'email');

    if (savedToken != null) {
      token.value = savedToken;
      username.value = savedUsername ?? '';
      email.value = savedEmail ?? '';

      // Re-validate the token and refresh if necessary
      try {
        await pb.collection('users').authRefresh();
        isLoggedIn.value = pb.authStore.isValid;
        print('Token loaded from storage and refreshed');
      } catch (e) {
        if (isAdmin.isTrue) {
          isLoggedIn.value = pb.authStore.isValid; 
        } else {
          print('Token refresh failed: $e');
          isLoggedIn.value = false;
          logout(); 
        }
      }
    }
  }
  void login() {
    Get.offAll(() => const LoginPage());
  }

  void logout() async {
    await storage.delete(key: 'auth_token');
    await storage.delete(key: 'username');
    await storage.delete(key: 'email');

    token.value = '';
    isLoggedIn.value = false;
    pb.authStore.clear();
    Get.offAll(() => const Shopping());
  }
  Future<void> viewproduct() async {
      if (pb.authStore.isValid) {
        var pbToken = pb.authStore.token;
        print('Token: $pbToken');

        final product = await pb.collection('products').getList(
          sort: '-created',
        );
        // print('product : $product');
        if (product.items.isNotEmpty) {
          products.clear(); 
          for (var item in product.items) {
        
            // print('productitem :$item');
            final productid = item.id;
            String productname = item.getStringValue('name') ?? 'No name';
            double price = item.getDoubleValue('price') ?? 0.0;
            int quantity = item.getIntValue('quantity') ?? 0;
            String description = item.getStringValue('description') ?? 'No description';
            String image = item.getStringValue('image') ?? '';
            products.add(ProductModel(
              productid:productid,
              name: productname,
              price: price,
              quantity: quantity,
              description: description,
              image: image,
            ));
            print('productid:$productid');
          }
        } else {
          print('No product found');
        }
      }
    }
  Future<void> editproduct(String id,String name, String price,String quantity,String description ,String image) async {
    if (id.isNotEmpty) {
        final data =  <String, dynamic>{
            "name": name,
            "price": price,
            "quantity": quantity,
            "description": description,
            "image": image
        };
      print('data :$data');
      final pbproduct = await pb.collection('products').getList(
        filter: 'id="$id"',
      );
      print('pbproduct:$pbproduct');
      if (pbproduct.items.isNotEmpty) {
         final record = pbproduct.items[0];
         print('record:${record.id}');
         final updatedRecord = await pb.collection('products').update(
          record.id,
          body: data);
          print(updatedRecord);
          Get.offAll(() => const Product());
      } else {
        print('cant find product that you want update');
      }
    } else {
      print('admin edit failed:');
    }
  }
  Future<void> deleteproduct(String id) async {
    if (id.isNotEmpty) {
      final pbproduct = await pb.collection('products').getList(
        filter: 'id="$id"',
      );
      print('pbproduct:$pbproduct');
      if (pbproduct.items.isNotEmpty) {
         final record = pbproduct.items[0];
         print('record:${record.id}');
         final deleteRecord = await pb.collection('products').delete(record.id);
          Get.offAll(() => const Product());
      } else {
        print('cant find product that you want update');
      }
    } else {
      print('admin edit failed:');
    }
  }
}
