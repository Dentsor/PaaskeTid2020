import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

void main() => runApp(new PaaskeTidApp());

class PaaskeTidApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => PaaskeTidState();
  /*
  @override
  State<StatefulWidget> createState() {
    return new PaaskeTidState();
  }
   */
}

class PaaskeTidState extends State<PaaskeTidApp> {

  Random rng;
  int img;

  @override
  void initState() {
    super.initState();
    rng = new Random();
    img = -1;
  }

  @override
  Widget build(BuildContext context) {

    // Select a (new) random background image
    int newImg;
    do { newImg = rng.nextInt(30);
    } while (newImg == img);
    img = newImg;

    String path = 'assets/backgrounds/'
        + img.toString().padLeft(2, '0')
        +'.jpg';

    // print(path);

    return new Container(
          decoration: new BoxDecoration(
          image: new DecorationImage(
          image: AssetImage(path),
      fit: BoxFit.cover
      )
      ),
      child: new Center(
        child: new ClockView(),
      )
    );

    /*
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("Tid for Påske"),
          actions: <Widget>[
            new IconButton(
                icon: new Icon(Icons.refresh),
                onPressed: () {
                  setState(() {});
                })
          ],
        ),
        body: new Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: AssetImage(path),
              fit: BoxFit.cover
            )
          ),
          child: new Center(
            child: new ClockView(),
          ),
        ),
      ),
    );
     */
  }
}

class ClockView extends StatefulWidget {
  //_SimpleClockState createState() => _SimpleClockState
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<ClockView> {

  String _displayString; // The string to be printed
  Timer _trigger; // A timer triggering an update every second

  @override
  void initState() {
    super.initState();

    // Initialize displayString
    _displayString = _retrieveDisplayString(DateTime.now());

    // Initialize timer for triggering every second
    _trigger = Timer.periodic(Duration(seconds: 1), (Timer t) {

      // If not mounted return without doing anything
      if (!mounted)
        return;

      // Else, set new displayString and update view
      setState(() {
        _displayString = _retrieveDisplayString(DateTime.now());
      });
    });
  }

  // Format current time for display
  String _retrieveDisplayString(DateTime time) {
    var baseTime = new DateTime(2020, 4, 4, 0);
    var startTime = new DateTime(2020, 4, 4, 10);
    var endTime = new DateTime(2020, 4, 8, 14);

    var baseTime2 = new DateTime(2020, 3, 9);
    var startTime2 = new DateTime(2020, 3, 10, 10);
    var endTime2 = new DateTime(2020, 3, 16, 0);

    baseTime = baseTime2; startTime = startTime2; endTime = endTime2;

    // Check if startTime hasn't passed
    if (startTime.difference(time).inMilliseconds > 0) {
      final diff = startTime.difference(time);
      final days = diff.inDays;
      final hours = (diff.inHours - diff.inDays * 24).toString().padLeft(2, '0');
      final min = (diff.inMinutes - diff.inHours * 60).toString().padLeft(2, '0');
      final sec = (diff.inSeconds - diff.inMinutes * 60).toString().padLeft(2, '0');
      return "$days dager $hours:$min:$sec \n til påska starter!";
    }
    // Check if endTime has passed
    else if (endTime.difference(time).inMilliseconds < 0) {
      return "Påska er dessverre over for i år,\nmen det er alltids neste år ;)";
    }
    // If within time-window, display time
    else {
      final diff = time.difference(baseTime);
      final days = diff.inHours ~/ 32 + 1; // How many 32 hours has passed, +1 for human readability
      final hours = (diff.inHours % 32).toString().padLeft(2, '0'); // How many hours has passed, when accounting for 32 hour days
      final minutes = (diff.inMinutes - diff.inHours * 60).toString().padLeft(2, '0'); // How many min has passed since start of last hour
      final seconds = (diff.inSeconds - diff.inMinutes * 60).toString().padLeft(2, '0'); // How many sec has passed since start of last minute
      return "Dag $days"
          +"\n$hours:$minutes:$seconds";
      ;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Center(
        child: GestureDetector(
            onTap: () {},
            child: Container(
                decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Color.fromRGBO(255, 255, 255, 80),
                ),
                padding: EdgeInsets.all(50),
                child: Text(_displayString,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w300,
                    )))));
  }
}
