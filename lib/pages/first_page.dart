import 'package:coronavirus/constants.dart';
import 'package:coronavirus/size_config.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:coronavirus/column_builder.dart';

bool currentLoading = false;
bool totalLoading = false;
bool countriesLoading = false;
var currentData;
var countries;
var totalData;

FirebaseAnalytics analytics = FirebaseAnalytics();
FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics:analytics);

class FirstPage extends StatefulWidget {


  @override
  _FirstPageState createState() => _FirstPageState();
}
class _FirstPageState extends State<FirstPage> {

//======================================================
//current
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
    });
  }

//countries
  Future<Map> getCountries() async{
    setState(() {
      countriesLoading = true;
    });
    var url = 'https://covid2019-api.herokuapp.com/countries';
    http.Response response = await http.get(url);
    if(response.statusCode == 200){
      setState(() {
        countriesLoading = false;
      });
      return json.decode(response.body);
    }

  }
  void getCountriesData() async{
    var  c = await getCountries();
    setState(() {
      countries = c['countries'];
    });
  }

  //total
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
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentData();
    getTotalData();
    getCountriesData();
  }

  //====================================================
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    print(countries);
    TextStyle tableText = TextStyle(fontFamily: 'ubuntu-bold',fontSize: SizeConfig.blockSizeHorizontal * 3.5,color: Color(0xff302E40),);
    TextStyle tableHeader = TextStyle(fontFamily: 'ubuntu-bold',fontSize: SizeConfig.blockSizeHorizontal * 4.0,color: Color(0xff302E40),);
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

                 //table header
                  Padding(
                    padding: const EdgeInsets.only(top: 20,bottom: 15),
                    child: Row(
                      children: <Widget>[
                        Expanded(child: Text("Countries",style: tableHeader ,textAlign: TextAlign.center,)),
                        Expanded(child: Text("Confirmed",style: tableHeader ,textAlign: TextAlign.center,),),
                        Expanded(child: Text("Deaths",style: tableHeader ,textAlign: TextAlign.center,),
                        ),
                        Expanded(child: Text("Recovered",style: tableHeader ,textAlign: TextAlign.center,),
                        ),
                      ],
                    ),
                  ),
                  //the table
                  Padding(
                    padding: const EdgeInsets.only(bottom:5.0),
                    child: ColumnBuilder(
                      itemCount: countries.length,
                      itemBuilder: (context,index){
                        return  Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(child: Text(countries[index].toString().replaceAll('_', " "),style: tableText,textAlign: TextAlign.center,)),
                                Expanded(child: Text(currentData[countries[index]]['confirmed'].toString(),style: tableText,textAlign: TextAlign.center,)),
                                Expanded(child: Text(currentData[countries[index]]['deaths'].toString(),style: tableText,textAlign: TextAlign.center,)),
                                Expanded(child: Text(currentData[countries[index]]['recovered'].toString(),style: tableText,textAlign: TextAlign.center,)),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        );

                      },
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
