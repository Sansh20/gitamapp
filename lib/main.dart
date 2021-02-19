import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:gitamapp/screens/home.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';

void main() {
  runApp(MaterialApp(home:Login()));
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  WebViewController _controller;
  final cookieManager = WebviewCookieManager();
  var cookies;
  void getCookie(url) async{
    WebviewCookieManager cookieManager = WebviewCookieManager();

    var gotCookies = await cookieManager.hasCookies();
    print(gotCookies);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF152A35),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Login', style: GoogleFonts.montserrat(
            color: Color(0xFFFF9B52),
            fontWeight: FontWeight.w500,
            fontSize: 36,
          )),
          Padding(padding: const EdgeInsets.only(bottom: 20),),
          Center(
            child: Container(
              height: size.height/1.5,
              width: size.width/1.1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 10,
                    offset: Offset(1.0, 1.0),
                  )
                ]
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: WebView(
                  initialUrl: 'https://login.gitam.edu/studentapps.aspx',
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController){
                    _controller=webViewController;
                  },                  
                  onPageStarted: (url) async {
                    final gotCookies = await cookieManager.getCookies(url);
                    // if(url=="https://login.gitam.edu/studentapps.aspx"){
                    //   _controller.loadUrl("http://glearn.gitam.edu/student/welcome.aspx");
                    // }
                    print(gotCookies);
                    if(url=="http://glearn.gitam.edu/student/welcome.aspx"){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Home(cookie:gotCookies)),);
                    }
                  },

                      
                ),
              ),
            ),
          ),
          Padding(padding: const EdgeInsets.only(top: 20),),
          Container(
            width: size.width/1.2,
            child: Text('You will be taken to another screen in a while', style: GoogleFonts.montserrat(
              color: Color(0xFFFF9B52),
              fontWeight: FontWeight.w300,
              fontSize: 18,
            ), textAlign: TextAlign.center,),
          ),
        ],
      ),
    );
  }
}
