import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PinterestTestScreen extends StatefulWidget {
  const PinterestTestScreen({Key? key}) : super(key: key);

  @override
  State<PinterestTestScreen> createState() => _PinterestTestScreenState();
}

class _PinterestTestScreenState extends State<PinterestTestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              'Pinterest Login',
              style: TextStyle(fontSize: 30),
            ),
            ElevatedButton(
                onPressed: () async {
                  final url = Uri.https('api.pinterest.com', 'oauth', {
                    'response_type': 'code',
                    'client_id': "appId",
                    'redirect_uri': "https://brandandbeyondit.com/",
                    'state': 'someBogusStuff',
                    'scope': 'read_public,write_public',
                  });
                },
                child: Text("Pinteret Login")),
            ElevatedButton(onPressed: () {}, child: Text("Pinteret LogOut")),
          ],
        ),
      ),
    );
  }
}

//
// Future<String> _login() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//
//   accessToken = null;
//   if (accessToken == null) {
// //      accessToken = prefs.get(ACCESS_TOKEN_KEY);
//
//     //If we don't have an existing access token, get a new one.
//     if (accessToken == null) {
//       final appId = "myappid";
//       final secret =
//           "mysecret";
//
//       final url = Uri.https('api.pinterest.com', 'oauth', {
//         'response_type': 'code',
//         'client_id': appId,
//         'redirect_uri': "pdk<myappid>://",
//         'state': 'someBogusStuff',
//         'scope': 'read_public,write_public',
//       });
//
//       final result = await FlutterWebAuth.authenticate(
//           url: url.toString(), callbackUrlScheme: 'pdk<myappid>');
//
//       print(result);
//
//       final tokenEndpoint = Uri.https('api.pinterest.com', 'v1/oauth/token');
//
//       // Use the code to get an access token
//       final response = await http.post(tokenEndpoint, body: {
//         'client_id': appId,
//         'client_secret': secret,
//         'grant_type': 'authorization_code',
//         'code': Uri
//             .parse(result)
//             .queryParameters['code'],
//       });
//
//       if (response.statusCode != 200) {
//         return response.body;
//       }
//
//       var decodedResponse = jsonDecode(response.body);
//       print(decodedResponse);
//       accessToken = decodedResponse['access_token'];
//
//       //Save the access token
//       prefs.setString(ACCESS_TOKEN_KEY, accessToken);
//     }
//   }
//
//   return getMe(accessToken);
// }
//
// Future<String> getMe(String token) async {
//   final url =
//   Uri.https('api.pinterest.com', 'v1/me', {'access_token': token});
//
//   Completer<String> completer = Completer();
//   String result;
//   http.get(url, headers: {'User-Agent': 'PDK 1.0'}).then((response) {
//     print(response.statusCode);
//     result = response.body;
//   }).whenComplete(() => completer.complete(result));
//
//   return completer.future;
// }
