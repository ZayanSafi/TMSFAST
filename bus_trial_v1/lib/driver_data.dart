import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'firebase_options.dart';
import 'main.dart';


class Page2Screen extends StatefulWidget {
  const Page2Screen({super.key});

  @override
  State<Page2Screen> createState() => _Page2ScreenState();
}

class _Page2ScreenState extends State<Page2Screen> {
  FirebaseDatabase database = FirebaseDatabase.instance;
  late Object? a ;
  var array = [];
 
  loaddata() async{
     final ref = FirebaseDatabase.instance.ref();
    print("before");
    final snapshot = await ref.child('Driver/').get();
    print("hi");
    if (snapshot.exists) {
        a = snapshot.value;
        List all = List.from(a as List);
        for (var i = 0; i < all.length; i++) {
          try {
            Map<String, dynamic> _post = Map<String, dynamic>.from(all[i] as Map);
            if(_post['Active']=='Yes' || _post['Active']=='yes')
            {
                array.add(_post);
            }
            
            
          } catch (e) {
            print('null error');
          }
          
        }
        

        setState(() {
          
        });
    } else {
        print('No data available.');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loaddata();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
    appBar: AppBar(title: const Text(App.title)),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  <Widget>[
          Container(
            height: 400,
            width: size.width,
            child:ListView.builder(
          itemCount: array.length,
          itemBuilder: (BuildContext context, int index) {
            return (
              Container(
                child: Row(
                  children: [
                    Text(index.toString()+"-"),
                    Text('\t\t\tName:\t' + array[index]['Name'],style:TextStyle(color:array[index]['Active']=="Yes"?Colors.green:Colors.red)),
                    Text('\t\t\tBus#:\t' + array[index]['Bus'],style:TextStyle(color:array[index]['Active']=="Yes"?Colors.green:Colors.red)),
                    Text('\t\t\tPhone:\t' + array[index]['Phone'],style:TextStyle(color:array[index]['Active']=="Yes"?Colors.green:Colors.red)),
                    Text('\t\t\tRoute:\t' + array[index]['Route'],style:TextStyle(color:array[index]['Active']=="Yes"?Colors.green:Colors.red)),
                  ],
                ),
              )
            );
          }),
    ),
          ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Home'))
        ],
      ),
    ),
  );
  }
}






// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'main.dart';

// /// The screen of the second page.
// class Page2Screen extends StatelessWidget {
//   /// Creates a [Page2Screen].
//   const Page2Screen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) => Scaffold(
//     appBar: AppBar(title: const Text(App.title)),
//     body: Center(
//       child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children:  <Widget>[
//         Text('Data to be added', textScaleFactor: 2,),
//         ElevatedButton(
//         onPressed: () => context.go('/'),
//         child: const Text('Go back to home page')),
//       ],
//     ),
//   ),
//   );
// }