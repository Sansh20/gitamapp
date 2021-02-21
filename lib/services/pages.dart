import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;

import 'package:gitamapp/services/cookie_global.dart' as cookiesGlobal;

class Pages{
  String url='https://glearn.gitam.edu/student';
  String cookieFinal = cookiesGlobal.glearnCookie+';Expiry=Session';
  getWelcome() async{
    print(cookiesGlobal.glearnCookie);
    http.Response response = await http.get(url+'/welcome.aspx',
      headers: {'Cookie': cookieFinal}
    );
    dom.Document doc = parser.parse(response.body);
    print("CALLED");
    return doc;
  }
  getAttendance() async{
    http.Response response = await http.get(url+'/attendance.aspx',
      headers: {'Cookie': cookieFinal}
    );
    dom.Document doc = parser.parse(response.body);
    return doc;
  }
}