import 'package:flutter/material.dart';

import 'package:my_portfolio_app/presentation/mobile/home.dart';

class AppRouter {
  static Map<String, Widget Function(BuildContext)> get routes => {
    PortfolioHome.routeName: (context) => PortfolioHome(),
  };
}
