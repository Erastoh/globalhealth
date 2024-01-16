import 'package:flutter/material.dart';
import 'package:globalhealth/Pages/Homepage.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(
      Sizer(builder: (context, orientation, screenType) {
        return Sizer(builder: (context, orientation, screenType) {
          return
              MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    appBarTheme: const AppBarTheme(
                      backgroundColor: Colors.white,
                      iconTheme: IconThemeData(
                          color: Colors
                              .black), // set backbutton color here which will reflect in all screens.
                    ),
                  ),
                  home: MyApp(),
                  // routes: {
                  //   HomePage.route: (
                  //       context) => const HomePage(),
                  // }
             );

        });
      }));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Global Health',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
