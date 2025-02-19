import 'package:flutter/material.dart';
import 'package:initiation_project/providers/item_provider.dart';
import 'package:initiation_project/themes/button_style.dart';
import 'package:initiation_project/themes/text_style.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});

  final items = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Consumer<ItemProvider>(
            builder: (context, itemProvider, child) {
              final items = itemProvider.itemsCart;
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ListTile(
                    leading: Icon(itemProvider.getCategoryIcon(item.category)),
                    title: Text(item.name, style: labelTextStyle),
                    subtitle: Text('${item.price} €', style: bodyTextStyle),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => itemProvider.removeItemFromCart(item),
                    ),
                  );
                },
              );
            },
          ),
        ),
        Consumer<ItemProvider>(
          builder: (context, itemProvider, child) {
            final totalItems = itemProvider.itemsCart.length;
            final totalPrice = itemProvider.itemsCart
                .fold(0.0, (sum, item) => sum + item.price);
            return Container(
              color: Colors.transparent,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  if (totalItems > 0)
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor:
                                  const Color.fromARGB(255, 15, 15, 15),
                              title: const Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Order Placed ', style: titleTextStyle),
                                  Icon(Icons.check, color: Colors.green),
                                ],
                              ),
                              content: const Text(
                                'Your order has been successfully placed ! ',
                                style: bodyTextStyle,
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    itemProvider.clearCart();
                                  },
                                  child: const Text('Ok'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: primaryButtonStyle,
                      child: const Text('Place Order'),
                    ),
                  const SizedBox(height: 16.0),
                  Text(
                    'Total items: $totalItems',
                    style: labelTextStyle,
                  ),
                  Text(
                    'Total price: ${totalPrice.toStringAsFixed(2)} €',
                    style: bodyTextStyle,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
