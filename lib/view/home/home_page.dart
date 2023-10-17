import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:slivers/constants.dart';
import 'package:slivers/view/home/expanded_page.dart';

import '../../controller/database.dart';
import 'home_screen_widgets.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Database db = Database();
  final _mybox = Hive.box('myBox');

  @override
  void initState() {
    _mybox.get('mylist') == null ? db.demotodolist() : db.loadfromdatabase();
    db.myTODOList;
    super.initState();
  }

  final TextEditingController _dateController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String? _myTitle;
  String? _myDescription;
  int? trackcurrentIndex;
  int currentcolorindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.pink[200],
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              setState(() {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Colors.pink,
                      content: SizedBox(
                        height: 300,
                        width: 200,
                        child: Column(
                          children: [
                            TextField(
                              onChanged: (text) {
                                setState(() {
                                  _myTitle = text;
                                });
                              },
                              decoration: InputDecoration(
                                  hintText: 'TITLE',
                                  filled: true,
                                  fillColor: Colors.pink[600],
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20))),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextField(
                              onChanged: (value) {
                                setState(() {
                                  _myDescription = value;
                                });
                              },
                              decoration: InputDecoration(
                                  hintText: 'descriptions',
                                  filled: true,
                                  fillColor: Colors.pink[600],
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20))),
                            ),
                            TextField(
                              controller: _dateController,
                              decoration: InputDecoration(
                                labelText: 'Selected Date',
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.calendar_today),
                                  onPressed: () => _selectDate(context),
                                ),
                              ),
                            ),
                            const Spacer(),
                            const Text(
                              'Choose a color for your card',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: Colorconstants.colorsreal.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        // selectedColor =
                                        //     Colorconstants.colorsreal[index];
                                        currentcolorindex = index;
                                      });
                                    },
                                    child: SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: Card(
                                          color:
                                              Colorconstants.colorsreal[index],
                                        )),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      actions: [
                        ElevatedButton.icon(
                            onPressed: () {
                              setState(() {
                                db.myTODOList.add([
                                  _myTitle ?? 'title or name',
                                  _myDescription ?? 'description',
                                  _dateController.text,
                                  currentcolorindex,
                                ]);

                                db.updatedatabase();

                                Navigator.pop(context);
                              });
                            },
                            icon: const Icon(Icons.save),
                            label: const Text('Save')),
                        ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.close),
                            label: const Text('Close')),
                      ],
                    );
                  },
                );
              });
            }),
        appBar: AppBar(
          centerTitle: true,
          title: const Text('TODO APP'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CupertinoButton(
                      child: const Row(
                        children: [
                          Text('Delete all'),
                          Icon(Icons.delete_forever_outlined),
                        ],
                      ),
                      onPressed: () {
                        setState(() {
                          db.myTODOList.clear();
                        });
                        db.updatedatabase();
                      }),
                ],
              ),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                  itemCount: db.myTODOList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        trackcurrentIndex = index;
                        showCupertinoDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor: Colors.pink,
                            title: const Text(
                              'CHOOSE AN ACTION',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            actions: [
                              ElevatedButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      db.myTODOList
                                          .removeAt(trackcurrentIndex!);

                                      Navigator.pop(context);
                                    });
                                    db.updatedatabase();
                                  },
                                  icon: const Icon(Icons.delete),
                                  label: const Text('Delete')),
                              ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    setState(() {});
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              Expandedtodotile(
                                                  index: trackcurrentIndex!),
                                        ));
                                  },
                                  icon: const Icon(Icons.expand),
                                  label: const Text('Expand'))
                            ],
                          ),
                        );
                      },
                      child: Container(
                          child: todotile(
                        title: db.myTODOList[index][0],
                        description: db.myTODOList[index][1],
                        time: db.myTODOList[index][2],
                        index: index,
                        pickedColor: db.myTODOList[index][3],
                      )),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('dd-MM-yyyy')
            .format(picked); // Format the date as per your requirement
      });
    }
  }
}
