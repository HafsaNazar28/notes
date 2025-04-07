import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? error;

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@(gmail\.com|email\.com|yahoo\.com)$').hasMatch(email);
  }

  void signUp() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() => error = "Please fill the required fields.");
      return;
    }

    if (!isValidEmail(email)) {
      setState(() => error = "Invalid email address.");
      return;
    }

    final auth = Provider.of<AuthProvider>(context, listen: false);
    final result = await auth.signUp(email, password);

    if (result != null) {
      setState(() => error = result);
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
            TextField(controller: passwordController, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
            SizedBox(height: 16),
            ElevatedButton(onPressed: signUp, child: Text("Sign Up")),
            if (error != null) Padding(padding: EdgeInsets.only(top: 12), child: Text(error!, style: TextStyle(color: Colors.red))),
          ],
        ),
      ),
    );
  }
}
