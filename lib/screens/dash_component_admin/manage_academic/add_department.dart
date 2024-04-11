import 'package:flutter/material.dart';

import '../../../operations/error_handler.dart';
import '../../../services/firebase_department_control.dart';

class AddDepartmentDialog extends StatefulWidget {
  const AddDepartmentDialog({super.key});

  @override
  State<AddDepartmentDialog> createState() => _AddDepartmentDialogState();
}

class _AddDepartmentDialogState extends State<AddDepartmentDialog> {
  final TextEditingController fcCode = TextEditingController();
  final TextEditingController fcName = TextEditingController();

  Future<void> btnOk(context) async {
    if (fcCode.text.isNotEmpty && fcName.text.isNotEmpty) {
      await DataOrgManage().createDepartment(fcName.text, fcCode.text);

      try {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Department added successfully'),
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
            content: Text('Please enter valid department code and name'),
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
      title: const Text('Add New Department'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: fcCode,
            autofocus: true,

            decoration: const InputDecoration(hintText: 'Dep code (eg:ICT,EET,BPT)'),
          ),
          TextField(
            controller: fcName,
            decoration: const InputDecoration(hintText: 'Department name'),
          ),
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
              btnOk(context);
              Navigator.pop(context);
            },
            child: const Text('OK'))
      ],
      backgroundColor: Colors.lightGreenAccent,
    );
  }
}

