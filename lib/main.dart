import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:html' as html;

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
                  image: AssetImage("assets/layer7.png")),
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

Future<void> openDialog(
    BuildContext context, String name, String description, int index) {
  if (index == 5) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('그거아시나요?!'),
          content: Text('방금 클릭한 작품 만든 사람이 이 사이트 만든사람이에요!!'),
          actions: <Widget>[
            FlatButton(
              child: Text('아 네... 겁나 TMI네요...'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class MyStateWidget extends StatefulWidget {
  createState() => MyState();
}

class MyState extends State<MyStateWidget> {
  int _current = 0;
  var carousel;

  Widget IntroCardWidget(context, String addr, String title, String subtitle,
      String link, Color color, bool isWhite, int index) {
    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          if (_current != index) {
            carousel.animateToPage(index,
                duration: Duration(milliseconds: 400), curve: Curves.linear);
          } else {
            openDialog(context, title, subtitle, index);
            html.window.open(link, link);
          }
        },
        child: Container(
          color: color,
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(children: <Widget>[
            Padding(
                padding: EdgeInsets.only(top: 30),
                child: Image(
                  image: AssetImage(addr),
                  height: MediaQuery.of(context).size.height * 0.4,
                )),
            Padding(
                padding: EdgeInsets.only(left: 20),
                child: ListTile(
                  title: Text(
                    '\n$title',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                        color: isWhite ? Color(0xFFFFFFFF) : Color(0xFF000000)),
                  ),
                  subtitle: Text('\n$subtitle',
                      style: TextStyle(
                          fontSize: 16.0,
                          color:
                              isWhite ? Color(0xFFFFFFFF) : Color(0xFF000000))),
                ))
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
            "assets/kjt.png",
            "복합기 해킹 - 김준태",
            "레이어7 19기 부장님의 \"진짜 해킹\"\n실제 복합기를 해킹, 원리를 기술적으로 설명해봅니다 :D\n패스워드: HelloLayer7",
            "https://sunrinjuntae.tistory.com/163",
            Color(0xFF2F5597),
            true,
            0),
        IntroCardWidget(
            context,
            "assets/lsh.png",
            "테트리스 핵! - 이수혁",
            "\"테트리스 져봐\"\n\n\"그게 뭔데\"\n\"그거 어떻게 하는건데\"",
            "https://cg10036.tistory.com/129",
            Color(0xFF262626),
            true,
            1),
        IntroCardWidget(
            context,
            "assets/kgw.png",
            "킹왕짱 랜섬웨어 - 김건욱",
            "킹왕짱 랜섬웨어로 사랑을 쟁취해봅시다 ㅎㅎ",
            "https://adkim.tistory.com/65",
            Color(0xFF000000),
            true,
            2),
        IntroCardWidget(
            context,
            "assets/kms.png",
            "메시지 스니핑 - 권민석",
            "다른 사람 스마트폰의 문자를 읽을 수 있는 악성코드를 만들어 이를 시연합니다.",
            "https://www.youtube.com/watch?v=NCh2DC16bLM&feature=youtu.be",
            Color(0xFFFFFFFF),
            false,
            3),
        IntroCardWidget(
            context,
            "assets/kmg.png",
            "비밀번호 해킹 - 김민기",
            "요술공주 밍키의 스팀 계좌가 해킹당해 2원밖에 안남았다?!\n레이어식 복수로 혼내주자!",
            "https://mg-princess.tistory.com/entry/시연회-비밀번호-해킹",
            Color(0xFFEAE6E3),
            false,
            4),
        IntroCardWidget(
            context,
            "assets/kyg.png",
            "끄투 핵 - 김연규",
            "모?! 레이어 쀼장이랑 맞짱떠서 이기면 밥을 얻어 먹을수있다고오?!?!",
            "https://mengmota.blogspot.com/2020/04/blog-post.html",
            Color(0xFFE5456D),
            true,
            5),
      ],
    );
    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 25),
        ),
        carousel,
      ],
    );
  }
}
