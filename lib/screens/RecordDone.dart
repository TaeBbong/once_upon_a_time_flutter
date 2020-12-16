import 'package:flutter/material.dart';

class RecordDone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.amber[400],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('녹음이 완료되었습니다!'),
              Text('3000원을 적립하였습니다.'),
              FlatButton(
                onPressed: null,
                child: Text('홈으로'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
