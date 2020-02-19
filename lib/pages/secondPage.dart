import 'package:coronavirus/constants.dart';
import 'package:coronavirus/size_config.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

bool loading = false;
var data ;
FirebaseAnalytics analytics = FirebaseAnalytics();
FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics:analytics);

class SecondPage extends StatefulWidget {

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {

  Future<Map> getCities() async{
    setState(() {
      loading = true;
    });
    var url = 'https://covid2019-api.herokuapp.com/current';
    http.Response response = await http.get(url);
    if(response.statusCode == 200){
      setState(() {
        loading = false;
      });
      return json.decode(response.body);
    }

  }
  void getCitiesData() async{
    var  thatData = await getCities();
    setState(() {
      data = thatData;
      print(data);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCitiesData();
  }
  @override
  Widget build(BuildContext context) {
    print(loading);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        navigatorObservers: <NavigatorObserver>[observer],
      home: Scaffold(
        backgroundColor: secondColor,
        body: SingleChildScrollView(
         child: SafeArea(child: Column(
           mainAxisAlignment: MainAxisAlignment.start,
           children: <Widget>[
             Align(
                 alignment: Alignment.centerLeft,
                 child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Text("There are more useful things to do than worry\nFor one thing, you could wash your hands",style: headingStyle.copyWith(color: Colors.white),),
                 )),
             Container(
                 height: SizeConfig.blockSizeVertical * 50,
                 child: SvgPicture.asset('images/care-2.svg',)),
             ListTile(
               title: Text("\"Vaccine for new coronavirus 'COVID-19' could be ready in 18 months\"",style: regularWhiteHeader,),
               subtitle: Text("\nWorld Health Organization - Feb 11, 2020",style: regularWhiteHeader.copyWith(fontSize: 15),),),
             Divider(),
             ListTile(title: Text("There are currently no vaccines available to protect you against human coronavirus infection. You may be able to reduce your risk of infection by doing the following:",style: regularWhiteHeader),),
             ListTile(title: Text("\n• Avoid close contact with people who are sick.",style: regularWhiteText,),),
             ListTile(title: Text("•	Avoid touching your eyes, nose, and mouth with unwashed hands.",style: regularWhiteText,),),
             ListTile(title: Text("•	Stay home when you are sick.",style: regularWhiteText,),),
             ListTile(title: Text("•	Cover your cough or sneeze with a tissue, then throw the tissue in the trash.",style: regularWhiteText,),),
             ListTile(title: Text("•	Clean and disinfect frequently touched objects and surfaces using a regular household cleaning spray or wipe.",style: regularWhiteText,),),
             ListTile(title: Text("•	Follow CDC’s recommendations for using facemask.",style: regularWhiteText,),),
             ListTile(title: Text("•	Wash your hands often with soap and water for at least 20 seconds, especially after going to the bathroom; before eating; and after blowing your nose, coughing, or sneezing.",style: regularWhiteText,),),
             ListTile(title: Text("•	Maintain at least 1 metre (3 feet) distance between yourself and other people, particularly those who are coughing, sneezing and have a fever.",style: regularWhiteText,),),
             ListTile(title: Text("•	Tell your health care provider if you have traveled in an area in China where 2019-nCoV has been reported, or if you have been in close contact with someone with who has traveled from China and has respiratory symptoms.",style: regularWhiteText,),),
             ListTile(title: Text("•	Avoid consumption of raw or undercooked animal products, Handle raw meat, milk or animal organs with care, to avoid cross-contamination with uncooked foods, as per good food safety practices.",style: regularWhiteText,),),
             ListTile(title: Text("• Ensure regular hand washing with soap and potable water after touching animals and animal products; avoid touching eyes, nose or mouth with hands; and avoid contact with sick animals or spoiled animal products. Strictly avoid any contact with other animals in the market (e.g., stray cats and dogs, rodents, birds, bats). Avoid contact with potentially contaminated animal waste or fluids on the soil or structures of shops and market facilities.",style: regularWhiteText,),),
             ListTile(title: Text("What about flights?",style: regularWhiteHeader,),),
             //airplane image
             Container(
               height: SizeConfig.blockSizeVertical * 22,
               child: SvgPicture.asset('images/airplane-2.svg'),
             ),
             ListTile(title: Text("The virus can’t survive long on seats or armrests, so physical contact with another person carries the greatest risk of infection on a flight.",style: regularWhiteText,),),
           Divider(),
             ListTile(title: Text("Wash your hands frequently Why?",style: regularWhiteHeader,),),
             ListTile(title: Text("• Washing your hands with soap and water or using alcohol-based hand rub eliminates the virus if it is on your hands",style: regularWhiteText,),),
             ListTile(title: Text("Practice respiratory hygiene Why?",style: regularWhiteHeader,),),
             ListTile(title: Text("• Covering your mouth and nose when coughing and sneezing prevent the spread of germs and viruses. If you sneeze or cough into your hands, you may contaminate objects or people that you touch.",style: regularWhiteText,),),
             ListTile(title: Text("Maintain social distancing Why?",style: regularWhiteHeader,),),
             ListTile(title: Text("• When someone who is infected with a respiratory disease, like 2019-nCoV, coughs or sneezes they project small droplets containing the virus. If you are too close, you can breathe in the virus.",style: regularWhiteText,),),
             ListTile(title: Text("Avoid touching eyes, nose and mouth Why?",style: regularWhiteHeader,),),
             ListTile(title: Text("• Hands touch many surfaces which can be contaminated with the virus. If you touch your eyes, nose or mouth with your contaminated hands, you can transfer the virus from the surface to yourself.",style: regularWhiteText,),),
             ListTile(title: Text("If you have fever, cough and difficulty breathing, seek medical care early Why?",style: regularWhiteHeader,),),
             ListTile(title: Text("• Whenever you have fever, cough and difficulty breathing it’s important to seek medical attention promptly as this may be due to a respiratory infection or other serious condition. Respiratory symptoms with fever can have a range of causes, and depending on your personal travel history and circumstances, 2019-nCoV could be one of them.",style: regularWhiteText,),),

           ],
         )),
        ),


    )
      );
  }
}


