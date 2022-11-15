import 'package:flutter/material.dart';
import 'package:mobi_task/show_grid.dart';

class Grid extends StatefulWidget {
  const Grid({Key? key}) : super(key: key);

  @override
  _GridState createState() => _GridState();
}

class _GridState extends State<Grid> {
  TextEditingController row_Controller = TextEditingController();
  TextEditingController col_Controller = TextEditingController();
  int numGrid = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            "Mobigic",
            style: TextStyle(color: Colors.black),
          )),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
          TextField(
            controller: row_Controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                filled: true,
                hintStyle: TextStyle(color: Colors.grey[800]),
                hintText: "Enter number of Rows",
                fillColor: Colors.white70),
          ),
          TextField(
            controller: col_Controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                filled: true,
                hintStyle: TextStyle(color: Colors.grey[800]),
                hintText: "Enter number of Columns",
                fillColor: Colors.white70),
          ),
          ElevatedButton(
            onPressed: () {
              if (row_Controller.text.isNotEmpty &&
                  col_Controller.text.isNotEmpty) {
                int rows = int.parse(row_Controller.text);
                int cols = int.parse(col_Controller.text);
                numGrid = rows * cols;
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ShowGrid(numGrid)));
                    
              } else {
                // ignore: void_checks
                return showAlertDialog(context);
              }
              setState(() {});
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // <-- Radius
              ),
            ),
            child: const Text('Create Grid'),
          ),
          Text(
            "Numbe of box are $numGrid",
            style: TextStyle(fontSize: 12),
          ),
        ]),
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text("Alert"),
    content: Text("Please Enter value in textfield."),
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
