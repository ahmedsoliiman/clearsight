import 'package:flutter/material.dart';
class icon extends StatelessWidget {
  const icon({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1.15),
                  border: Border.all(color: Color(0xff3869EB))
              ),
              width:100,height:25,child: Image.asset('images/img_4.png',width: 16,height: 16,)),
          SizedBox(width: 2,),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1.15),
                  border: Border.all(color: Color(0xff3869EB))
              ),
              width:100,height:25,child: Image.asset('images/img_2.png',width: 16,height: 16,)),
          SizedBox(width: 2,),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1.15),
                  border: Border.all(color: Color(0xff3869EB))
              ),
              width:100,height:25,child: Image.asset('images/img_5.png',width: 16,height: 16,))
        ],
      ),
    );
  }
}
