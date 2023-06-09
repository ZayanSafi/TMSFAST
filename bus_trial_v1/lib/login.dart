import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'main.dart';


/// The screen of the first page.
class Page1Screen extends StatelessWidget {
  /// Creates a [Page1Screen].
  const Page1Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text(App.title)),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () => context.go('/page7'),
            child: const Text('Login as Administrator'),
          ),
          const SizedBox(height: 10,),
          ElevatedButton(
            onPressed: () => context.go('/page8'), //page8 change
            child: const Text('Login as Student'),
          ),
        ],
      ),
    ),
  );
}