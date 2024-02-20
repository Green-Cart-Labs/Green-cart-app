import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:green_cart/api_service.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
  }

  Future<dynamic> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      print("Google User: ${googleUser}");

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      var info = await FirebaseAuth.instance.signInWithCredential(credential);
      // print(info.user.);
      var res = await ApiService().addUser(info.user?.uid,
          info.user?.displayName, info.user?.email, info.user?.photoURL);
      return await info;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
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
  // print(userCredential);
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
                        context.go('/');
                        print("User credentials: ${userCredential}");
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
