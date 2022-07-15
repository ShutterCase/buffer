import 'package:buffer/screens/home_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../helper/utils.dart';

import '../helper/constants.dart';
import '../main.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/loading_indicator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isHiddenPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.06,
            horizontal: MediaQuery.of(context).size.height * 0.04,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                ' Welcome Back \n $bufferAccount',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomTextField(
                      maxLines: 1,
                      validator: (value) => EmailValidator.validate(value!) ? null : "Please enter a valid email",
                      textEditingController: _emailController,
                      textInputType: TextInputType.emailAddress,
                      hintText: 'E-mail',
                      icon: const Icon(Icons.email),
                    ),
                    CustomTextField(
                      maxLines: 1,
                      validator: (value) => value != null && value.length < 8 ? 'Enter min. 8 characters' : null,
                      textEditingController: _passwordController,
                      textInputType: TextInputType.visiblePassword,
                      hintText: 'Password',
                      icon: const Icon(Icons.lock),
                      suffixicon: InkWell(
                        onTap: () {
                          setState(() {
                            isHiddenPassword = !isHiddenPassword;
                          });
                        },
                        child: Icon(isHiddenPassword ? Icons.visibility : Icons.visibility_off),
                      ),
                      isPass: isHiddenPassword,
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50), elevation: 0, primary: voiletColor),
                      onPressed: () {
                        signIn();
                      },
                      icon: const Icon(Icons.lock_open),
                      label: const Text('Log In'),
                    ),
                  ],
                ),
              ),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Forget Password?',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              InkWell(
                onTap: () => Navigator.pushReplacementNamed(context, '/signUpScreen'),
                child: RichText(
                  text: TextSpan(
                    text: 'Don\'t have an account ?? ',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                    children: <TextSpan>[
                      TextSpan(text: 'Sign Up', style: TextStyle(fontWeight: FontWeight.bold, color: voiletColor)),
                      // TextSpan(text: ' world!'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Future signIn() async {
    showDialog(context: context, barrierDismissible: false, builder: (context) => const Center(child: LoadingIndicatorWidget()));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text.trim(), password: _passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
    // Navigator.pushNamed(context, '/loginScreen');
  }
}
