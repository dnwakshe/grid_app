import 'package:flutter/material.dart';
import 'package:mobi_task/get_grid_count.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowGrid extends StatefulWidget {
  final int count;
  const ShowGrid(this.count, {Key? key}) : super(key: key);

  @override
  _ShowGridState createState() => _ShowGridState();
}

Iterable<int> range(int low, int high) sync* {
  for (int i = low; i < high; ++i) {
    yield i;
  }
}

class _ShowGridState extends State<ShowGrid> {
  Widget appBarTitle = const Text(
    "My Grid",
    style: TextStyle(color: Colors.white),
  );
  Icon actionIcon = const Icon(
    Icons.search,
    color: Colors.white,
  );
  List<Choice> gridList = [];
  // List<String> grindList =[];
  final key = GlobalKey<ScaffoldState>();
  late String _searchQuery;
  late bool _IsSearching;
  List<Choice> _list = [];
  List<Choice> _searchList = [];
  String _searchText = "";
  late SharedPreferences prefe;

  @override
  void initState() {
    super.initState();
    getStoredPref();
    _IsSearching = false;
    init_List();
  }

  getStoredPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  }

  void init_List() {
    for (int i in range(0, widget.count)) {
      _list.add(Choice(id: i, title: ""));
    }
    print(_list);
    _searchList = _list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: key,
        appBar: buildBar(context),
        body: GridView.builder(
            itemCount: _searchList.length,
            itemBuilder: (context, index) {
              return Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        hintText: "Enter alphabets ",
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      onChanged: (value) {
                        if (gridList[index] == index &&gridList[index].title == "") {
                          gridList.add(Choice(id: index, title: value));
                        }
                      },
                    ),
                  ],
                ),
              );
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
            )));
  }

  buildBar(BuildContext context) {
    return AppBar(
        centerTitle: true,
        title: appBarTitle,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: <Widget>[
          IconButton(
            icon: actionIcon,
            onPressed: () {
              setState(() {
                if (actionIcon.icon == Icons.search) {
                  actionIcon = const Icon(
                    Icons.close,
                    color: Colors.white,
                  );
                  appBarTitle = TextField(
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    onSubmitted: (value) {
                      var searchText = value;
                      print(searchText);
                    },
                    decoration: const InputDecoration(
                        hintText: "Search here..",
                        hintStyle: TextStyle(color: Colors.white)),
                  );
                  _handleSearchStart();
                } else {
                  _handleSearchEnd();
                }
              });
            },
          ),
          IconButton(
            onPressed: () {
              print("restoted presed");
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Grid()));
            },
            icon: const Icon(Icons.restore_outlined),
          ),
        ]);
  }

  void _handleSearchStart() {
    setState(() {
      _IsSearching = true;
      print(_searchText);
    });
  }

  void _handleSearchEnd() {
    setState(() {
      _IsSearching = false;
      _searchQuery = "";
    });
  }

  List<Choice> _buildSearchList() {
    if (_searchText.isEmpty) {
      return _searchList =
          _list; //_list.map((contact) =>  Uiitem(contact)).toList();
    } else {
      /*for (int i = 0; i < _list.length; i++) {
        String name = _list.elementAt(i);
        if (name.toLowerCase().contains(_searchText.toLowerCase())) {
          _searchList.add(name);
        }
      }*/

      _searchList = _list
          .where((element) =>
              element.title.toLowerCase().contains(_searchText.toLowerCase()))
          .toList();
      print('${_searchList.length}');
      return _searchList; //_searchList.map((contact) =>  Uiitem(contact)).toList();
    }
  }

  // Widget gridView() {
  //   return Card(
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: [
  //         TextField(
  //           decoration: const InputDecoration(
  //             contentPadding: EdgeInsets.all(10.0),
  //             enabledBorder: UnderlineInputBorder(
  //               borderSide: BorderSide(color: Colors.grey),
  //             ),
  //             hintText: "Enter alphabets ",
  //             hintStyle: TextStyle(color: Colors.grey),
  //           ),
  //           onChanged: (value) {
  //             print(value);
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }
}

class Choice {
  const Choice({
    required this.id,
    required this.title,
  });
  final String title;
  final int id;
}
