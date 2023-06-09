import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';


class G9Screen extends StatefulWidget {
  const G9Screen({Key? key}) : super(key: key);

  @override
  _G9ScreenState createState() => _G9ScreenState();
}

class _G9ScreenState extends State<G9Screen> {
  late DatabaseReference _databaseReference;
  int? firebaseVariable;
  int availableSeats = 40;

  @override
  void initState() {
    super.initState();
    _databaseReference =
        FirebaseDatabase.instance.reference().child('/Drivers/Ali/Number Of Students Entered');
    _databaseReference.onValue.listen((DatabaseEvent databaseEvent) {
      setState(() {
        firebaseVariable = databaseEvent.snapshot.value as int?;
      });
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text(App.title)),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Number of seats available: ${availableSeats - (firebaseVariable ?? 0)}',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => context.go('/page9'),
                child: const Text('View on maps'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => context.go('/'),
                child: const Text('Go back to home page'),
              ),
            ],
          ),
        ),
      );
}




// /// The screen of the sixth page.
// class G9Screen extends StatelessWidget {
//   /// Creates a [Page6Screen].
//   const G9Screen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) => Scaffold(
//     appBar: AppBar(title: const Text(App.title)),
//     body: Center(
//       child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children:  <Widget>[
//         ElevatedButton(
//             onPressed: () => context.go('/page9'),
//             child: const Text('View on maps'),
//           ),
//           const SizedBox(height: 10,),
//         ElevatedButton(
//         onPressed: () => context.go('/'),
//         child: const Text('Go back to home page')),
//       ],
//     ),
//   ),
//   );
// }