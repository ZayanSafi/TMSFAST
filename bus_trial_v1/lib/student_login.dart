import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'firebase_options.dart';
import 'admin_side.dart';
import 'student_side.dart';


/// The screen of the eighth page.
class Page8Screen extends StatefulWidget {
  @override
  _Page8ScreenState createState() => _Page8ScreenState();
}

class _Page8ScreenState extends State<Page8Screen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  FirebaseDatabase database = FirebaseDatabase.instance;
  late Object? a ;
  var array = [];



loaddata() async {
  final ref = FirebaseDatabase.instance.ref();
  print("before");
  final snapshot = await ref.child('StudentLogin/').get();
  print("hi");
  if (snapshot.exists) {
    a = snapshot.value;
    List all = List.from(a as List);

    for (var i = 0; i < all.length; i++) {
      try {
        Map<String, dynamic> _post =
            Map<String, dynamic>.from(all[i] as Map);
        array.add(_post);
      } catch (e) {
        print('null error');
      }
    }
    setState(() {});
    print('array: $array');
  } else {
    print('No data available.');
  }
}

@override
void initState() {
  super.initState();
  loaddata();
}

@override
Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text(App.title)),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Roll Number'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your Roll Number (e.g i201234)';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final email = _emailController.text.trim();
                    final password = _passwordController.text.trim();
                    print('email: $email');
                    print('password: $password');
                    final match = array.any(
                        (map) => map['Roll No'].toString() == email && map['Password'] == password);
                    print('match: $match');
                    if (match) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Page6Screen()),
                      );
                    } else {
                      print('Invalid roll number or password');
                    }
                  }
                },
                child: Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
}