import 'package:flutter/material.dart';

import '../../../operations/error_handler.dart';
import '../../../services/firebase_course_control.dart';

class AddAcademicYear extends StatefulWidget {
  const AddAcademicYear({super.key});

  @override
  State<AddAcademicYear> createState() => _AddAcademicYearState();
}

class _AddAcademicYearState extends State<AddAcademicYear> {
  final TextEditingController acYearName = TextEditingController();
  int? _selectedValue;

  Future<void> ayBtnOk(context) async {
    if (acYearName.text.isNotEmpty || _selectedValue != null) {
      await DbCourseMethods().createAcademicYear(acYearName.text, _selectedValue!);

      try {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Academic Year added successfully'),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        AppLogger.log(e);
      }
    } else {
      try {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter valid Academic Year name and no'),
            backgroundColor: Colors.red,
          ),
        );
      } catch (e) {
        AppLogger.log(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Batch'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: acYearName,
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Batch Name Ex: 18-19-Batch'),
          ),
          const SizedBox(height: 30,),
          const Text(
            'Select Academic Year:',
            style: TextStyle(fontSize: 16),
          ),
          Row(
            children: [
              Radio<int>(
                value: 0,
                groupValue: _selectedValue,
                onChanged: (value) {
                  setState(() {
                    _selectedValue = value;
                  });
                },
              ),
              const Text('Pre'),
            ],
          ),
          Row(
            children: [
              for (int i = 1; i <= 4; i++)
                Row(
                  children: [
                    Radio<int>(
                      value: i,
                      groupValue: _selectedValue,
                      onChanged: (value) {
                        setState(() {
                          _selectedValue = value;
                        });
                      },
                    ),
                    Text(i.toString()),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel')),
        TextButton(
            onPressed: () {
              ayBtnOk(context);
              Navigator.pop(context);
            },
            child: const Text('OK'))
      ],
      backgroundColor: Colors.lightGreenAccent,
    );
  }
}
