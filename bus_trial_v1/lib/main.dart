import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_strategy/url_strategy.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'firebase_options.dart';

import 'admin_side.dart';
import 'driver_data.dart';
import 'student_fee_data.dart';
import 'unpaid_students.dart';
import 'login.dart';
import 'student_side.dart';
import 'student_login.dart';
import 'admin_login.dart';
import 'route_1.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'g_9.dart';

// await Firebase.initializeApp(
//   options: DefaultFirebaseOptions.currentPlatform,
// );
  Future<void> _messageHandler(RemoteMessage message) async {
    print('background message ${message.notification!.body}');
  }

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  setPathUrlStrategy();
  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  return runApp(App());
}

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  static const String title = 'TMS FAST';

  // @override
  // Widget build(BuildContext context) => MaterialApp.router(
  //   routerDelegate: _router.routerDelegate,
  //   routeInformationParser: _router.routeInformationParser,
  //   routeInformationProvider: _router.routeInformationProvider,

  // );
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 184, 203, 213),
      ),
      // builder: (context, child) {
      //   return Container(
      //     decoration: BoxDecoration(
      //       image: DecorationImage(
      //         image: AssetImage('C:\Games\bgimage.jpg'), // Replace with your image path
      //         fit: BoxFit.cover,
      //       ),
      //     ),
      //     child: child,
      //   );
      // },
    );
  }

  final GoRouter _router = GoRouter(
    errorBuilder: (context, state) => ErrorScreen(error:state.error),
    routes: <GoRoute>[
      GoRoute(

        routes: <GoRoute>[
          GoRoute(
            path: 'page2',
            builder: (BuildContext context, GoRouterState state) =>
            const Page2Screen(),
          ),
          GoRoute(
            path: 'page3',
            builder: (BuildContext context, GoRouterState state) =>
            const Page3Screen(),

          ),
          GoRoute(
            path: 'page4',
            builder: (BuildContext context, GoRouterState state) =>
            const Page4Screen(),

          ),
          GoRoute(
            path: 'page5',
            builder: (BuildContext context, GoRouterState state) =>
            const Page5Screen(),

          ),
           GoRoute(
            path: 'page6',
            builder: (BuildContext context, GoRouterState state) =>
            const Page6Screen(),

          ),GoRoute(
            path: 'page7',
            builder: (BuildContext context, GoRouterState state) =>
            Page7Screen(),

          ),GoRoute(
            path: 'page8',
            builder: (BuildContext context, GoRouterState state) =>
            Page8Screen(),

          ),
          GoRoute(
            path: 'page9',
            builder: (BuildContext context, GoRouterState state) =>
            MapScreen(),

          ),
          GoRoute(
            path: 'page10',
            builder: (BuildContext context, GoRouterState state) =>
            G9Screen(),

          ),
        ],
        path: '/',
          builder: (BuildContext context, GoRouterState state) =>
          const Page1Screen(),
          //const MapScreen(),
      ),
    ],

  );
}

class ErrorScreen extends StatelessWidget {
  final Exception? error;
  const ErrorScreen( {Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Error"),

      ),
      body: Center(
        child: Text(
            error.toString()
        ),
      ),
    );
  }
}