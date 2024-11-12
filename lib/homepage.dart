//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'auth_service.dart';

class HomePage extends StatefulWidget {
  final String? idToken;
  final String? accessToken;
  const HomePage({Key? key, this.idToken, this.accessToken}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //String? user = FirebaseAuth.instance.currentUser!.email ?? FirebaseAuth.instance.currentUser!.displayName;
  

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Future.delayed(
    //     Duration(seconds: 3),
    //     () => setState(() {
    //           idtoken = AuthService().idtoken;
    //           accesstoken = AuthService().accesstoken;
    //         }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /*
            CircleAvatar(
              radius: 40,
              backgroundImage:
                  NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              FirebaseAuth.instance.currentUser!.displayName!,
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              FirebaseAuth.instance.currentUser!.email!,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            const SizedBox(
              height: 30,
            ),
            */
            Text(
              widget.idToken??"",
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              widget.accessToken??"",
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            const SizedBox(
              height: 30,
            ),
            /*
            MaterialButton(
              padding: const EdgeInsets.all(10),
              color: Colors.green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: const Text(
                'LOG OUT',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              onPressed: () {
                AuthService().signOut();
              },
            ),
            */
          ],
        ),
      ),
    );
  }
}
