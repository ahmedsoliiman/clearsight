import 'package:flutter/material.dart';
import 'package:clearsight/pages/location.dart';
import 'package:clearsight/pages/settings.dart';
import '../widget/supervisor_health_indicator.dart';
import 'package:clearsight/pages/supervisor_detail.dart';
import 'package:clearsight/pages/face_recognition_info.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffFFFFFF),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xffFFFFFF),
          title: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('images/img_16.png'),
              ),
              SizedBox(width: 10),
              Column(
                children: [
                  Row(
                    children: [
                      Text('Hi,',
                          style: TextStyle(
                              color: Color(0xff000000), fontSize: 18)),
                      Text('Rowaina',
                          style: TextStyle(
                              color: Color(0xff5D83DD), fontSize: 18)),
                    ],
                  ),
                  Text('Female, 60y.o',
                      style: TextStyle(color: Color(0xff5B80D8), fontSize: 10)),
                ],
              ),
              // RichText(
              //   text: TextSpan(
              //     text: 'Hi, ',
              //     style: TextStyle(color: Colors.black, fontSize: 18),
              //     children: <TextSpan>[
              //       TextSpan(
              //         text: 'Rowaina',
              //         style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              //       ),
              //     ],),
              // ),
              Spacer(),
              Icon(Icons.notifications),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: ListView(
            children: [
              SizedBox(height: 30),
              //text
              Row(
                children: [
                  Text("Meet a Supervisor",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  Spacer(),
                  Text("See All",
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff5B80D8))),
                ],
              ),
              SizedBox(height: 30),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search Supervisor',
                  labelStyle: TextStyle(
                      fontSize: 20,
                      color: Color(0xff6F6F6F),
                      fontWeight: FontWeight.w400),
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffFFFFFF)),
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
              SizedBox(height: 20),
              Text("Add a Supervisor",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SupervisorDetailPage()),
                  );
                },
                
                icon: Icon(Icons.supervisor_account, color: Color(0xffFFFFFF)),
                label: Text(
                  "Patient Status Now",
                  style: TextStyle(color: Color(0xffFFFFFF)),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff5D83DD),
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
              SizedBox(height: 20),
              Text("Follow the Location",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Location(),
                )),
                icon: Icon(Icons.person, color: Color(0xffFFFFFF)),
                label: Text(
                  "Location",
                  style: TextStyle(color: Color(0xffFFFFFF)),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff5D83DD),
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
              SizedBox(height: 20),
              Text("Eco-Friendly Tips",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              SizedBox(height: 30),
              Container(
                width: 384,
                height: 200,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xffB5D4F1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.home, color: Colors.blue),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("At-Home Helping Tips:",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        Text(
                          "Donate Reused Items: Give gently used braille ",
                          style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "books, audiobooks, or assistive devices to ",
                          style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 2),
                        Text(
                          " organizations or individuals. ",
                          style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 25),
                        Text(
                          "Use Digital Resources: Share e-books,",
                          style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "audiobooks, and voice-assisted apps to reduce ",
                          style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 2),
                        Text(
                          " paper waste ",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 160,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SettingsPage(),
                    )),
                    child: Icon(
                      Icons.settings,
                      color: Color(0xff2B4278),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => FaceRecognitionInfoPage()),
                      );
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(Icons.camera_alt, color: Color(0xff2B4278)),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xff5D83DD), width: 2),
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                            child: Icon(Icons.face, color: Color(0xff5D83DD), size: 13),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Location(),
                          )),
                      child:
                          Icon(Icons.location_pin, color: Color(0xff2B4278))),
                  Icon(Icons.chat_bubble, color: Color(0xff2B4278)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
