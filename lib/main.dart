import 'package:flutter/material.dart';

void main() => runApp(new PaaskeTidApp());

class PaaskeTidApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new PaaskeTidState();
  }
}

class PaaskeTidState extends State<PaaskeTidApp> {
  var _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("Tid for Påske"),
          actions: <Widget>[
            new IconButton(
                icon: new Icon(Icons.refresh),
                onPressed: () {
                  print("Reloading...");
                  setState(() {
                    _isLoading = !_isLoading;
                  });
                })
          ],
        ),
        body: new Center(
          child: _isLoading ? new CircularProgressIndicator() : new ClockView(),
        ),
      ),
    );
  }
}

class ClockView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var baseTime = new DateTime(2020, 01, 4);
    var startTime = new DateTime(2020, 01, 4, 2);
    var endTime = new DateTime(2020, 01, 05, 0);
    
    var baseTime2 = new DateTime(2020, 4, 4, 0);
    var startTime2 = new DateTime(2020, 4, 4, 10);
    var endTime2 = new DateTime(2020, 4, 8, 14);

    //baseTime = baseTime2; startTime = startTime2; endTime = endTime2;
    
    final time = new DateTime.now();

    // Check if startTime hasn't passed
    if (startTime.difference(time).inMilliseconds > 0) {
      final diff = startTime.difference(time);
      final days = diff.inDays;
      final hours = diff.inHours - diff.inDays * 24;
      final min = diff.inMinutes - diff.inHours * 60;
      final sec = diff.inSeconds - diff.inMinutes * 60;
      return new Text("Det er $days dager, $hours timer, $min minutter og $sec sekunder igjen til påska starter!");
    }
    // Check if endTime has passed
    else if (endTime.difference(time).inMilliseconds < 0) {
      return new Text("Påska er dessverre over for i år, men det er alltids neste år ;)");
    }
    // If within time-window, display time
    else {
      final diff = time.difference(baseTime);
      final days = diff.inHours ~/ 32 + 1; // How many 32 hours has passed, +1 for human readability
      final hours = diff.inHours % 32; // How many hours has passed, when accounting for 32 hour days
      final minutes = diff.inMinutes - diff.inHours * 60; // How many min has passed since start of last hour
      final seconds = diff.inSeconds - diff.inMinutes * 60; // How many sec has passed since start of last minute
      return new Column(
        children: <Widget>[
          new Container(height: 80.0),
          new Text("Vanlig tid er nå: " +
              time.hour.toString() +
              ":" +
              time.minute.toString() +
              ":" +
              time.second.toString()),
          new Text("Leirtid er nå: Dag $days kl. $hours:$minutes:$seconds"),
        ],
      );
    }
  }
}
