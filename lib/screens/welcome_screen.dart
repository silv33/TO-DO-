import 'package:flutter/material.dart';
import 'package:newapp/screens/register_screen.dart';
import 'package:newapp/widgets/custom_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/Todo_logo.png",
      height: 300,
      ),
      const SizedBox(height:20),
      const Text("Let's get started",
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      ),
      const SizedBox(height:10),
      const Text("Get organized, get productive!",
      style: TextStyle(
        fontSize: 14,
       color: Colors.black38,
       fontWeight: FontWeight.bold,
        ),
        ),
        const SizedBox(height:20),
        //custom button
        SizedBox(
          width: double.infinity,
          height: 50,
          child: CustomButton(
            onPressed: () {
              Navigator.push(context,
              MaterialPageRoute(builder: (context) => const RegisterScreen(),
              ),
              );
            },
            text: "Get started",
          ),
        )
      ],
      ),
      ),
      ),
    ),
    );
  }
}