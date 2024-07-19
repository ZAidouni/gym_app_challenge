import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_out/config/text.dart';
import 'package:work_out/config/text_fr.dart';
import 'package:work_out/view/widgets/general_widgets/screen_background_image.dart';
import '../../../config/show_delay_mixin.dart';
import '../../../controller/get_started_controller/get_started_controller.dart';
import '../../../helpers/string_methods.dart';
import '../../widgets/general_widgets/mainScreenTitle.dart';
import '../../widgets/general_widgets/titleWithDescription.dart';
import 'componenets/get_started_cards_scroll_view.dart';

class GetStartedPage extends GetView<GetStartedController> with DelayHelperMixin {
  GetStartedPage({super.key});

  // Helper method to get the text based on the selected language
  String getText(String key) {
    if (Get.locale?.languageCode == 'fr') {
      return AppTextsFr.getText(key);
    } else {
      return AppTexts.getText(key);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const BackgroundImage(),
          Container(
            color: const Color(0xff0B183C).withOpacity(0.69),
            width: double.infinity,
            child: Container(
              margin: const EdgeInsets.symmetric(
                vertical: 15,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Spacer(),
                  DelayedDisplay(
                    delay: getDelayDuration(),
                    child: MainScreenTitle(
                      mainWord: getText('firstMainWord'),
                      secondaryWord: getText('secondaryMainWord'),
                    ),
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: DelayedDisplay(
                      delay: getDelayDuration(),
                      child: TitleWithDescription(
                        title: capitalize(getText('aboutYou')),
                        description: getText('getStartedDescription'),
                      ),
                    ),
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: Theme.of(context).colorScheme.copyWith(
                        primary: Colors.transparent,
                        secondary: Colors.transparent,
                      ),
                    ),
                    child: GetStartedCardsScrollView(
                      delay: getDelayDuration(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    child: DelayedDisplay(
                      delay: getDelayDuration(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            child: Text(
                              capitalize(''),
                              style: TextStyle(
                                color:
                                const Color(0xffffffff).withOpacity(0.42),
                              ),
                            ),
                          ),
                          const IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(width: 15),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
