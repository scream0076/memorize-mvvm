import 'package:flutter/material.dart';
import 'package:memorize_mvvm/banner/emoji_banner.dart';
import 'package:memorize_mvvm/button/newGame_button.dart';
import 'package:memorize_mvvm/button/restartGame_button.dart';
import 'package:memorize_mvvm/models/bundleCard_model.dart';
import 'package:memorize_mvvm/vm_memorize.dart';

class MemorizeView extends StatefulWidget {
  const MemorizeView({super.key});

  @override
  State<MemorizeView> createState() {
    return _MemorizeViewState();
  }
}

class _MemorizeViewState extends State<MemorizeView> {
  final MemorizeViewModel _viewModel = MemorizeViewModel();

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(context) {
    return StreamBuilder<BundleCardModel>(
      stream: _viewModel.outputBundleCardModel,
      builder: (context, snapshot) {
        return _getContentWidget(snapshot.data);
      },
    );
  }

  Widget _getContentWidget(BundleCardModel? bundleCardViewModel) {
    if(bundleCardViewModel == null) {
      return Container();
    } else {
      return Scaffold(
        backgroundColor: const Color(0xFF212121),
        body: Column(
          children: [
            EmojiBanner(gradientColor: bundleCardViewModel.gradientColor),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(flex: 1, child: NewGameButton(newGame: () {
                    _viewModel.onNewGameTap(bundleCardViewModel);
                  })),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(bundleCardViewModel.emoji,
                            style: const TextStyle(color: Colors.white)
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text('S C O R E  |  ',
                            style: TextStyle(color: Colors.white)
                        ),
                        StreamBuilder<int>(
                          stream: _viewModel.outputScore,
                          builder: (context, snapshot) {
                            return Text(snapshot.hasData
                              ? snapshot.data.toString()
                              : _viewModel.score.toString(),
                              style: const TextStyle(color: Colors.red)
                            );
                          },
                        ),
                      ]
                    )
                  ),
                ],
              ),
            ),
            const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: GridView.builder(
                itemCount: bundleCardViewModel.cardObject.length,
                itemBuilder: (ctx, index) {
                  if (_viewModel.countCorrect.contains(index)) {
                    return Container();
                  }
                  return _onCardView(bundleCardViewModel, index);
                },
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 0.8,
                  mainAxisSpacing: 8,
                ),
              ),
            ),
          ),
          ],
        ),
        floatingActionButton: RestartGameButton(restart: () {
          _viewModel.onRestartGameTap(bundleCardViewModel);
        }),
      );
    }
  }

  Widget _onCardView(BundleCardModel? bundleCardViewModel, int index) {
    return Center(
      child: GestureDetector(
        onTap: () {
          _viewModel.onTapp(index, bundleCardViewModel, context);
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: bundleCardViewModel!.cardObject[index].isSelected
                ? bundleCardViewModel.gradientColor
                : [
                    const Color(0xFF212121),
                    const Color(0xFF212121)
                  ]
            ),
            borderRadius:
                const BorderRadius.all(Radius.circular(5)),
            boxShadow: [
              BoxShadow(
                color: bundleCardViewModel.color.withOpacity(0.7),
                spreadRadius: 1,
                blurRadius: 15
              ),
            ],
          ),
          margin: const EdgeInsets.all(5),
          child: bundleCardViewModel.cardObject[index].isSelected
            ? Text(
                bundleCardViewModel.cardObject[index].emoji,
                style: const TextStyle(
                  fontSize: 20, color: Colors.black),
              )
            : const Text(
                '',
                style:
                  TextStyle(fontSize: 20, color: Colors.white),
              ),
        ),
      )
    );
  }
}