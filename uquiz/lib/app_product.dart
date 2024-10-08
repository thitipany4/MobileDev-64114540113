import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uquiz/controller.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final UquizController uquizController = Get.find<UquizController>();
  final nameProduct = TextEditingController();
  final priceProduct = TextEditingController();
  final quantityProduct = TextEditingController();
  final descriptionProduct = TextEditingController();
  final urlimageProduct = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      obscureText: false,
                      controller: nameProduct,
                      validator: (value) {
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Product name',
                      ),
                    ),
                  ),             
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      obscureText: false,
                      controller: priceProduct,
                      validator: (value) {
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Price',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      obscureText: false,
                      controller: quantityProduct,
                      validator: (value) {
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Quantity of Product',
                      ),
                    ),
                  ),
                  Padding(padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: descriptionProduct,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true, // Keeps the label at the top when maxLines > 1
                      contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 4.0), // Adds padding
                    ),
                    maxLines: 3, // Allows more space like a textarea
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  )),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0,left: 8,right: 8),
                    child: TextFormField(
                      obscureText: false,
                      controller: urlimageProduct,
                      validator: (value) {
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'URL image of Product',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  uquizController.addproduct(nameProduct.text,priceProduct.text,
                  quantityProduct.text,descriptionProduct.text,urlimageProduct.text);
                  },
                child: const Text('Save Changes'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                 },
                child: const Text('Cancel'),
              ),
            ],
          ),
        ),
      ),
    );
}}