import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:initiation_project/app_router.dart';
import 'package:initiation_project/pages/create_page.dart';
import 'package:initiation_project/pages/cart_page.dart';
import 'package:badges/badges.dart' as badges;
import 'package:initiation_project/pages/shop_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:initiation_project/providers/item_provider.dart';
import 'firebase_options.dart';

import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ItemProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'My Shop App',
      theme: ThemeData(
        primaryColor: Colors.white,
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.black87,
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.white,
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      routerConfig: AppRouter.router,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    const ShopPage(),
    const CreatePage(),
    CartPage(),
  ];

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        centerTitle: true,
        title: IconButton(
          icon: const Icon(
            Icons.shopping_basket_outlined,
            size: 64,
            color: Colors.white54,
          ),
          onPressed: () {
            context.go('/more');
          },
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black87,
        fixedColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onNavTapped,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Shop',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Consumer<ItemProvider>(
              builder: (context, itemProvider, child) {
                return badges.Badge(
                  showBadge: itemProvider.itemsCart.isNotEmpty,
                  badgeStyle: const badges.BadgeStyle(
                    badgeColor: Colors.deepPurpleAccent,
                  ),
                  child: const Icon(Icons.shopping_cart),
                );
              },
            ),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}
