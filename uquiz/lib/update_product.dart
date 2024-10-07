import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uquiz/controller.dart';
import 'package:uquiz/models.dart';

class ProductEditPage extends StatefulWidget {
  final ProductModel product;
  final String id;

  const ProductEditPage({super.key, required this.product, required this.id});

  @override
  State<ProductEditPage> createState() => _ProductEditPageState();
}

class _ProductEditPageState extends State<ProductEditPage> {
  final UquizController uquizController = Get.find<UquizController>();
  final _formKey = GlobalKey<FormState>();
  late TextEditingController idControllter;
  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController quantityController;
  late TextEditingController descriptionController;
  late TextEditingController imageController;

  @override
  void initState() {
    super.initState();
    // Initialize the text controllers with the current product data
    idControllter =  TextEditingController(text:widget.id);
    nameController = TextEditingController(text: widget.product.name);
    priceController = TextEditingController(text: widget.product.price.toString());
    quantityController = TextEditingController(text: widget.product.quantity.toString());
    descriptionController = TextEditingController(text: widget.product.description);
    imageController = TextEditingController(text: widget.product.image);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
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
                      controller: nameController,
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
                      controller: idControllter,
                      validator: (value) {
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'id',
                      ),
                    ),
                  ),              
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      obscureText: false,
                      controller: priceController,
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
                      controller: quantityController,
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
                    controller: descriptionController,
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
                      controller: imageController,
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
                  uquizController.editproduct(idControllter.text,nameController.text,
                  priceController.text ,quantityController.text,
                  descriptionController.text,imageController.text);
                  Navigator.pop(context);
                },
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
