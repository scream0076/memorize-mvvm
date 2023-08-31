import 'package:flutter/material.dart';// ignore: file_names
import 'package:memorize_mvvm/data/card_data.dart';
import 'package:memorize_mvvm/models/bundleCard_model.dart';

final bundleCard = [
  BundleCardModel(
    name: 'Emoji', 
    emoji: '😀',
    cardObject: emojiCardList..shuffle(),
    gradientColor: [const Color(0xFFFF4E50), const Color(0xFFF9D423)],
    color: const Color(0xFFF9D423)
  ),
  BundleCardModel(
    name: 'Animal', 
    emoji: '🐷',
    cardObject: animalCardList..shuffle(),
    gradientColor: [const Color(0xFFff9966), const Color(0xFFff5e62)],
    color: const Color(0xFFff5e62)
  ),
  BundleCardModel(
    name: 'Fruit', 
    emoji: '🍉',
    cardObject: fruitCardList..shuffle(),
    gradientColor: [const Color(0xFF00b09b), const Color(0xFF96c93d)],
    color: const Color(0xFF00b09b)
  ),
  BundleCardModel(
    name: 'Sport', 
    emoji: '🪀',
    cardObject: sportCardList..shuffle(),
    gradientColor: [const Color(0xFFF3904F), const Color(0xFF3B4371)],
    color: const Color(0xFFF3904F)
  ),
  BundleCardModel(
    name: 'Food', 
    emoji: '🥩',
    cardObject: foodCardList..shuffle(),
    gradientColor: [const Color(0xFF348F50), const Color(0xFF56B4D3)],
    color: const Color(0xFF56B4D3)
  ),
];