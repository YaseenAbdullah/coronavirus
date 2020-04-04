import 'package:coronavirus/constants.dart';
import 'package:coronavirus/size_config.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


FirebaseAnalytics analytics = FirebaseAnalytics();
FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics:analytics);

class ThirdPage extends StatefulWidget {

  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorObservers: <NavigatorObserver>[observer],
      home: Scaffold(
        backgroundColor: Color(0xff945561),
        body: SingleChildScrollView(
          child:SafeArea(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //=========== the title ============
                 Align(
                     alignment: Alignment.centerLeft,
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Text("Let's take a look\nat the coronavirus history",style: TextStyle(fontFamily: 'ubuntu-bold',fontSize: 22,color: Colors.white),),
                     )),

                Container(
                  height: SizeConfig.blockSizeVertical * 62,
                  child: SvgPicture.asset('images/chinese-woman-2.svg'),
                ),
                //what is coronavirus
                ListTile(
                  title:  Text("What is coronavirus?",style: TextStyle(fontFamily: 'ubuntu-bold',fontSize: 20,color: Colors.white),),
                    subtitle: Text("\nIt is a novel virus named for the crown-like spikes that protrude from its surface. The coronavirus can infect both animals and people.\nCoronaviruses are a group of viruses that cause respiratory tract illnesses, including the common cold, but can sometimes be more serious, particularly for infants, the elderly and patients with weak or compromised immune systems, according to the US Centres for Disease Control and Prevention (CDC). This viral pathogen was responsible for the Middle East Respiratory Syndrome (MERS) and Severe Acute Respiratory (SARS) outbreaks.\n\nThe 2003 SARS outbreak also emerged from China and was believed to be responsible for 8,000 cases and around 800 deaths. There was some controversy about the Chinese authorities’ management and alleged cover up of the impacts of the virus.\n\nThe first identified case of MERS occurred in 2012 in Saudi Arabia, and the outbreak was primarily contained in the Arabian Peninsula. However, there was a larger outbreak in the Republic of Korea in 2015, transmitted by someone who had visited Saudi Arabia, the UAE and Bahrain. There were approximately 186 cases and 36 deaths from this outbreak.",style: TextStyle(fontFamily: 'ubuntu-bold',fontSize: 15,color: Colors.white),),

                ),
                //where does the virus come from
                ListTile(
                  title: Text("\nWhere does the virus come from?",style: TextStyle(fontFamily: 'ubuntu-bold',fontSize: 20,color: Colors.white)),
                  subtitle: Text("\nThe first cases of novel coronavirus occurred in a group of people with pneumonia, linked to a seafood and live animal market in Wuhan, where many fish, reptiles, bats and other live and dead animals were traded. The disease then spread from those who were sick, to family members and healthcare workers.\n\nCoronaviruses circulate in a range of animals and can sometimes make the jump from animals to humans, via process known as a “spillover”, which can occur due to a mutation in the virus, or increased contact between animals and humans.\n\nThe transmission of the virus from person to person has occurred mainly in the city of Wuhan, the epicenter of the outbreak, but also in other parts of China and outside the country.\n\nThe exact way that the disease is transmitted is yet to be determined but, in general, respiratory diseases are spread via drops of fluids when someone coughs or sneezes, or by touching a surface infected with the virus.\n\nAccording to Chinese scientists, people who get the virus are contagious even before they show symptoms. The incubation period –  the period from when the infection occurs until symptoms develop – is between 1 and 14 days.",style: TextStyle(fontFamily: 'ubuntu-bold',fontSize: 15,color: Colors.white),),
                ),
                //Is the virus transmitted from person to person?
                ListTile(
                  title: Text("\nIs the virus transmitted from person to person?",style: TextStyle(fontFamily: 'ubuntu-bold',fontSize: 20,color: Colors.white)),
                  subtitle: Text("\nThe transmission of the virus from person to person has occurred mainly in the city of Wuhan, the epicenter of the outbreak, but also in other parts of China and outside the country.\n\nThe exact way that the disease is transmitted is yet to be determined but, in general, respiratory diseases are spread via drops of fluids when someone coughs or sneezes, or by touching a surface infected with the",style: TextStyle(fontFamily: 'ubuntu-bold',fontSize: 15,color: Colors.white),),
                ),
                //did we know it's gonna happen?


                //title
                ListTile(title: Text("\nWhat new coronavirus looks like under the microscope?",style: TextStyle(fontFamily: 'ubuntu-bold',fontSize: 20,color: Colors.white))),

              //the virus images
                Container(
                height: SizeConfig.blockSizeVertical*35,
                child: ListView.builder(itemCount: locations.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: SizeConfig.blockSizeVertical*40,
                      width: SizeConfig.blockSizeHorizontal * 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 2,
                            )
                          ],
                          image: DecorationImage(image: AssetImage(locations[index]),fit: BoxFit.fill,)
                        ),
                      ),
                  );
                },
                ),
              ),
                 ListTile(title: Text("This image from a scanning electron microscope shows, in orange, the coronavirus that causes the disease COVID-19.\nis seen here emerging from the surface of cells — in gray — cultured in the lab.",style: TextStyle(fontFamily: 'ubuntu-bold',fontSize: 15,color: Colors.white),)),
                 ListTile(title: Text("the images look rather similar to previous coronavirus MERS-CoV (Middle East respiratory syndrome coronavirus, which emerged in 2012) and the original SARS-CoV (severe acute respiratory syndrome coronavirus, which emerged in 2002).\nThat is not surprising The spikes on the surface of coronaviruses give this virus family its name – corona, which is Latin for 'crown,' and most any coronavirus will have a crown-like appearance.",style: TextStyle(fontFamily: 'ubuntu-bold',fontSize: 15,color: Colors.white),)),
                Padding(
                  padding: const EdgeInsets.only(left:16.0,bottom: 12),
                  child: Text("\nDid we know it's going to happen?",style: TextStyle(fontFamily: 'ubuntu-bold',fontSize: 20,color: Colors.white)),
                ),

                //=========== the title ============
                ListTile(
                  title: Text("\"It is generally believed that bat-borne CoVs will re-emerge to cause the next disease outbreak. In this regard, China is a likely hotspot. The challenge is to predict when and where, so that we can tryour best to prevent such outbreaks.\"",style: TextStyle(fontFamily: 'ubuntu-bold',fontSize: 16,color: Colors.white),),
                  subtitle:   Text("-29 January 2019,Wuhan Institute of Virology\n10 months before the break!",style: TextStyle(fontFamily: 'ubuntu-bold',fontSize: 14,color: Colors.white),),
                ),
                ListTile(title: Text("This statement is from a group of reaserchers from Wuhan Institute of Virology, Chinese Academy of Science they shared that months before the virus happens\nThey also mentniod:\n",style: TextStyle(fontFamily: 'ubuntu-bold',fontSize: 18,color: Colors.white),)),

                //bat statement
                ListTile(title: Text("\"it is highly likely that future SARS- or MERS-like coronavirusoutbreaks will originate from batss, and there is an increased probability that this will occur in China.\"",style: TextStyle(fontFamily: 'ubuntu-bold',fontSize: 16,color: Colors.white),)),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}
