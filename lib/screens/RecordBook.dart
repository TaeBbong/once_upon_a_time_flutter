import 'dart:async';
import 'dart:io' as io;

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
    final ScreenParameter screenParameter =
        ModalRoute.of(context).settings.arguments;
    book = screenParameter.book;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(book.title),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FlatButton(
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
                                  _init();
                                  break;
                                }
                              default:
                                break;
                            }
                          },
                          child: _buildText(_currentStatus),
                          color: Colors.lightBlue,
                        ),
                      ),
                      FlatButton(
                        onPressed: _currentStatus != RecordingStatus.Unset
                            ? _stop
                            : null,
                        child:
                            Text("Stop", style: TextStyle(color: Colors.white)),
                        color: Colors.blueAccent.withOpacity(0.5),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      FlatButton(
                        onPressed: onPlayAudio,
                        child:
                            Text("Play", style: TextStyle(color: Colors.white)),
                        color: Colors.blueAccent.withOpacity(0.5),
                      ),
                    ],
                  ),
                  Text("Status : $_currentStatus"),
                  Text('Avg Power: ${_current?.metering?.averagePower}'),
                  Text('Peak Power: ${_current?.metering?.peakPower}'),
                  Text("File path of the record: ${_current?.path}"),
                  Text("Format: ${_current?.audioFormat}"),
                  Text(
                      "isMeteringEnabled: ${_current?.metering?.isMeteringEnabled}"),
                  Text("Extension : ${_current?.extension}"),
                  Text(
                      "Audio recording duration : ${_current?.duration.toString()}")
                ]),
          ),
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

  Widget _buildText(RecordingStatus status) {
    var text = "";
    switch (_currentStatus) {
      case RecordingStatus.Initialized:
        {
          text = 'Start';
          break;
        }
      case RecordingStatus.Recording:
        {
          text = 'Pause';
          break;
        }
      case RecordingStatus.Paused:
        {
          text = 'Resume';
          break;
        }
      case RecordingStatus.Stopped:
        {
          text = 'Init';
          break;
        }
      default:
        break;
    }
    return Text(text, style: TextStyle(color: Colors.white));
  }

  void onPlayAudio() async {
    AudioPlayer audioPlayer = AudioPlayer();
    await audioPlayer.play(_current.path, isLocal: true);
  }
}
