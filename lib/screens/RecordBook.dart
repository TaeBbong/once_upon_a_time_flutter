import 'dart:async';
import 'dart:io' as io;
import 'package:http/http.dart' as http;

import 'package:audioplayers/audioplayers.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:once_upon_a_time_app/models/Book.dart';
import 'package:once_upon_a_time_app/utils/ScreenParameter.dart';

class RecordBook extends StatefulWidget {
  final LocalFileSystem localFileSystem;

  RecordBook({localFileSystem})
      : this.localFileSystem = localFileSystem ?? LocalFileSystem();

  @override
  _RecordBookState createState() => _RecordBookState();
}

class _RecordBookState extends State<RecordBook> {
  Book book;
  int currentPage;
  FlutterAudioRecorder _recorder;
  Recording _current;
  RecordingStatus _currentStatus = RecordingStatus.Unset;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    final ScreenParameter screenParameter =
        ModalRoute.of(context).settings.arguments;
    book = screenParameter.book;
    currentPage = screenParameter.currentPage;
    List<String> pages = book.pages;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                book.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'THEvanillabean',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        body: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.72,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/background.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          pages[currentPage],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontFamily: 'THEvanillabean',
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.all(10),
                  // ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        (currentPage + 1).toString() +
                            '/' +
                            book.pages.length.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'THEvanillabean',
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.28,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    height: MediaQuery.of(context).size.height * 0.13,
                    // onPressed: _currentStatus == RecordingStatus.Stopped
                    //     ? onPlayAudio
                    //     : null,
                    onPressed: onPlayAudio,
                    child: Text(
                      "들어보기",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'THEvanillabean',
                        fontSize: 18,
                      ),
                    ),
                    color: Colors.blueGrey[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(15),
                    padding: EdgeInsets.all(8.0),
                    child: FlatButton(
                      height: MediaQuery.of(context).size.height * 0.2,
                      onPressed: () {
                        switch (_currentStatus) {
                          case RecordingStatus.Initialized:
                            {
                              _start();
                              break;
                            }
                          case RecordingStatus.Recording:
                            {
                              _pause();
                              break;
                            }
                          case RecordingStatus.Paused:
                            {
                              _resume();
                              break;
                            }
                          case RecordingStatus.Stopped:
                            {
                              // _init();
                              _nextPage();
                              break;
                            }
                          default:
                            break;
                        }
                      },
                      child: _buildText(_currentStatus),
                      color: Colors.amber[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  FlatButton(
                    height: MediaQuery.of(context).size.height * 0.13,
                    onPressed: _currentStatus != RecordingStatus.Stopped
                        ? _stop
                        : _init,
                    child: Text(
                      _currentStatus != RecordingStatus.Stopped ? "완료" : "다시하기",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'THEvanillabean',
                        fontSize: 18,
                      ),
                    ),
                    color: Colors.blueGrey[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _init() async {
    try {
      if (await FlutterAudioRecorder.hasPermissions) {
        String customPath = '/flutter_audio_recorder_';
        io.Directory appDocDirectory;
//        io.Directory appDocDirectory = await getApplicationDocumentsDirectory();
        if (io.Platform.isIOS) {
          appDocDirectory = await getApplicationDocumentsDirectory();
        } else {
          appDocDirectory = await getExternalStorageDirectory();
        }

        customPath = appDocDirectory.path +
            customPath +
            DateTime.now().millisecondsSinceEpoch.toString();
        _recorder =
            FlutterAudioRecorder(customPath, audioFormat: AudioFormat.WAV);

        await _recorder.initialized;
        var current = await _recorder.current(channel: 0);
        print(current);
        setState(() {
          _current = current;
          _currentStatus = current.status;
          print(_currentStatus);
        });
      } else {
        Scaffold.of(context).showSnackBar(
            SnackBar(content: Text("You must accept permissions")));
      }
    } catch (e) {
      print(e);
    }
  }

  _start() async {
    try {
      await _recorder.start();
      var recording = await _recorder.current(channel: 0);
      setState(() {
        _current = recording;
      });

      const tick = const Duration(milliseconds: 50);
      Timer.periodic(tick, (Timer t) async {
        if (_currentStatus == RecordingStatus.Stopped) {
          t.cancel();
        }

        var current = await _recorder.current(channel: 0);
        print(current.status);
        setState(() {
          _current = current;
          _currentStatus = _current.status;
        });
      });
    } catch (e) {
      print(e);
    }
  }

  _resume() async {
    await _recorder.resume();
    setState(() {});
  }

  _pause() async {
    await _recorder.pause();
    setState(() {});
  }

  _stop() async {
    var result = await _recorder.stop();
    print("Stop recording: ${result.path}");
    print("Stop recording: ${result.duration}");
    File file = widget.localFileSystem.file(result.path);
    print("File length: ${await file.length()}");
    setState(() {
      _current = result;
      _currentStatus = _current.status;
    });
  }

  _nextPage() async {
    // String result = await uploadImage(
    //     _current.path, 'https://ictcoc-server.herokuapp.com/records/');
    // print(result);
    if (currentPage + 1 == book.pages.length) {
      Navigator.pushReplacementNamed(context, '/record/done');
    } else {
      Navigator.pushReplacementNamed(
        context,
        '/record/book',
        arguments: ScreenParameter(book, currentPage + 1, []),
      );
    }
  }

  Future<String> uploadImage(filename, url) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('audio', filename));
    var res = await request.send();
    print(filename);
    return res.reasonPhrase;
  }

  Widget _buildText(RecordingStatus status) {
    var text = "";
    switch (_currentStatus) {
      case RecordingStatus.Initialized:
        {
          text = '시작하기';
          break;
        }
      case RecordingStatus.Recording:
        {
          text = '일시정지';
          break;
        }
      case RecordingStatus.Paused:
        {
          text = '이어서';
          break;
        }
      case RecordingStatus.Stopped:
        {
          text = (currentPage + 1) == book.pages.length ? '끝났어요!' : '다음페이지';
          break;
        }
      default:
        break;
    }
    return Text(
      text,
      style: TextStyle(
        color: Colors.black,
        fontFamily: 'THEvanillabean',
        fontSize: 30,
      ),
    );
  }

  void onPlayAudio() async {
    AudioPlayer audioPlayer = AudioPlayer();
    await audioPlayer.play(_current.path, isLocal: true);
  }
}
