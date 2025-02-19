import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Datelistwidget extends StatelessWidget {
  const Datelistwidget({super.key});

  List<String> makedatelist() {
    DateTime now = DateTime.now();
    List<String> datelist = [];

    for (var i = 0; i < 6; i++) {
      DateTime date = now.add(Duration(days: i));
      if (i == 0) {
        datelist.add("TODAY");
      } else {
        String formattedDate = DateFormat("d").format(date);
        datelist.add(formattedDate);
      }
    }
    return datelist;
  }

  @override
  Widget build(BuildContext context) {
    List<String> datelist = makedatelist();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < datelist.length; i++) ...[
            // 날짜 출력
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                datelist[i],
                style: TextStyle(
                  fontSize: 40,
                  color:
                      datelist[i] == "TODAY" ? Colors.white : Colors.grey[400],
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            // TODAY와 다음 날짜 사이에만 점 추가
            if (i == 0)
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.purple,
                  shape: BoxShape.circle,
                ),
              ),
          ]
        ],
      ),
    );
  }
}
