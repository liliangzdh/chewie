import 'dart:ui';

import 'package:chewie/src/chewie_player.dart';
import 'package:chewie/src/cupertino_controls.dart';
import 'package:chewie/src/material_controls.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayerWithControls extends StatelessWidget {
  PlayerWithControls({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChewieController chewieController = ChewieController.of(context);

    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: AspectRatio(
          aspectRatio:
              chewieController.aspectRatio ?? _calculateAspectRatio(context),
          child: _buildPlayerWithControls(chewieController, context),
        ),
      ),
    );
  }

  Container _buildPlayerWithControls(
      ChewieController chewieController, BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          chewieController.placeholder ?? Container(),
          Center(
            child: Hero(
              tag: chewieController.videoPlayerController,
              child: AspectRatio(
                aspectRatio: chewieController.aspectRatio ??
                    _calculateAspectRatio(context),
                child: VideoPlayer(chewieController.videoPlayerController),
              ),
            ),
          ),
          chewieController.overlay ?? Container(),
          _buildControls(context, chewieController),
//          _buildHeader(context,"assa"),
        ],
      ),
    );
  }

//  final barHeight = 48.0;
//  final lightColor = Color.fromRGBO(255, 255, 255, 0.85);
//  final darkColor = Color.fromRGBO(1, 1, 1, 0.35);
//
//  AnimatedOpacity _buildHeader(BuildContext context, String title) {
//    return AnimatedOpacity(
//      opacity: _hideStuff ? 0.0 : 1.0,
//      opacity: 1.0,
//      duration: Duration(milliseconds: 300),
//      child: Container(
//        color: Colors.black.withOpacity(0.5),
//        height: barHeight,
//        child: Row(
//          crossAxisAlignment: CrossAxisAlignment.center,
//          children: <Widget>[
//            IconButton(
//              onPressed: () {},
//              color: lightColor,
//              icon: Icon(Icons.chevron_left),
//            ),
//            Text(
//              '返回',
//              style: TextStyle(
//                color: lightColor,
//                fontSize: 18.0,
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }

  Widget _buildControls(
    BuildContext context,
    ChewieController chewieController,
  ) {
    return chewieController.showControls
        ? chewieController.customControls != null
            ? chewieController.customControls
            : Theme.of(context).platform == TargetPlatform.android
                ? (chewieController.androidUiType == UiType.CupertinoUI
                    ? CupertinoControls(
                        backgroundColor: Color.fromRGBO(41, 41, 41, 0.7),
                        iconColor: Color.fromARGB(255, 200, 200, 200),
                      )
                    : MaterialControls())
                : (chewieController.iosUiType == UiType.MaterialUI
                    ? MaterialControls()
                    : CupertinoControls(
                        backgroundColor: Color.fromRGBO(41, 41, 41, 0.7),
                        iconColor: Color.fromARGB(255, 200, 200, 200),
                      ))
        : Container();
  }

  double _calculateAspectRatio(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return width > height ? width / height : height / width;
  }
}
