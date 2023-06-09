import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'main.dart';


/// The screen of the fifth page.
class Page5Screen extends StatelessWidget {
  /// Creates a [Page5Screen].
  const Page5Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text(App.title)),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () => context.go('/page2'),
            child: const Text('Drivers Data'),
          ),
          const SizedBox(height: 10,),
          ElevatedButton(
            onPressed: () => context.go('/page3'),
            child: const Text('Students Data'),
          ),
        ],
      ),
    ),
  );
}