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
                      child: RefreshIndicator(
                        onRefresh: () {
                          return provider.getDiscount(id);
                        },
                        child: SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Carusel Slider
                              Stack(
                                children: [
                                  SizedBox(
                                    width: Get.width,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Image.network(
                                        HttpService.images + provider.carusel['image'],
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.0),

                              //Title
                              Text(
                                '${provider.carusel['title']}',
                                style: Get.textTheme.titleSmall,
                              ),
                              SizedBox(height: 20.0),

                              //Subtitle
                              Text(
                                '${provider.carusel['sub_title']}',
                                style: Get.textTheme.bodyMedium!.copyWith(
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 20.0),

                              //Description
                              Text(
                                '${provider.carusel['description']}',
                                style: Get.textTheme.bodyLarge!.copyWith(
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 20.0),

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
                                                "${e['text']}",
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
                    ),
            );
          });
        });
  }
}
