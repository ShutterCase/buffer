import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookLogin extends StatefulWidget {
  const FacebookLogin({Key? key}) : super(key: key);

  @override
  State<FacebookLogin> createState() => _FacebookLoginState();
}

class _FacebookLoginState extends State<FacebookLogin> {
  bool loggedIn = false;

  AccessToken? _accessToken;
  UserModelFb? _currentUser;
  @override
  Widget build(BuildContext context) {
    UserModelFb? modelFb = _currentUser;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Facebook Login",
              style: TextStyle(fontSize: 30),
            ),
            modelFb != null ? Text(_currentUser?.name ?? "Waiting") : Text("not found"),
            modelFb != null ? Text(_currentUser?.email ?? "Waiting") : Text("not found"),
            modelFb != null ? Image.network(_currentUser?.pictureModel?.url ?? "Waiting") : Text("not found"),
            ElevatedButton(
              onPressed: signIn,
              child: const Text("signIn"),
            ),
            ElevatedButton(
              onPressed: signOut,
              child: const Text("SignOut"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signIn() async {
    final LoginResult result = await FacebookAuth.i.login();
    if (result.status == LoginStatus.success) {
      _accessToken = result.accessToken;

      final data = await FacebookAuth.i.getUserData();
      UserModelFb modelFb = UserModelFb.fromJson(data);
      _currentUser = modelFb;
      setState(() {});
    }
  }

  Future<void> signOut() async {
    await FacebookAuth.i.logOut();
    _currentUser = null;
    _accessToken = null;
    setState(() {});
  }
}

class UserModelFb {
  final String? email;
  final String? id;
  final String? name;
  final PictureModel? pictureModel;

  UserModelFb({this.email, this.id, this.name, this.pictureModel});

  factory UserModelFb.fromJson(Map<String, dynamic> json) => UserModelFb(
        email: json["email"],
        id: json['id'] as String,
        name: json["name"],
        pictureModel: PictureModel.fromJson(
          json["picture"]["data"],
        ),
      );
}

class PictureModel {
  final String? url;
  final int? width;
  final int? height;

  PictureModel({
    this.url,
    this.width,
    this.height,
  });
  factory PictureModel.fromJson(Map<String, dynamic> json) => PictureModel(url: json["url"], width: json['width'], height: json['height']);
}
