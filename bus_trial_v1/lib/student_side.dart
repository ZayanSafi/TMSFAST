import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'main.dart';

/// The screen of the sixth page.
class Page6Screen extends StatelessWidget {
  /// Creates a [Page6Screen].
  const Page6Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text(App.title)),
    body: Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  <Widget>[
        ElevatedButton(
            onPressed: () => context.go('/page10'),
            child: const Text('G-9'),
          ),
          const SizedBox(height: 10,),
        ElevatedButton(
        onPressed: () => context.go('/'),
        child: const Text('Go back to home page')),
      ],
    ),
  ),
  );
}