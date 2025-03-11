import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SelectTimeWidget extends StatefulWidget {
  const SelectTimeWidget({
    super.key,
    required TextEditingController timeController,
  }) : _timeController = timeController;

  final TextEditingController _timeController;

  @override
  State<SelectTimeWidget> createState() => _SelectTimeWidgetState();
}

class _SelectTimeWidgetState extends State<SelectTimeWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.grey[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF6A3DE8).withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.access_time_rounded,
            color: Color(0xFF6A3DE8),
          ),
        ),
        title: const Text(
          'Time',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          widget._timeController.text.isEmpty
              ? 'Tap to select time'
              : widget._timeController.text,
          style: TextStyle(
            color: widget._timeController.text.isEmpty
                ? Colors.grey
                : Colors.black87,
          ),
        ),
        onTap: () {
          setState(() {
            selectTime(context, widget._timeController);
          });
        },
      ),
    );
  }
}

Future<void> selectTime(BuildContext context, timeController) async {
  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.dark().copyWith(
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFF6A3DE8),
            onPrimary: Colors.white,
            surface: Color(0xFF222222),
            onSurface: Colors.white,
          ),
          dialogBackgroundColor: const Color(0xFF333333),
        ),
        child: child!,
      );
    },
  );
  if (picked != null) {
    final now = DateTime.now();
    final selectedTime = DateTime(
      now.year,
      now.month,
      now.day,
      picked.hour,
      picked.minute,
    );
    timeController.text = DateFormat('hh:mm a').format(selectedTime);
  }
}
