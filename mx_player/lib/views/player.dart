import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mx_player/controller/player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Player extends StatelessWidget {
  final List<SongModel> data;
  const Player({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PlayerController>();

    return Scaffold(
        backgroundColor: Colors.black26,
        appBar: AppBar(),
        body: Column(
          children: [
            Obx(
              ()=> Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                    height: 350,
                    width: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.red,
                    ),
                    alignment: Alignment.center,
                    child: QueryArtworkWidget(
                      id: data[controller.playIndex.value].id,
                      type: ArtworkType.AUDIO,
                      artworkHeight: double.infinity,
                      artworkWidth: double.infinity,
                      nullArtworkWidget: const Icon(
                        Icons.music_note,
                        size: 40,
                        color: Colors.white,
                      ),
                    )),
              )),
            ),
            SizedBox(
              height: 1,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: Colors.yellow,
                    child: Obx(
                      ()=> Column(children: [
                        Text(
                          data[controller.playIndex.value].displayNameWOExt,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          data[controller.playIndex.value].artist.toString(),
                            textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Obx(
                          () => Row(
                            children: [
                              Text(
                                controller.position.value,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.white,
                                ),
                              ),
                              Expanded(
                                child: Slider(
                                    thumbColor: Colors.green,
                                    activeColor: Colors.red,
                                    inactiveColor: Colors.purple,
                                    min: const Duration(seconds: 0)
                                        .inSeconds
                                        .toDouble(),
                                    max: controller.max.value,
                                    value: controller.value.value,
                                    onChanged: (newValue) {
                                      controller.changeDurationToSecond(
                                          newValue.toInt());
                                      newValue = newValue;
                                    }),
                              ),
                              Text(
                                controller.duration.value,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    controller.playSong(
                                        data[controller.playIndex.value-1].uri,
                                        controller.playIndex.value - 1);
                                  },
                                  icon: Icon(
                                    Icons.skip_previous_rounded,
                                    size: 20,
                                    color: Colors.red,
                                  )),
                              Obx(
                                () => CircleAvatar(
                                  radius: 35,
                                  backgroundColor: Colors.red,
                                  child: Transform.scale(
                                    scale: 2.5,
                                    child: IconButton(
                                        onPressed: () {
                                          if (controller.isPlaying.value) {
                                            controller.audioPlayer.pause();
                                            controller.isPlaying(false);
                                          } else {
                                            controller.audioPlayer.play();
                                            controller.isPlaying(true);
                                          }
                                        },
                                        icon: controller.isPlaying.value
                                            ? const Icon(
                                                Icons.pause,
                                                size: 30,
                                                color: Colors.white,
                                              )
                                            : const Icon(Icons.play_arrow_rounded,
                                                color: Colors.white)),
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    controller.playSong(
                                        data[controller.playIndex.value].uri,
                                        controller.playIndex.value + 1);
                                  },
                                  icon: Icon(
                                    Icons.skip_next_rounded,
                                    size: 20,
                                    color: Colors.red,
                                  )),
                            ]),
                      ]),
                    )),
              ),
            ),
          ],
        ));
  }
}
