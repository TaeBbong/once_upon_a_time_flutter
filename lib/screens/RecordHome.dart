import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:once_upon_a_time_app/models/Book.dart';
import 'package:once_upon_a_time_app/utils/ScreenParameter.dart';

class RecordHome extends StatelessWidget {
  DateTime currentBackPressTime;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Book> books = [
    Book(
      index: 0,
      title: '누가 내 머리에 똥 쌌어?',
      image:
          'https://t2.daumcdn.net/thumb/R720x0/?fname=http://t1.daumcdn.net/brunch/service/user/3xdL/image/McUSP7GLtw3U4Ku0pfpfMjU9nfQ.jpg',
      pages: [
        'https://i.ytimg.com/vi/uPbtN5-v6yU/maxresdefault.jpg',
        'https://i.ytimg.com/vi/aXXWCQ9VRxE/maxresdefault.jpg',
      ],
    ),
    Book(
      index: 1,
      title: '하품하는 악어',
      image: 'https://img.ridicdn.net/cover/805021357/xxlarge',
      pages: [
        'https://i.ytimg.com/vi/uPbtN5-v6yU/maxresdefault.jpg',
        'https://i.ytimg.com/vi/aXXWCQ9VRxE/maxresdefault.jpg',
      ],
    ),
    Book(
      index: 2,
      title: '숲속 피아노',
      image: 'https://img.hankyung.com/photo/201704/BD.13793381.1.jpg',
      pages: [
        'https://i.ytimg.com/vi/uPbtN5-v6yU/maxresdefault.jpg',
        'https://i.ytimg.com/vi/aXXWCQ9VRxE/maxresdefault.jpg',
      ],
    ),
    Book(
      index: 3,
      title: '숙제 해주는 로봇',
      image: 'https://image.yes24.com/Goods/35763188/L',
      pages: [
        'https://i.ytimg.com/vi/uPbtN5-v6yU/maxresdefault.jpg',
        'https://i.ytimg.com/vi/aXXWCQ9VRxE/maxresdefault.jpg',
      ],
    ),
  ];
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          bool result = onPressBackButton();
          return await Future.value(result);
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('녹음자님 안녕하세요!'),
            centerTitle: true,
          ),
          body: Container(
            child: GridView.count(
              // padding: EdgeInsets.all(5),
              crossAxisCount: 2,
              children: List.generate(4, (index) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/record/book',
                      arguments: ScreenParameter(books[index]),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Center(
                      child: Image.network(books[index].image),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  bool onPressBackButton() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      scaffoldKey.currentState
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text("한 번 더 눌러 종료하기"),
        ));
      return false;
    }
    return true;
  }
}
