import 'package:flutter/material.dart';
import 'package:flutter_zoom_videosdk/native/zoom_videosdk.dart';
import 'package:flutter_zoom_videosdk_example/screens/call_screen.dart';
import 'package:flutter_zoom_videosdk_example/screens/intro_screen.dart';
import 'package:flutter_zoom_videosdk_example/screens/join_screen.dart';

class ZoomVideoSdkProvider extends StatelessWidget {
  const ZoomVideoSdkProvider({super.key});

  @override
  Widget build(BuildContext context) {
    var zoom = ZoomVideoSdk();
    InitConfig initConfig = InitConfig(domain: "zoom.us", enableLog: true);
    zoom.initSdk(initConfig);
    return const SafeArea(child: IntroScreen());
  }
}

void main() {
  runApp(
    MaterialApp(
      title: 'My app', // used by the OS task switcher
      home: Builder(
        builder: (context) {
          final stableTop = MediaQuery.of(context).viewPadding.top;
          return Padding(
            padding: EdgeInsets.only(top: stableTop),
            child: const ZoomVideoSdkProvider(),
          );
        },
      ),
      routes: {
        "Join": (context) => const JoinScreen(),
        "Call": (context) => const CallScreen(),
        "Intro": (context) => const IntroScreen(),
      },
    ),
  );
}
