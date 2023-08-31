import 'package:memorize_mvvm/models/card_model.dart';

List<CardModel> emojiList = [
  CardModel(emoji: '😀'),
  CardModel(emoji: '🥶'),
  CardModel(emoji: '😡'),
  CardModel(emoji: '🎃'),
  CardModel(emoji: '🤢'),
];

List<CardModel> animalList = [
  CardModel(emoji: '🐶'),
  CardModel(emoji: '🐱'),
  CardModel(emoji: '🦊'),
  CardModel(emoji: '🐷'),
  CardModel(emoji: '🐵'),
];

List<CardModel> fruitList = [
  CardModel(emoji: '🍏'),
  CardModel(emoji: '🍐'),
  CardModel(emoji: '🍊'),
  CardModel(emoji: '🍌'),
  CardModel(emoji: '🍉'),
];

List<CardModel> sportList = [
  CardModel(emoji: '⚽️'),
  CardModel(emoji: '🏀'),
  CardModel(emoji: '🏈'),
  CardModel(emoji: '🥎'),
  CardModel(emoji: '🪀'),

];

List<CardModel> foodList = [
  CardModel(emoji: '🥩'),
  CardModel(emoji: '🍗'),
  CardModel(emoji: '🍖'),
  CardModel(emoji: '🌭'),
  CardModel(emoji: '🥮'),
];

List<CardModel> emojiCardList = duplicateCardModel(emojiList);
List<CardModel> animalCardList = duplicateCardModel(animalList);
List<CardModel> fruitCardList = duplicateCardModel(fruitList);
List<CardModel> sportCardList = duplicateCardModel(sportList);
List<CardModel> foodCardList = duplicateCardModel(foodList);

duplicateCardModel(List<CardModel> cardList) {
  // List<CardModel> newCardList = [];

  // // ignore: avoid_function_literals_in_foreach_calls
  // cardList.forEach((card) {
  //   CardModel cardA = CardModel(emoji: card.emoji);
  //   newCardList.add(cardA);
  //   CardModel cardB = CardModel(emoji: card.emoji);
  //   newCardList.add(cardB);
  // });
  // return newCardList;

  return cardList.followedBy(cardList.map((card) => CardModel(emoji: card.emoji))).toList();
}