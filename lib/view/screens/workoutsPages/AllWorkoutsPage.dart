import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_out/controller/functionsController.dart';
import 'package:work_out/config/Colors.dart';
import 'package:work_out/config/text.dart';
import 'package:work_out/view/screens/homepage/componenets/avatar.dart';
import '../../../controller/userController/userController.dart';
import '../../../config/workouts lists/workouts Lists.dart';
import '../../../helpers/string_methods.dart';
import '../homepage/componenets/tabBarViewSections.dart';
import '../user profile/userProfil.dart';
import 'components/mainWorkoutCard.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AllWorkoutsPage extends StatelessWidget {
  AllWorkoutsPage({Key? key, this.dataList}) : super(key: key);
  List? dataList;
  final FunctionsController controller = Get.put(FunctionsController());
  final userInformationController = Get.put(UserInformationController());
  @override
  Widget build(BuildContext context) {
     List workoutOfDayList = controller.filteredListwith(Get.arguments[1], "isWorkoutOfDay", "true");
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: DelayedDisplay(
          slidingBeginOffset: const Offset(0.0, 0.1),
          delay: Duration(milliseconds: delay),
          child: AppBar(
            actions: [
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Avatar(
                    onProfileImgTap: () {
                      Get.to(() => const UserProfile());
                    },
                    networkImage:
                        userInformationController.userProfileImg.value,
                  ),
                ),
              ),
            ],
            elevation: 0,
            toolbarHeight: 80,
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            backgroundColor: AppColors.darkBlue,
            title: Text(
              Get.arguments[0].toString(),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
               DelayedDisplay(
                delay: Duration(milliseconds: delay + 100),
                slidingBeginOffset: const Offset(0.0, 0.1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
                  children: [
                    Text(
                      AppTexts.workoutOfDay,
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                      Center(
                      child: Text(
                        AppTexts.basedOnReviews,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            DelayedDisplay(
                delay: Duration(milliseconds: delay + 100),
                slidingBeginOffset: const Offset(0.0, 0.1),
                child: CarouselSlider.builder(
                  options: CarouselOptions(
                    height: 490,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    viewportFraction: 0.8,
                  ),
                  itemCount: workoutOfDayList.length,
                  itemBuilder: (BuildContext context, int index, int realIndex) {
                    var workout = workoutOfDayList[index];
                    return MainWorkoutCard(
                      isFavortite: false,
                      sectionTitle: "",
                      description: "",
                      imagePath: workout["imagePath"],
                      cardTitle: workout["workOutTitle"],
                      filledStars: workout["rating"],
                      timeLeft: workout["timeLeftInHour"],
                      comments: workout["comments"],
                      durationInMinutes: workout["durationInMinutes"],
                      hasFreeTrial: workout["hasFreeTrial"],
                      movesNumber: workout["movesNumber"],
                      priceInDollars: workout["priceInDollars"],
                      setsNumber: workout["setsNumber"],
                      reviews: workout["reviews"],
                      localisation: workout["localisation"],
                    );
                  },
                ),
              ),
            const SizedBox(
              height: 0,
            ),
            DelayedDisplay(
              slidingBeginOffset: const Offset(0.0, 0.1),
              delay: Duration(milliseconds: delay + 100),
              child: TabBarViewSection(
                itemsToShow: WorkoutsList.legsWorkoutsList.length,
                title: capitalize(
                  AppTexts.pushyourlimit,
                ),
                dataList: controller.filteredListwith(
                    Get.arguments[1], "isDiscounted", "true"),
                hasSeeAllButton: false,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            DelayedDisplay(
              slidingBeginOffset: const Offset(0.0, 0.1),
              delay: Duration(milliseconds: delay + 200),
              child: MainWorkoutCard(
                isFavortite: false,
                sectionTitle: AppTexts.dailyFreeWorkout,
                description: AppTexts.choosedCarefully,
                imagePath: controller.filterWorkoutWith(
                    Get.arguments[1], "dailyFreeWorkout", "true")["imagePath"],
                cardTitle: controller.filterWorkoutWith(Get.arguments[1],
                    "dailyFreeWorkout", "true")["workOutTitle"],
                filledStars: controller.filterWorkoutWith(
                    Get.arguments[1], "dailyFreeWorkout", "true")["rating"],
                timeLeft: controller.filterWorkoutWith(Get.arguments[1],
                    "dailyFreeWorkout", "true")["timeLeftInHour"],
                comments: controller.filterWorkoutWith(
                    Get.arguments[1], "dailyFreeWorkout", "true")["comments"],
                durationInMinutes: controller.filterWorkoutWith(
                    Get.arguments[1],
                    "dailyFreeWorkout",
                    "true")["durationInMinutes"],
                hasFreeTrial: controller.filterWorkoutWith(Get.arguments[1],
                    "dailyFreeWorkout", "true")["hasFreeTrial"],
                movesNumber: controller.filterWorkoutWith(Get.arguments[1],
                    "dailyFreeWorkout", "true")["movesNumber"],
                priceInDollars: controller.filterWorkoutWith(Get.arguments[1],
                    "dailyFreeWorkout", "true")["priceInDollars"],
                setsNumber: controller.filterWorkoutWith(
                    Get.arguments[1], "dailyFreeWorkout", "true")["setsNumber"],
                reviews: controller.filterWorkoutWith(
                    Get.arguments[1], "dailyFreeWorkout", "true")["reviews"],
                localisation: controller.filterWorkoutWith(
                    Get.arguments[1], "dailyFreeWorkout", "true")["localisation"],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            DelayedDisplay(
              slidingBeginOffset: const Offset(0.0, 0.1),
              delay: Duration(milliseconds: delay + 300),
              child: TabBarViewSection(
                itemsToShow: WorkoutsList.legsWorkoutsList.length,
                title: capitalize(
                  AppTexts.allWorkouts,
                ),
                dataList: Get.arguments[1],
                hasSeeAllButton: false,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      )),
    );
  }
}
