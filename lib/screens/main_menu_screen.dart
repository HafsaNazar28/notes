import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

class MainMenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notes App')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => SignUpScreen()));
              }, child: Text('Sign Up')),
              SizedBox(height: 20),
              ElevatedButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
              }, child: Text('Sign In')),
            ],
          ),
        ),
      ),
    );
  }
}
