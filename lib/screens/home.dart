import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'package:gitamapp/widgets/tile.dart';
import 'package:gitamapp/widgets/elementTile.dart';
import 'package:gitamapp/screens/attendance.dart';
import 'package:gitamapp/screens/assignments.dart';
import 'package:gitamapp/screens/timetable.dart';
import 'package:gitamapp/services/pages.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextStyle textStyle26 = GoogleFonts.montserrat(color: Color(0xFF2a9d8f), fontWeight: FontWeight.w600, fontSize: 26);
  TextStyle textStyle20 = GoogleFonts.montserrat(color: Color(0xFF2a9d8f), fontWeight: FontWeight.w600, fontSize: 20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1D3557),
      body: FutureBuilder(
        future: Pages().getWelcome(),
        builder: (context, AsyncSnapshot snapshot) {
          if(snapshot.hasData){
            String img = snapshot.data.getElementById('imgempid').attributes['src'].toString();
            String nameFromSite = snapshot.data.getElementById('lblname').text.toString();
            List nameInParts = nameFromSite.split(' ');
            String name='';
            for(String i in nameInParts){
              name+=i[0]+i.substring(1, i.length).toLowerCase();
              name+=' ';
            }
            var assignments = snapshot.data.getElementById('ContentPlaceHolder1_GridView1').getElementsByClassName('main_li');
            return SingleChildScrollView(
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top:34.0),
                      child: Container(
                        height: 170,
                        width: 170,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:  Border.all(
                            color: Color(0xFF457B9D),
                            width: 6
                          ),
                          boxShadow: [
                            BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.4),
                            blurRadius: 28,
                            offset: Offset(0.0, 4.0)
                          )],
                          image:  DecorationImage(
                            image: NetworkImage(img.substring(1,img.length), scale: 1.0),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: const EdgeInsets.only(top: 18)),
                    Text(
                      name, 
                      style: GoogleFonts.montserrat(
                        fontSize: 36,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF2a9d8f)
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Padding(padding: const EdgeInsets.only(top: 20),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Tile(
                          onPressedFunction: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Attendance()));
                          },
                          widget: FutureBuilder(
                            future: Pages().getAttendance(),
                            builder: (context, attendance){
                              if(attendance.hasData){
                                String attendanceVal = attendance.data.getElementById('ContentPlaceHolder1_lblpercent').text.toString();
                                return CircularPercentIndicator(
                                  radius: 80.0,
                                  lineWidth: 10.0,
                                  animation: true,
                                  percent: double.parse(attendanceVal)/100,
                                  progressColor: Color(0xFF2a9d8f),
                                  circularStrokeCap: CircularStrokeCap.round,
                                  center: Text(attendanceVal+'%',
                                    style: textStyle20,
                                  ),
                                  footer: Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text('Attendance',
                                      style: textStyle20,
                                    ),
                                  ),
                                );
                              }
                              else{
                                return CircularProgressIndicator(
                                  backgroundColor: Colors.grey,
                                  valueColor: AlwaysStoppedAnimation(Color(0xFF2a9d8f)),
                                  strokeWidth: 10,
                                );
                              }
                            }
                          )),
                        Padding(padding: const EdgeInsets.only(left: 16, right: 16),),
                        Tile(
                          onPressedFunction: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> Assignments(data: assignments)));
                          },
                          widget: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              assignments.length.toString(),
                              style: GoogleFonts.montserrat(
                                color: Color(0xFF2a9d8f),
                                fontWeight: FontWeight.w600,
                                fontSize: 42
                              ),
                            ),
                            Text(
                              'Assignments Pending',
                              style: textStyle20,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 26, bottom: 13),
                      child: ElementTile(
                        onPressedFunction: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> TimeTable())),
                        widget: Text(
                          'Time Table',
                          style: textStyle26
                        ),
                        height: 80,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 13, bottom: 16),
                      child: Text(
                        'Scheduled Online Classes',
                        style: textStyle26,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    DisabledElementTile(
                      widget: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'No Online Classes Scheduled \nfor now',
                            style: textStyle20,
                            textAlign: TextAlign.center,
                          ),
                          Padding(padding: const EdgeInsets.only(top: 0.8)),
                          Text(
                            "(Doesn't Work For Now)",
                            style: GoogleFonts.montserrat(
                              color: Color(0xFF2a9d8f),
                              fontWeight: FontWeight.w600,
                              fontSize: 10
                            ),
                            textAlign: TextAlign.center,
                          )
                        ],
                      )
                    ),
                    Padding(padding: const EdgeInsets.only(top:10)),
                    Text(
                      "Developed by Sanyam Sharma",
                      style: GoogleFonts.montserrat(
                        color: Color(0xFF2a9d8f),
                        fontWeight: FontWeight.w600,
                        fontSize: 14
                      ),
                    ),
                    Padding(padding: const EdgeInsets.only(top:10)),
                  ],
                ),
              ),
            );
          }
          else{
            return Center(
              child: CircularProgressIndicator(
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation(Color(0xFF2a9d8f)),
              strokeWidth: 10,
            ));
          }
        },
      ),
    );
  }
}