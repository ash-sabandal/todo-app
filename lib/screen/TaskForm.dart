import 'package:flutter/material.dart';
import 'package:my_app/model/user_model.dart';
import 'package:my_app/provider/entryrecord_provider.dart';
import 'package:provider/provider.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({super.key});

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  User? _userValues;
  String? _selectedcategory = _categorys[0];
  DateTime? _deadlineDate = DateTime.now();
  TimeOfDay? _deadlineTime = TimeOfDay(hour: 02, minute: 02);

  String _getName() {
    return _userValues?.name != null ? "Name: ${_userValues!.name}\n" : "";
  }
  String _getcategory() {
    return _userValues?.category != null ? "category: ${_userValues!.category}\n" : "";
  }

  String _getDate() {
    return _userValues?.deadline != null ? "Date: ${_userValues!.deadline}\n" : "";
  }
  static final List<String> _categorys = [
    "Sunny", 
    "Rainy", 
    "Stormy", 
    "Hailing", 
    "Snowy", 
    "Cloudy", 
    "Foggy", 
    "Partly Cloudy"
  ];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      // all onSaved properties will be triggered
      _formKey.currentState!.save();

      setState(() {
        _userValues = User(
          name: _nameController.text,
          category: _selectedcategory,
          // deadline: DateFormat('y MMMM d, h:mm a').format(DateTime.now()),
          deadline: DateTime(_deadlineDate!.year, _deadlineDate!.month, _deadlineDate!.day, _deadlineTime!.hour, _deadlineTime!.minute),
          isDone: false,
        );
      }); 

      if (context.read<EntryRecord>().cart.isEmpty || 
          (context.read<EntryRecord>().cart.isNotEmpty && 
          (context.read<EntryRecord>().cart.last.name != _userValues!.name ||
            context.read<EntryRecord>().cart.last.category != _userValues!.category
            ))) {
        _addEntry();
      }
  }
}

void _addEntry() {
  context
      .read<EntryRecord>()
      .addUser(_userValues!);
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text("Entry added!"),
    duration: const Duration(seconds: 1, milliseconds: 100),
  ));
  Navigator.pop(context);
}

/*
text: name
dropdown: category
date: date
 */
  @override
  Widget build(BuildContext context) {
      return IntrinsicHeight(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUnfocus,
          child: 
            Container(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  // name text field
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter string",
                        labelText: "Name",
                      ),
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your name";
                        }

                        return null;
                      },
                    ),
                  ),
                  // name text field
                  Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 20,
                        children: <Widget>[
                          Text(
                            _deadlineDate != null
                                ? '${_deadlineDate!.day}/${_deadlineDate!.month}/${_deadlineDate!.year}'
                                : 'No date selected',
                          ),
                          Text(
                            _deadlineTime != null
                                ? '${_deadlineTime!.hour}:${_deadlineTime!.minute}'
                                : 'No time selected',
                          ),
                          OutlinedButton(onPressed: () async {
                            final DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: _deadlineDate,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2030),
                            );

                            if (pickedDate != null && pickedDate != _deadlineDate) {
                              setState(() {
                                _deadlineDate = pickedDate;
                              });
                            }
                          }, child: const Text('Select Date')),
                        ],
                      ),
                  // time picker
                  ElevatedButton(
                    child: const Text('Open time picker'),
                    onPressed: () async {
                      final TimeOfDay? time = await showTimePicker(
                        context: context,
                        initialTime: _deadlineTime!,
                        initialEntryMode: TimePickerEntryMode.dial,
                        orientation: null,
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                            data: Theme.of(context).copyWith(materialTapTargetSize: MaterialTapTargetSize.padded),
                            child: MediaQuery(
                                data: MediaQuery.of(
                                  context,
                                ).copyWith(alwaysUse24HourFormat: false),
                                child: child!,
                              ),

                          );
                        },
                      );
                      if (time != null && time != _deadlineTime) {
                        setState(() {
                          _deadlineTime = time;
                        });
                      }
                    },
                  ),
                  DropdownButtonFormField<String>(
                    value: _selectedcategory,
                        dropdownColor: Color(0xFF7D6BA3),
                    onChanged: (String? value) {
                      setState(() {
                        _selectedcategory = value;
                      });
                    },
                    items:
                        _categorys.map((
                          String value,
                        ) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                    onSaved: (newValue) {
                      print("Dropdown onSaved method triggered");
                    },
                  ),
                  // save and reset
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(onPressed: _saveForm, 
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF7D6BA3),
                        ),
                        child: Text('Save', style: 
                          TextStyle(
                            fontFamily: 'InsideOut',
                            fontSize: 18,
                            color: Colors.white,),),

                            ),
                      ],
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0), 
                      child: Text(
                        "${_getName()}" 
                        "${_getcategory()}"
                        "${_getDate()}",
                        style: 
                          TextStyle(
                            fontFamily: 'InsideOut',
                            fontSize: 18,
                            color: Colors.white,),
                      ),
                    ),
                  )
                ],
              ),
            ),
        )
      );
  }
}