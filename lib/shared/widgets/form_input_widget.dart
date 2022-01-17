import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String label;
  final IconData icon;
  final List<TextInputFormatter>? mask;

  const FormInputWidget(
      {Key? key,
      required this.label,
      required this.icon,
      required this.controller,
      required this.keyboardType,
      this.mask})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        controller: controller,
        keyboardType: keyboardType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return ("This field is required");
          }
          return null;
        },
        inputFormatters: mask ?? [],
        style: TextStyle(color: Colors.white, fontFamily: 'OpenSans'),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.white),
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          hintText: label,
          hintStyle: TextStyle(
            color: Colors.white60,
          ),
        ),
      ),
    );
  }
}
