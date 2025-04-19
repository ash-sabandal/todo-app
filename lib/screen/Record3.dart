// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:my_app/model/user_model.dart';
// import 'package:my_app/myDrawer.dart';
// import 'package:my_app/provider/entryrecord_provider.dart';
// import 'package:my_app/screen/EntryView.dart';
// import 'package:provider/provider.dart';

// class Record extends StatelessWidget {
//   const Record({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: MyDrawer(),
//       appBar: AppBar(
//         title: Text("Mood Entries"),
//         backgroundColor: Theme.of(context).primaryColor,
//         foregroundColor: Colors.white,
//       ),
//       body: SizedBox.expand( 
//       child: Container(
//         // decoration: BoxDecoration(
//         //   image: DecorationImage(
//         //     image: AssetImage("images/bg2.jpg"),
//         //     fit: BoxFit.cover,
//         //   ),
//         // ),
//         padding: EdgeInsets.all(24),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             getUsers(context),
//           ],
//         ),
//       )
//       )
//     );
//   }

//   Widget getUsers(BuildContext context) {
//     List<User> entries = context.watch<EntryRecord>().cart;
//     String removed = "";
//     return entries.isEmpty
//         ? Center(
//           child: Column(
//             children: [
//               Text('No entries yet. Try adding some!',
//               textAlign: TextAlign.center,),
//               OutlinedButton(
//                 child: const Text("Add Entries"),
//                 onPressed: () {
//                   Navigator.pushNamed(context, "/add-entry");
//                 },
//               ),
//             ],
//           )
//         )
//         : Expanded(
//             child: Column(
//             children: [
//               Flexible(
//                   child: ListView.builder(
//                 itemCount: entries.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Container(
//                     // decoration: BoxDecoration(
//                     //   image: DecorationImage(
//                     //     image: AssetImage("images/${entries[index].emotion}.jpg"),
//                     //     fit: BoxFit.cover,
//                     //   ),
//                     // ),
//                     child:  ListTile(
//                         onTap:() {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => EntryVieww(entry: entries[index])),
//                           );
//                         },
//                         leading: Checkbox(
//                           value: entries[index].isDone,
//                           // onChanged: (value) => _toggleTask(task['id'], task['isDone']),
//                         ),
//                         title: Text("${entries[index].name!} - ${DateFormat('MMMM d y, h:mm a').format(entries[index].deadline!)}"),
//                         trailing: IconButton(
//                           icon: const Icon(Icons.delete),
//                           onPressed: () {
//                             removed = context.read<EntryRecord>().removeUser(index).name!;
//                             if (entries.isNotEmpty) {
//                               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                                 content: Text("$removed removed!"),
//                                 duration:
//                                     const Duration(seconds: 1, milliseconds: 100),
//                               ));
//                             } else {
//                               ScaffoldMessenger.of(context)
//                                   .showSnackBar(const SnackBar(
//                                 content: Text("Record Empty!"),
//                                 duration: Duration(seconds: 1, milliseconds: 100),
//                               ));
//                             }
//                           },
//                         ),
//                       )
//                   );
//                 },
//               )),
//               ],
//           ));
//   }}

