import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'firebase_options.dart';
import 'main.dart';


class Page4Screen extends StatefulWidget {
  const Page4Screen({super.key});

  @override
  State<Page4Screen> createState() => _Page4ScreenState();
}

class _Page4ScreenState extends State<Page4Screen> {
  FirebaseDatabase database = FirebaseDatabase.instance;
  late Object? a ;
  var array = [];
 
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
            if(_post['Status']=='Not Paid' || _post['Status']=='Not paid' || _post['Status']=='not Paid' || _post['Status']=='not paid')
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
                    Text('\t\t\tName:\t' + array[index]['Name'],style:TextStyle(color:array[index]['Status']=="Paid"?Colors.green:Colors.red)),
                    Text('\t\t\tRoll#:\t' + array[index]['Roll'],style:TextStyle(color:array[index]['Status']=="Paid"?Colors.green:Colors.red)),
                    Text('\t\t\tPhone:\t' + array[index]['Phone'],style:TextStyle(color:array[index]['Status']=="Paid"?Colors.green:Colors.red)),
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