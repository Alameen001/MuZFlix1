import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';

import 'package:music_application_1/screens/musics/mymusic.dart';
import 'package:on_audio_query/on_audio_query.dart';

class NowPlaying extends StatefulWidget {
  const NowPlaying({
    Key? key,
  }) : super(key: key);

  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');

class _NowPlayingState extends State<NowPlaying>
    with SingleTickerProviderStateMixin {
  // bool _isPLaying = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: const BoxDecoration(
      //               gradient: LinearGradient(
      //                   begin: Alignment.topCenter,
      //                   end: Alignment.bottomCenter,
      //                   colors: [
      //                     Color.fromARGB(255, 18, 33, 19),
      //                     Colors.black
      //                   ]),
      //             ),
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(
              'Now Playing',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.white,
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_drop_down))
            ],
            centerTitle: true,
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
            child: player.builderCurrent(
              builder: (context, playing) {
                return Builder(builder: (context) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 30,
                        width: 300,
                        child: Marquee(
                          velocity: 20,
                          blankSpace: 50,
                          text: '${playing.playlist.current.metas.title}',
                          //textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      SizedBox(
                        height: 30,
                        width: 150,
                        child: Marquee(
                          blankSpace: 10,
                          velocity: 20,
                          text: '${playing.playlist.current.metas.artist}',
                          //textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 245, 243, 243),
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, left: 43, right: 42, bottom: 20),
                        child: Container(
                          height: 340,
                          width: 400,
                          child: QueryArtworkWidget(
                            artworkBorder: BorderRadius.circular(20),
                            artworkFit: BoxFit.cover,
                            artworkQuality: FilterQuality.high,
                            quality: 100,
                            nullArtworkWidget: ClipRRect(
                              child: Image.asset(
                                "assets/hedphone.jpeg",
                                fit: BoxFit.cover,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                            ),

                            // size: 300,
                            id: int.parse(playing.audio.audio.metas.id!),
                            type: ArtworkType.AUDIO,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                        child: seekBarWidget(context),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Wrap(
                              alignment: WrapAlignment.center,
                              children: [
                                //  previous
                               
                                IconButton(
                                  onPressed: playing.index != 0
                                      ? () {
                                          player.previous();
                                        }
                                      : () {},
                                  icon: playing.index == 0
                                      ? const Icon(
                                          Icons.skip_previous_sharp,
                                          size: 42,
                                          color: Color.fromARGB(
                                              255, 190, 190, 190),
                                        )
                                      : const Icon(
                                          Icons.skip_previous_sharp,
                                          size: 42,
                                          color: Colors.white,
                                        ),
                                ),

                               
                                SizedBox(
                                  width: 10,
                                ),

                                // play pause
                                PlayerBuilder.isPlaying(
                                  player: player,
                                  builder: (context, isPlaying) {
                                    return IconButton(
                                      icon: Icon(
                                        isPlaying
                                            ? Icons.pause_circle
                                            : Icons.play_circle,
                                        size: 50,
                                      ),
                                      onPressed: () {
                                        player.playOrPause();
                                      },
                                      color: Colors.white,
                                    );
                                  },
                                ),
                                SizedBox(
                                  width: 15,
                                ),

                                IconButton(
                                  onPressed:
                                      playing.index == allSongs.length - 1
                                          ? () {}
                                          : () {
                                              player.next();
                                            },
                                  icon: playing.index == allSongs.length - 1
                                      ? Icon(
                                          Icons.skip_next_sharp,
                                          size: 40,
                                          color: Color.fromARGB(
                                              255, 190, 190, 190),
                                        )
                                      : const Icon(Icons.skip_next_sharp,
                                          size: 40, color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                });
              },
            ),
          )),
    );
  }

  Widget seekBarWidget(BuildContext ctx) {
    return player.builderRealtimePlayingInfos(
      builder: (ctx, infos) {
        Duration currentPosition = infos.currentPosition;
        Duration total = infos.duration;
        return Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: ProgressBar(
              progress: currentPosition,
              total: total,
              onSeek: (to) {
                player.seek(to);
              },
              timeLabelTextStyle: const TextStyle(color: Colors.white),
              baseBarColor: Colors.black,
              progressBarColor: Colors.white,
              // bufferedBarColor: Colors.red,
              thumbColor: Colors.white),
        );
      },
    );
  }
}
