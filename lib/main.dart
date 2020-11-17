import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

import 'pages/home.dart';

const APP_TITLE = 'Flutter Logging Sample?';

final log = Logger('FlutterLoggingSample');

// From the documentation at https://github.com/dart-lang/logging
// [Level]s to control logging output. Logging can be enabled to include all
// levels above certain [Level]. [Level]s are ordered using an integer
// value [Level.value]. The predefined [Level] constants below are sorted as
// follows (in descending order): [Level.SHOUT], [Level.SEVERE],
// [Level.WARNING], [Level.INFO], [Level.CONFIG], [Level.FINE], [Level.FINER],
// [Level.FINEST], and [Level.ALL].

void main() {
  final f = new DateFormat('yyyy-MM-dd hh:mm');

  // Note: when debugging, you must reload the app as live-reload won't
  // catch changes to these values.

  // Pick one of the following levels, and the output messages up to that
  // level will be printed to the console.
  // Logger.root.level = Level.OFF;
  // Logger.root.level = Level.SHOUT;
  // Logger.root.level = Level.SEVERE;
  // Logger.root.level = Level.WARNING;
  // Logger.root.level = Level.INFO;
  // Logger.root.level = Level.CONFIG;
  // Logger.root.level = Level.FINE;
  // Logger.root.level = Level.FINER;
  // Logger.root.level = Level.FINEST;
  Logger.root.level = Level.ALL;

  Logger.root.onRecord.listen((record) {
    // format the date the way I want it
    String formattedDate = DateFormat('HH:mm:ss:SS').format(record.time);
    // Build a string with the number of spaces we need between the label
    // and the message
    String spaces = ' ' * (7 - record.level.name.length);
    // Print the message (formatted)
    print('$formattedDate ${record.level.name}$spaces : ${record.message}');
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_TITLE,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoggingApp(title: APP_TITLE, log: log),
    );
  }
}
