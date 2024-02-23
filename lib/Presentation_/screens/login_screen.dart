import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_bloc_ddd_2024/Infrastructure_/auth_service_impl.dart';
import 'package:weather_bloc_ddd_2024/Presentation_/Bloc/weather_bloc.dart';
import 'package:weather_bloc_ddd_2024/Presentation_/screens/signup_screen.dart';
import 'package:weather_bloc_ddd_2024/Presentation_/screens/weather_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _onSignInSuccess(BuildContext context) {
    // After successful sign-in, navigate to WeatherPage and replace the current route
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => WeatherBloc()..add(GetWeatherByLocationEvent()),
          child: WeatherPage(),
        ),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                AuthService authService = AuthService();
                String? errorMessage = await authService.signInWithEmail(
                  emailController.text,
                  passwordController.text,
                );

                if (errorMessage == null) {
                  // Navigate to home or next screen upon successful login
                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                  _onSignInSuccess(context);
                } else {
                  // Show error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(errorMessage + '\n\n\n Try Again With Correct Details')),
                  );
                }
              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                child: Text('Login'),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
              },
              child: Text('Sign UP'),
            ),
          ],
        ),
      ),
    );
  }
}
