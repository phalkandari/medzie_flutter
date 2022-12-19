import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medzie_flutter/pages/prescription_list.dart';
import 'package:medzie_flutter/pages/signin.dart';
import 'package:medzie_flutter/pages/signup.dart';
import 'package:provider/provider.dart';
import 'providers/signing_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var signingProvider = SigningProvider();

  var isAuthenticated = await signingProvider.hasToken();

  runApp(Medzie(
    signingProvider: signingProvider,
    initialRoute: isAuthenticated ? '/list' : '/signup',
  ));
}

class Medzie extends StatelessWidget {
  final String initialRoute;
  final SigningProvider signingProvider;

  Medzie({required this.signingProvider, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      initialLocation: initialRoute,
      routes: [
        GoRoute(
          path: '/list',
          builder: (context, state) => PrescriptionList(),
        ),
        GoRoute(
          path: '/signup',
          builder: (context, state) => SignUp(),
        ),
        GoRoute(
          path: '/signin',
          builder: (context, state) => SignIn(),
        ),
      ],
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SigningProvider()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Medzie',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme:
                GoogleFonts.openSansTextTheme(Theme.of(context).textTheme)),
        routerConfig: router,
      ),
    );
  }
}
