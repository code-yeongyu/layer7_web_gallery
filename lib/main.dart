import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() => runApp(MyApp());

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Center(
              child: AppBar(
            backgroundColor: Color(0xFF2F2F2F),
            title: Row(children: <Widget>[
              Image(
                  width: 40,
                  height: 40,
                  image: NetworkImage(
                      "http://layer7.kr/2020/images/logo_nochar.png")),
              Padding(padding: EdgeInsets.only(right: 20)),
              Text("Layer7 - What We Hacked")
            ]),
          )),
        ),
        body: MyStateWidget(),
      ),
    );
  }
}

Future<void> openDialog(BuildContext context, String name, String description) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('You just clicked $name!'),
        content: Text('Their phrase is $description'),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

class MyStateWidget extends StatefulWidget {
  createState() => MyState();
}

class MyState extends State<MyStateWidget> {
  int _current = 0;
  var carousel;

  Widget IntroCardWidget(
      context, String addr, String title, String subtitle, int index) {
    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          if (_current != index) {
            carousel.animateToPage(index,
                duration: Duration(milliseconds: 400), curve: Curves.linear);
          } else {
            openDialog(context, title, subtitle);
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(children: <Widget>[
            Image(
              image: NetworkImage(addr),
              height: MediaQuery.of(context).size.height * 0.25,
            ),
            ListTile(
              title: Text('$title'),
              subtitle: Text('$subtitle'),
            )
          ]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    carousel = CarouselSlider(
      onPageChanged: (index) {
        setState(() {
          _current = index;
        });
      },
      enlargeCenterPage: true,
      height: MediaQuery.of(context).size.height * 0.8,
      items: [
        IntroCardWidget(
            context,
            "https://www.freepnglogos.com/uploads/apple-logo-png/apple-logo-png-dallas-shootings-don-add-are-speech-zones-used-4.png",
            "Apple",
            "Think Different.",
            0),
        IntroCardWidget(
            context,
            "https://pluspng.com/img-png/nike-logo-png-nike-logo-png-4944.png",
            "Nike",
            "Just Do It.",
            1),
        IntroCardWidget(
            context,
            "https://www.freepnglogos.com/uploads/apple-logo-png/apple-logo-png-dallas-shootings-don-add-are-speech-zones-used-4.png",
            "lol",
            "no loop plz",
            2),
        IntroCardWidget(
            context,
            "https://pluspng.com/img-png/nike-logo-png-nike-logo-png-4944.png",
            "No god",
            "Cuz I experienced it",
            3),
        IntroCardWidget(
            context,
            "https://www.freepnglogos.com/uploads/apple-logo-png/apple-logo-png-dallas-shootings-don-add-are-speech-zones-used-4.png",
            "LG",
            "Life's Good",
            4),
        IntroCardWidget(
            context,
            "https://pluspng.com/img-png/nike-logo-png-nike-logo-png-4944.png",
            "Samsung",
            "노조없음 ㅋ",
            5),
      ],
    );
    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 40),
        ),
        carousel,
      ],
    );
  }
}
