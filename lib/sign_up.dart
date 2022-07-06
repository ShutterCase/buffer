import 'package:buffer/home_screen.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreen createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
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
                height: MediaQuery.of(context).size.height * 0.20,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomTextField(
                      textEditingController: _emailController,
                      textInputType: TextInputType.emailAddress,
                      hintText: 'Enter E-mail',
                      icon: const Icon(Icons.email),
                    ),
                    CustomTextField(
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
                        child: Icon(isHiddenPassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      isPass: isHiddenPassword,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.10,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Text('8+ characters'),
                      Text('1 uppercase'),
                      Text('1 number or symbol'),
                    ],
                  ),
                ),
              ),
              RichText(
                text: const TextSpan(
                  text: 'I agree to Buffer\'s ',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  children: <TextSpan>[
                    TextSpan(
                        //
                        text: 'Terms and Conditions',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: voiletColor)),
                    // TextSpan(text: ' world!'),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 1.0,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      elevation: 0,
                      primary: voiletColor),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
                  },
                  icon: const Icon(Icons.lock_open),
                  label: const Text('Log In'),
                ),
              ),
              RichText(
                text: const TextSpan(
                  text: 'Don\'t have an account ?? ',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  children: <TextSpan>[
                    TextSpan(
                        //
                        text: 'Sign Up',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: voiletColor)),
                    // TextSpan(text: ' world!'),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
