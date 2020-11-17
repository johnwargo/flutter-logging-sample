import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class LoggingApp extends StatefulWidget {
  LoggingApp({Key key, this.title, this.log}) : super(key: key);

  final String title;
  final Logger log;

  @override
  _LoggingAppState createState() => _LoggingAppState(log);
}

class _LoggingAppState extends State<LoggingApp> {
  _LoggingAppState(this.log);

  final Logger log;
  int _counter = 0;

  void _incrementCounter() {
    // Zero or more of these messages will print to the console depending
    // on what the log level is set in `main.dart`
    log.shout('Shout message');
    log.severe('Severe message');
    log.warning('Warning message');
    log.info('Info message');
    log.config('Config message');
    log.fine('Fine message');
    log.finer('Finer message');
    log.finest('Finest message');

    log.info('Ha! Incrementing counter');
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Button pushed this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
