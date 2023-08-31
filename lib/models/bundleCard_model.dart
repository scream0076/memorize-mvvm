// ignore: file_names
import 'package:flutter/material.dart';
import 'package:memorize_mvvm/models/card_model.dart';

class BundleCardModel {
  final String name;
  final String emoji;
  final List<CardModel> cardObject;
  final List<Color> gradientColor;
  final Color color;

  const BundleCardModel({
    required this.name, 
    required this.emoji, 
    required this.cardObject, 
    required this.gradientColor, 
    required this.color
  });
}