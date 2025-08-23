import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_portfolio_app/constants/theme/theme_data.dart';
import 'package:my_portfolio_app/firebase_options.dart';
import 'package:my_portfolio_app/presentation/mobile/home.dart';
import 'package:my_portfolio_app/router/app_router.dart';
import 'package:my_portfolio_app/services/theme_service.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: ValueListenableBuilder<ThemeMode>(
        valueListenable: ThemeService.themeModeNotifier,
        builder:
            (_, ThemeMode currentMode, __) => MaterialApp(
              title: 'Egundeyi Oladotun\'s Portfolio',
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: currentMode,
              initialRoute: PortfolioHome.routeName,
              routes: AppRouter.routes,
              debugShowCheckedModeBanner: false,
            ),
      ),
    );
  }
}
