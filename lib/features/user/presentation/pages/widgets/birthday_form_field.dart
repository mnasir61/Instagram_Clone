import 'package:flutter/material.dart';
import 'package:instagram_clone/features/global/styles/style.dart';
import 'package:intl/intl.dart';

class BirthdayFormField extends StatefulWidget {
  final bool? isDob;
  final String? hintText;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;

  const BirthdayFormField({Key? key, this.isDob = false, this.hintText, this.validator, this.controller}) : super(key: key);

  @override
  _BirthdayFormFieldState createState() => _BirthdayFormFieldState();
}

class _BirthdayFormFieldState extends State<BirthdayFormField> {
  DateTime? _selectedDate;
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() {
          _selectedDate = null;
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        widget.controller?.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  String getHintText() {
    if (_selectedDate == null) {
      return widget.hintText ?? '${DateFormat("dd/MM/yyy").format(DateTime.now())}';
    } else {
      return DateFormat('dd/MM/yyyy').format(_selectedDate!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      readOnly: widget.isDob!,
      controller: widget.controller,
      focusNode: _focusNode,
      onTap: widget.isDob! ? () => _selectDate(context) : null,
      decoration: InputDecoration(
        labelText: 'Birthday',
        hintText: getHintText(),
        contentPadding: EdgeInsets.symmetric(vertical:20,horizontal: 15),
        filled: true,
        fillColor: Styles.colorWhite,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Styles.secondaryColor.withOpacity(.4),
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color:  Styles.secondaryColor.withOpacity(.4),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Styles.secondaryColor,
            width: 1,
          ),
        ),
      ),
    );
  }
}
