import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:temp_app/pages/homepage2_.dart';
import 'package:temp_app/services/api_services.dart';

void main() {
  
  runApp(MultiProvider (providers: [ChangeNotifierProvider(create: (_)=>ApiService())], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage2(),
    );
  }
}
