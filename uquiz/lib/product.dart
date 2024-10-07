import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uquiz/profile.dart';
import 'package:uquiz/shopping.dart';
import 'package:uquiz/controller.dart';
import 'package:uquiz/update_product.dart';
class Product extends StatefulWidget {
  const Product({super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
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
          bool isAdmin = uquizController.isAdmin.value;
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
            body: isAdmin
                ? Column(
                    children: [
                      // Button to create a new product
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.add),
                          label: const Text('Create New Product'),
                          onPressed: () {
                            // Open dialog or navigate to product creation form
                            print('add new product');
                          },
                        ),
                      ),
                      Expanded(
                        child: Obx(() {
                          if (uquizController.products.isEmpty) {
                            return const Center(child: Text("No products available"));
                          }
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
                                      Column(
                                        children: [
                                          // Update button
                                          IconButton(
                                            icon: const Icon(Icons.edit),
                                            onPressed: () {
                                              print('product.id :${product.productid}');
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => ProductEditPage(product: product,id: product.productid,)),
                                                );
                                            },
                                          ),
                                          // Delete button
                                          IconButton(
                                            icon: const Icon(Icons.delete),
                                            onPressed: () {
                                              print('delete prodcut');
                                              uquizController.deleteproduct(product.productid);
                                            },
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                      ),
                    ],
                  )
                : const Center(
                    child: Text(
                      'You do not have permission to access this page.',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
            bottomNavigationBar: NavigationBar(
              onDestinationSelected: (index) {
                if (index == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Shopping()),
                  );
                } else if (index == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfilePage()),
                  );
                }
              },
              selectedIndex: 1,
              destinations: const [
                NavigationDestination(icon: Icon(Icons.home), label: 'product'),
                NavigationDestination(icon: Icon(Icons.shop), label: 'Shop'),
                NavigationDestination(icon: Icon(Icons.settings), label: 'Profile'),
              ],
            ),
          );
        }
      }
      );}}