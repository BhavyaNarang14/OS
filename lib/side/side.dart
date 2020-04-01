import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sidebar/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:sidebar/side/menu_item.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() =>
      _SideBarState(); //not final because we'll have to dispose it
}

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
  AnimationController _animationController;
  StreamController<bool> isSidebarOpenedStreamController;
  Stream<bool> isSidebarOpenedStream;
  StreamSink<bool> isSidebarOpenedSink;
  final animationDuration = const Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink =
        isSidebarOpenedStreamController.sink; //initializing stream controller
  }

  @override
  void dispose() {
    //dispose method
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus ==
        AnimationStatus.completed; //sideBar is opened means animation completed

    if (isAnimationCompleted) {
      isSidebarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isSidebarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return StreamBuilder<bool>(
      initialData: false,
      stream: isSidebarOpenedStream,
      builder: (context, isSideBarOpenedAsync) {
        //async will have T or F
        return AnimatedPositioned(
          duration: animationDuration,
          top: 0,
          bottom: 0,
          left: isSideBarOpenedAsync.data ? 0 : -screenWidth,
          right: isSideBarOpenedAsync.data
              ? 0
              : screenWidth - 45, //only the handle of sidebar is visible
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: Colors
                      .deepPurple, //handle of side bar in semi-circular shape
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 100,
                      ),
                      ListTile(
                        title: Text(
                          "aNUkriti",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        subtitle: Text(
                          "Newsletter",
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        leading: CircleAvatar(
                          child: Icon(
                            Icons.speaker_notes,
                            color: Colors.white,
                          ),
                          radius: 40,
                        ),
                      ),
                      Divider(
                        height: 64,
                        thickness: 0.5,
                        color: Colors.white.withOpacity(0.5),
                        indent: 32,
                        endIndent: 32,
                      ),
                      MenuItem(
                        icon: Icons.calendar_today,
                        title: "March",
                        onTap: () {
                          onIconPressed(); //to close sidebar on opting for homepage
                          BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.HomepageClickedEvent); //add dispatches the homepage
                        },
                      ),
                      MenuItem(
                        icon: Icons.calendar_today,
                        title: "February",
                        onTap: () {
                          onIconPressed(); //to close sidebar on opting for homepage
                          BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.FebruaryClickedEvent); //add dispatches the homepage
                        },
                      ),
                      MenuItem(
                        icon: Icons.calendar_today,
                        title: "January",
                        onTap: () {
                          onIconPressed(); //to close sidebar on opting for homepage
                          BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.JanuaryClickedEvent); //add dispatches the homepage
                        },
                      ),
                      Divider(
                        height: 64,
                        thickness: 0.5,
                        color: Colors.white.withOpacity(0.5),
                        indent: 32,
                        endIndent: 32,
                      ),
                      MenuItem(
                        icon: Icons.help,
                        title: "Help",
                      ),
                      MenuItem(
                        icon: Icons.exit_to_app,
                        title: "Exit",
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, -0.9),
                child: GestureDetector(        
                  onTap: () {
                    onIconPressed();
                  },
                  child: ClipPath(
                    clipper: CustomMenuClipper(),
                  
                  child: Container(
                    width: 35,
                    height: 110,
                    color: Colors.deepPurple,
                    alignment: Alignment.center,
                    child: AnimatedIcon(
                        icon: AnimatedIcons.menu_close,
                        progress: _animationController.view,
                        color: Colors.cyan,
                        size: 25),
                  ),
                ),
              ),
              ),
            ],
          ),
        );
      },
    );
  }
}


class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;
    final width = size.width;
    final height = size.height;
    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  } 

  

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;   
  }
}


// its written line 148 Cool? yes bro