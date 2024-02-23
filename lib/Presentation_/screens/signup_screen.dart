import 'package:flutter/material.dart';
import 'package:weather_bloc_ddd_2024/Infrastructure_/auth_service_impl.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email' , hintText: 'enter your email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password', hintText: 'minimum 6 letters or digits'),
              obscureText: true,
              onChanged: (password) {
                setState(() {
                  // Enable the button only if the password length is more than 5
                  isButtonEnabled = password.length > 5;
                });
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: isButtonEnabled
                  ? () async {
                AuthService authService = AuthService();
                String? errorMessage = await authService.signUpWithEmail(
                  emailController.text,
                  passwordController.text,
                );

                if (errorMessage == null) {
                  // Navigate to home or next screen upon successful sign-up
                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                  Navigator.pop(context);
                } else {
                  // Show error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(errorMessage)),
                  );
                }
              }
                  : null, // Disable the button if isButtonEnabled is false
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
