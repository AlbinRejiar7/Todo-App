import 'package:flutter/material.dart';
import 'package:slivers/constants.dart';
import 'package:slivers/controller/database.dart';

class Expandedtodotile extends StatefulWidget {
  final int index;
  const Expandedtodotile({super.key, required this.index});

  @override
  State<Expandedtodotile> createState() => _ExpandedtodotileState();
}

class _ExpandedtodotileState extends State<Expandedtodotile> {
  @override
  Widget build(BuildContext context) {
    final Database db = Database();
    db.loadfromdatabase();

    return Scaffold(
      backgroundColor:
          Colorconstants.colorsreal[db.myTODOList[widget.index][3]],
      appBar: AppBar(
        backgroundColor:
            Colorconstants.colorsreal[db.myTODOList[widget.index][3]],
        title: Text(
          db.myTODOList[widget.index][0],
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(db.myTODOList[widget.index][1],
                style: const TextStyle(fontSize: 25.0)),
            const Spacer(),
            Text("Date :-${db.myTODOList[widget.index][2]}",
                style: const TextStyle(fontSize: 25.0)),
          ],
        ),
      ),
    );
  }
}
