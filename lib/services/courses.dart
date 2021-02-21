import 'dart:collection';

import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;

import 'package:gitamapp/services/cookie_global.dart' as cookiesGlobal;

class Courses{
  getCourses() async {
    HashMap<String, String> coursesMap = new HashMap();
    http.Response response = await http.get('https://glearn.gitam.edu/student/welcome.aspx',
      headers: {'Cookie': cookiesGlobal.glearnCookie+';Expiry=Session'}
    );
    dom.Document doc = parser.parse(response.body);
    var coursesList = doc.getElementById('ContentPlaceHolder1_GridView2').getElementsByClassName('main_li');
    coursesList.forEach((element) {
      String courseId;
      String courseName;
      element.getElementsByTagName('h4').forEach((element) {
        courseId = element.text;
      });
      element.getElementsByTagName('h6').forEach((element) {
        courseName = element.text;
      });
      coursesMap.putIfAbsent(courseId, () => courseName);
    });
    return coursesMap;
  } 
}
