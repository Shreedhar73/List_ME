import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:listme/models/postmodels/post_model.dart';
import 'package:listme/views/splash_screen.dart';

void main() async {
   Hive.registerAdapter(PostModelAdapter());

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
       home: SplashScreen(),
    );
  }
}
