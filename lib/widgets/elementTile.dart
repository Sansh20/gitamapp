import 'package:flutter/material.dart';

class ElementTile extends StatelessWidget{
  final Widget widget;
  final double height;
  final Function onPressedFunction;
  ElementTile({@required this.widget, this.height, this.onPressedFunction});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: ()=>(onPressedFunction())!=null? onPressedFunction():null,
      child: Container(
        width: size.width/1.15,
        height: (height!=null)?height:100,
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
      ),
    );
  }}

class DisabledElementTile extends StatelessWidget{
  final Widget widget;
  final double width;
  DisabledElementTile({@required this.widget, this.width});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: (width==null) ? size.width/1.15 : width,
      height: 120,
      decoration: BoxDecoration(
        color: Color(0xFF152E52),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(34, 74, 131, 0.54),
            blurRadius: 10.0,
            spreadRadius: 1.0,
            offset: Offset(0.0, 0.0)
          )
        ],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Color(0xFF122949),
          width: 2.0,
        )
      ),
      child: widget
    );
  }}
  