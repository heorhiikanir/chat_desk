import 'package:chat_desk/core/io/message.dart';
import 'package:chat_desk/io/app_style.dart';
import 'package:chat_desk/io/server_handler.dart';
import 'package:chat_desk/ui/screens/chat_room/controls/chat_components/text_file_chat_components.dart';
import 'package:chat_desk/ui/screens/chat_room/controls/chat_components/url_chat_component.dart';
import 'package:chat_desk/ui/screens/chat_room/controls/image_holder.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart' as text_validator;

class Chat extends StatelessWidget {
  const Chat({
    super.key,
    required this.message,
  });

  final Message message;

  @override
  Widget build(BuildContext context) {
    bool isURL = message.type == 'text' &&
        text_validator.isURL(message.message) &&
        message.message.contains("://");
    return Row(
      mainAxisAlignment: message.sender == thisClient.id
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        if (message.sender == thisClient.id)
          Text(
            message.time,
            style: TextStyle(
                fontFamily: "Sen",
                fontSize: 14,
                color: Colors.grey
                    .withOpacity(currentStyleMode == AppStyle.dark ? 0.6 : 1)),
          ),
        if (message.type == 'text' && !isURL)
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              child: Text(
                message.message,
                style: TextStyle(
                  fontFamily: "Sen",
                  fontSize: 16,
                  color: currentStyle.getTextColor(),
                ),
              ),
            ),
          ),
        if (message.type == 'text' && isURL) UrlChatComponent(message: message),
        if (message.type == 'image')
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 4.0,
            ),
            child: ImageHolder(message: message),
          ),
        if (message.type == 'text-file')
          TextFileChatComponent(message: message),
        if (message.sender != thisClient.id)
          Text(
            message.time,
            style: TextStyle(
                fontFamily: "Sen",
                fontSize: 14,
                color: Colors.grey
                    .withOpacity(currentStyleMode == AppStyle.dark ? 0.6 : 1)),
          ),
      ],
    );
  }
}
