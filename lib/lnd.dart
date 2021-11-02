import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart' as rootBundle;
import 'dart:convert';

class Lindi extends StatefulWidget {
  const Lindi({Key? key}) : super(key: key);

  @override
  _LindiState createState() => _LindiState();
}

class _LindiState extends State<Lindi> {
  Future<List<Fruits>> ReadJsonData() async {
    // print("reached");

    final jsondata =
        await rootBundle.rootBundle.loadString('jsonfile/fruits.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => Fruits.fromJson(e)).toList();

    // var jsonData = json.decode('''[
    // {
    //   "index": 0,
    //   "name": "Apple",
    //   "about": "Apple is red in color",
    //   "picture": "https://images.pexels.com/photos/102104/pexels-photo-102104.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500"
    // },
    //   {
    //   "index": 1,
    //   "name": "Apple 1",
    //   "about": "mast",
    //   "picture": "https://images.pexels.com/photos/102104/pexels-photo-102104.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500"
    // },
    // {
    //     "index": 2,
    //     "name": "Apple 2",
    //     "about": "mast",
    //     "picture": "https://images.pexels.com/photos/102104/pexels-photo-102104.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500"
    //   },
    //     {
    //     "index": 3,
    //     "name": "Apple 3",
    //     "about": "mast",
    //     "picture": "https://images.pexels.com/photos/102104/pexels-photo-102104.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500"
    //   },
    //   {
    //     "index": 4,
    //     "name": "Apple 4",
    //     "about": "mast",
    //     "picture": "https://images.pexels.com/photos/102104/pexels-photo-102104.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500"
    //   },
    //     {
    //     "index": 5,
    //     "name": "Apple 5",
    //     "about": "mast",
    //     "picture": "https://images.pexels.com/photos/102104/pexels-photo-102104.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500"
    //   } ]''');
    // List<Fruits> fruits = [];
    // for (var u in jsonData) {
    //   Fruits fruit = Fruits(u["index"], u["name"], u["about"], u["picture"]);
    //   fruits.add(fruit);
    // }
    // print(fruits.length);

    // return fruits;
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Container(
            height: 0.9 * screenHeight,
            width: screenWidth,
            child: FutureBuilder(
                future: ReadJsonData(),
                builder: (context, data) {
                  if (data == null) {
                    return Container(
                      child: const Center(
                          child: Text(
                        "Loading....",
                      )),
                    );
                  } else if (data.hasData) {
                    var items = data.data as List<Fruits>;
                    return ListView.builder(
                      itemCount: items.length,
                      //itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 0.9 * screenHeight,
                          width: 0.9 * screenWidth,
                          child: Card(
                              elevation: 50,
                              shadowColor: Colors.blue,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                      height: 0.4 * screenHeight,
                                      width: 0.4 * screenHeight,
                                      child: Image(
                                        image: NetworkImage(
                                            items[index].picture.toString()),
                                      )),
                                  Container(
                                    child: Center(
                                      child: Text(items[index].name.toString(),
                                          style: TextStyle(
                                              fontSize: 0.1 * screenWidth,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    height: 0.24 * screenHeight,
                                    width: 0.24 * screenHeight,
                                  ),
                                  // Container(
                                  //   child: Text(snapshot.data[index].about,
                                  //       style: TextStyle(
                                  //           fontSize: 0.06 * screenWidth,
                                  //           decorationStyle:
                                  //               TextDecorationStyle.wavy)),
                                  //   height: 0.12 * screenHeight,
                                  //   width: 0.24 * screenHeight,
                                  // ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                          height: 0.2 * screenHeight,
                                          width: 0.48 * screenWidth,
                                          child: InkWell(
                                            child: Icon(Icons.thumb_down,
                                                color: Colors.red,
                                                size: 0.06 * screenHeight),
                                            key: UniqueKey(),
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    Future.delayed(
                                                        const Duration(
                                                            seconds: 3), () {
                                                      Navigator.of(context)
                                                          .pop(true);
                                                    });
                                                    return const AlertDialog(
                                                      title: Text(
                                                          "You dont like it"),
                                                    );
                                                  });
                                              setState(() {
                                                items.removeAt(index);
                                              });
                                            },
                                          )),
                                      Container(
                                          height: 0.2 * screenHeight,
                                          width: 0.48 * screenWidth,
                                          child: InkWell(
                                            child: Icon(Icons.thumb_up,
                                                color: Colors.green,
                                                size: 0.06 * screenHeight),
                                            key: UniqueKey(),
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    Future.delayed(
                                                        const Duration(
                                                            seconds: 3), () {
                                                      Navigator.of(context)
                                                          .pop(true);
                                                    });
                                                    return const AlertDialog(
                                                      title:
                                                          Text("You like it"),
                                                    );
                                                  });
                                              setState(() {
                                                items.removeAt(index);
                                              });
                                            },
                                          ))
                                    ],
                                  )
                                ],
                              )),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text("Data is Loading"),
                    );
                  }
                })));
  }
}

class Fruits {
  int? index;
  String? name;
  String? about;
  String? picture;

  Fruits({this.index, this.name, this.about, this.picture});

  Fruits.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    name = json['name'];
    about = json['about'];
    picture = json['picture'];
  }
}
