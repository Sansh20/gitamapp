import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:async/async.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'package:gitamapp/widgets/tile.dart';



class Home extends StatefulWidget {
  final List cookie;
  Home({this.cookie});
  @override
  _HomeState createState() => _HomeState(cookie:cookie);
}

class _HomeState extends State<Home> {
  final List cookie;
  _HomeState({this.cookie});

  String url='https://glearn.gitam.edu/student';
  String attendance;

  final AsyncMemoizer _welcomeMemoizer = AsyncMemoizer();
  final AsyncMemoizer _attendanceMemoizer = AsyncMemoizer();
    
  parseHtml() {
    
    return this._welcomeMemoizer.runOnce(() async{
      http.Response response = await http.get(url+'/welcome.aspx',
        headers: {'Cookie': cookie[0].toString()+';Expiry=Session'}
      );
      dom.Document doc = parser.parse(response.body);
      print("CALLED");
      return doc;
    });
  }

  getAttendance() async{
    return this._attendanceMemoizer.runOnce(() async{
      http.Response response = await http.get(url+'/attendance.aspx',
        headers: {'Cookie': cookie[0].toString()+';Expiry=Session'}
      );
      dom.Document doc = parser.parse(response.body);
      return doc.getElementById('ContentPlaceHolder1_lblpercent').text.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1D3557),
      body: FutureBuilder(
        future: parseHtml(),
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
            getAttendance().then((value)=>setState(()=>attendance=value));
            
            return SingleChildScrollView(
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top:40.0),
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
                    Padding(padding: const EdgeInsets.only(top: 20)),
                    Text(
                      name, 
                      style: GoogleFonts.montserrat(
                        fontSize: 36,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF2a9d8f)
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Padding(padding: const EdgeInsets.only(top: 30),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Tile(
                          widget: CircularPercentIndicator(
                            radius: 80.0,
                            lineWidth: 10.0,
                            animation: true,
                            percent: double.parse(attendance)/100,
                            progressColor: Color(0xFF2a9d8f),
                            circularStrokeCap: CircularStrokeCap.round,
                            center: Text(attendance+'%',
                              style: GoogleFonts.montserrat(
                                color: Color(0xFF2a9d8f),
                                fontWeight: FontWeight.w600,
                                fontSize: 20
                              ),
                            ),
                            footer: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text('Attendance',
                              style: GoogleFonts.montserrat(
                                color: Color(0xFF2a9d8f),
                                fontWeight: FontWeight.w600,
                                fontSize: 20
                              ),
                            ),
                            ),
                          ),
                        ),
                        Tile(widget: Text('Yes'))
                      ],
                    )
                  ],
                ),
              ),
            );
          }
          else{
            print('Loading');
            return Center(child: Text("Loading"));
          }
        },
      ),
    );
  }
}