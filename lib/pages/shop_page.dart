import 'package:flutter/material.dart';
import 'package:initiation_project/providers/item_provider.dart';
import 'package:initiation_project/themes/text_style.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ItemProvider>(
      builder: (context, itemProvider, child) {
        return ListView.builder(
          itemCount: itemProvider.itemsShop.length,
          itemBuilder: (context, index) {
            final item = itemProvider.itemsShop[index];
            return ListTile(
              leading: Icon(itemProvider.getCategoryIcon(item.category)),
              title: Text(item.name, style: labelTextStyle),
              subtitle: Text('${item.price} €', style: bodyTextStyle),
              trailing: IconButton(
                icon: const Icon(Icons.add_shopping_cart),
                onPressed: () {
                  itemProvider.addItemToCart(item);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: const Duration(milliseconds: 1500),
                      backgroundColor: Colors.black54,
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${item.name} added to the cart !'),
                          const Icon(Icons.check, color: Colors.green),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
