import 'package:Veegil/screens/splash.dart';
import 'package:Veegil/utils/constants.dart';
import 'package:Veegil/utils/providers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(Provider(
    create: (_) => Providers(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: white,
        primaryColor: primary,
        accentColor: accent,
        textTheme: GoogleFonts.rubikTextTheme(),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Splash(),
    );
  }
}
