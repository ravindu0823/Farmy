import 'package:farmy/components/input_text_field.dart';
import 'package:farmy/constants.dart';
import 'package:farmy/screens/home_page.dart';
import 'package:farmy/screens/register_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final DatabaseReference ref = FirebaseDatabase.instance.ref();
  SessionManager sessionManager = SessionManager();
  bool passwordVisible = false;
  String username = "";
  String password = "";

  Future<bool> isLoggedIn() async {
    return await sessionManager.containsKey("username") &&
            await sessionManager.containsKey("password")
        ? true
        : false;
  }

  void getFirebaseUserData(String username, String password) async {
    final snapshot = await ref.child('Users/${username}').get();

    if (snapshot.exists) {
      if (snapshot.child("password").value == password) {
        await sessionManager.set("username", username);
        await sessionManager.set("password", password);
        await sessionManager.set("email", snapshot.child("email").value);
        await sessionManager.set("phone", snapshot.child("phone").value);
        await sessionManager.set(
          "image_file_path",
          snapshot.child("filepath").value,
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      } else {
        Fluttertoast.showToast(
          msg: "The Password is incorrect",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: kTextColor,
          fontSize: 16.0,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "The Username is incorrect",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: kTextColor,
        fontSize: 16.0,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    isLoggedIn().then((value) {
      value
          ? Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            )
          : passwordVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(
                bottom: 10,
              ),
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            InputTextFieldWidget(
              icon: Icon(Icons.person),
              labelText: 'Username',
              onChanged: (value) {
                username = value;
              },
              obscureText: false,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: TextField(
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                obscureText: passwordVisible,
                decoration: kInputTextField.copyWith(
                  suffixIconColor: Colors.grey,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                    icon: Icon(
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                  prefixIcon: Icon(Icons.lock),
                  labelText: "Password",
                ),
                onChanged: (value) {
                  password = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: ElevatedButton(
                style: kLoginRegisterButtons.copyWith(
                  fixedSize: MaterialStateProperty.all(
                    Size(
                      MediaQuery.of(context).size.width - 200,
                      50,
                    ),
                  ),
                ),
                onPressed: () {
                  getFirebaseUserData(username, password);
                },
                child: Text(
                  'Login',
                ),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  EdgeInsets.only(
                    top: 30,
                  ),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterPage(),
                  ),
                );
              },
              child: Text(
                'Register',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
