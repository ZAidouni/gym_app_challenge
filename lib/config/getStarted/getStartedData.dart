// Get started card options
import 'dart:convert';

import '../../model/get_started_page_card_choices_model.dart';

String cardsJson = '''[
  {
  "title": "Membre",
  "description": "Let's make progress"
},
{
  "title": "Coach",
  "description": "Lead the group"
}
  ]''';

List<ChoiceCard> handledCardsList = List<ChoiceCard>.from(
  jsonDecode(cardsJson).map(
    (choiceCardJson) => ChoiceCard.fromJson(
      choiceCardJson,
    ),
  ),
);
