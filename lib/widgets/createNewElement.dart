import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab_mis/model/termin.dart';
import 'package:nanoid/nanoid.dart';

class createNewElement extends StatefulWidget {

  final Function addTermin;
  createNewElement(this.addTermin);

  @override
  State<StatefulWidget> createState() => _NewElementState();
}

class _NewElementState extends State<createNewElement>{

  final _imePredmetController = TextEditingController();
  final _datumController = TextEditingController();
  final _vremeController = TextEditingController();

  void _submitData(){
    if(_imePredmetController.text.isEmpty || _datumController.text.isEmpty || _vremeController.text.isEmpty){
      return ;
    }

    final newTermin = Termin(
        id: nanoid(5), 
        ime: _imePredmetController.text, 
        datum: _datumController.text, 
        vreme: _vremeController.text,
      );
      widget.addTermin(newTermin);
      Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(labelText: "Subject name"),
            controller: _imePredmetController,
            onSubmitted: (_) => _submitData(),
          ),
          TextField(
            decoration: InputDecoration(labelText: "Date"),
            controller: _datumController,
            onSubmitted: (_) => _submitData(),
          ),
          TextField(
            decoration: InputDecoration(labelText: "Time"),
            controller: _vremeController,
            onSubmitted: (_) => _submitData(),
          ),
        ],
      )
    );
  }
}