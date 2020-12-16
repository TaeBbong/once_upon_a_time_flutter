import 'package:flutter/material.dart';

class RecordDone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.amber[400],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    '녹음이 완료되었습니다!',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'THEvanillabean',
                      fontSize: 30,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                  ),
                  Text(
                    '2000원을 적립하였습니다.',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'THEvanillabean',
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
              FlatButton(
                height: MediaQuery.of(context).size.height * 0.13,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/record');
                },
                child: Text(
                  '    홈으로 돌아가기    ',
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
