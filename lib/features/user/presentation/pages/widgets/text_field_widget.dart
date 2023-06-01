import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/features/global/styles/style.dart';
import 'package:intl/intl.dart';

class TextFieldWidget extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final IconData? suffixIcon;
  final bool? isPasswordField;
   final bool? isDob;
  final TextInputType? textInputType;
  final bool? readOnly;
  final VoidCallback? onTap;
  final FormFieldValidator<String>? validator;


  const TextFieldWidget({
    Key? key,
    this.controller,
    this.hintText,
    this.labelText,
    this.suffixIcon,
    this.isPasswordField = false,
    this.textInputType, this.isDob=false, this.readOnly=false, this.onTap, this.validator,
  }) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  TextEditingController _dobController = TextEditingController();
  bool _obscureText = false;
  FocusNode _searchFocusNode = FocusNode();
  DateTime? _selectedDate;

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(readOnly: widget.readOnly!,
      keyboardType: widget.textInputType,
      controller: widget.controller,
      onTap: widget.isDob==true ? () => _selectDate(context) : null,
      focusNode: _searchFocusNode,
      validator: widget.validator,
      onTapOutside: (PointerDownEvent event) {
        _searchFocusNode.unfocus();
      },
      obscureText: widget.isPasswordField == true ? _obscureText == false : false,
      decoration: InputDecoration(
        hintText: widget.isDob==true
            ? (_selectedDate == null
            ? "${DateFormat('dd/MM/yyyy').format(DateTime.now())}"
            : DateFormat('dd/MM/yyyy').format(_selectedDate!))
            : widget.hintText,
        labelText: widget.labelText,
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
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;

            });
          },
          child: widget.isPasswordField == true
              ? Icon(
                  _obscureText == false ? FontAwesomeIcons.eyeSlash: FontAwesomeIcons.eye,
                  size: 21,
                  color: _obscureText == false ? Colors.grey : colorBlue,
                )
              : Text(""),
        ),
      ),
    );
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
        _dobController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }
}
