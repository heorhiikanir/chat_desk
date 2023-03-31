import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:chat_desk/io/app_style.dart';
import 'package:chat_desk/ui/utils.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AppInfoScreen extends StatelessWidget {
  const AppInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: currentStyle.getBackground(),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 250),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      "assets/icon/app_icon_256.png",
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "chat desk",
                    style: TextStyle(
                      fontFamily: "Audiowide",
                      fontSize: 32,
                      color: currentStyle.getTextColor(),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "beta-release v0.8",
                    style: TextStyle(
                      fontFamily: "Sen",
                      fontSize: 20,
                      color: currentStyle.getTextColor(),
                    ),
                  ),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "written with ❤️ by",
                        style: TextStyle(
                          fontFamily: "Sen",
                          fontSize: 18,
                          color: currentStyle.getTextColor(),
                        ),
                      ),
                      AnimatedTextKit(
                        animatedTexts: [
                          ColorizeAnimatedText(
                            "omegaui",
                            textStyle: TextStyle(
                              fontFamily: "Audiowide",
                              fontSize: 22,
                              color: currentStyle.getTextColor(),
                            ),
                            colors: [
                              Colors.pink,
                              Colors.grey,
                              Colors.blue,
                              Colors.white,
                            ],
                          ),
                        ],
                        isRepeatingAnimation: true,
                        repeatForever: true,
                      ),
                      const SizedBox(height: 30),
                    ],
                  ))
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: AppUtils.buildTooltip(
                  text: "Visit Repo",
                  child: IconButton(
                    onPressed: () async {
                      var url = "https://github.com/omegaui/chat_desk";
                      if (await canLaunchUrlString(url)) {
                        await launchUrlString(url);
                      }
                    },
                    iconSize: 48,
                    icon: Image.asset('assets/icon/icons8-github-96.png'),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: AppUtils.buildTooltip(
                  text: "Close",
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    iconSize: 24,
                    icon: Icon(
                      Icons.close,
                      color: currentStyle.getTextColor(),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: MoveWindow(),
            )
          ],
        ),
      ),
    );
  }
}
