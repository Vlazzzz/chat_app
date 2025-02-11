import 'package:chat_app_2/auth_provider.dart';
import 'package:chat_app_2/home_screen.dart';
import 'package:chat_app_2/signup_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'Please enter email.';
                }
                return null;
              }
            ),
            SizedBox(height:20),
            TextFormField(
              controller: _passController,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'Please enter password.';
                }
                return null;
              }
            ),
            SizedBox(height:50),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.5,
              height: 55,
              child: ElevatedButton(
                onPressed: () async{
                  try {
                    await authProvider.signIn(
                    _emailController.text, _passController.text);
                    Fluttertoast.showToast(msg: "Login successful");

                    Navigator.pushReplacement(
                      context, 
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ));
                  } catch (e) {
                    print(e);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              )
            ),
            SizedBox(height: 20),
            Text("OR"),
            SizedBox(height: 10),
            TextButton(onPressed: (){
               Navigator.pushReplacement(
                      context, 
                      MaterialPageRoute(
                        builder: (context) => SignUpScreen(),
                      ));
            }, 
            child: Text(
                "Create account",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                )
              )
            )
          ]
        )
      )
    );
  }
}