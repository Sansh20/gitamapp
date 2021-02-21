import 'dart:collection';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'package:gitamapp/services/courses.dart';
import 'package:gitamapp/services/pages.dart';
import 'package:gitamapp/widgets/elementTile.dart';

class Attendance extends StatefulWidget {
  @override
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  HashMap<String, String> courses = new HashMap();
  @override
  void initState(){
    super.initState();
    Courses().getCourses().then((map)=> setState(()=>courses = HashMap.from(map)));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1D3557),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 6),
            child: Text(
              'Attendance', 
              style: GoogleFonts.montserrat(
                color: Color(0xFF2a9d8f), 
                fontWeight: FontWeight.w500, 
                fontSize: 26
              ),
            ),
          ),
          FutureBuilder(
            future: Pages().getAttendance(),
            builder: (context, snapshot){
              if(snapshot.hasData && courses.isNotEmpty){          
                var courseAttendance = snapshot.data.getElementById('ContentPlaceHolder1_GridView4').getElementsByTagName('tr');
                List courseIds=[];
                List totalDays=[];
                List presentDays=[];
                List percentage=[];
                courseAttendance.forEach((element){
                  List elementList = element.getElementsByTagName('td');
                  if(elementList.isNotEmpty){
                    courseIds.add(elementList[1].text);
                    totalDays.add(elementList[3].text);
                    presentDays.add(elementList[4].text);
                    percentage.add(elementList[6].text);
                  }
                });
                return Expanded(
                  child: ListView.builder(
                    itemCount: courseIds.length,
                    itemBuilder: (context, index){
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 6.0, bottom: 10.0),
                            child: Container(
                              width: 260,
                              child: DisabledElementTile(
                                widget: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      courses[courseIds[index]], 
                                      style: GoogleFonts.montserrat(
                                        color: Color(0xFF2a9d8f), 
                                        fontWeight: FontWeight.w500, 
                                        fontSize: 20
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 6.0, left: 8.0, bottom: 10.0),
                            child: Container(
                              width: 100,
                              child: DisabledElementTile(
                                widget: Center(
                                  child: CircularPercentIndicator(
                                    radius: 80.0,
                                    lineWidth: 10.0,
                                    animation: true,
                                    percent: int.parse(percentage[index])/100,
                                    progressColor: Color(0xFF2a9d8f),
                                    circularStrokeCap: CircularStrokeCap.round,
                                    center: Text(
                                      percentage[index]+'%',
                                      style: GoogleFonts.montserrat(
                                        color: Color(0xFF2a9d8f), 
                                        fontWeight: FontWeight.w500, 
                                        fontSize: 16
                                      ),
                                    ),
                                    footer: Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        presentDays[index]+'/'+totalDays[index], 
                                        style: GoogleFonts.montserrat(
                                          color: Color(0xFF2a9d8f), 
                                          fontWeight: FontWeight.w500, 
                                          fontSize: 12
                                        ),
                                      ),
                                    ),
                                  )
                                ),
                              ),
                            ),
                          ),                    
                        ],
                      );
                    },
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation(Color(0xFF2a9d8f)),
                  strokeWidth: 10,
                )
              );
            },
          ),
        ],
      ),
    );
  }
}