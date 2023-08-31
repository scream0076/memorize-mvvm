import 'dart:async';
import 'dart:math';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:memorize_mvvm/baseViewModel.dart';
import 'package:memorize_mvvm/data/bundleCard_data.dart';
import 'package:memorize_mvvm/models/bundleCard_model.dart';

randomBundleCard() {
  int cardBundleRandom = Random().nextInt(bundleCard.length);
  BundleCardModel selectedBundleCard = bundleCard[cardBundleRandom];
  return selectedBundleCard;
}

class MemorizeViewModel extends BaseViewModel implements MemorizeInputs, MemorizeOutputs {
  final _cardViewController = StreamController<BundleCardModel>();
  final _score = StreamController<int>();

  int score = 0;
  bool isFlipping = false;
  int matchCorrect = 0;
  List<int> countInCorrect = [];
  List<int> countCorrect = [];
  List<IsCardSelected> isCardSelected = [];

  @override
  void start() {
    _postDataToView();
  }

  @override
  void dispose() {
    _cardViewController.close();
    _score.close();
  }
  
  @override
  void onTapp(int index, BundleCardModel bundleCardViewModel, BuildContext context) {
    if (!isFlipping && !bundleCardViewModel.cardObject[index].isSelected) {
      bundleCardViewModel.cardObject[index].isSelected = true;
      inputBundleCardModel.add(bundleCardViewModel);
      isCardSelected.add(
        IsCardSelected(
          cardIndex: index,
          cardEmoji: bundleCardViewModel.cardObject[index].emoji
      ));
    }
    if (isCardSelected.length >= 2) {
      isFlipping = true;

      if (isCardSelected[0].cardEmoji == isCardSelected[1].cardEmoji) {
        Future.delayed(const Duration(seconds: 1), () {
          inputScore.add(score += 2);
          matchCorrect++;
          isFlipping = false;
          // ignore: avoid_function_literals_in_foreach_calls
          isCardSelected.forEach((selectedCard) {
            countCorrect.add(selectedCard.cardIndex);
            inputBundleCardModel.add(bundleCardViewModel);
          });
          
          isCardSelected = [];

          if (matchCorrect == bundleCardViewModel.cardObject.length ~/ 2) {
            _showGameOverDialog(context, bundleCardViewModel);
          }
        });
      } else {
        Future.delayed(const Duration(seconds: 1), () {
          // ignore: avoid_function_literals_in_foreach_calls
          isCardSelected.forEach((selectedCard) {
            bundleCardViewModel.cardObject[selectedCard.cardIndex].isSelected = false;
            inputBundleCardModel.add(bundleCardViewModel);

            if (countInCorrect.contains(selectedCard.cardIndex)) {
              if (score != 0) {
                inputScore.add(score -= 1);
              }
            }

            countInCorrect.add(selectedCard.cardIndex);                
          });

          isFlipping = false;
          isCardSelected = [];
        });
      }
    }
  }

  @override
  void onNewGameTap(BundleCardModel bundleCardViewModel) {
    _newGame(bundleCardViewModel);
  }

  @override
  void onRestartGameTap(BundleCardModel bundleCardViewModel) {
    _restartGame(bundleCardViewModel);
  }

  _postDataToView() {
    inputBundleCardModel.add(randomBundleCard());
  }

  _showGameOverDialog(context, BundleCardModel bundleCardViewModel) {
    AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.success,
      body: Center(child: Text('Finish! | Your score : $score'),),
      btnOkOnPress: () {
        _newGame(bundleCardViewModel);
      },
    ).show();
  }

  void _newGame(BundleCardModel bundleCardViewModel) {
    bundleCardViewModel.cardObject.shuffle();
    bundleCardViewModel = randomBundleCard();
    isFlipping = false;
    isCardSelected.clear();
    countInCorrect.clear();
    score = 0;
    matchCorrect = 0;
    countCorrect = [];
    // ignore: avoid_function_literals_in_foreach_calls
    bundleCardViewModel.cardObject.forEach((selectedCard) {
      selectedCard.isSelected = false;
    });

    inputBundleCardModel.add(bundleCardViewModel);
    inputScore.add(score);
  }

  void _restartGame(BundleCardModel bundleCardViewModel) {
    bundleCardViewModel.cardObject.shuffle();
    isFlipping = false;
    isCardSelected.clear();
    countInCorrect.clear();
    score = 0;
    matchCorrect = 0;
    countCorrect = [];
    // ignore: avoid_function_literals_in_foreach_calls
    bundleCardViewModel.cardObject.forEach((selectedCard) {
      selectedCard.isSelected = false;
    });

    inputBundleCardModel.add(bundleCardViewModel);
    inputScore.add(score);
  }
  
  @override
  Sink get inputBundleCardModel => _cardViewController.sink;

  @override
  Stream<BundleCardModel> get outputBundleCardModel {
    return _cardViewController.stream.map((bundleCardViewModel) {
      return bundleCardViewModel;
    });
  }
  
  @override
  Sink get inputScore => _score.sink;
  
  @override
  Stream<int> get outputScore => _score.stream;
}

abstract class MemorizeInputs {
  void onTapp(int index, BundleCardModel bundleCardViewModel, BuildContext context);
  void onNewGameTap(BundleCardModel bundleCardViewModel);
  void onRestartGameTap(BundleCardModel bundleCardViewModel);

  Sink get inputBundleCardModel;
  Sink get inputScore;
}

abstract class MemorizeOutputs {
  Stream<BundleCardModel> get outputBundleCardModel;
  Stream<int> get outputScore;
}

class IsCardSelected {
  final int cardIndex;
  final String cardEmoji;
  
  IsCardSelected({required this.cardIndex, required this.cardEmoji});
}