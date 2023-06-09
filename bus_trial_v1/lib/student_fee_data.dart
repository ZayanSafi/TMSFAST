import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'firebase_options.dart';
import 'main.dart';

class Page3Screen extends StatefulWidget {
  const Page3Screen({super.key});

  @override
  State<Page3Screen> createState() => _Page3ScreenState();
}

class _Page3ScreenState extends State<Page3Screen> {
  FirebaseDatabase database = FirebaseDatabase.instance;
  late Object? a ;
  var array = [];
  var filteredArray = [];
  var searchTerm = '';

  loaddata() async{
     final ref = FirebaseDatabase.instance.ref();
    print("before");
    final snapshot = await ref.child('Students:/').get();
    print("hi");
    if (snapshot.exists) {
        a = snapshot.value;
        List all = List.from(a as List);

        for (var i = 0; i < all.length; i++) {
          try {
            Map<String, dynamic> _post = Map<String, dynamic>.from(all[i] as Map);
            array.add(_post);
          } catch (e) {
            print('null error');
          }

        }

        filteredArray=array;
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

  void filterData(String term, List<dynamic> arr) {
      setState(() {
        searchTerm = term;
        filteredArray = arr.where((student) {
          return student['Roll'].toLowerCase().contains(searchTerm.toLowerCase());
        }).toList();
      });
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
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value) {
                        filterData(value,array);
                      },
                      decoration: const InputDecoration(
                        hintText: "Search by Roll Number",
                        prefixIcon: Icon(Icons.search)
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredArray.length,
                      itemBuilder: (BuildContext context, int index) {
                        return (
                          Container(
                            child: Row(
                              children: [
                                Text("$index-"),
                                Text('\t\t\tName:\t' + filteredArray[index]['Name'],style:TextStyle(color:filteredArray[index]['Status']=="Paid"?Colors.green:Colors.red)),
                                Text('\t\t\tRoll#:\t' + filteredArray[index]['Roll'],style:TextStyle(color:filteredArray[index]['Status']=="Paid"?Colors.green:Colors.red)),
                                Text('\t\t\tPhone:\t' + filteredArray[index]['Phone'],style:TextStyle(color:filteredArray[index]['Status']=="Paid"?Colors.green:Colors.red)),
                              ],
                            ),
                          )
                        );
                      }),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => context.go('/page4'),
              child: const Text('Unpaid Fee Tab')
            ),
          ],
        ),
      ),
    );
  }

}


//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//     appBar: AppBar(title: const Text(App.title)),
//     body: Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children:  <Widget>[
//           Container(
//             height: 400,
//             width: size.width,
//             child:ListView.builder(
//           itemCount: array.length,
//           itemBuilder: (BuildContext context, int index) {
//             return (
//               Container(
//                 child: Row(
//                   children: [
//                     Text(index.toString()+"-"),
//                     Text('\t\t\tName:\t' + array[index]['Name'],style:TextStyle(color:array[index]['Status']=="Paid"?Colors.green:Colors.red)),
//                     Text('\t\t\tRoll#:\t' + array[index]['Roll'],style:TextStyle(color:array[index]['Status']=="Paid"?Colors.green:Colors.red)),
//                     Text('\t\t\tPhone:\t' + array[index]['Phone'],style:TextStyle(color:array[index]['Status']=="Paid"?Colors.green:Colors.red)),
//                   ],
//                 ),
//               )
//             );
//           }),
//     ),
//           ElevatedButton(
//               onPressed: () => context.go('/page4'),
//               child: const Text('Unpaid Fee Tab'))
//         ],
//       ),
//     ),
//   );
//   }
// }
