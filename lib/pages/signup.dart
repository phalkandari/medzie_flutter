import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:medzie_flutter/providers/signing_provider.dart';
import 'package:provider/provider.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign up'),
      ),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(hintText: "username"),
                validator: ((value) {
                  if (value == null || value.isEmpty) {
                    return 'required field';
                  }
                  return null;
                }),
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(hintText: "password"),
                validator: ((value) {
                  if (value == null || value.isEmpty) {
                    return 'required field';
                  }
                  return null;
                }),
              ),
              TextFormField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(hintText: "confirm password"),
                validator: ((value) {
                  if (value == null || value.isEmpty) {
                    return 'required field';
                  }

                  if (passwordController.text != value) {
                    return 'passwords do not match';
                  }
                  return null;
                }),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    print("The Form is Valid");
                    var signedUp = await context.read<SigningProvider>().signup(
                        username: usernameController.text,
                        password: passwordController.text);
                    if (signedUp) {
                      context.go('/list');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("NOT a successful signup")));
                    }
                  } else {
                    print('The Form is NOT Valid');
                  }
                },
                child: Text("sign up"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account? '),
                  InkWell(
                    onTap: () {
                      context.replace('/signin');
                    },
                    child: Text(
                      'Sign in',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
