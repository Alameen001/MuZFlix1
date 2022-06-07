import 'package:flutter/material.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';

final OnAudioQuery audioQuery = OnAudioQuery();

// final OnAudioRoom _audioRoom = OnAudioRoom();

void dialogBox(
  BuildContext context,
  List<SongModel> allsongs,
  OnAudioRoom _audioRoom,
  int songIndex,
) {
  // List<SongModel> songmodel = [];
  // _audioQuery.querySongs().then((value) {
  //   songmodel = value;
  // });
  showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(builder: (context, setState) {
            return SimpleDialog(
              children: [
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context);
                    createPlaylist(ctx, setState, _audioRoom);
                  },
                  child: Text('New Playlist'),
                ),
                SimpleDialogOption(
                    child: SizedBox(
                  height: 120,
                  width: 200,
                  child: FutureBuilder<List<PlaylistEntity>>(
                      future: _audioRoom.queryPlaylists(),
                      builder: (context, item) {
                        //final x = item.data[0].id
                        if (item.data == null || item.data!.isEmpty)
                          return Center(
                            child: Text('Nothing Found'),
                          );

                        return ListView.separated(
                          shrinkWrap: true,
                          itemCount: item.data!.length,
                          itemBuilder: (ctx, index) => ListTile(
                              onTap: () {
                                _audioRoom.addTo(RoomType.PLAYLIST,
                                    allsongs[songIndex].getMap.toSongEntity(),
                                    playlistKey: item.data![index].key,
                                    ignoreDuplicate: false);
                                final snackBar = SnackBar(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  backgroundColor: Colors.red,
                                  content: const Text(
                                    ' Added to Playlist',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                Navigator.pop(ctx);
                              },
                              title: Text(
                                item.data![index].playlistName,
                              )),
                          separatorBuilder: (ctx, index) => SizedBox(
                            height: 5,
                          ),
                        );
                      }),
                ))
              ],
            );
          }));
}

void createPlaylist(
  BuildContext ctx,
  void Function(void Function()) setState,
  OnAudioRoom audioRoom,
) {
  final playlistNameController = TextEditingController();
  showDialog(
      barrierDismissible: false,
      context: ctx,
      builder: (ctx1) => AlertDialog(
            content: TextField(
                controller: playlistNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  //filled: true,
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  hintText: 'Playlist Name',
                )),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    createNewPlaylist(playlistNameController.text, audioRoom);
                    setState(() {});
                    Navigator.pop(ctx);
                    // dialogBox(context);
                  },
                  child: Text('Ok'))
            ],
          ));
}

void createPlaylistFrom(
  BuildContext ctx,
  VoidCallback refresh,
  // TextEditingController playlistNameController,
  OnAudioRoom audioRoom,
) {
  final playlistNameController = TextEditingController();

  showDialog(
      barrierDismissible: false,
      context: ctx,
      builder: (ctx1) => AlertDialog(
            content: TextField(
                controller: playlistNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  //filled: true,
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  hintText: 'Playlist Name',
                )),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    // audioRoom.createPlaylist(playlistNameController.text);
                    createNewPlaylist(playlistNameController.text, audioRoom);
                    refresh();
                    Navigator.pop(ctx);
                    // dialogBox(context);
                  },
                  child: Text('Ok'))
            ],
          ));
}

void createNewPlaylist(String name, OnAudioRoom audioRoom) {
  if (name.isEmpty && name == '') {
    print(".......................Alalalaallaalalal.....");
    SnackBar(
      content: Text('Name Something'),
      action: SnackBarAction(label: ('Type Something'), onPressed: () {}),
    );
  } else {
    audioRoom.createPlaylist(name);
    print('Creeeeeeeeeeated');
  }
}
