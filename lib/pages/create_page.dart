import 'package:flutter/material.dart';
import 'package:initiation_project/models/item.dart';
import 'package:initiation_project/providers/item_provider.dart';
import 'package:initiation_project/themes/button_style.dart';
import 'package:initiation_project/themes/text_style.dart';
import 'package:initiation_project/themes/textfield_style.dart';
import 'package:provider/provider.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final categoryController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Create an item', style: titleTextStyle),
                const SizedBox(height: 4.0),
                Text('Fill in the details below',
                    style: bodyTextStyle.copyWith(color: Colors.white70)),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: nameController,
                  decoration: nameInputDecoration,
                  style: const TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: priceController,
                  decoration: priceInputDecoration,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        double.tryParse(value) == null) {
                      return 'Please enter a valid price';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  decoration:
                      nameInputDecoration.copyWith(labelText: 'Category'),
                  dropdownColor: Colors.black87,
                  style: const TextStyle(color: Colors.white),
                  items: ItemProvider()
                      .getCategories()
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category, style: bodyTextStyle),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      categoryController.text = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a category';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<ItemProvider>().addItemToShop(
                              Item(
                                  name: nameController.text,
                                  price: double.parse(priceController.text),
                                  category: categoryController.text),
                            );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(milliseconds: 1500),
                            backgroundColor: Colors.black54,
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Item created successfully !'),
                                Icon(Icons.check, color: Colors.green),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                    style: primaryButtonStyle,
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
