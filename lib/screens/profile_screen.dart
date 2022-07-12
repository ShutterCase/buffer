import 'package:buffer/helper/constants.dart';
import 'package:buffer/widgets/create_profile.dart';
import 'package:buffer/widgets/loading_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = false;

  String name = '';
  String email = '';
  String age = '';
  String detail = "";

  void dataChanges() {
    FirebaseDatabase.instance.ref("users").child(FirebaseAuth.instance.currentUser!.uid).onValue.listen((event) {
      var checker = event.snapshot.child("name").value;

      if (checker != null) {
        setState(() {
          name = event.snapshot.child("name").value.toString();
          email = event.snapshot.child("email").value.toString();
          age = event.snapshot.child("age").value.toString();
          detail = event.snapshot.child("detailString").value.toString();
          LoadingIndicatorWidget();

          isLoading = true;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    dataChanges();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text('Create Profile'),
        // ),
        body: isLoading
            ? Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.maxFinite,
                        height: MediaQuery.of(context).size.height * 0.35,
                        child: Stack(
                          children: [
                            SizedBox(
                              height: double.maxFinite,
                              width: double.maxFinite,
                              child: Image.network(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-jVtQ0FFAZzBdbf4s0EsNsZJGrcRpKCITwv8PAMalrpHn45krrsU1BbFb82LsyCznPks&usqp=CAU",
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 5, bottom: 7),
                              child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.camera,
                                      size: 35,
                                    ),
                                    onPressed: () {},
                                  )),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        // color: Colors.yellow,
                        height: MediaQuery.of(context).size.height * 0.55,
                        width: double.maxFinite,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, right: 15, left: 15, bottom: 10),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            'Profile',
                            style: TextStyle(color: whiteColor, fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.172),
                        const CircleAvatar(
                          radius: 75,
                          backgroundColor: whiteColor,
                          child: CircleAvatar(
                            radius: 70,
                            backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-jVtQ0FFAZzBdbf4s0EsNsZJGrcRpKCITwv8PAMalrpHn45krrsU1BbFb82LsyCznPks&usqp=CAU"),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                        Text(
                          name,
                          style: const TextStyle(color: whiteColor, fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          detail,
                          style: TextStyle(color: grey, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ListTileWidget(
                                name: name,
                                title: 'Name',
                              ),
                              const Divider(height: 2),
                              ListTileWidget(
                                name: email,
                                title: 'Email',
                              ),
                              const Divider(height: 2),
                              ListTileWidget(
                                name: age,
                                title: 'Age',
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            : const CreateProfile());
  }
}

class ListTileWidget extends StatelessWidget {
  const ListTileWidget({
    Key? key,
    required this.name,
    required this.title,
  }) : super(key: key);

  final String name;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(color: voiletColor, fontWeight: FontWeight.w600, fontSize: 16),
      ),
      subtitle: Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
      ),
      // contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
    );
  }
}
