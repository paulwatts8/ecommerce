import 'package:ecommerce/widgets/custom_btn.dart';
import 'package:ecommerce/widgets/custom_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  void _submitForm() async {
    //set form to loading state
    setState(() {
      _isRegLoading = true;
    });

    //runs create account and retrieve errors
    String _createAccountFeedback = await _createAccount();

    //dispalying error message when creating account
    if (_createAccountFeedback != null) {
      _alertDialogBuilder(_createAccountFeedback);

      //removes form loading state
      setState(() {
        _isRegLoading = false;
      });
    } else {
      //user account in and sent to homepage
      Navigator.pop(context);
    }
  }

  //creating new user account
  Future<String> _createAccount() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _regEmail, password: _regPass);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  //dispalys and alert dialog for errors
  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Container(
              child: Text(error),
            ),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Close Dialog'))
            ],
          );
        });
  }

  //default form loading state
  bool _isRegLoading = false;

  //form input values
  String _regEmail = '';
  String _regPass = '';

  //focusNodes for the input fields
  FocusNode _passFocusNode;

  @override
  void initState() {
    _passFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passFocusNode.dispose();
    super.dispose();
  }

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
                  onChanged: (value) {
                    _regEmail = value;
                  },
                  onSubmitted: (value) {
                    _passFocusNode.requestFocus();
                  },
                  textInputAction: TextInputAction.next,
                ),
                CustomInput(
                  hintText: 'Password....',
                  onChanged: (value) {
                    _regPass = value;
                  },
                  focusNode: _passFocusNode,
                  obsecureText: true,
                  onSubmitted: (value) {
                    _submitForm();
                  },
                ),
                CustomButton(
                    text: 'Register',
                    onPressed: () {
                      _submitForm();
                    },
                    isLoading: _isRegLoading)
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
