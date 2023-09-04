import 'package:farmy/components/input_text_field.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool passwordVisible = false;
  bool confirmPasswordVisible = false;
  late String username;
  late String phoneNumber;
  late String email;
  late String password;
  late String confirmPassword;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
    confirmPasswordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              flex: 2,
              child: Container(
                margin: EdgeInsets.only(
                  top: 30,
                  bottom: 10,
                ),
                child: Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
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
            InputTextFieldWidget(
              icon: Icon(Icons.phone),
              labelText: 'Phone Number',
              onChanged: (value) {
                phoneNumber = value;
              },
              obscureText: false,
            ),
            InputTextFieldWidget(
              icon: Icon(Icons.email),
              labelText: 'Email Address',
              onChanged: (value) {
                email = value;
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
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: TextField(
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                obscureText: confirmPasswordVisible,
                decoration: kInputTextField.copyWith(
                  suffixIconColor: Colors.grey,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        confirmPasswordVisible = !confirmPasswordVisible;
                      });
                    },
                    icon: Icon(
                      confirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                  prefixIcon: Icon(Icons.lock),
                  labelText: "Confirm Password",
                ),
                onChanged: (value) {
                  confirmPassword = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
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
                  print(username);
                  print(phoneNumber);
                  print(email);
                  print(password);
                  print(confirmPassword);
                },
                child: Text(
                  'Register',
                ),
              ),
            ),
            Flexible(
              child: TextButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    EdgeInsets.only(
                      top: 30,
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'I already have an account',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
