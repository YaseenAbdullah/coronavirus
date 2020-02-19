import 'package:coronavirus/constants.dart';
import 'package:coronavirus/size_config.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

bool currentLoading = false;
bool totalLoading = false;
var currentData;
var totalData;

FirebaseAnalytics analytics = FirebaseAnalytics();
FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics:analytics);

class FirstPage extends StatefulWidget {


  @override
  _FirstPageState createState() => _FirstPageState();
}
class _FirstPageState extends State<FirstPage> {

//======================================================
  Future<Map> getCurrent() async{
    setState(() {
      currentLoading = true;
    });
    var url = 'https://covid2019-api.herokuapp.com/current';
    http.Response response = await http.get(url);
    if(response.statusCode == 200){
      setState(() {
        currentLoading = false;
      });
      return json.decode(response.body);
    }

  }
  void getCurrentData() async{
    var  data = await getCurrent();
    setState(() {
      currentData = data;
      print(data);
    });
  }

  Future<Map> getTotal() async{
    setState(() {
      totalLoading = true;
    });
    var url = 'https://covid2019-api.herokuapp.com/total';
    http.Response response = await http.get(url);
    if(response.statusCode == 200){
      setState(() {
        totalLoading = false;
      });
      return json.decode(response.body);
    }

  }
  void getTotalData() async{
    var  data = await getTotal();
    setState(() {
      totalData = data;
      print(totalData);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentData();
    getTotalData();
  }

  //====================================================
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    print(currentData);
    print(totalData);
    TextStyle tableText = TextStyle(fontFamily: 'ubuntu-bold',fontSize: SizeConfig.blockSizeHorizontal * 3.2,color: Color(0xff302E40),);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorObservers: <NavigatorObserver>[observer],
      home: Scaffold(
        backgroundColor:Color(0xff62BEED),
        body:  Container(
          child: totalLoading||currentLoading? Center(child:Container(
              height: SizeConfig.blockSizeVertical*30,
              child: FlareActor('images/loading_circle.flr',color: Colors.white,alignment: Alignment.center,fit: BoxFit.contain,animation: 'Untitled',)),)
              :SingleChildScrollView(
            child: SafeArea(
              child:Column(
                children: <Widget>[
                  //=========== the title ============
                  ListTile(
                    title: Text("CORONAVIRUS",style: headingStyle.copyWith(fontSize: 24),),
                    subtitle:   Text("STAY SAFE",style: headingSubtitleStyle.copyWith(fontSize: 20),),
                  ),
                  //===== image svg ======
                  Container(
                      height: SizeConfig.blockSizeVertical * 50,
                      child: SvgPicture.asset('images/corona-1.svg')),
                  //==== text info =======
                  Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child:   Text("\nCoronaviruses (CoV) are a large family of viruses that cause illness ranging from the common cold to more severe diseases such as MERS-CoV and SARS-Cov.\nnCoV is a new strain that has not been previously identified in humans.\nCoronaviruses are zoonotic, meaning they are transmitted between animals and people.  Detailed investigations found that SARS-CoV was transmitted from civet cats to humans and MERS-CoV from dromedary camels to humans and the new coronavirus transmitted from bats. Several known coronaviruses are circulating in animals that have not yet infected humans. ",style: TextStyle(height: 1.1,fontFamily: 'ubuntu-bold',fontSize: 16,color: Color(0xff302E40)),),
                  ),

                  //===== confirmed cases=
                  Padding(
                    padding: const EdgeInsets.only(top:18.0,bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FittedBox(child: Text("Confirmed Cases: ",style: confirmedCasesStyle.copyWith(fontSize: SizeConfig.blockSizeHorizontal*6.2),)),Text(totalData['confirmed'].toString(),style: confirmedCasesStyle,),
                      ],
                    ),),

                  //deaths and recovered
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      //======= deaths =======
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            FittedBox(child: Text("Deaths: ",style: deathsAndConfirmedStyle.copyWith(fontSize: SizeConfig.blockSizeHorizontal*5.1),)),
                            FittedBox(child: Text(totalData['deaths'].toString(),style: deathsNumberStyle.copyWith(fontSize: SizeConfig.blockSizeHorizontal*5.1),)),
                          ],
                        ),
                      ),
                      //=====recovered========
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            FittedBox(child: Text("Recovered:  ",style: deathsAndConfirmedStyle.copyWith(fontSize: SizeConfig.blockSizeHorizontal*5.1),)),
                            FittedBox(child: Text(totalData['recovered'].toString(),style: recoveredNumberStyle.copyWith(fontSize: SizeConfig.blockSizeHorizontal*5.1),)),
                          ],
                        ),
                      ),
                    ],
                  ),

                  //the table
                  Padding(
                    padding: const EdgeInsets.only(top: 20,bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        //countries
                        Wrap(
                          direction: Axis.vertical,
                          crossAxisAlignment: WrapCrossAlignment.start,
                          spacing: 5,
                          children: <Widget>[
                            Text("Country",style: TextStyle(fontFamily: 'ubuntu-bold',fontSize: SizeConfig.blockSizeHorizontal *4,color: Colors.white),),
                            Text("China",style: tableText,),
                            Text("Thailand",style:tableText,),
                            Text("Japan",style:tableText,),
                            Text("South Korea",style:tableText,),
                            Text("Taiwan",style:tableText,),
                            Text("US",style:tableText,),
                            Text("Macau",style:tableText,),
                            Text("Hong Kong",style:tableText,),
                            Text("Singapore",style:tableText,),
                            Text("Vietnam",style:tableText,),
                            Text("France",style:tableText,),
                            Text("Nepal",style:tableText,),
                            Text("Malaysia",style:tableText,),
                            Text("Canada",style:tableText,),
                            Text("Australia",style:tableText,),
                            Text("Cambodia",style:tableText,),
                            Text("Sri Lanka",style:tableText,),
                            Text("Germany",style:tableText,),
                            Text("Finland",style:tableText,),
                            Text("United Arab Emirates",style:tableText,),
                            Text("Philippines",style:tableText,),
                            Text("India",style:tableText,),
                            Text("Italy",style:tableText,),
                            Text("UK",style:tableText,),
                            Text("Russia",style:tableText,),
                            Text("Sweden",style:tableText,),
                            Text("Spain",style:tableText,),
                            Text("Belgium",style:tableText,),
                            Text("Others",style:tableText,),




                          ],
                        ),
                        //confirmed
                        Wrap(
                          direction: Axis.vertical,
                          crossAxisAlignment: WrapCrossAlignment.start,
                          spacing: 5,
                          children: <Widget>[
                            Text("Confirmed",style: TextStyle(fontFamily: 'ubuntu-bold',fontSize: SizeConfig.blockSizeHorizontal *4,color: Colors.white),),
                            Text(currentData['Mainland_China']['confirmed'].toString(),style:tableText,),
                            Text(currentData['Thailand']['confirmed'].toString(),style:tableText,),
                            Text(currentData['Japan']['confirmed'].toString(),style:tableText,),
                            Text(currentData['South_Korea']['confirmed'].toString(),style:tableText,),
                            Text(currentData['Taiwan']['confirmed'].toString(),style:tableText,),
                            Text(currentData['US']['confirmed'].toString(),style:tableText,),
                            Text(currentData['Macau']['confirmed'].toString(),style:tableText,),
                            Text(currentData['Hong_Kong']['confirmed'].toString(),style:tableText,),
                            Text(currentData['Singapore']['confirmed'].toString(),style:tableText,),
                            Text(currentData['Vietnam']['confirmed'].toString(),style:tableText,),
                            Text(currentData['France']['confirmed'].toString(),style:tableText,),
                            Text(currentData['Nepal']['confirmed'].toString(),style:tableText,),
                            Text(currentData['Malaysia']['confirmed'].toString(),style:tableText,),
                            Text(currentData['Canada']['confirmed'].toString(),style:tableText,),
                            Text(currentData['Australia']['confirmed'].toString(),style:tableText,),
                            Text(currentData['Cambodia']['confirmed'].toString(),style:tableText,),
                            Text(currentData['Sri_Lanka']['confirmed'].toString(),style:tableText,),
                            Text(currentData['Germany']['confirmed'].toString(),style:tableText,),
                            Text(currentData['Finland']['confirmed'].toString(),style:tableText,),
                            Text(currentData['United_Arab_Emirates']['confirmed'].toString(),style:tableText,),
                            Text(currentData['Philippines']['confirmed'].toString(),style:tableText,),
                            Text(currentData['India']['confirmed'].toString(),style:tableText,),
                            Text(currentData['Italy']['confirmed'].toString(),style:tableText,),
                            Text(currentData['UK']['confirmed'].toString(),style:tableText,),
                            Text(currentData['Russia']['confirmed'].toString(),style:tableText,),
                            Text(currentData['Sweden']['confirmed'].toString(),style:tableText,),
                            Text(currentData['Spain']['confirmed'].toString(),style:tableText,),
                            Text(currentData['Belgium']['confirmed'].toString(),style:tableText,),
                            Text(currentData['Others']['confirmed'].toString(),style:tableText,),




                          ],
                        ),
                        //deaths
                        Wrap(
                          direction: Axis.vertical,
                          crossAxisAlignment: WrapCrossAlignment.start,
                          spacing: 5,
                          children: <Widget>[
                            Text("Deaths",style: TextStyle(fontFamily: 'ubuntu-bold',fontSize: SizeConfig.blockSizeHorizontal *4,color: Colors.white),),
                            Text(currentData['Mainland_China']['deaths'].toString(),style:tableText,),
                            Text(currentData['Thailand']['deaths'].toString(),style:tableText,),
                            Text(currentData['Japan']['deaths'].toString(),style:tableText,),
                            Text(currentData['South_Korea']['deaths'].toString(),style:tableText,),
                            Text(currentData['Taiwan']['deaths'].toString(),style:tableText,),
                            Text(currentData['US']['deaths'].toString(),style:tableText,),
                            Text(currentData['Macau']['deaths'].toString(),style:tableText,),
                            Text(currentData['Hong_Kong']['deaths'].toString(),style:tableText,),
                            Text(currentData['Singapore']['deaths'].toString(),style:tableText,),
                            Text(currentData['Vietnam']['deaths'].toString(),style:tableText,),
                            Text(currentData['France']['deaths'].toString(),style:tableText,),
                            Text(currentData['Nepal']['deaths'].toString(),style:tableText,),
                            Text(currentData['Malaysia']['deaths'].toString(),style:tableText,),
                            Text(currentData['Canada']['deaths'].toString(),style:tableText,),
                            Text(currentData['Australia']['deaths'].toString(),style:tableText,),
                            Text(currentData['Cambodia']['deaths'].toString(),style:tableText,),
                            Text(currentData['Sri_Lanka']['deaths'].toString(),style:tableText,),
                            Text(currentData['Germany']['deaths'].toString(),style:tableText,),
                            Text(currentData['Finland']['deaths'].toString(),style:tableText,),
                            Text(currentData['United_Arab_Emirates']['deaths'].toString(),style:tableText,),
                            Text(currentData['Philippines']['deaths'].toString(),style:tableText,),
                            Text(currentData['India']['deaths'].toString(),style:tableText,),
                            Text(currentData['Italy']['deaths'].toString(),style:tableText,),
                            Text(currentData['UK']['deaths'].toString(),style:tableText,),
                            Text(currentData['Russia']['deaths'].toString(),style:tableText,),
                            Text(currentData['Sweden']['deaths'].toString(),style:tableText,),
                            Text(currentData['Spain']['deaths'].toString(),style:tableText,),
                            Text(currentData['Belgium']['deaths'].toString(),style:tableText,),
                            Text(currentData['Others']['deaths'].toString(),style:tableText,),




                          ],
                        ),
                        //recovered
                        Wrap(
                          direction: Axis.vertical,
                          crossAxisAlignment: WrapCrossAlignment.start,
                          spacing: 5,
                          children: <Widget>[
                            Text("Recovered",style: TextStyle(fontFamily: 'ubuntu-bold',fontSize: SizeConfig.blockSizeHorizontal *4,color: Colors.white),),
                            Text(currentData['Mainland_China']['recovered'].toString(),style:tableText,),
                            Text(currentData['Thailand']['recovered'].toString(),style:tableText,),
                            Text(currentData['Japan']['recovered'].toString(),style:tableText,),
                            Text(currentData['South_Korea']['recovered'].toString(),style:tableText,),
                            Text(currentData['Taiwan']['recovered'].toString(),style:tableText,),
                            Text(currentData['US']['recovered'].toString(),style:tableText,),
                            Text(currentData['Macau']['recovered'].toString(),style:tableText,),
                            Text(currentData['Hong_Kong']['recovered'].toString(),style:tableText,),
                            Text(currentData['Singapore']['recovered'].toString(),style:tableText,),
                            Text(currentData['Vietnam']['recovered'].toString(),style:tableText,),
                            Text(currentData['France']['recovered'].toString(),style:tableText,),
                            Text(currentData['Nepal']['recovered'].toString(),style:tableText,),
                            Text(currentData['Malaysia']['recovered'].toString(),style:tableText,),
                            Text(currentData['Canada']['recovered'].toString(),style:tableText,),
                            Text(currentData['Australia']['recovered'].toString(),style:tableText,),
                            Text(currentData['Cambodia']['recovered'].toString(),style:tableText,),
                            Text(currentData['Sri_Lanka']['recovered'].toString(),style:tableText,),
                            Text(currentData['Germany']['recovered'].toString(),style:tableText,),
                            Text(currentData['Finland']['recovered'].toString(),style:tableText,),
                            Text(currentData['United_Arab_Emirates']['recovered'].toString(),style:tableText,),
                            Text(currentData['Philippines']['recovered'].toString(),style:tableText,),
                            Text(currentData['India']['recovered'].toString(),style:tableText,),
                            Text(currentData['Italy']['recovered'].toString(),style:tableText,),
                            Text(currentData['UK']['recovered'].toString(),style:tableText,),
                            Text(currentData['Russia']['recovered'].toString(),style:tableText,),
                            Text(currentData['Sweden']['recovered'].toString(),style:tableText,),
                            Text(currentData['Spain']['recovered'].toString(),style:tableText,),
                            Text(currentData['Belgium']['recovered'].toString(),style:tableText,),
                            Text(currentData['Others']['recovered'].toString(),style:tableText,),




                          ],
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
