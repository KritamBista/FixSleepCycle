import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:last/controller/alarm.dart';
import 'package:last/views/more.dart';

class ALarmView extends StatelessWidget {
  ALarmView({super.key});
  static onAlarm() {
    print("hello world");
  }

  DateTime? _alarmTime;

  @override
  Widget build(BuildContext context) {
    // final List<String> sounds = [
    //   "Default"
    //       "sound 1",
    //   "sound 2"
    // ];
    var controller = Get.find<AlarmController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Set Alarm",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(MoreView());
              },
              icon: Icon(Icons.more_vert)),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 200,
            child: Card(
              child: CupertinoTheme(
                data: const CupertinoThemeData(
                    textTheme: CupertinoTextThemeData(
                        dateTimePickerTextStyle:
                            TextStyle(fontSize: 30, color: Colors.black),
                        pickerTextStyle:
                            TextStyle(fontWeight: FontWeight.bold))),
                child: CupertinoDatePicker(
                    // itemExtent: 40,
                    initialDateTime: _alarmTime,
                    use24hFormat: false,
                    mode: CupertinoDatePickerMode.time,
                    onDateTimeChanged: (DateTime datetime) {
                      _alarmTime = datetime;
                      print(_alarmTime);
                    }),
              ),
            ),
          ),
          // DropdownButtonHideUnderline(
          //   child: DropdownButton(
          //       elevation: 0,
          //       value: controller.selectedSortoptions.value,
          //       // hint: const Text("sort by :"),
          //       items: controller.sortOptions.map((e) {
          //         return DropdownMenuItem(
          //           child: Text("sort by:$e"),
          //           value: e,
          //         );
          //       }).toList(),
          //       onChanged: (val) {
          //         controller.setItems(val!);
          //       }),
          // ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(
              "This app uses its own default sound which is scientifically proved for waking up fast",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size.fromWidth(Get.width * 0.3),
                backgroundColor: Colors.red,
                shape: const LinearBorder(),
              ),
              onPressed: () async {
                print("alarmTime :$_alarmTime");
                if (_alarmTime != null) {
                  DateTime now = DateTime.now();
                  DateTime scheduleTime = DateTime(now.year, now.month, now.day,
                      _alarmTime!.hour, _alarmTime!.minute, now.second);
                  print("scheduleTime :$scheduleTime");
                  if (scheduleTime.isBefore(now)) {
                    scheduleTime = scheduleTime.add(Duration(days: 1));
                    controller.scheduleAlarm(scheduleTime);
                    Get.snackbar(
                      'Success',
                      'Alarm scheduled sucessfully will ring after 24 hrs',
                      colorText: Colors.black,
                    );
                  }

                  controller.scheduleAlarm(scheduleTime);
                  Get.snackbar(
                    'Success',
                    'Alarm scheduled sucessfully',
                    colorText: Colors.black,
                  );
                }

                // await AndroidAlarmManager.oneShotAt(
                //   scheduleTime,
                //   1,
                //   _alarmCallback,
                //   alarmClock: false,
                //   exact: true,
                //   wakeup: true,
                // );
              },
              child: const Text(
                "Set Alarm",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              )),
          Spacer(),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "Powered By\n",
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(
                text: "        KB ",
                style: TextStyle(fontWeight: FontWeight.bold)),
          ]))
        ],
      ),
    );
  }
}
