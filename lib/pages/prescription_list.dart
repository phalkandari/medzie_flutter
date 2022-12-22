import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medzie_flutter/providers/signing_provider.dart';
import 'package:provider/provider.dart';

class PrescriptionList extends StatelessWidget {
  const PrescriptionList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Prescription List"),
      ),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text("Welcome to Medzie"),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: const Text("Signin"),
            trailing: const Icon(Icons.login),
            onTap: () {
              GoRouter.of(context).push('/signin');
            },
          ),
          ListTile(
            title: const Text("Signup"),
            trailing: const Icon(Icons.how_to_reg),
            onTap: () {
              GoRouter.of(context).push('/signup');
            },
          ),
          ListTile(
            title: const Text("Logout"),
            trailing: const Icon(Icons.logout),
            onTap: () {
              context.read<SigningProvider>().logout();
              GoRouter.of(context).go('/signin');
            },
          ),
        ],
      )),
      body: Column(children: [ListTile()]),
    );
  }
}
