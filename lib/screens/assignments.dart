import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'package:gitamapp/services/pages.dart';
import 'package:gitamapp/widgets/elementTile.dart';

class Assignments extends StatefulWidget { 
  final List data;
  Assignments({this.data});  
  @override
  _AssignmentsState createState() => _AssignmentsState();
}

class _AssignmentsState extends State<Assignments> {
  @override
  Widget build(BuildContext context) {
    List assignmentName=[];
    List course=[];
    List deadline=[];
    widget.data.forEach((element) {
      var spanList = element.getElementsByTagName('span');
      assignmentName.add(element.getElementsByTagName('h4')[0].text);
      List courseName = spanList[0].text.split('-');
      course.add(courseName[1]);
      deadline.add(spanList[1].text);
    });
    return Scaffold(
      backgroundColor: Color(0xFF1D3557),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 10),
              child: Text(
                'Pending Assignments', 
                style: GoogleFonts.montserrat(
                  color: Color(0xFF2a9d8f), 
                  fontWeight: FontWeight.w500, 
                  fontSize: 26
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: assignmentName.length,
                itemBuilder: (context, index){
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 20.0),
                    child: DisabledElementTile(
                      height: (assignmentName[index].length>30)? 150 : 124,
                      widget: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                assignmentName[index], 
                                style: GoogleFonts.montserrat(
                                  color: Color(0xFF2a9d8f), 
                                  fontWeight: FontWeight.w500, 
                                  fontSize: 21
                                ),
                              ),
                            ),
                            Padding(padding: const EdgeInsets.only(top: 10)),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                course[index], 
                                style: GoogleFonts.montserrat(
                                  color: Color(0xFF1E7066), 
                                  fontWeight: FontWeight.w500, 
                                  fontSize: 21
                                ),
                              ),
                            ),
                            Padding(padding: const EdgeInsets.only(top: 16)),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                deadline[index], 
                                style: GoogleFonts.montserrat(
                                  color: Color(0xFF17574F), 
                                  fontWeight: FontWeight.w500, 
                                  fontSize: 21
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ),
                  );
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}
