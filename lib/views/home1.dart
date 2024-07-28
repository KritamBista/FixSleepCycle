import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:last/controller/alarm.dart';
import 'package:last/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static Future<void> stopcallback() async {
    print("stop callback");
    AndroidAlarmManager.cancel(1);
    playerx.stop();
  }

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<AlarmController>();
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        body: Obx(() {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    'Solve these math problems to stop the alarm',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Column(
                  children: List.generate(controller.problems.length, (index) {
                    final problem = controller.problems[index];

                    return Column(
                      children: [
                        Text(
                          '${problem.a} + ${problem.b} =',
                          style: const TextStyle(
                              fontSize: 24, color: Colors.white),
                        ),
                        const SizedBox(width: 10),
                        TextField(
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            // hoverColor: Colors.white,
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(
                                      0xFFD9D8D9)), // Border when not focused
                            ),
                            hoverColor: Colors.transparent,
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            controller.userAnswers[index] =
                                int.tryParse(value) ?? 0;
                          },
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white),
                        ),
                      ],
                    );
                    // return Row(
                    //   children: [
                    //     // Text(problem.toString()),
                    //     Text.rich(TextSpan(children: [
                    //       TextSpan(text: problem.a.toString()),
                    //       TextSpan(text: problem.b.toString()),
                    //     ])),
                    //     const SizedBox(width: 10),
                    //     SizedBox(
                    //       width: 50,
                    //       child: TextField(
                    //         keyboardType: TextInputType.number,
                    //         onChanged: (value) async {
                    //           controller.userAnswers[index] =
                    //               int.tryParse(value) ?? 0;
                    //         },
                    //       ),
                    //     )
                    //   ],
                    // );
                  }),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size.fromWidth(Get.width * 0.3),
                          backgroundColor: Colors.red,
                          shape: const LinearBorder(),
                        ),
                        onPressed: () async {
                          if (controller
                              .checkAnswerWith(controller.userAnswers)) {
                            await AndroidAlarmManager.oneShot(
                              const Duration(microseconds: 0),
                              2,
                              HomeView.stopcallback,
                              rescheduleOnReboot: true,
                              exact: true,
                              wakeup: true,
                            );
                            Get.snackbar('Great',
                                'Alarm is stopping in few seconds. Get ready for fight!',
                                colorText: Colors.white);
                          } else {
                            await HomeView.stopcallback();

                            Get.snackbar(
                                'Error', 'Incorrect answers, please try again.',
                                colorText: Colors.white);
                          }
                        },
                        child: const Text(
                          "SUBMIT",
                          style: TextStyle(color: Colors.white),
                        )),
                  ],
                )
              ]);
        }));
  }

  @override
  void initState() {
    // TODO: implement initState
    _clearNavigationData();
    super.initState();
  }
}

Future<void> _clearNavigationData() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('navigate');
}
