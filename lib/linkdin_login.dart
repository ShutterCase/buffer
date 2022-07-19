import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linkedin_login/linkedin_login.dart';

const String redirectUrl = 'https://brandandbeyondit.com/';
const String clientId = '860kx19cc72jr7';
const String clientSecret = 'GyVwn74vy4C5iG51';

class TestApp extends StatefulWidget {
  const TestApp({Key? key}) : super(key: key);

  @override
  State<TestApp> createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  AuthCodeObject? authorizationCode;
  bool logoutUser = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          LinkedInButtonStandardWidget(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (final BuildContext context) => LinkedInAuthCodeWidget(
                    destroySession: logoutUser,
                    redirectUrl: redirectUrl,
                    clientId: clientId,
                    onError: (final AuthorizationFailedAction e) {
                      print('Error: ${e.toString()}');
                      print('Error: ${e.stackTrace.toString()}');
                    },
                    onGetAuthCode: (final AuthorizationSucceededAction response) {
                      print('Auth code ${response.codeResponse.code}');

                      print('State: ${response.codeResponse.state}');

                      authorizationCode = AuthCodeObject(
                        code: response.codeResponse.code!,
                        state: response.codeResponse.state!,
                      );
                      setState(() {});

                      Navigator.pop(context);
                    },
                  ),
                  fullscreenDialog: true,
                ),
              );
            },
          ),
          LinkedInButtonStandardWidget(
            onTap: () {
              setState(() {
                authorizationCode = null;
                logoutUser = true;
              });
            },
            buttonText: 'Logout user',
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Auth code: ${authorizationCode?.code} '),
                Text('State: ${authorizationCode?.state} '),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCodeObject {
  AuthCodeObject({required this.code, required this.state});

  final String code;
  final String state;
}
