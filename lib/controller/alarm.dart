import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get/get.dart';
import 'package:last/main.dart';
import 'package:last/model/maths.dart';

class AlarmController extends GetxController {
  var problems =
      List<MathProblem>.generate(3, (_) => MathProblem.generate()).obs;
  var userAnswers = List<int>.generate(3, (_) => 0).obs;

  bool checkAnswerWith(List<int> answers) {
    for (int i = 0; i < problems.length; i++) {
      if (problems[i].answer != answers[i]) {
        return false;
      }
    }
    return true;
  }

  Future<void> scheduleAlarm(DateTime scheduledNotificationDateTime) async {
    print("ram");

    await AndroidAlarmManager.oneShotAt(
        scheduledNotificationDateTime, 1, alarmCallback,
        alarmClock: true, wakeup: true, exact: true);
  }

  void resetProblems() {
    problems.value =
        List<MathProblem>.generate(3, (_) => MathProblem.generate());
    userAnswers.value = List<int>.generate(3, (_) => 0);
  }

  static void alarmCallback() async {
    print("we will be fine");

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: -1, // -1 is replaced by a random number
          channelKey: 'alerts',
          title: 'Wake UP!',
          body: "Time to push yourself buddy!",

          //'asset://assets/images/balloons-in-sky.jpg',
          notificationLayout: NotificationLayout.BigPicture,
          payload: {'navigate': 'true'}),
    );
    playerx.setReleaseMode(ReleaseMode.loop);
    playerx.play(AssetSource("sounds/wake_up.mp3"));

    // You can perform any action here, like showing a notification
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
