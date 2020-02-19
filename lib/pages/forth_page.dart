import 'package:coronavirus/constants.dart';
import 'package:coronavirus/size_config.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

FirebaseAnalytics analytics = FirebaseAnalytics();
FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics:analytics);

class ForthPage extends StatefulWidget {

  @override
  _ForthPageState createState() => _ForthPageState();
}

class _ForthPageState extends State<ForthPage> {

  //url launcher
  _launchURL() async {
    const url = 'https://paypal.me/donatecorona?locale.x=en_US';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorObservers: <NavigatorObserver>[observer],
      home: Scaffold(
        backgroundColor: forthColor,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(children: <Widget>[
              ListTile(title: Text("HELP THE WORLD\nTO RECOVER FASTER",style: headingWhiteStyle,)),
              //donation image
              Container(
                height: SizeConfig.blockSizeVertical * 34,
                width: SizeConfig.blockSizeHorizontal *95,
                child: SvgPicture.asset('images/donate.svg'),
              ),
              ListTile(title: Text("Be on the right side of the history and help the world to recover faster",style: regularWhiteHeader,)),
            Container(
              height: SizeConfig.blockSizeVertical *20,
              width: SizeConfig.blockSizeHorizontal * 98,
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                color: Color(0xffF4BDB8),
                child: Column(
                  children: <Widget>[
                     Text("Donate",style: headingStyle,textAlign: TextAlign.center,),
                  Divider(color: Color(0xff305399).withOpacity(0.2),),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Paypal",textAlign: TextAlign.center,style: headingStyle.copyWith(color: Color(0xff305399),),),
                    )
                   ,  GestureDetector(child: Text("donatecoronavirus@gmail.com",style: headingSubtitleBlackStyle,textAlign: TextAlign.center,),
                    onTap: (){
                     _launchURL();
                    },
                    ),

                  ],
                )
              ),
            ),

            ],),
          ),
        ),
      ),
    );
  }
}
