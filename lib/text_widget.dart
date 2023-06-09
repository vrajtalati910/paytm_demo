import 'package:flutter/material.dart';

class EditText extends StatefulWidget {
  final String text, value;
  final Function? onChange;
  const EditText(this.text, this.value, {super.key, this.onChange});
  @override
  State<StatefulWidget> createState() {
    return _EditTextState();
  }
}

class _EditTextState extends State<EditText> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.bottomLeft,
          margin: const EdgeInsets.fromLTRB(12, 8, 0, 0),
          child: Text(
            widget.text,
            style: const TextStyle(fontSize: 18),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(12, 8, 12, 8),
          child: TextField(
            controller: TextEditingController(text: widget.value),
            onChanged: widget.onChange as void Function(String)?,
            decoration: InputDecoration(
              hintText: 'Enter ${widget.text}',
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white, width: 1.0),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
