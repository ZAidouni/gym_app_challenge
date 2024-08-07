import 'package:get/get.dart';
import 'package:work_out/helpers/extension/set_extension.dart';

import '../../model/checked_get_started_card_info.dart';

class GetStartedController extends GetxController {
  String rebuildId = "rebuildId";
  Set<CheckedCard> checkedCardsIds = {};
  bool hasUserChooserAtLeastOneChoice = false;

  /// this method is called when user click on a card
  handelChangeInCheckedCardsList(CheckedCard checkedCard) {
    print(checkedCard.id == 0);
    if(checkedCard.id == 0){
    Get.toNamed("/signUp"); 

    }else{
    Get.toNamed("/signUpCoach"); 

    };
    checkedCardsIds.addIfRemoveElse(
      checkedCard,
      checkedCard.isChecked,
      removeElse: !checkedCard.isChecked,
    );

    hasUserChooserAtLeastOneChoice = checkedCardsIds.isNotEmpty;

    update([rebuildId]);
  }
}
