import 'package:flutter/material.dart';
import 'package:oya_porter/spec/colors.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    this.fieldKey,
    @required this.hintText,
    this.onSaved,
    this.validate = false,
    this.removeBorder = false,
    this.onFieldSubmitted,
    @required this.labelText,
    @required this.controller,
    @required this.validateMsg,
    @required this.focusNode,
    @required this.inputType,
  });
  final Key fieldKey;
  final String hintText, labelText, validateMsg;
  final FormFieldSetter<String> onSaved;
  final bool validate, removeBorder;
  final ValueChanged<String> onFieldSubmitted;
  final TextEditingController controller;
  final TextInputType inputType;

  final FocusNode focusNode;
  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: SECONDARYCOLOR, borderRadius: BorderRadius.circular(6)),
      child: TextFormField(
        key: widget.fieldKey,
        obscureText: _obscureText,
        onSaved: widget.onSaved,
        keyboardType: widget.inputType,
        validator: (value) {
          if (value.isEmpty && widget.validate) {
            return widget.validateMsg;
          }
          return null;
        },
        onFieldSubmitted: widget.onFieldSubmitted,
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: widget.hintText,
          labelText: widget.labelText,
          labelStyle: TextStyle(color: ASHDEEP),
          contentPadding: EdgeInsets.only(left: 10),
          hintStyle: TextStyle(
            color: ASHDEEP,
          ),
          enabledBorder: widget.removeBorder
              ? InputBorder.none
              : OutlineInputBorder(
                  borderSide: BorderSide(color: BLACK, width: .5),
                ),
          focusedBorder: widget.removeBorder
              ? InputBorder.none
              : OutlineInputBorder(
                  borderSide: BorderSide(color: BLACK, width: .5),
                ),
          border: widget.removeBorder
              ? InputBorder.none
              : OutlineInputBorder(
                  borderSide: BorderSide(color: BLACK, width: .5),
                ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
