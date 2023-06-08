import 'package:flutter/material.dart';
import 'ITEM_MODEL.dart';
import 'data_store.dart';
import 'inf.dart';

class HomeScreen extends StatelessWidget {
  final List<String> buttonTitles = ['Detail 1', 'Detail 2', 'Detail 3'];

  @override
  Widget build(BuildContext context) {
    DataStore.initData();
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: buttonTitles.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: ElevatedButton(
                child: Text(buttonTitles[index]),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/detail${index + 1}',
                    arguments: index + 1, // Pass the index as an argument
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class Detail1 extends StatelessWidget {
  List<ItemModel> itemModels = [];

  @override
  Widget build(BuildContext context) {
    itemModels = DataStore.getData();
    return Scaffold(
      appBar: AppBar(
        title: Text('GridView'),
      ),
      body: ListView.builder(
        itemCount: itemModels.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(itemModels[index].name),
          );
        },
      ),
    );
  }
}

class Detail2 extends StatefulWidget {
  const Detail2({super.key});

  @override
  State<Detail2> createState() => _Detail2();
}

class _Detail2 extends State<Detail2> {
  String selected = "";
  List checkListItems = [
    {
      "id": 0,
      "value": false,
      "title": "Nam",
    },
    {
      "id": 1,
      "value": false,
      "title": "Nữ",
    },
  ];
  TextEditingController t = TextEditingController();
  TextEditingController ns = TextEditingController();
  @override
  void dispose() {
    t.dispose();
    ns.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thông tin')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextField(
            controller: t,
            decoration: InputDecoration(
              // labelText: 't',
              label: Text.rich(
                TextSpan(
                  children: <InlineSpan>[
                    WidgetSpan(
                      child: Text(
                        'Tên',
                      ),
                    ),
                    WidgetSpan(
                      child: Text(
                        '*',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          TextField(
            controller: ns,
            // obscureText: true,
            decoration: InputDecoration(
              label: Text.rich(
                TextSpan(
                  children: <InlineSpan>[
                    WidgetSpan(
                      child: Text(
                        'Năm Sinh',
                      ),
                    ),
                    WidgetSpan(
                      child: Text(
                        '*',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
          Row(
            children: List.generate(
              checkListItems.length,
                  (index) => Expanded(child: CheckboxListTile(
                dense: true,
                title: Text(
                  checkListItems[index]["title"],
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
                value: checkListItems[index]["value"],
                onChanged: (value) {
                  setState(
                        () {
                      for (var element in checkListItems) {
                        element["value"] = false;
                      }
                      checkListItems[index]["value"] = value;
                      inf.id = checkListItems[index]['id'];
                      selected =
                      "${checkListItems[index]["id"]}, ${checkListItems[index]["title"]}, ${checkListItems[index]["value"]}";
                    },
                  );
                },
              ),
              ),
            ),
          ),
          ElevatedButton(onPressed: (){
            setState(() {
              ns.text = inf.ns;
            });
          },
            child: Text('Hien thi'),)
        ],
      ),
      bottomNavigationBar: Container(
        // alignment: Alignment.bottomCenter,
        child: ElevatedButton(
          // style: Alignment.bottomRight.,
          child: Text("Lưu"),
          onPressed: () {
            setState(() {
                inf.t = t.text;
                inf.ns = ns.text;
                inf.ns = ns.text;
                Navigator.pop(context);
            });
          },
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => HomeScreen(),
      '/detail1': (context) => Detail1(),
      '/detail2': (context) => Detail2(),
      '/detail3': (context) => Detail3(),
    },
  ));
}

class Detail3 extends StatefulWidget {
  const Detail3({super.key});

  @override
  State<Detail3> createState() => _Detail3();
}

class _Detail3 extends State<Detail3> {
  String selected = "";
  List checkListItems = [
    {
      "id": 0,
      "value": false,
      "title": "0",
    },
    {
      "id": 1,
      "value": false,
      "title": "1",
    },
    {
      "id": 2,
      "value": false,
      "title": "2",
    },
  ];
  List<bool> _data = [false, false, false];

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [];
    Widget cb;
    for (int i = 0; i < checkListItems.length; i++) {
      cb = Checkbox(
        value: _data[i],
        onChanged: (bool? value) {
          setState(() {
            _data[i] = value!;
          });
        },
      );
      list.add(cb);
    }
    ;
    return Scaffold(
      appBar: AppBar(title: const Text('CheckboxListTile Sample')),
      body: Row(
            children: List.generate(
              checkListItems.length,
              (index) => Expanded(child: CheckboxListTile(
                dense: true,
                title: Text(
                  checkListItems[index]["title"],
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
                value: checkListItems[index]["value"],
                onChanged: (value) {
                  setState(
                    () {
                      for (var element in checkListItems) {
                        element["value"] = false;
                      }
                      checkListItems[index]["value"] = value;
                      selected =
                          "${checkListItems[index]["id"]}, ${checkListItems[index]["title"]}, ${checkListItems[index]["value"]}";
                    },
                  );
                },
              ),
              ),
            ),
          ),
      //   ],
      // ),
    );
  }
}
