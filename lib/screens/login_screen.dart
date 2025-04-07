import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? error;

  void signIn() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() => error = "Please fill the required fields.");
      return;
    }

    final auth = Provider.of<AuthProvider>(context, listen: false);
    final result = await auth.signIn(email, password);

    if (result != null) {
      setState(() => error = result);
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign In")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: emailController, decoration: InputDecoration(labelText: "Email")),
            TextField(controller: passwordController, decoration: InputDecoration(labelText: "Password"), obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(onPressed: signIn, child: Text("Sign In")),
            if (error != null) Text(error!, style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
