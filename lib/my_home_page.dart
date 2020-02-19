import 'package:coronavirus/constants.dart';
import 'package:coronavirus/pages/first_page.dart';
import 'package:coronavirus/pages/forth_page.dart';
import 'package:coronavirus/pages/secondPage.dart';
import 'package:coronavirus/pages/third_page.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:bubbled_navigation_bar/bubbled_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyHomePage extends StatefulWidget {

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  final titles = ['Home', 'Care', 'History', 'Donate'];
  final colors = [mainColor, secondColor, thirdColor, forthColor];
  final widgets = [FirstPage(),SecondPage(),ThirdPage(),ForthPage()];
  final icons = [
    CupertinoIcons.home,
    CupertinoIcons.heart,
    CupertinoIcons.book,
    FontAwesomeIcons.handHoldingHeart,
  ];

  MyHomePage({Key key,this.analytics,this.observer}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  //=================================================
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _menuPositionController = MenuPositionController(initPosition: 0);
    _pageController = PageController(
        initialPage: 0,
        keepPage: false,
        viewportFraction: 1.0
    );
    _pageController.addListener(handlePageChange);
  }
  PageController _pageController;
  MenuPositionController _menuPositionController;
  bool userPageDragging = false;

  void handlePageChange() {
    _menuPositionController.absolutePosition = _pageController.page;
  }

  void checkUserDragging(ScrollNotification scrollNotification) {
    if (scrollNotification is UserScrollNotification && scrollNotification.direction != ScrollDirection.idle) {
      userPageDragging = true;
    } else if (scrollNotification is ScrollEndNotification) {
      userPageDragging = false;
    }
    if (userPageDragging) {
      _menuPositionController.findNearestTarget(_pageController.page);
    }
  }
  //================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            checkUserDragging(scrollNotification);
          },
          child: PageView(
            controller: _pageController,
            children: widget.widgets.map((Widget w) => Container(child: w,)).toList(),
            onPageChanged: (page) {
            },
          ),
        ),
        bottomNavigationBar: BubbledNavigationBar(
          controller: _menuPositionController,
          initialIndex: 0,
          itemMargin: EdgeInsets.symmetric(horizontal: 8),
          backgroundColor: Colors.white,
          defaultBubbleColor: Colors.blue,
          onTap: (index) {
            _pageController.animateToPage(
                index,
                curve: Curves.easeInOutQuad,
                duration: Duration(milliseconds: 500)
            );
          },
          items: widget.titles.map((title) {
            var index = widget.titles.indexOf(title);
            var color = widget.colors[index];
            return BubbledNavigationBarItem(
              icon: getIcon(index, color),
              activeIcon: getIcon(index, Colors.white),
              bubbleColor: color,
              title: Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            );
          }).toList(),
        )
    );
  }

  Padding getIcon(int index, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Icon(widget.icons[index], size: 30, color: color),
    );
  }
}