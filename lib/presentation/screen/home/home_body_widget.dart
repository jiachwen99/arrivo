import 'package:arrivo/presentation/screen/post/post_screen.dart';
import 'package:arrivo/presentation/screen/subscription/subscription_screen.dart';
import 'package:flutter/material.dart';

class HomeBodyWidget extends StatelessWidget {
  final String menu;
  const HomeBodyWidget({Key? key, required this.menu}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (menu) {
      case 'Post':
        page = PostScreen();
        break;
      case 'Subscriptions':
        page = SubscriptionScreen();
        break;
      case 'Logout':
        page = const Center(
          child: Text(
            "Other Page",
            style: TextStyle(
              color: Color(0xFF171719),
              fontSize: 22,
            ),
          ),
        );
        break;
      default:
        page = const Center(
          child: Text(
            "Other Page",
            style: TextStyle(
              color: Color(0xFF171719),
              fontSize: 22,
            ),
          ),
        );
    }
    return page;
  }
}
