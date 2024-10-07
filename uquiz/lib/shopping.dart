import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uquiz/controller.dart';
import 'package:uquiz/product.dart';
import 'package:uquiz/profile.dart';

class Shopping extends StatefulWidget {
  const Shopping({super.key});

  @override
  State<Shopping> createState() => _ShoppingState();
}

class _ShoppingState extends State<Shopping> {
  final UquizController uquizController = Get.find<UquizController>();

  @override
  void initState() {
    super.initState();
    uquizController.viewproduct(); // Fetch products when the page is initialized
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: uquizController.loadToken(),  // Ensure token is loaded first
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          var username = uquizController.username.value;
          return Scaffold(
            appBar: AppBar(
              title: const Text("UQuiz Shopping"),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Row(
                    children: [
                      if (uquizController.isLoggedIn.value) ...[
                        Text(
                          username,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.logout),
                          onPressed: () {
                            uquizController.logout();
                          },
                        ),
                      ] else ...[
                        IconButton(
                          icon: const Icon(Icons.login),
                          onPressed: () {
                            uquizController.login();
                          },
                        ),
                      ]
                    ],
                  ),
                ),
              ],
            ),
            body: Flexible(
              child: Obx(() {
                return ListView.builder(
                  itemCount: uquizController.products.length,
                  itemBuilder: (context, index) {
                    final product = uquizController.products[index];
                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Image.network(
                              product.image,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text('Price: \$${product.price}'),
                                  Text('Quantity: ${product.quantity}'),
                                  Text(product.description),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
            bottomNavigationBar: NavigationBar(
              onDestinationSelected: (index) {
                if (index == 0) {
                  Get.to(() => const Product());
                } else if (index == 2) {
                  Get.to(() => const ProfilePage());
                }
              },
              selectedIndex: 1,
              destinations: const [
                NavigationDestination(icon: Icon(Icons.home), label: 'Product'),
                NavigationDestination(icon: Icon(Icons.shop), label: 'Shop'),
                NavigationDestination(icon: Icon(Icons.settings), label: 'Profile'),
              ],
            ),
          );
        }
      },
    );
  }
}
