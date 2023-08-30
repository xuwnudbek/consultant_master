import 'package:consultant_orzu/utils/hex_to_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PopDialog extends StatefulWidget {
  PopDialog({super.key, required this.onSend});

  Function(String valueL) onSend;

  @override
  State<PopDialog> createState() => _PopDialogState();
}

class _PopDialogState extends State<PopDialog> {
  var textTheme = Theme.of(Get.context!).textTheme.titleSmall;
  var numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Stack(
        children: [
          Text(
            "Mijozning telefon raqamini\nkiriting",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Positioned(
            right: 0,
            top: 0,
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.clear,
                color: Colors.red,
                size: 48,
              ),
            ),
          ),
        ],
      ),
      content: Container(
        constraints: BoxConstraints(minWidth: 400),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(20),
        child: _buildInput(numberController),
      ),
      actions: [
        MaterialButton(
          onPressed: () {
            print("${numberController.text}");
            if (numberController.text.length == 13) {
              widget.onSend(numberController.text);
              Get.back();
            }
          },
          child: Text(
            "Send",
            style: TextStyle(
              fontSize: 17,
              color: Colors.white,
            ),
          ),
          color: HexToColor.mainColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        )
      ],
      actionsPadding: EdgeInsets.only(right: 20, bottom: 15),
    );
  }

  Widget _buildInput(TextEditingController controller) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.only(left: 5),
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("+998 ", style: textTheme),
          Expanded(
            flex: 1,
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.done,
              onChanged: (value) {},
              textAlign: TextAlign.left,
              style: textTheme,
              autofocus: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: Colors.grey.withOpacity(0.7),
                ),
                hintText: "(xx)-xxx-xxxx",
                errorStyle: TextStyle(fontSize: 0),
              ),
              inputFormatters: [
                MaskTextInputFormatter(mask: "(##)-###-####", type: MaskAutoCompletionType.eager),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              numberController.clear();
            },
          )
        ],
      ),
    );
  }
}
