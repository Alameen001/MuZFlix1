import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:music_application_1/splash.dart';
import 'package:on_audio_room/on_audio_room.dart';
import 'package:permission_handler/permission_handler.dart';

void main(List<String> args) {
  
    OnAudioRoom().initRoom();


    //----screen orriantaion----//
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);


  runApp(const MyApp(),);
}

//------useless-----//

void permission(){
  Permission.storage.request();
  
  }


class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
   permission();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'login Sample',
      theme: ThemeData(
          primaryColor: Color(0xFF070A0A),
      ),
      home: Splashscreen(),
    );
  }
}