import 'package:chat_app_2/auth_provider.dart';
import 'package:chat_app_2/chat_provider.dart';
import 'package:chat_app_2/firebase_options.dart';
import 'package:chat_app_2/home_screen.dart';
import 'package:chat_app_2/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthenticationWrapper()
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context){
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child){
        if(authProvider.isSignedIn){
          return HomeScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}