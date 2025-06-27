import 'package:flutter/material.dart';
class appapar extends StatelessWidget {
  const appapar({super.key});

  @override
  Widget build(BuildContext context) {
    return
       AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('images/img_16.png'),
            ),
            SizedBox(width: 10),
            RichText(
              text: TextSpan(
                text: 'Hi, ',
                style: TextStyle(color: Colors.black, fontSize: 18),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Rowaina',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                ],
              ),
            ),
            Spacer(),
            Icon(Icons.notifications),
          ],
        ),

    );
  }
}
