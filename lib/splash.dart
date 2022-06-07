import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:music_application_1/screenhome.dart';



class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    gotologin();
    // TODO: implement initState
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      
      body:
      
       Container(
         height: double.infinity,
        width: double.infinity,
         child: Column(
          
          
          children: [
            SizedBox(
              height: 80,
            ),
           
             Container(
              
              child: TextLiquidFill(
             
                boxHeight: 80,
                text: 'MuZ Flix',
                waveColor: Color.fromARGB(255, 241, 237, 237),
                textStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ),

            SizedBox(
              height: 50,
            ),
            Container(
              child: Image.asset(
                'assets/muzflix (1024 × 1024 px) (2).png',
                width: 300,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                  height: 100,
                      width: 180,
                      child: Lottie.asset('assets/106903-red-sound-wave.json',
                          width: double.infinity, height:double.infinity, fit: BoxFit.cover),

              ),
            ),
           
          ],
      ),
       ),
    );
  }

  Future<void> gotologin() async {
    await Future.delayed(Duration(seconds:6));
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) {
      return screenhome();
    }));
  }
}
