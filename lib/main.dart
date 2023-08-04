import 'package:dm_mobile/models/shop/shop.dart';
import 'package:dm_mobile/providers/shop_provider.dart';
import 'package:dm_mobile/screens/logIn-screen.dart';
import 'package:dm_mobile/screens/search_page.dart';
import 'package:dm_mobile/screens/shop_register_screen.dart';
import 'package:dm_mobile/screens/verification_screen.dart';
import 'package:dm_mobile/screens/message_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'providers/message_notifier.dart';
import 'models/message/message.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MessageAdapter());
  Hive.registerAdapter(ShopAdapter());

  // Hive
  //   ..initFlutter()
  //   ..registerAdapter(MessageAdapter())
  //   ..registerAdapter(ShopAdapter());

  await Hive.openBox<Message>('messageBox');
  await Hive.openBox<Shop>('shopBox');

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => MessageNotifier(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: VerificationScreen(),
    );
  }
}
