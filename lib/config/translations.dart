import 'package:get/get.dart';
import 'text.dart';
import 'text_fr.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en': {
      'error': AppTexts.error,
      'firstMainWord': AppTexts.firstMainWord,
      'secondaryMainWord': AppTexts.secondaryMainWord,
      'welcome': AppTexts.welcome,
      // Add other translations here...
    },
    'fr': {
      'error': AppTextsFr.error,
      'firstMainWord': AppTextsFr.firstMainWord,
      'secondaryMainWord': AppTextsFr.secondaryMainWord,
      'welcome': AppTextsFr.welcome,
      // Add other translations here...
    }
  };
}
