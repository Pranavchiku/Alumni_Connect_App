import 'package:flutter/material.dart';

class SignUpFormAlumni extends StatefulWidget {
  const SignUpFormAlumni({super.key});

  @override
  State<SignUpFormAlumni> createState() => _SignUpFormAlumniState();
}

class _SignUpFormAlumniState extends State<SignUpFormAlumni> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(),
      ),
    );
  }
}
