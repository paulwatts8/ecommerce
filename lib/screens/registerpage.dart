import 'package:ecommerce/widgets/custom_btn.dart';
import 'package:ecommerce/widgets/custom_input.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Text(
                'Create New Account',
                textAlign: TextAlign.center,
                style: Constants.boldHeading,
              ),
            ),
            Column(
              children: [
                CustomInput(
                  hintText: 'Email...',
                ),
                CustomInput(
                  hintText: 'Password....',
                ),
                CustomButton(
                  text: 'Register',
                  onPressed: () {},
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: CustomButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                text: 'Back to Login',
                outLineButton: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
