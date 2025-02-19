import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:initiation_project/main.dart';
import 'package:initiation_project/pages/cart_page.dart';
import 'package:initiation_project/pages/create_page.dart';
import 'package:initiation_project/pages/more_page.dart';
import 'package:initiation_project/pages/shop_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        name: 'home',
        path: '/home',
        pageBuilder: (context, state) => const MaterialPage(child: HomePage()),
      ),
      GoRoute(
        name: 'create',
        path: '/create',
        pageBuilder: (context, state) =>
            const MaterialPage(child: CreatePage()),
      ),
      GoRoute(
        name: 'shop',
        path: '/shop',
        pageBuilder: (context, state) => const MaterialPage(child: ShopPage()),
      ),
      GoRoute(
        name: 'cart',
        path: '/cart',
        pageBuilder: (context, state) => MaterialPage(child: CartPage()),
      ),
      GoRoute(
        name: 'more',
        path: '/more',
        pageBuilder: (context, state) => const MaterialPage(child: MorePage()),
      )
    ],
  );
}
