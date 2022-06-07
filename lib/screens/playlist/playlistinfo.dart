import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:music_application_1/miniplayer.dart';
import 'package:music_application_1/screens/musics/mymusic.dart';
import 'package:music_application_1/screens/nowplaying.dart';
import 'package:music_application_1/screens/playlist/playlist.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';

class PlaylistInfo extends StatefulWidget {
  int playlistKey;
  List<SongEntity> songs;
  String title;
  PlaylistInfo(
      {Key? key,
      required this.title,
      required this.songs,
      required this.playlistKey})
      : super(key: key);

  @override
  State<PlaylistInfo> createState() => _PlaylistInfoState();
}

class _PlaylistInfoState extends State<PlaylistInfo> {
 
  @override
  Widget build(BuildContext context) {
    List<Audio> songs = [];
    for (var song in allSongs) {
      songs.add(
        Audio.file(
          song.uri.toString(),
          metas: Metas(
            title: song.title,
            artist: song.artist,
            id: song.id.toString(),
          ),
        ),
      );
    }
    List<Audio> playlistSong = [];
    for (var song in widget.songs) {
      playlistSong.add(Audio.file(song.lastData,
          metas: Metas(
              title: song.title, artist: song.artist, id: song.id.toString())));
    }
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        title: Text(
          widget.title,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.white,
          ),
        ),
    
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
            ],
          ),
        ),
        height: double.infinity,
        width: double.infinity,
        child: playlistSong.isEmpty
            ?  Center(
                //  child: Text('Nothing Found'),
                 child: DefaultTextStyle(style: TextStyle(fontSize: 16), child:  AnimatedTextKit(
            animatedTexts: [
              WavyAnimatedText('Nothing Found', textStyle: GoogleFonts.montserrat(color: Colors.white),),],
              
            
            repeatForever: true,
            isRepeatingAnimation: true,
          ),),
            
                
              )
            : Padding(
             padding: const EdgeInsets.only(top: 30),
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 8, top: 8),
                    child: Divider(thickness: 3,),
                  );
                },
                  itemBuilder: (ctx, index) => Slidable(
                    endActionPane: ActionPane(
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            setState(() {
                              audioRoom.deleteFrom(
                                  RoomType.PLAYLIST, widget.songs[index].id,
                                  playlistKey: widget.playlistKey);
                            });
                          },
                          backgroundColor: Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ],
                      motion: ScrollMotion(),
                    ),
                    child: ListTile(
                      onTap: () async {
                        await player.open(
                            Playlist(audios: playlistSong, startIndex: index),
                            showNotification: true,
                            loopMode: LoopMode.playlist,
                            notificationSettings:
                                const NotificationSettings(stopEnabled: false));
                      },
                      title: Text(
                        widget.songs[index].title,
                        style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color.fromARGB(255, 202, 197, 197),
                            ),
                      ),
                      // subtitle: Text(widget.songs[index].artist!),
                      leading: QueryArtworkWidget(
                        id: widget.songs[index].id,
                        type: ArtworkType.AUDIO,
                        nullArtworkWidget: ClipRRect(
                          child: Image.asset(
                            "assets/hedphone.jpeg",
                            fit: BoxFit.cover,
                            width: 40,
                            height: 40,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                    ),
                    //itemCount: widget.songs.length,
                  ),
                  itemCount: widget.songs.length,
                ),
            ),
      ),
      bottomSheet: MiniPlayer(),
    );
  }
}
