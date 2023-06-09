import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'firebase_options.dart';
import 'admin_side.dart';



class Page7Screen extends StatefulWidget {
  @override
  _Page7ScreenState createState() => _Page7ScreenState();
}

class _Page7ScreenState extends State<Page7Screen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  FirebaseDatabase database = FirebaseDatabase.instance;
  late Object? a ;
  var array = [];



loaddata() async {
  final ref = FirebaseDatabase.instance.ref();
  print("before");
  final snapshot = await ref.child('AdminLogin/').get();
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
              decoration: InputDecoration(labelText: 'CNIC'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your 13-digit CNIC number (without dashes or spaces)';
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
                        (map) => map['CNIC'].toString() == email && map['Password'] == password);
                    print('match: $match');
                    if (match) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Page5Screen()),
                      );
                    } else {
                      print('Invalid cnic or password');
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

  // loaddata() async{
  //    final ref = FirebaseDatabase.instance.ref();
  //   print("before");
  //   final snapshot = await ref.child('AdminLogin/').get();
  //   print("hi");
  //   if (snapshot.exists) {
  //       a = snapshot.value;
  //       List all = List.from(a as List);

  //       for (var i = 0; i < all.length; i++) {
  //         try {
  //           Map<String, dynamic> _post = Map<String, dynamic>.from(all[i] as Map);
  //           array.add(_post);
  //         } catch (e) {
  //           print('null error');
  //         }

  //       }
  //       setState(() {

  //       });
  //   } else {
  //       print('No data available.');
  //   }
  // }


  //  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   loaddata();
  // }




  // @override
  // Widget build(BuildContext context) => Scaffold(
  //   appBar: AppBar(title: const Text(App.title)),
  //   body: Form(
  //       key: _formKey,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           TextFormField(
  //             controller: _emailController,
  //             decoration: InputDecoration(labelText: 'Email'),
  //             validator: (value) {
  //               if (value!.isEmpty) {
  //                 return 'Please enter your email';
  //               }
  //               return null;
  //             },
  //           ),
  //           TextFormField(
  //             controller: _passwordController,
  //             obscureText: true,
  //             decoration: InputDecoration(labelText: 'Password'),
  //             validator: (value) {
  //               if (value!.isEmpty) {
  //                 return 'Please enter your password';
  //               }
  //               return null;
  //             },
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.symmetric(vertical: 16.0),
  //             child: ElevatedButton(
  //               onPressed: () {
  //                 if (_formKey.currentState!.validate()) {
  //                   // TODO: implement login functionality
  //                   final email = _emailController.text.trim();
  //                   final password = _passwordController.text.trim();
  //                   final match = array.any((map) => map['CNIC'] == email && map['Password'] == password);
  //                   print(email);
  //                   print(password);
  //                   print(match);
  //                   if (match) {
  //                     // If there is a match, navigate to Page5Screen
  //                     Navigator.push(
  //                       context,
  //                       MaterialPageRoute(builder: (context) => Page5Screen()),
  //                     );
  //                   } else {
  //                     // If there is no match, show an error message
  //                     print('Invalid email or password');
  //                   }
  //                   // if (_emailController.text == "user@example.com" &&
  //                   //     _passwordController.text == "password") {
  //                   //       print("Hi 2");
  //                   //       print(array);
  //                   //   Navigator.push(
  //                   //     context,
  //                   //     MaterialPageRoute(builder: (context) => Page5Screen()),
  //                   //   );
  //                   // }
  //                 }
  //               },
  //               child: Text('Login'),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }





// /// The screen of the seventh page.
// class Page7Screen extends StatelessWidget {
//   /// Creates a [Page7Screen].
//   const Page7Screen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) => Scaffold(
//     appBar: AppBar(title: const Text(App.title)),
//     body: Center(
//       child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children:  <Widget>[
//         Text('admin login page', textScaleFactor: 2,),
//         ElevatedButton(
//             onPressed: () => context.go('/page5'),
//             child: const Text('Temp admin page route'),
//           ),
//         ElevatedButton(
//         onPressed: () => context.go('/'),
//         child: const Text('Go back to home page')),
//       ],
//     ),
//   ),
//   );
// }
