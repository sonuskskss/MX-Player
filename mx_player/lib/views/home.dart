import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mx_player/controller/player_controller.dart';
import 'package:mx_player/views/player.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:audioplayers/audioplayers.dart';

import '../consts/text_style.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ))
        ],
        leading: Icon(Icons.play_circle, size: 45, color: Colors.white),
        title: Text(
          'MX Playre',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      //<List<SongModel>>
      body: FutureBuilder<List<SongModel>>(
          future: controller.audioQuery.querySongs(
            ignoreCase: true,
            orderType: OrderType.ASC_OR_SMALLER,
            sortType: null,
            uriType: UriType.EXTERNAL,
          ),
          builder: (BuildContext context, snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data!.isEmpty) {
              print(snapshot.data);
              return Center(
                child: Text(
                  'No song found',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              );
            } else {
              //  print(snapshot.data);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, int index) {
                      return Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          child: Obx(
                            () => ListTile(
                              shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.circular(11)),
                              tileColor: Colors.white10,
                              title: Text(
                                "{$snapshot.data![index].displayNameWOExt}",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                              subtitle: Text('${snapshot.data![index].artist}',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white)),
                              leading: QueryArtworkWidget(
                                id: snapshot.data![index].id,
                                type: ArtworkType.AUDIO,
                                nullArtworkWidget: const Icon(
                                  Icons.music_note,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              trailing: controller.playIndex.value == index &&
                                      controller.isPlaying.value
                                  ? Icon(
                                      Icons.play_arrow,
                                      size: 25,
                                      color: Colors.white,
                                    )
                                  : null,
                              onTap: () {
                                //   controller.playSong(snapshot.data![index].uri, index);

                                Get.to(() =>   Player(data: snapshot.data!,
                                ),
                                transition:Transition.downToUp,
                                
                                );
                                 controller.playSong(snapshot.data![index].uri, index);

                              },
                            ),
                          ));
                    }),
              );
            }
          }),
    );
  }
}










//  FutureBuilder<List<SongModel>>  FutureBuilder (
//             future: controller.audioQuery.querySongs(
//                 ignoreCase: true,
//                 orderType: OrderType.ASC_OR_SMALLER,
//                 sortType: null,
//                  uriType: UriType.EXTERNAL,

//                 builder: (BuildContext, context, snapshot) {
//                   if (snapshot.Data == null) {
//                     return Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   } else if (snapshot.data!.isEmty) {
//                     return Center(
//                       child: Text('No song found', style: TextStyle(fontSize: 15, color:Colors.white),),
//                     );
//                   } else {
//                     print(snapshot.data);
//                     return 

//  Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: ListView.builder(
//               physics: BouncingScrollPhysics(),
//               itemCount: 44,
//               itemBuilder: ( context, int index) {
//                 return Container(
//                     margin: const EdgeInsets.only(bottom: 5),
//                     child: ListTile(
//                       shape: BeveledRectangleBorder(
//                           borderRadius: BorderRadius.circular(11)),
//                       tileColor: Colors.white10,
//                       title: Text(
//                         'Music Name',
//                         style: TextStyle(fontSize: 15, color: Colors.white),
//                       ),
//                       subtitle: Text('Artist name',
//                           style: TextStyle(fontSize: 12, color: Colors.white)),
//                       leading:
//                           Icon(Icons.music_note, size: 30, color: Colors.white),
//                       trailing: Icon(
//                         Icons.play_arrow,
//                         size: 25,
//                         color: Colors.white,
//                       ),
//                     ));
//               }),
//         );
//                   }
//                 }),),




















//  Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: ListView.builder(
//               physics: BouncingScrollPhysics(),
//               itemCount: 44,
//               itemBuilder: (BuildContext context, int index) {
//                 return Container(
//                     margin: const EdgeInsets.only(bottom: 5),
//                     child: ListTile(
//                       shape: BeveledRectangleBorder(
//                           borderRadius: BorderRadius.circular(11)),
//                       tileColor: Colors.white10,
//                       title: Text(
//                         'Music Name',
//                         style: TextStyle(fontSize: 15, color: Colors.white),
//                       ),
//                       subtitle: Text('Artist name',
//                           style: TextStyle(fontSize: 12, color: Colors.white)),
//                       leading:
//                           Icon(Icons.music_note, size: 30, color: Colors.white),
//                       trailing: Icon(
//                         Icons.play_arrow,
//                         size: 25,
//                         color: Colors.white,
//                       ),
//                     ));
//               }),
//         )









