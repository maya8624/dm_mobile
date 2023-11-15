import 'package:dm_mobile/screens/splash/components/body.dart';
import 'package:flutter/material.dart';

import '../../utils/size_config.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  static String routeName = "/splash";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: Body(),
    );
  }
}
