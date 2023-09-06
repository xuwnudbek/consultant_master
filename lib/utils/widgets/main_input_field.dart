import 'package:consultant_orzu/utils/hex_to_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MainInputField extends StatefulWidget {
  MainInputField({
    super.key,
    this.isEnabled = true,
    required this.controller,
    required this.hintText,
    this.initValue,
    this.onChangableVisibility = false,
    this.inputFormatters = const [],
  });

  final TextEditingController controller;
  final String hintText;
  final String? initValue;

  bool onChangableVisibility;
  final bool isEnabled;
  final List<TextInputFormatter> inputFormatters;

  @override
  State<MainInputField> createState() => _MainInputFieldState();
}

class _MainInputFieldState extends State<MainInputField> {
  bool isVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            enabled: widget.isEnabled,
            style: Get.textTheme.bodyLarge,
            obscureText: widget.onChangableVisibility ? !isVisibility : false,
            obscuringCharacter: "*",
            inputFormatters: widget.inputFormatters,
            controller: widget.controller,
            onChanged: (value) {
              if (int.tryParse(value) != null) {
                if (widget.onChangableVisibility) return;
                widget.controller.clear();
              }
            },
            decoration: InputDecoration(
              hintText: "${widget.hintText}",
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              hintStyle: Get.textTheme.bodyLarge!.copyWith(color: Colors.grey),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: HexToColor.mainColor),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: HexToColor.mainColor),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        Visibility(
          visible: widget.onChangableVisibility,
          child: IconButton(
            onPressed: () {
              setState(() {
                isVisibility = !isVisibility;
              });
            },
            icon: Icon(isVisibility ? Icons.visibility : Icons.visibility_off),
          ),
        )
      ],
    );
  }
}
