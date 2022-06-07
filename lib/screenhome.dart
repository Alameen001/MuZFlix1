import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';


import 'package:music_application_1/miniplayer.dart';
import 'package:music_application_1/screens/favorites/favorites.dart';
import 'package:music_application_1/screens/musics/mymusic.dart';
import 'package:music_application_1/screens/playlist/playlist.dart';
import 'package:music_application_1/screens/settings/settings.dart';

class screenhome extends StatefulWidget {
  screenhome({Key? key}) : super(key: key);

  @override
  State<screenhome> createState() => _screenhomeState();
}

class _screenhomeState extends State<screenhome> {
  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  int _currentselectedindex = 0;

  final _pages = [
    musicscreen(),
    favoritescreen(),
    playlistscreen(),
    Settingsscreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        color: const Color.fromARGB(146, 241, 234, 234),
        backgroundColor: Colors.black,
        buttonBackgroundColor: Color.fromARGB(255, 158, 158, 158),
        animationDuration: Duration(microseconds: 300),
        animationCurve: Curves.bounceInOut,
        items: const [
          Icon(
            Icons.headphones,
          ),
          Icon(
            Icons.favorite,
          ),
          Icon(Icons.playlist_play),
          Icon(Icons.settings),
        ],
        onTap: (newindex) {
          setState(() {
            _currentselectedindex = newindex;
          });
        },
      ),
      body: _pages[_currentselectedindex],
      bottomSheet: const MiniPlayer(),
    );
  }
}
