import 'dart:async';
import 'dart:typed_data';

import 'package:camera_macos/camera_macos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screenshot/screenshot.dart';
import 'package:timer_application/platform_channels/camera_service.dart';
import 'package:timer_application/widgets/home/bloc/home_bloc.dart';
import 'package:timer_application/widgets/home/screens/tabs/screen_shot_tab.dart';

import '../../../constant/color.dart';
import '../../3d_buttons.dart';
import '../../count_up_timer/count_timer.dart';
import '../../count_up_timer/count_timer_widget.dart';
import 'tabs/head_shot_tab.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CountTimerController controller;
  ScreenshotController screenshotController = ScreenshotController();

  late CameraMacOSController macOSController = CameraMacOSController(CameraMacOSArguments(size: Size(100, 100)));

  late HomeBloc homeBloc;
  @override
  void initState() {
    super.initState();
    homeBloc = context.read<HomeBloc>();

    controller = CountTimerController(
      onTimeUpdate10Sec: () {},
      onTimeUpdate: (duration) async {
        Uint8List? image = await screenshotController.capture();
        if (image != null) {
          homeBloc.add(AddScreenShot(image: image));
         // macOSController.takePicture();
          CameraService.captureHeadshot();
        }
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screenshot(
        controller: screenshotController,
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primaryColor, Colors.black87],
              stops: [0.01, 1],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20,),
              CountTimer(
                format: CountTimerFormat.daysHoursMinutesSeconds,
                spacerWidth: 8,
                daysDescription: "Days",
                hoursDescription: "Hours",
                minutesDescription: "Minutes",
                secondsDescription: "Seconds",
                timeTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                descriptionTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
                colonsTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                controller: controller,
              ),
              const SizedBox(height: 10),
              Button3d(
                stretch: false,
                borderThickness: 1,
                borderRadius: 100,
                width: 90,
                height: 90,
                startColor: AppColors.startColorOf3dButton,
                endColor: AppColors.endColorOf3dButton,
                borderColor: AppColors.endColorOf3dButton,
                gradientOrientation: GradientOrientation.vertical,
                onTap: (finish) {
                  setState(() {
                    controller.isPlaying ? controller.pause() : controller.start(startFromSeconds: 1);
                  });
                },
                child: Center(
                  child: Icon(
                    !controller.isPlaying ? CupertinoIcons.play_arrow_solid : CupertinoIcons.pause_fill,
                    color: Colors.white,
                    size: 48,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Divider(color: Colors.white54, height: 1),
              Expanded(
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      TabBar(
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.white54,
                        dividerColor: Colors.white54,
                        indicatorColor: Colors.white,
                        indicatorSize: TabBarIndicatorSize.tab,
                        tabs: [
                          Tab(text: 'Screenshots'),
                          Tab(text: 'Headshots'),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            ScreenshotTab(),
                            HeadshotTab(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




