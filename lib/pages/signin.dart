import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medzie_flutter/providers/signing_provider.dart';
import 'package:provider/provider.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
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
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    print("The Form is Valid");
                    var signedIn = await context.read<SigningProvider>().signin(
                        username: usernameController.text,
                        password: passwordController.text);
                    if (signedIn) {
                      context.go('/list');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("NOT a successful signin")));
                    }
                  } else {
                    print('The Form is NOT Valid');
                  }
                },
                child: Text("sign in"),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an account? '),
                  InkWell(
                    onTap: () {
                      context.replace('/signup');
                    },
                    child: Text(
                      'Sign up',
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
