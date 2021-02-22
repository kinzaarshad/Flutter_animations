import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animations/essentials/HexColor.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>  with SingleTickerProviderStateMixin{
  AnimationController _controller;
  Animation<Offset> _circleAnimation;
  Animation<Offset> _titleAnimation;
  Animation<Offset> _tableAnimation;
  bool isBlack = true;
  SequenceAnimation sequenceAnimation;
  Color color1 = HexColor("#586a9a");


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    sequenceAnimation=SequenceAnimationBuilder()
        .addAnimatable(animatable: Tween<Offset>(begin:Offset.zero,end:Offset(1,0)),
        from: const Duration(milliseconds: 200),
        to: const Duration(milliseconds: 1000),
        tag:'title_animation')
        .addAnimatable(animatable: Tween<Offset>(begin:Offset.zero,end:Offset(-1,0)),
        from: const Duration(milliseconds: 200),
        to: const Duration(milliseconds: 1000),
        tag: "table_animation")
        .addAnimatable(animatable: Tween<Offset>(begin:Offset(1,0.35),end:Offset(0.75,0.35)),
        from: const Duration(milliseconds: 200),
        to: const Duration(milliseconds: 1000),
        tag: "blue1_slide")
        .addAnimatable(animatable: Tween<Offset>(begin:Offset(-1,0),end:Offset(0,0)),
        from: const Duration(milliseconds: 200),
        to: const Duration(milliseconds: 1000),
        tag: "blue2_slide")
        .addAnimatable(animatable: Tween<Offset>(begin:Offset.zero,end:Offset(0,-1.2)),
        from: const Duration(milliseconds: 200),
        to: const Duration(milliseconds: 1000),
        tag: 'circle_animation')
        .addAnimatable(animatable: Tween<double>(begin: 40,end:200),
        from: const Duration(milliseconds: 200),
        to: const Duration(milliseconds: 1000),
        tag: 'zoom_animation')
        .addAnimatable(animatable: ColorTween(begin:Colors.grey[850],end:color1),
        from: const Duration(milliseconds: 200),
        to: const Duration(milliseconds: 1000),
        tag: 'color')
        .addAnimatable(animatable: Tween<double>(begin:0,end:1),
        from: const Duration(milliseconds: 200),
        to: const Duration(milliseconds: 1000),
        tag: 'fade_in')
        .animate(_controller);
   // _controller.forward();



  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, _) {
          return Scaffold(
              backgroundColor: sequenceAnimation['color'].value,
              body: Stack(
                children: [
                  ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(20),

                      children:  <Widget>[
                        SizedBox(height: 60),
                        Center(
                          child: Stack(
                              children: <Widget> [
                                FractionalTranslation(
                                  //margin:EdgeInsets.only(bottom: sequenceAnimation['table_animation'].value),
                                  translation: sequenceAnimation['circle_animation'].value,
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    child: Image(
                                      image: AssetImage('assets/circle.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                FractionalTranslation(
                                  translation: sequenceAnimation['title_animation'].value,
                                  //margin:EdgeInsets.only(left: sequenceAnimation['table_animation'].value),
                                  child: Container(
                                      alignment: Alignment.center,
                                      height: 300,
                                      width:400,
                                      child: Text(
                                        'AIDA',
                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 52.0),
                                      )),
                                ),
                              ]

                          ),
                        ),
                        FractionalTranslation(
                          //margin:EdgeInsets.only(left: sequenceAnimation['table_animation'].value),
                          translation: sequenceAnimation['table_animation'].value,
                          child: Container(
                              alignment: Alignment.center,
                              child: Center(
                                child: Text(
                                  'Your Personalized Smart \nHome Assistant',
                                  textAlign:TextAlign.center,
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22.0),
                                ),
                              )
                          ),
                        ),
                        SizedBox(height: 30,),
                        Container(
                          //margin:EdgeInsets.only(left: sequenceAnimation['table_animation'].value),
                          child: Center(
                            child: Stack(
                                children: <Widget> [
                                  FractionalTranslation(
                                    translation: sequenceAnimation['table_animation'].value,
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Image(
                                        image: AssetImage('assets/Table.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  FractionalTranslation(
                                    translation: sequenceAnimation['circle_animation'].value,
                                    child: Container(
                                      alignment: Alignment.topCenter,
                                      child: Image(
                                        height: sequenceAnimation['zoom_animation'].value,
                                        width: sequenceAnimation['zoom_animation'].value,
                                        image: AssetImage('assets/camera.png'),
                                      ),
                                    ),
                                  ),

                                ]

                            ),
                          ),
                        ),
                        SizedBox(height: 30,),
                        FractionalTranslation(
                          translation: sequenceAnimation['table_animation'].value,
                          //margin:EdgeInsets.only(left: sequenceAnimation['table_animation'].value),
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                _controller.forward();
                              },
                              child: Container(
                                  height: 50.0,
                                  width: 200.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25.0),
                                      color: Colors.white
                                  ),
                                  child: Center(
                                      child: Text(
                                          'Start Animation',
                                          style: TextStyle(
                                              fontFamily: 'nunito',
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black
                                          )
                                      )
                                  )
                              ),
                            ),
                          ),
                        ),
                      ]
                    //crossAxisAlignment: CrossAxisAlignment.start,


                  ),
                  FractionalTranslation(
                    translation: sequenceAnimation['blue1_slide'].value,
                    child: Positioned(
                      top: 100,
                      right: -210,
                      child: Opacity(
                        opacity: sequenceAnimation['fade_in'].value,
                        child: Image(
                            image: AssetImage('assets/blue1.png'),
                            fit: BoxFit.cover,
                          ),
                      ),

                    ),
                  ),
                  FractionalTranslation(
                    translation: sequenceAnimation['blue2_slide'].value,
                    child: Positioned(
                      top: 0,
                      right: 200,
                      child: Opacity(
                        opacity: sequenceAnimation['fade_in'].value,
                        child: Image(
                          image: AssetImage('assets/blue2.png'),
                          fit: BoxFit.cover,
                        ),
                      ),

                    ),
                  ),
                  FractionalTranslation(
                    translation: sequenceAnimation['blue2_slide'].value,
                    //margin:EdgeInsets.only(left: sequenceAnimation['table_animation'].value),
                      child: Container(
                        margin: EdgeInsets.all(30),
                        child: InkWell(
                            onTap: () {
                              _controller.reverse();
                            },
                            child: Image(
                              image: AssetImage('assets/back.png'),
                            ),
                        ),
                      ),
                  ),

                  FractionalTranslation(
                    //margin:EdgeInsets.only(left: sequenceAnimation['table_animation'].value),
                    translation: sequenceAnimation['blue2_slide'].value,
                    child:Center(
                      child: Container(
                          margin: EdgeInsets.only(top:200),
                          child: Text(
                              'Hi there, Im AIDA',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22.0),
                            ),
                      ),
                    ),
                  ),
                  FractionalTranslation(
                    //margin:EdgeInsets.only(left: sequenceAnimation['table_animation'].value),
                    translation: sequenceAnimation['blue2_slide'].value,
                    child: Center(
                      child: Container(
                          margin: EdgeInsets.only(top:300),
                          child:Text(
                              'I\'ve got your back in all your day to day matters',
                              textAlign:TextAlign.center,
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22.0),
                            ),
                      ),
                    ),
                  ),

                ]

              )
          );
        },

    );
  }


}

