import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutterchallenge/widgets/dateListWidget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final now = DateTime.now();

  // Example list of events
  final List<Map<String, dynamic>> events = [
    {
      "title": "DESIGN MEETING",
      "startTime": "11:30",
      "endTime": "12:20",
      "participants": ["Alex", "Helena", "Nana"],
      "color": Color(0xFFFFF176), // Yellow
    },
    {
      "title": "DAILY PROJECT",
      "startTime": "12:35",
      "endTime": "14:10",
      "participants": ["Me", "Richard", "Ciry", "+4"],
      "color": Color(0xFFBA68C8), // Purple
    },
    {
      "title": "WEEKLY PLANNING",
      "startTime": "15:00",
      "endTime": "16:30",
      "participants": ["Den", "Nana", "Mark"],
      "color": Color(0xFF81C784), // Green
    },
  ];

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat("EEEE, d").format(now);

    return Scaffold(
      backgroundColor: Color(0xff1f1f1f),
      appBar: AppBar(
        backgroundColor: Color(0xff1f1f1f),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              padding: EdgeInsets.all(8.0),
              icon: Container(
                width: 50,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Icon(Icons.person, color: Colors.white, size: 40),
              ),
              iconSize: 50,
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.add, color: Colors.white),
              iconSize: 40,
              onPressed: () {},
            )
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              formattedDate,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Datelistwidget(),
          ),
          SizedBox(
            height: 20,
            child: DecoratedBox(decoration: BoxDecoration(color: Colors.white)),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return Container(
                  height: 200, // Fixed height for each event
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: event["color"],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${event['startTime']} - ${event['endTime']}",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        event['title'],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Text(
                        event['participants'].join(", "),
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
