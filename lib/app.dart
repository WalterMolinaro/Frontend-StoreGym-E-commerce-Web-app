import 'package:flutter/material.dart';
import 'package:progetto_piattaforme/app_router.dart';

import 'package:progetto_piattaforme/pages/home_page.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Store gym',
      theme: ThemeData(
          primarySwatch: Colors.green,
          primaryColor: Colors.white,
          brightness: Brightness.dark),
      debugShowCheckedModeBanner: false,
      initialRoute: HomePage.routeName,
      onGenerateRoute: AppRouter.generatedRoute,
    );
  }
}
