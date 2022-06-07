import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

class Settingsscreen extends StatelessWidget {
  const Settingsscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: const BoxDecoration(
          // borderRadius: BorderRadius.only(
          //     topLeft: Radius.circular(18), topRight: Radius.circular(18)),
          // color: Colors.grey[200],
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
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.share_outlined,
                  color: Color.fromARGB(255, 202, 197, 197),
                ),
                title: const Text(
                  'Share App',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color.fromARGB(255, 202, 197, 197),
                  ),
                ),
                onTap: () async {
                  await Share.share('https://www.instagram.com/ameen_aash/');
                },
              ),
              const ListTile(
                leading: Icon(
                  Icons.lock,
                  color: Color.fromARGB(255, 202, 197, 197),
                ),
                title: Text(
                  'Privacy policy',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color.fromARGB(255, 202, 197, 197),
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  aboutUs(context);
                },
                leading: const Icon(
                  Icons.person_outline_sharp,
                  color: Color.fromARGB(255, 202, 197, 197),
                ),
                title: const Text(
                  'About Me',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color.fromARGB(255, 202, 197, 197),
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return LicensePage(
                      
                        applicationIcon: Image.asset('assets/appstore.png'),
                        applicationName: 'MuZFlix',
                        applicationVersion:
                            "Version 1.0.0\n\nCopyright © 2022-2023",
                        applicationLegalese:
                            "Developed by Al Ameen Ahammed Kabeer ",
                      );
                    },
                  ));
                },
                leading: const Icon(
                  Icons.report_gmailerrorred_sharp,
                  color: Color.fromARGB(255, 202, 197, 197),
                ),
                title: const Text(
                  'License',
                  style: TextStyle(
                    
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color.fromARGB(255, 202, 197, 197),
                  ),
                ),
              ),
              const Spacer(),
              Column(
                children: const [
                  Text(
                    'Version',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    '2.4.2',
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 135,
              )
            ],
          ),
        ),
      ),
    );
  }

  void aboutUs(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.black,
          content: Padding(
            padding: EdgeInsets.only(bottom: 10, top: 10.0),
            child: Text(
              'Hi I am  AL AMEEN a Flutter developer alameen001.github.io/Personel-Website',
              style: TextStyle(color: Color.fromARGB(255, 240, 237, 235)),
            ),
          ),
        );
      },
    );
  }
}
