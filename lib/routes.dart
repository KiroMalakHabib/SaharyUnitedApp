import 'package:flutter/material.dart';
import 'package:sahary_united_company_for_powers/screens/bottomNavigation/bottom_navigator.dart';
import 'package:sahary_united_company_for_powers/screens/bottomNavigation/screens/divisions/division_screen.dart';
import 'package:sahary_united_company_for_powers/screens/bottomNavigation/screens/divisions/product_details.dart';
import 'package:sahary_united_company_for_powers/screens/drawerScreens/clients.dart';
import 'package:sahary_united_company_for_powers/screens/drawerScreens/common_questions.dart';
import 'package:sahary_united_company_for_powers/screens/drawerScreens/partners.dart';
import 'package:sahary_united_company_for_powers/screens/drawerScreens/who_we_are.dart';
import 'package:sahary_united_company_for_powers/screens/on_boarding.dart';

class AppRoutes {
  static const String onBoarding = '/on-boarding';
  static const String bottomNavigator = '/bottom-navigator';
  static const String clients = '/clients';
  static const String commonQuestions = '/common-questions';
  static const String partners = '/partners';
  static const String whoWeAre = '/who-we-are';
  static const String departmentScreen = '/department-screen';
  static const String productDetails = '/product-details';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onBoarding:
        return MaterialPageRoute(
          builder: (_) => const OnBoardingScreen(),
          fullscreenDialog: true,
        );
      case bottomNavigator:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder:
              (context) => BottomNavigator(
                tabIndex: args?['tabIndex'],
                productName: args?['productName'],
                departmentId: args?['department_id'],
              ),
        );
      case clients:
        return MaterialPageRoute(
          builder: (_) => const Clients(),
          fullscreenDialog: true,
        );
      case commonQuestions:
        return MaterialPageRoute(
          builder: (_) => const CommonQuestions(),
          fullscreenDialog: true,
        );
      case partners:
        return MaterialPageRoute(
          builder: (_) => const Partners(),
          fullscreenDialog: true,
        );
      case whoWeAre:
        return MaterialPageRoute(
          builder: (_) => const WhoWeAre(),
          fullscreenDialog: true,
        );
      case departmentScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder:
              (_) => DivisionScreen(
                divisionId: args['id'],
                title: args['title'],
                divisionName: args['divisionName'],
                isSearchMode: args['isSearchMode'] as bool? ?? false,
              ),
          fullscreenDialog: true,
        );
      case productDetails:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder:
              (_) => ProductDetails(
                departmentId: args['department_id'],
                id: args['id'],
                imageUrl: args['imageUrl'],
                specifications: args['specifications'],
                title: args['title'],
                tags: args['tags'],
                product: args['product'],
              ),
          fullscreenDialog: true,
        );
      default:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
    }
  }
}