import 'package:flutter/material.dart';
import '../utils/index.dart';

const year = Duration(days: 360);

class DatePickerFormFieldWithLabel extends StatefulWidget {
  final String label;
  final String? hintText;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final void Function(DateTime?)? onChangeDate;
  final String? errorText;
  const DatePickerFormFieldWithLabel({
    Key? key,
    this.initialDate,
    this.onChangeDate,
    this.label = "",
    this.hintText,
    this.errorText,
    this.firstDate,
    this.lastDate,
  }) : super(key: key);

  @override
  State<DatePickerFormFieldWithLabel> createState() =>
      _DatePickerFormFieldWithLabelState();
}

class _DatePickerFormFieldWithLabelState
    extends State<DatePickerFormFieldWithLabel> {
  final TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    if (widget.initialDate != null) {
      dateController.text = formatDate(widget.initialDate!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: dateController,
          onTap: () async {
            final now = DateTime.now();
            DateTime firstDate = widget.firstDate ?? now.subtract(year);
            DateTime initialDate = widget.initialDate ?? now;
            if (widget.firstDate != null) {
              initialDate = widget.firstDate!;
            }

            DateTime lastDate = widget.lastDate ?? initialDate.add(year);
            if (widget.lastDate == null) {}

            DateTime? dateSelected = await showDatePicker(
              context: context,
              initialDate: initialDate,
              firstDate: firstDate,
              lastDate: lastDate,
            );

            if (widget.onChangeDate != null) {
              widget.onChangeDate!(dateSelected);
            }

            if (dateSelected != null) {
              dateController.text = formatDate(dateSelected);
            }
          },
          readOnly: true,
          decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFf8f8f8),
              hintText: widget.hintText,
              errorText: widget.errorText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: Colors.red))),
        ),
      ],
    );
  }
}

class TimePickerFormFieldWithLabel extends StatefulWidget {
  final String label;
  final String? hintText;
  final TimeOfDay? initialTime;
  final void Function(TimeOfDay?)? onChangeTime;

  const TimePickerFormFieldWithLabel({
    Key? key,
    this.initialTime,
    this.onChangeTime,
    this.label = "",
    this.hintText,
  }) : super(key: key);

  @override
  State<TimePickerFormFieldWithLabel> createState() =>
      _TimePickerFormFieldWithLabelState();
}

class _TimePickerFormFieldWithLabelState
    extends State<TimePickerFormFieldWithLabel> {
  final TextEditingController timeController = TextEditingController();

  @override
  void initState() {
    if (widget.initialTime != null) {
      timeController.text = formatTime(widget.initialTime!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label.isNotEmpty)
          Text(
            widget.label,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        TextFormField(
          controller: timeController,
          onTap: () async {
            TimeOfDay time = widget.initialTime == null
                ? TimeOfDay.now()
                : widget.initialTime!;

            TimeOfDay? timeSelected = await showTimePicker(
              context: context,
              initialTime: time,
            );

            if (widget.onChangeTime != null) {
              widget.onChangeTime!(timeSelected);
            }

            if (timeSelected != null) {
              timeController.text = formatTime(timeSelected);
            }
          },
          readOnly: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFf8f8f8),
            hintText: widget.hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
