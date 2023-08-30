import 'package:consultant_orzu/utils/functions/main_func.dart';
import 'package:consultant_orzu/utils/hex_to_color.dart';
import 'package:consultant_orzu/utils/numeric_text_formatter/numeric_text_formatter.dart';
import 'package:consultant_orzu/utils/shadow/container_shadow.dart';
import 'package:consultant_orzu/utils/widgets/calculator_form/provider/calculator_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CalculatorForm extends StatelessWidget {
  CalculatorForm({
    required this.price,
  });

  int price;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CalculatorFormProvider>(
        create: (context) => CalculatorFormProvider(price),
        builder: (context, snapshot) {
          return Consumer<CalculatorFormProvider>(builder: (context, provider, _) {
            return Container(
              // height: 100,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: shadowContainer(),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 15,
                      bottom: 15,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "instalment_pay".tr,
                          style: TextStyle(fontSize: 14.8.sp, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "summa".tr,
                              style: TextStyle(
                                fontSize: 12.8.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              height: 48,
                              padding: EdgeInsets.only(left: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: Colors.grey.shade400,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    "${MainFunc().prettyPrice(provider.price)}",
                                    style: TextStyle(
                                      fontSize: 14.8.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "initial_payment".tr,
                              style: TextStyle(
                                fontSize: 12.8.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            SizedBox(height: 5),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              controller: provider.initPriceController,
                              onChanged: (value) {
                                value = value.replaceAll(RegExp(r'[^0-9]'), "");
                                var pretPrice = MainFunc().prettyPrice(price);
                                if ((int.tryParse(value) ?? 0) >= price) {
                                  provider.initPriceController.value = TextEditingValue(
                                    text: "${MainFunc().prettyPrice(price)}",
                                    selection: TextSelection.fromPosition(
                                      TextPosition(offset: pretPrice.length),
                                    ),
                                  );
                                }
                              },
                              inputFormatters: [
                                NumericTextFormatter(),
                              ],
                              style: TextStyle(fontSize: 14.8.sp, fontWeight: FontWeight.w600),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 20),
                                hintText: "0",
                                fillColor: HexToColor.greyTextFieldColor,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: HexToColor.mainColor, width: 1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 12),
                      InkWell(
                        onTap: () {
                          if (provider.initPriceController.text != "0") {
                            provider.clear();
                          }
                        },
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            // color: Colors.red,
                            border: Border.all(width: 1, color: provider.initPriceController.text.length > 0 ? HexToColor.mainColor : HexToColor.greyTextFieldColor),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Icon(
                            Icons.cleaning_services_outlined,
                            color: provider.initPriceController.text.length < 1 ? HexToColor.greyTextFieldColor : HexToColor.mainColor,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 15),
                  Table(
                    border: TableBorder.all(color: Colors.white),
                    children: [
                      //Table titles
                      TableRow(
                        children: [
                          ...["month".tr, "summa".tr, "per_month".tr].map(
                            (e) => Container(
                              height: 40,
                              margin: EdgeInsets.symmetric(horizontal: .5),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  "$e",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //Data of table
                      ...provider.instalmentTable.entries.map((e) {
                        return TableRow(
                          children: [
                            _buildCell("${e.key} " + "month".tr.toLowerCase(), color: e.key % 3 == 0 ? Colors.lightGreen.shade200 : null),
                            _buildCell("${MainFunc().prettyPrice(e.value["summ"])} " + "sum".tr, color: e.key % 3 == 0 ? Colors.lightGreen.shade200 : null),
                            _buildCell("${MainFunc().prettyPrice(e.value["per_month"])} " + "sum".tr, color: e.key % 3 == 0 ? Colors.lightGreen.shade200 : null),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                  SizedBox(height: 15),
                ],
              ),
            );
          });
        });
  }

  Widget _buildCell(String value, {Color? color = Colors.green}) {
    return Container(
      height: 40,
      // margin: EdgeInsets.symmetric(horizontal: .5, vertical: .8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: color ?? Colors.green)),
        color: color,
      ),
      child: Center(
        child: Text(
          "$value",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
