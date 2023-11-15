import 'package:dm_mobile/helper/init_dependency.dart';
import 'package:dm_mobile/models/business/business.dart';
import 'package:dm_mobile/routs.dart';
import 'package:dm_mobile/screens/profile/profile_screen.dart';
import 'package:dm_mobile/screens/settings_screen.dart';
import 'package:dm_mobile/screens/splash/splash_screen.dart';
import 'package:dm_mobile/screens/verification_screen.dart';
import 'package:dm_mobile/services/cron_service.dart';
import 'package:dm_mobile/theme.dart';
import 'package:dm_mobile/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/message/message.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CronService().startScheduler();

  await Hive.initFlutter();
  Hive.registerAdapter(MessageAdapter());
  Hive.registerAdapter(BusinessAdapter());

  // Hive
  //   ..initFlutter()
  //   ..registerAdapter(MessageAdapter())
  //   ..registerAdapter(ShopAdapter());

  await Hive.openBox<Message>('messageBox');
  await Hive.openBox<Business>('businessBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitDep(),
      initialRoute: SplashScreen.routeName,
      routes: routes,
      // initialRoute: "/",
      // getPages: [
      //   GetPage(name: "/", page: () => const VerificationScreen()),
      // ],
      debugShowCheckedModeBanner: false,
      title: 'Direct Message',
      theme: theme(),
      // home: const VerificationScreen(),
      // home: const SettingsScreen(),
      // home: const ProfileScreen(),
    );
  }
}
