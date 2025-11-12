// lib/app/routes/app_pages.dart
import 'package:base_project/app/modules/cart/view/cart_screen.dart';
import 'package:base_project/app/modules/sales/view/sales_report_screen.dart';
import 'package:base_project/app/modules/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:base_project/app/modules/login/screens/business_id_screen.dart';
import 'package:base_project/app/modules/login/screens/pass_code_screen.dart';
import 'package:base_project/app/modules/login/screens/select_user_screen.dart';
import 'package:base_project/app/modules/menu/views/menu_screen.dart';
import 'package:base_project/app/modules/menu/views/profile_screen.dart';
import 'package:base_project/app/modules/menu/views/product_detail_screen.dart';
import 'app_routes.dart';

class AppPages {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return _buildRoute(const SplashScreen());
      case AppRoutes.businessId:
        return _buildRoute(const BusinessIdScreen());
      case AppRoutes.passcode:
        return _buildRoute(const PasscodeScreen());
      case AppRoutes.selectUser:
        return _buildRoute(const SelectUserScreen());
      case AppRoutes.menu:
        return _buildRoute(const MenuScreen());
      case AppRoutes.profile:
        return _buildRoute(const ProfileScreen());
      case AppRoutes.cart:
        return _buildRoute(const CartScreen());
      case AppRoutes.salesReport:
        return _buildRoute(const SalesReportScreen());
      case AppRoutes.productDetail:
        final args = settings.arguments as Map<String, dynamic>?;
        return _buildRoute(
          ProductDetailScreen(
            productName: args?['productName'] ?? '',
            price: args?['price'] ?? '',
          ),
        );
      default:
        return _buildRoute(const SplashScreen());
    }
  }

  /// ✅ Custom Page Transition (Slide Left → Right)
  static PageRouteBuilder _buildRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 350),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Slide from right to left
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
