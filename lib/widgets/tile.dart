import 'package:flutter/material.dart';

class Tile extends StatelessWidget{
  final Widget widget;
  Tile({@required this.widget});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: Color(0xFF1D3557),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(18, 38, 65, 0.59),
            blurRadius: 10.0, 
            spreadRadius: 1.0, 
            offset: Offset(8.0, 6.0),
          ),
          BoxShadow(
            color: Color.fromRGBO(34, 74, 131, 0.54),
            blurRadius: 10.0,
            spreadRadius: 1.0,
            offset: Offset(-8.0, -5.0)
          )
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(child: widget)
    );
  }}