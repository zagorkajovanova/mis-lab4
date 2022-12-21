import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:lab_mis/screens/signin_screen.dart';

import '../model/termin.dart';
import '../widgets/createNewElement.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget{
  static const String idScreen = "mainScreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen>{
  final List<Termin> _termini = [
    Termin(
        id: "1",
        ime: "Mobile information systems",
        datum: "15.01.2023",
        vreme: "10:00h"),
    Termin(
        id: "2",
        ime: "Management information systems",
        datum: "25.01.2023",
        vreme: "15:30h"),
    Termin(
        id: "3",
        ime: "Design of human-computer interaction",
        datum: "16.01.2023",
        vreme: "8:00h")
  ];

  void _showModal(BuildContext ctx){
    showModalBottomSheet(
      context: ctx, 
      builder: (_){
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: createNewElement(_addNewTermin),
        );
      }
    );
  }

  void _addNewTermin(Termin termin){
    setState(() {
      _termini.add(termin);
    });
  }

  void _deleteTermin(String id){
    setState(() {
      _termini.removeWhere((termin) => termin.id == id);
    });
  }

  Future _signOut() async{
    try {
      await FirebaseAuth.instance.signOut().then((value) {
        print("User signed out");
        Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen()));
      });
    } on FirebaseAuthException catch (e){
        print("ERROR HERE");
        print(e.message);
    }
  }


  PreferredSizeWidget _createAppBar(BuildContext context){
    //final user = FirebaseAuth.instance.currentUser?.email;
    return AppBar(
        title: Text("Upcoming exams"),
        actions:[
          IconButton(
            icon: Icon(Icons.add_box_outlined),
            onPressed: () => _showModal(context)),
          ElevatedButton(
            child: Text("Sign out"),
            onPressed: _signOut,
          )
        ],
      );
  }

  Widget _createBody(BuildContext context){
    return Center(
          child: _termini.isEmpty
              ? Text("No exams scheduled")
              : ListView.builder(
                  itemCount: _termini.length,
                  itemBuilder: (ctx, index) {
                    return Card(
                      elevation: 2,
                      margin: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                      child: ListTile(
                        tileColor: Colors.green[100],
                        title: Text(
                          _termini[index].ime,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          _termini[index].datum + " | " + _termini[index].vreme,
                          style: TextStyle(color: Colors.grey),
                        ),
                        trailing: IconButton(
                          onPressed: () => _deleteTermin(_termini[index].id),
                          icon: Icon(Icons.delete_outline)),
                      ),
                    );
                  },
                ),
              );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _createAppBar(context),
      body: _createBody(context),
    );
  }
}