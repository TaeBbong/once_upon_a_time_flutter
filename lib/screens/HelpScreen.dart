import 'package:flutter/material.dart';
import 'package:once_upon_a_time_app/models/Book.dart';
import 'package:once_upon_a_time_app/utils/ScreenParameter.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ScreenParameter screenParameter =
        ModalRoute.of(context).settings.arguments;
    int currentPage = screenParameter.currentPage;
    List<String> help = screenParameter.help;
    Book book = screenParameter.book;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.amber[400],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                (currentPage + 1) != help.length + 1
                    ? '녹음을 시작하기 전에..'
                    : '그럼 이제부터 녹음을 시작하겠습니다.\n녹음 시작 버튼을 눌러주세요!',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'THEvanillabean',
                  fontSize: 30,
                ),
                textAlign: TextAlign.center,
              ),
              (currentPage + 1) == help.length + 1
                  ? Container()
                  : Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          help[currentPage],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'THEvanillabean',
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                      height: MediaQuery.of(context).size.height * 0.13,
                      onPressed: (currentPage + 1) != help.length + 1
                          ? () {
                              Navigator.pushReplacementNamed(context, '/help',
                                  arguments: ScreenParameter(
                                      book, currentPage + 1, help));
                            }
                          : () {
                              Navigator.pushReplacementNamed(
                                  context, '/record/book',
                                  arguments: ScreenParameter(book, 0, []));
                            },
                      child: Text(
                        (currentPage + 1) == help.length + 1
                            ? '  녹음 시작  '
                            : '    다음    ',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'THEvanillabean',
                          fontSize: 30,
                        ),
                      ),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.only(right: 35),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, '/record/book',
                              arguments: ScreenParameter(book, 0, []));
                        },
                        child: Text(
                          '건너뛰기',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'THEvanillabean',
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
