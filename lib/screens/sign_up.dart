import 'package:buffer/screens/home_screen.dart';
import 'package:buffer/screens/login_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../helper/constants.dart';
import '../helper/utils.dart';
import '../main.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/loading_indicator.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    Key? key,
  }) : super(key: key);
  @override
  _SignUpScreen createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isHiddenPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.10,
            left: MediaQuery.of(context).size.height * 0.04,
            right: MediaQuery.of(context).size.height * 0.04,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.10,
                child: const Center(
                  child: Text(
                    '   Create Your\n$bufferAccount',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.24,
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                    ],
                  ),
                ),
              ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.10,
              //   child: Align(
              //     alignment: Alignment.topLeft,
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //       children: const [
              //         Text('8+ characters'),
              //         Text('1 uppercase'),
              //         Text('1 number or symbol'),
              //       ],
              //     ),
              //   ),
              // ),
              RichText(
                text: const TextSpan(
                  text: 'I agree to Buffer\'s ',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  children: <TextSpan>[
                    TextSpan(
                        //
                        text: 'Terms and Conditions',
                        style: TextStyle(fontWeight: FontWeight.bold, color: voiletColor)),
                    // TextSpan(text: ' world!'),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 1.0,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50), elevation: 0, primary: voiletColor),
                  onPressed: () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => const HomeScreen()));
                    signUp();
                  },
                  icon: const Icon(Icons.lock_open),
                  label: const Text('Sign Up'),
                ),
              ),
              InkWell(
                onTap: () => Navigator.pushReplacementNamed(context, '/loginScreen'),
                child: RichText(
                  text: const TextSpan(
                    text: 'Don\'t have an account ?? ',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                    children: <TextSpan>[
                      TextSpan(
                          // recognizer: TapGestureRecognizer()
                          //   ..onTap = widget.onClickedSignUp,
                          text: 'Sign In',
                          style: TextStyle(fontWeight: FontWeight.bold, color: voiletColor)),
                      // TextSpan(text: ' world!'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(context: context, barrierDismissible: false, builder: (context) => const Center(child: LoadingIndicatorWidget()));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailController.text.trim(), password: _passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
    // Navigator.pushNamed(context, '/homeScreen');
  }
}
