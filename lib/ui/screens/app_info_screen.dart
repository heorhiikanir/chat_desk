import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:chat_desk/io/app_style.dart';
import 'package:chat_desk/ui/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher_string.dart';

class AppInfoScreen extends StatelessWidget {
  const AppInfoScreen({super.key});

  Future<int> _fetchStars() async {
    var request = await http
        .get(Uri.parse('https://api.github.com/repos/omegaui/chat_desk'));
    if (request.statusCode == 200) {
      var body = request.body;
      var json = jsonDecode(body);
      return json['stargazers_count'];
    }
    return -1;
  }

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
                  Hero(
                    tag: 'icon',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "assets/icon/app_icon_256.png",
                      ),
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
                      Hero(
                        tag: 'buttons',
                        child: AnimatedTextKit(
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
                child: GestureDetector(
                  onTap: () async {
                    var url = "https://github.com/omegaui/chat_desk";
                    if (await canLaunchUrlString(url)) {
                      await launchUrlString(url);
                    }
                  },
                  child: AppUtils.buildTooltip(
                    text: "Visit Repo",
                    child: Container(
                      width: 160,
                      height: 60,
                      decoration: BoxDecoration(
                        color: currentStyleMode == AppStyle.light
                            ? const Color(0xffc0c0c0).withOpacity(0.25)
                            : Colors.black.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: FutureBuilder(
                          future: _fetchStars(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Text(
                                "Fetching data ...",
                                style: TextStyle(
                                  fontFamily: "Sen",
                                  color: currentStyle.getTextColor(),
                                ),
                              );
                            }
                            if (snapshot.hasError || snapshot.data == -1) {
                              return Text(
                                "Cannot fetch Stars",
                                style: TextStyle(
                                  fontFamily: "Sen",
                                  color: currentStyle.getTextColor(),
                                ),
                              );
                            }
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    'assets/icon/icons8-github-96.png',
                                    width: 32,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "${snapshot.data}",
                                    style: TextStyle(
                                      fontFamily: "Sen",
                                      fontSize: 22,
                                      color: currentStyle.getTextColor(),
                                    ),
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow.shade800,
                                    size: 22,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
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
                    icon: Icon(
                      Icons.close,
                      color: currentStyle.getTextColor(),
                    ),
                    iconSize: 24,
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
