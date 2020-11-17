# Flutter Logging Sample

I use `print` statements in my apps (Flutter and others) to help me better understand what's happening in the app as it runs. I'll use the Debugger when I need to, but print statements help me learn as I code, so they're everywhere. I'm working on my second Flutter app I'll submit to the app stores and started thinking about a better way to use print statements in my app. I recently learned how to effectively use logging in Python apps, so I thought there might be a corresponding way to do it in Flutter (and there is). 

The Flutter dev team published the [logging](https://pub.dev/packages/logging) package earlier this year, so I thought I'd give it a try in an app (this app, the one in this repository).  The team did an OK job documenting how it works, but some details were missing from the docs (I had to go to the library's source code, for example, to figure out what the logging levels were) so I decided to publish my learning app so others can see a fully functional example when the add logging to their Flutter apps. 

In this app, I took the standard Flutter sample app (incrementing a counter) and added some output to the app's `_incrementCounter` method that looks like this:


``` text
I/flutter (17244): 11:40:11:049 SHOUT   : Shout message
I/flutter (17244): 11:40:11:097 SEVERE  : Severe message
I/flutter (17244): 11:40:11:097 WARNING : Warning message
I/flutter (17244): 11:40:11:098 INFO    : Info message
I/flutter (17244): 11:40:11:098 CONFIG  : Config message
I/flutter (17244): 11:40:11:098 FINE    : Fine message
I/flutter (17244): 11:40:11:099 FINER   : Finer message
I/flutter (17244): 11:40:11:099 FINEST  : Finest message
I/flutter (17244): 11:40:11:099 INFO    : Ha! Incrementing counter
```

What you'll see in the output varies depending on how you setup logging in your app.

Let me show  you how I did it.

In the app's `main.dart` file, I added a couple of libraries:

```dart
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
```

You'll need to update the project's `pubspec.yaml` file to load the libraries in the project. 

Next, I created a `log` object I can use to write to the logger:

```dart
final log = Logger('FlutterLoggingSample');
```

Finally, in `main` I did the following:

```dart
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
```

Here I define the log level for the app - when you call logger to write data to the log, only the messages sent at the set log level, and below, will make it to the console.

I also setup a `DateFormat` object I'll use in a little while to format the output from the log; you'll see how/why in a minute.

Finally, I setup the `onRecord` listener that's called whenever a message is sent to the log at or below the current log level. 

 When it comes to outputting the message, you have complete control over that in the event listener. The example provided by the Google team writes the date, level and message to the console, but I wanted to format it a little differently. For mine, I stripped out the date and formatted the time value just the way I wanted. 

I also wanted the output in columns, so I used Dart's cool string math to generate the necessary column spaces between the level string and my output message as shown in the following code:

```dart
// format the date the way I want it
String formattedDate = DateFormat('HH:mm:ss:SS').format(record.time);
// Build a string with the number of spaces we need between the label
// and the message
String spaces = ' ' * (7 - record.level.name.length);
// Print the message (formatted)
print('$formattedDate ${record.level.name}$spaces : ${record.message}');
```

In the code, the `7` represents the length of the widest level name (warning).

Finally, the app writes a bunch of junk to the logger whenever the user taps the app's floating button using the following code:

```dart
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
```

A simple and silly example, but it's a complete example of how to use the logging library.

***

If you find this code useful, and feel like thanking me for providing it, please consider making a purchase from [my Amazon Wish List](https://amzn.com/w/1WI6AAUKPT5P9). You can find information on many different topics on my [personal blog](http://www.johnwargo.com). Learn about all of my publications at [John Wargo Books](http://www.johnwargobooks.com).