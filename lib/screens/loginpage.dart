
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/screens/registerpage.dart';
import 'package:ecommerce/widgets/custom_btn.dart';
import 'package:ecommerce/widgets/custom_input.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                'Welcome User.\n Login to your account',
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
                  text: 'Login',
                  onPressed: () {},
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: CustomButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (contect) => RegisterPage()));
                },
                text: 'Create New Account',
                outLineButton: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
