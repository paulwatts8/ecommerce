import 'package:ecommerce/constants.dart';
import 'package:ecommerce/screens/registerpage.dart';
import 'package:ecommerce/widgets/custom_btn.dart';
import 'package:ecommerce/widgets/custom_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void _submitForm() async {
    //set form to loading state
    setState(() {
      _isLoginLoading = true;
    });

    //runs signs in and retrieve errors
    String _loginAccountFeedback = await _createAccount();

    //dispalying error message when creating account
    if (_loginAccountFeedback != null) {
      _alertDialogBuilder(_loginAccountFeedback);

      //removes form loading state
      setState(() {
        _isLoginLoading = false;
      });
    } else {
      //user logged in and sent to homepage
      Navigator.pop(context);
    }
  }

  //Logining new user account
  Future<String> _createAccount() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _signinEmail, password: _signinPass);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
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
  bool _isLoginLoading = false;

  //form input values
  String _signinEmail = '';
  String _signinPass = '';

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
          'Welcome User.\n Login to your account',
          textAlign: TextAlign.center,
          style: Constants.boldHeading,
        ),
      ),
      Column(
        children: [
          CustomInput(
            hintText: 'Email...',
            onChanged: (value) {
              _signinEmail = value;
            },
            onSubmitted: (value) {
              _passFocusNode.requestFocus();
            },
            textInputAction: TextInputAction.next,
          ),
          CustomInput(
            hintText: 'Password....',
            onChanged: (value) {
              _signinPass = value;
            },
            focusNode: _passFocusNode,
            obsecureText: true,
            onSubmitted: (value) {
              _submitForm();
            },
          ),
          CustomButton(
              text: 'Login',
              onPressed: () {
                _submitForm();
              },
              isLoading: _isLoginLoading)
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: CustomButton(
          isLoading: _isLoginLoading,
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
