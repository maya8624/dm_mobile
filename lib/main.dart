import 'package:cron/cron.dart';
import 'package:dm_mobile/models/business/business.dart';
import 'package:dm_mobile/screens/verification_screen.dart';
import 'package:dm_mobile/services/cron_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'providers/message_notifier.dart';
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
