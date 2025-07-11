import 'package:flutter/material.dart';

class MyDevice extends StatelessWidget {
  String name;
  String id;
  VoidCallback onTap;
  Color color;
  MyDevice({required this.color, required this.id,required this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: Container(
        
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.face),
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(name,style: TextStyle(fontWeight: FontWeight.bold),),
                  Text(id,style: TextStyle(fontWeight: FontWeight.w500),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}