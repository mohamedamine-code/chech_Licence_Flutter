import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  String data;
  IconData icon;
  VoidCallback onTap;
  MyListTile({required this.data,required this.icon,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 10),
      child: ListTile(
        onTap: (){
          onTap();
        },
        title: Text(data,style:TextStyle(color:Colors.black,),),
        leading: Icon(icon,color:Colors.black,),
      ),
    );
  }
}