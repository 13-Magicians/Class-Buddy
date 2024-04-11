

import 'package:flutter/material.dart';

import '../../../operations/course_handler.dart';

class ChangeAcademicYearDialog extends StatefulWidget {
  final int initialSelectedIndex; // Pre-select year
  final String currentACYear;

  const ChangeAcademicYearDialog({Key? key, required this.currentACYear, required this.initialSelectedIndex})
      : super(key: key);

  @override
  State<ChangeAcademicYearDialog> createState() => _ChangeAcademicYearDialogState();
}

class _ChangeAcademicYearDialogState extends State<ChangeAcademicYearDialog> {
  int _selectedIndex = 0; // State variable for selected year
  String currentACYear = '';

  @override
  void initState() {
    super.initState();
    currentACYear = widget.currentACYear;
    _selectedIndex = widget.initialSelectedIndex; // Set initial year
  }

  final List<ButtonSegment<int>> segments = List.generate(5,
        (index) => ButtonSegment<int>(
      value: index,
      label: Text(index.toString()),
    ),
  );


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.all(10),
      title: const Text('Change Academic Year', style: TextStyle(fontSize: 20)),
      content: SizedBox(
        height: 50,
        child: SegmentedButton<int>(
          segments: segments,
          selected: {_selectedIndex},
          onSelectionChanged: (Set<int> selectedValues) {
            if (selectedValues.isNotEmpty) {
              setState(() {
                _selectedIndex = selectedValues.first;
              });
            }
          },
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // Handle user selection (e.g., print selected year)
            AcademicOperation().changeACYear(currentACYear, _selectedIndex);
            print('Selected year: $_selectedIndex');
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    ); // Empty build method (removed AlertDialog)
  }
}
