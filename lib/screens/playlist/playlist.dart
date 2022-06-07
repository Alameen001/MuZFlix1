import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_application_1/functions/functions.dart';
import 'package:music_application_1/screens/playlist/playlistinfo.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';

class playlistscreen extends StatefulWidget {
  playlistscreen({Key? key}) : super(key: key);

  @override
  State<playlistscreen> createState() => _playlistscreenState();
}

OnAudioRoom audioRoom = OnAudioRoom();

class _playlistscreenState extends State<playlistscreen> {
  @override
  Widget build(BuildContext context) {
    final OnAudioQuery audioQuery = OnAudioQuery();
    OnAudioRoom audioRoom = OnAudioRoom();

    TextEditingController playlistController = TextEditingController();

    //return Container();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        title: Text(
          'Playlists',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                createPlaylistFrom(context, () {
                  setState(() {});
                }, audioRoom);
                // _audioQuery.createPlaylist();
              },
              icon: Icon(Icons.playlist_add))
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black,
                Color.fromARGB(255, 158, 48, 48),
                Colors.black,
              ]),
          // borderRadius: BorderRadius.only(
          //     topLeft: Radius.circular(18), topRight: Radius.circular(18)),
          // color: Color.fromARGB(188, 182, 36, 111),
        ),
        height: double.infinity,
        width: double.infinity,
        child: FutureBuilder<List<PlaylistEntity>>(
          future: OnAudioRoom().queryPlaylists(),
          builder: (context, AsyncSnapshot<List<PlaylistEntity>> songs) {
            print('[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[');
            print(songs.data);

            if (songs.data == null || songs.data!.isEmpty) {
              return Center(
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

            return ListView.separated(
                itemBuilder: (ctx, index) => Slidable(
                      endActionPane: ActionPane(
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              dialog(
                                context,
                                songs.data![index].key,
                                songs.data![index].playlistName,
                                audioRoom,
                              );
                            },
                            backgroundColor: Color.fromARGB(255, 50, 63, 77),
                            foregroundColor: Colors.white,
                            icon: Icons.edit,
                            label: 'Edit',
                          ),
                          SlidableAction(
                            onPressed: (context) {
                              setState(() {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content: const Text(
                                        'Do you really want to delete?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('NO'),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            setState(() {
                                              audioRoom.deletePlaylist(
                                                  songs.data![index].key);
                                              Navigator.pop(context);
                                            });
                                          },
                                          child: const Text('YES')),
                                    ],
                                  ),
                                );
                                // _audioRoom.deletePlaylist(
                                //     item.data![index].key);
                              });
                            },
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                        motion: ScrollMotion(),
                      ),
                      child: ListTile(
                        onTap: () {
                          //final x = item.data[index].key;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => PlaylistInfo(
                                        title: songs.data![index].playlistName,
                                        songs: songs.data![index].playlistSongs,
                                        playlistKey: songs.data![index].key,
                                      )));
                        },
                        contentPadding: EdgeInsets.only(left: 30),
                        title: Text(
                          songs.data![index].playlistName,
                          style: GoogleFonts.montserrat(color: Colors.white),
                        ),
                        leading: Icon(
                          Icons.music_note,
                          color: Colors.white,
                        ),
                      ),
                    ),
                separatorBuilder: (ctx, index) => Divider(
                      thickness: 2,
                    ),
                itemCount: songs.data!.length);
          },
        ),
      ),
    );
  }

  void dialog(
    BuildContext context,
    int key,
    String playlistName,
    OnAudioRoom onAudioRoom,
  ) {
    var playlistNameController = TextEditingController();
    playlistNameController.text = playlistName;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (ctx1) => AlertDialog(
              content: TextField(
                  controller: playlistNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    //filled: true,

                    hintStyle: TextStyle(color: Colors.grey[600]),
                    hintText: playlistName,
                  )),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx1);
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        onAudioRoom.renamePlaylist(
                            key, playlistNameController.text);
                      });
                      Navigator.pop(ctx1);
                      //createNewPlaylist(playlistNameController.text);

                      // dialogBox(context);
                    },
                    child: Text('Ok'))
              ],
            ));
  }
}
