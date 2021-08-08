import 'package:events_app/providers/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  TextEditingController editingController;
  String text;
  TextInputType textype;
  double height;
  int maxLines;

  CustomTextField(
      {required this.editingController,
      this.text = "",
      this.textype = TextInputType.text,
      this.height = 75,
      this.maxLines = 1});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool isnull = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 5, 10, 0),
        child: Container(
            height: widget.height,
            child: TextFormField(
              maxLines: widget.maxLines,
              keyboardType: widget.textype,
              onFieldSubmitted: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    isnull = false;
                  });
                }
              },
              validator: (value) {
                if (value!.isEmpty) {
                  ///setState(() {
                  // isnull = true;
                  return "";
                  // });
                }
              },
              controller: widget.editingController,
              decoration: InputDecoration(
                hintText: widget.text,
                isDense: true,
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: isnull ? Colors.red : Colors.grey,
                    width: isnull ? 2 : 1.0,
                  ),
                ),
              ),
            )));
  }
}
