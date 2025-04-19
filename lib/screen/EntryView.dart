import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/model/user_model.dart';
import 'package:my_app/myDrawer.dart';

class EntryVieww extends StatefulWidget {
  final User entry;
  const EntryVieww({super.key, required this.entry});

  @override
  State<EntryVieww> createState() => _EntryViewwState();
}

class _EntryViewwState extends State<EntryVieww> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.notifications_sharp)),
            label: 'Notifications',
          ),
          NavigationDestination(
            icon: Badge(label: Text('2'), child: Icon(Icons.messenger_sharp)),
            label: 'Messages',
          ),
        ],
      ),
    drawer: MyDrawer(),
    appBar: AppBar(
      title: Text("Details"),
      backgroundColor: Theme.of(context).primaryColor,
      foregroundColor: Colors.white,
    ),
    body: SizedBox.expand( 
      child: Container(
        decoration: BoxDecoration(
          // image: DecorationImage(
          //   image: AssetImage("images/${widget.entry.emotion}.jpg"),
          //   fit: BoxFit.cover,
          // ),
        ),
        padding: EdgeInsets.all(24),
        child: Column(
          spacing: 18, 
          children: [
            // Text("Date: ${widget.entry.date}"),
            Text('Name: ${widget.entry.name}'),
            Text('Category: ${widget.entry.category}'),
            Text('Deadline: ${DateFormat('MMMM d y, h:mm a').format(widget.entry.deadline!)}'),
            Text('Done?: ${widget.entry.isDone}'),
            // Text('Category: ${MaterialLocalizations.of(context).formatTimeOfDay(widget.entry.deadlineTime!)}'),
            // Text('Deadline: ${widget.entry.deadlineDate!.month} ${widget.entry.deadlineDate!.day} ${widget.entry.deadlineDate!.year} ${widget.entry.deadlineTime.toString()}'),
            Center(
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.white, width: 2), 
                ),
                child: Text('Back'),
              ),
            )
          ],
        ),
      ),
    ),
  );
  }
}