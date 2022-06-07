import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_application_1/screens/nowplaying.dart';
import 'package:music_application_1/screens/playlist/playlist.dart';


import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';

class favoritescreen extends StatefulWidget {
  const favoritescreen({Key? key}) : super(key: key);

  @override
  State<favoritescreen> createState() => _favoritescreenState();
}

class _favoritescreenState extends State<favoritescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourites'),
        centerTitle: true,
        backgroundColor: Colors.black,
        // actions: [
        //   IconButton(
        //     onPressed: () async {
        //       await audioRoom.clearRoom(RoomType.FAVORITES);
        //       setState(() {});
        //     },
        //     icon: const Icon(Icons.delete_forever_rounded),
        //   )
        // ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black,
                Color.fromARGB(255, 158, 48, 48),
                Colors.black,
              ]),
        ),
        height: double.infinity,
        width: double.infinity,
        child: FutureBuilder<List<FavoritesEntity>>(
          future: OnAudioRoom().queryFavorites(
            limit: 50,
            reverse: false,
            sortType: null, //  Null will use the [key] has sort.
          ),
          builder: (context, item) {
            if (item.data == null || item.data!.isEmpty) {
              return Center(
                // child: Text(
                //   'Nothing Found',
                //   style: GoogleFonts.montserrat(color: Colors.white),
                // ),
                child: DefaultTextStyle(
                  style: TextStyle(fontSize: 16),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      WavyAnimatedText(
                        'Nothing Found',
                        textStyle: GoogleFonts.montserrat(color: Colors.white),
                      ),
                    ],
                    repeatForever: true,
                    isRepeatingAnimation: true,
                  ),
                ),
              );
            }

            List<FavoritesEntity> favorites = item.data!;
            List<Audio> favSongs = [];

            for (var songs in favorites) {
              favSongs.add(Audio.file(songs.lastData,
                  metas: Metas(
                      title: songs.title,
                      artist: songs.artist,
                      id: songs.id.toString())));
            }

            return Padding(
              padding: const EdgeInsets.only(top: 30),
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, bottom: 8, top: 8),
                    child: Divider(
                      thickness: 3.0,
                    ),
                  );
                },
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    endActionPane:
                        ActionPane(motion: ScrollMotion(), children: [
                      SlidableAction(
                        onPressed: (context) async {
                          await audioRoom.deleteFrom(
                            RoomType.FAVORITES,
                            favorites[index].key,
                          );
                          setState(() {});
                        },
                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      )
                    ]),
                    child: ListTile(
                      onTap: () async {
                        await player.open(
                          Playlist(audios: favSongs, startIndex: index),
                          showNotification: true,
                          loopMode: LoopMode.playlist,
                          notificationSettings: const NotificationSettings(
                            stopEnabled: false,
                          ),
                        );
                      },
                      title: Text(
                        favorites[index].title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color.fromARGB(255, 202, 197, 197),
                        ),
                      ),
                      leading: QueryArtworkWidget(
                        id: favorites[index].id,
                        type: ArtworkType.AUDIO,
                        nullArtworkWidget: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(300),
                          ),
                          child: Image.asset(
                            'assets/hedphone.jpeg',
                            fit: BoxFit.cover,
                            width: 60,
                            height: 60,
                          ),
                        ),
                      ),
                    ),
                  );

                  // return ListTile(

                  //   title: Text(favorites[index].title),
                  //   subtitle: Text(favorites[index].dateAdded.toString()),
                  //   // onTap: () async {

                  //   //   //  Most the method will return a bool to indicate if method works.
                  //   //   await audioRoomone.deleteFrom(
                  //   //     RoomType.FAVORITES,
                  //   //     favorites[index].key,
                  //   //   );
                  //   //   //  Call setState to see the result,
                  //   //   setState(() {});
                  //   // },
                  // );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
