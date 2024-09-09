import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo6/firebase_options.dart';
import 'package:todo6/ui/home/tabs/list/settings/provider.dart';
import 'package:todo6/ui/screens/home_screen.dart';
import 'package:todo6/utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseFirestore.instance.disableNetwork();

  FirebaseFirestore.instance.settings =
    const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoProvider()),  // Example provider
      ],
      child: const MyApp())
      );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        home: const HomeScreen(),
        routes: {HomeScreen.routeName: (_) => const HomeScreen()},
        initialRoute: HomeScreen.routeName,
      );
    
  }
}
