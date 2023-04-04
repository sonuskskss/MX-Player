//import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mx_player/main.dart';

class PlayerController extends GetxController {
  final audioQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();
  var duration = ''.obs;
  var position = ''.obs;
  var playIndex = 0.obs;
  var isPlaying = false.obs;
  var max = 0.0.obs;
  var value = 0.0.obs;

  void onInit() {
    super.onInit();
    checkPermission();
  }

  updatePosition() {
    audioPlayer.durationStream.listen((d) {
      duration.value = d.toString().split(".")[0];

      max.value = d!.inSeconds.toDouble();
    });

    audioPlayer.positionStream.listen((p) {
      position.value = p.toString().split(".")[0];
      value.value = p.inSeconds.toDouble();
    });
  }

  changeDurationToSecond(seconds) {
    var duration = Duration(seconds: seconds);

    audioPlayer.seek(duration);
  }

  playSong(String? uri, index) {
    playIndex.value = index;

    try {
      audioPlayer.setAudioSource(
        AudioSource.uri(Uri.parse(uri!)),
      );
      audioPlayer.play();
      isPlaying(true);
      updatePosition();
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  checkPermission() async {
    var perm = await Permission.storage.request();

    if (perm.isGranted) {
    } else {
      checkPermission();
    }
  }
}


//  return audioQuery.querySongs(
//         ignoreCase: true,
//         orderType: OrderType.ASC_OR_SMALLER,
//         sortType: null,
//         uriType: UriType.EXTERNAL,