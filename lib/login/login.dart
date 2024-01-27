import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // late Future<FirebaseApp> _firebaseInitialization;

  @override
  void initState() {
    super.initState();
    // _firebaseInitialization = _initializeFirebase();
  }

  // Future<FirebaseApp> _initializeFirebase() async {
  //   FirebaseApp firebaseApp = await Firebase.initializeApp(
  //     name: 'Bloom',
  //     options: const FirebaseOptions(
  //       // TODO: improve code quality
  //       apiKey: 'AIzaSyAXJxGwdgBHW92uZtbER8MFjxAR5t6Ehl0',
  //       appId: '1:529019554109:android:e30d4efa057826cf725d54',
  //       messagingSenderId: '529019554109',
  //       projectId: 'book-my-ground-331b5',
  //       storageBucket: 'book-my-ground-331b5.appspot.com',
  //     ),
  //   );
  //   return firebaseApp;
  // }

  Future<dynamic> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      print("googleUser.toString()");
      print(googleUser.toString());
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      print('credential->$credential');
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on Exception catch (e) {
      // TODO
      print('exception->$e');
    }
  }

  Future<bool> signOutFromGoogle() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  ValueNotifier userCredential = ValueNotifier('');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Google SignIn Screen')),
      body: ValueListenableBuilder(
        valueListenable: userCredential,
        builder: (context, value, child) {
          return (userCredential.value == '' || userCredential.value == null)
              ? Center(
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      iconSize: 40,
                      icon: SvgPicture.asset(
                        'assets/images/logo.svg',
                      ),
                      onPressed: () async {
                        userCredential.value = await signInWithGoogle();
                        print(userCredential);
                        print("90");
                        // if (userCredential.value != null)
                        //   print(userCredential.value.user!.email);
                        // print("object");
                      },
                    ),
                  ),
                )
              : Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1.5,
                            color: Colors.black54,
                          ),
                        ),
                        child: Image.network(
                          userCredential.value.user!.photoURL.toString(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        userCredential.value.user!.displayName.toString(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        userCredential.value.user!.email.toString(),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          bool result = await signOutFromGoogle();
                          if (result) userCredential.value = '';
                          // print("object");
                        },
                        child: const Text('Logout'),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
