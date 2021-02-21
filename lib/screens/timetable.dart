import 'dart:collection';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'package:gitamapp/services/courses.dart';
import 'package:gitamapp/services/pages.dart';
import 'package:gitamapp/widgets/elementTile.dart';

class TimeTable extends StatefulWidget {
  @override
  _TimeTableState createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  HashMap<String, String> courses = new HashMap();
  List days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"];
  @override
  void initState(){
    super.initState();
    Courses().getCourses().then((map)=> setState(()=>courses = HashMap.from(map)));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1D3557),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 6),
              child: Text(
                'Time Table', 
                style: GoogleFonts.montserrat(
                  color: Color(0xFF2a9d8f), 
                  fontWeight: FontWeight.w500, 
                  fontSize: 26
                ),
              ),
            ),
            FutureBuilder(
              future: Pages().getTimeTable(),
              builder: (context, snapshot){
                if(snapshot.hasData && courses.isNotEmpty){
                  HashMap<String, List> dayWise = HashMap();
                  String day='';
                  List periods=[];
                  List time=[];
                  var timetable = snapshot.data.getElementById('ContentPlaceHolder1_grd1').getElementsByTagName('tr');
                  var timeHtml =snapshot.data.getElementById('ContentPlaceHolder1_grd1').getElementsByTagName('th');
                  timeHtml.forEach((element){
                    time.add(element.text);
                  });
                  timetable.forEach((element){
                    var elementList = element.getElementsByTagName('td');
                    if(elementList!=null){
                      elementList.forEach((value){
                        periods.add(value.text);
                      });
                    }
                    if(periods.isNotEmpty){
                      day=periods[0];
                      dayWise.putIfAbsent(day, () =>periods.sublist(1, periods.length));
                      periods.clear();
                    }
                  });
                  return Expanded(
                    child: ListView.builder(
                      itemCount: days.length,
                      itemBuilder: (context, index){
                        return Column(
                          children: [
                             Text(
                              days[index], 
                              style: GoogleFonts.montserrat(
                                color: Color(0xFF2a9d8f), 
                                fontWeight: FontWeight.w500, 
                                fontSize: 26
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 10, bottom: 10),
                              height: 180,
                              child: ListView.builder(
                                itemCount: dayWise['Monday'].length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, indexPer){
                                  if(dayWise[days[index]][indexPer]!=''){
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10.0),
                                          child: Container(
                                            width: 100,
                                            child: DisabledElementTile(
                                              widget: Center(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    time[indexPer], 
                                                    style: GoogleFonts.montserrat(
                                                      color: Color(0xFF2a9d8f), 
                                                      fontWeight: FontWeight.w500, 
                                                      fontSize: 20
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),                    
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: Container(
                                            width: 260,
                                            child: DisabledElementTile(
                                              widget: Padding(
                                                padding: const EdgeInsets.only(left: 10.0),
                                                child: Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                    courses[dayWise[days[index]][indexPer]], 
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
                                        
                                      ],
                                    );
                                  }
                                  return Padding(padding: const EdgeInsets.only(top: 0.1));
                                }
                              ),
                            ),
                          ],
                        );
                      }
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
              }
            )
          ],
        ),
      ),
    );
  }
}