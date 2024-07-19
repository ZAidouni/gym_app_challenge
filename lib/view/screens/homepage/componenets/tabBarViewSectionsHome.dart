import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_out/controller/functionsController.dart';
import 'package:work_out/config/images%20sources.dart';

import '../../../../config/text.dart';
import '../../../../helpers/string_methods.dart';
import '../../workoutsPages/AllWorkoutsPage.dart';
import 'WorkOutCardHome.dart';

class TabBarViewSectionHome extends StatelessWidget {
  TabBarViewSectionHome({
    Key? key,
    required this.title,
    required this.dataList,
    this.itemsToShow = 8,
    this.hasSeeAllButton = true,
  }) : super(key: key);

  String title;
  List dataList;
  bool hasSeeAllButton;
  int itemsToShow;
  final FunctionsController controller = Get.put(FunctionsController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 33,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(AllWorkoutsPage(), arguments: [title, dataList]);
              },
              child: Visibility(
                visible: hasSeeAllButton,
                child: Container(
                  margin: const EdgeInsets.only(right: 5),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white.withOpacity(.1),
                  ),
                  child: Text(
                    capitalize(AppTexts.seeAll),
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              childAspectRatio: 0.6,
            ),
            itemCount: itemsToShow < dataList.length ? itemsToShow : dataList.length,
            itemBuilder: (context, index) {
              final item = dataList[index];
              return WorkOutCardHome(
                index: index,
                listCollection: dataList,
                title: capitalize(
                  item["workOutTitle"] ?? AppTexts.somethingWrong,
                ),
                imagePath: item["imagePath"],
              );
            },
          ),
        ),
      ],
    );
  }
}
