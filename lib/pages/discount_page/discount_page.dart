import 'package:consultant_orzu/controller/https/http.dart';
import 'package:consultant_orzu/pages/discount_page/provider/discount_provider.dart';
import 'package:consultant_orzu/utils/widgets/loaders/cp_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class DiscountPage extends StatelessWidget {
  const DiscountPage({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DiscountProvider>(
        create: (context) => DiscountProvider(id),
        builder: (context, snapshot) {
          return Consumer<DiscountProvider>(builder: (context, provider, _) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: BackButton(color: Colors.black),
              ),
              body: provider.isLoading
                  ? CPIndicator()
                  : Padding(
                      padding: EdgeInsets.all(20.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Carusel Slider
                            Stack(
                              fit: StackFit.passthrough,
                              children: [
                                Container(
                                  width: Get.width,
                                  height: Get.height * 0.3,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    image: DecorationImage(
                                      image: NetworkImage(HttpService.images + provider.carusel['image']),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                // Align(
                                //   alignment: Alignment(-0.7, 0),
                                //   child: Container(
                                //     width: Get.width * 0.4,
                                //     child: Text(
                                //       '${provider.carusel['corusel_text']}',
                                //       style: Get.textTheme.titleSmall,
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                            SizedBox(height: 20.0),

                            //Title
                            Text(
                              '${provider.carusel['title']} Юбилейная распродажа',
                              style: Get.textTheme.titleSmall,
                            ),
                            SizedBox(height: 20.0),

                            //Subtitle
                            Text(
                              '${provider.carusel['sub_title']} Lorem ipsum dolor sit amet consectetur, adipisicing elit.',
                              style: Get.textTheme.bodyMedium!.copyWith(
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 20.0),

                            //Description
                            Text(
                              '${provider.carusel['description']} Lorem ipsum dolor sit amet consectetur, adipisicing elit. Quae, quam. Lorem ipsum dolor sit amet consectetur, adipisicing elit. Quae, quam.',
                              style: Get.textTheme.bodyLarge!.copyWith(
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20.0),

                            //Binnimalar

                            Text(
                              '''OrzuGrand раздаёт миллиарды бонусов! Стань участником программы лояльности O.orzu, покупай товары и получай бонусы за покупкию''',
                              style: Get.textTheme.bodyLarge!.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20.0),
                            ...provider.carusel['conditions']
                                .map(
                                  (e) => Container(
                                    margin: EdgeInsets.only(bottom: 20.0),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 20.0),
                                          child: CircleAvatar(
                                            backgroundColor: Colors.green,
                                            child: Text(
                                              "${provider.carusel['conditions'].indexOf(e) + 1}",
                                              style: Get.textTheme.titleSmall!.copyWith(
                                                color: Colors.white,
                                              ),
                                            ),
                                            maxRadius: 30,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 15.0),
                                          child: SizedBox(
                                            width: Get.width * 0.7,
                                            child: Text(
                                              "${e['text']} Купи любой товар в период с 14 марта по 1 мая. Проверь, что ты участвуешь в нашей программе Купи любой товар в период с 14 марта по 1 мая. Проверь, что ты участвуешь в нашей программе",
                                              style: Get.textTheme.bodyMedium!.copyWith(
                                                color: Colors.grey.shade800,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList()
                          ],
                        ),
                      ),
                    ),
            );
          });
        });
  }
}
