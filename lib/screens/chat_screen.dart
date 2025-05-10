import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/chat_controller.dart';
import '../widgets/base_scaffold.dart';
import '../widgets/typing_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/custom_rich_text.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  static const String routeName = '/chat';

  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  RichTextData textTransformation({
    required BuildContext context,
    required String text,
  }) {
    final locRegex = RegExp(r'<loc_(\d+)>');
    final urlRegex = RegExp(r'<url_(https?://[^\s]+)>');
    final regex = RegExp(r'(<loc_(\d+)>|<url_(https?://[^\s]+)>)');

    final matches = regex.allMatches(text);

    final richText = RichTextData(textWithTags: []);

    var currentIndex = 0;

    for (final match in matches) {
      final beforeText = text.substring(currentIndex, match.start);

      if (beforeText.isNotEmpty) {
        richText.textWithTags.add(
          TextWithTag(
            text: beforeText,
          ),
        );
      }

      final locMatch = locRegex.firstMatch(match.group(0)!);
      final urlMatch = urlRegex.firstMatch(match.group(0)!);

      if (locMatch != null) {
        final locationNumber = locMatch.group(1);
        final locationKey = 'loc_$locationNumber';
        final locationName = AppLocalizations.of(context)!.getString(locationKey);
        richText.textWithTags.add(
          TextWithTag(
            text: locationName,
            style: TextStyle(color: Colors.blue),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                final locationId = int.tryParse(locationNumber ?? '');
                if (locationId != null) {
                  Get.offNamed('/map', arguments: {'initialLocationId': locationId});
                }
              },
          ),
        );
      } else if (urlMatch != null) {
        final url = urlMatch.group(1);
        richText.textWithTags.add(
          TextWithTag(
            text: url,
            style: TextStyle(color: Colors.blue),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                final uri = Uri.parse(url!);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                } else {
                  throw 'Could not launch $url';
                }
              },
          ),
        );
      }

      currentIndex = match.end;
    }

    final remainingText = text.substring(currentIndex);

    if (remainingText.isNotEmpty) {
      richText.textWithTags.add(
        TextWithTag(
          text: remainingText,
        ),
      );
    }

    return richText;
  }

  @override
  Widget build(BuildContext context) {
    final chatController = Get.put<ChatController>(ChatController());

    return BaseScaffold(
      appBarTitle: AppLocalizations.of(context)!.chatScreenTitle,
      body: Obx(() {
        return Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  GetBuilder<ChatController>(builder: (controller) {
                    return chatController.isLoading.value
                        ? Center(child: const CircularProgressIndicator.adaptive())
                        : ListView.builder(
                            controller: chatController.scrollController,
                            itemCount: chatController.messages.length + 2,
                            reverse: true,
                            itemBuilder: (context, index) {
                              if (index == 1) {
                                return TypingIndicator(
                                  isTyping: chatController.isTyping.value,
                                );
                              }
                              if (index == 0) {
                                return SizedBox(
                                  height:
                                      Theme.of(context).platform == TargetPlatform.iOS ? 22 : 56,
                                );
                              }
                              final message = chatController.messages[index - 2];
                              return ListTile(
                                title: Align(
                                  alignment: message.isSentByUser
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: Container(
                                    margin: message.isSentByUser
                                        ? const EdgeInsets.only(left: 100)
                                        : const EdgeInsets.only(right: 100),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: message.isSentByUser
                                          ? Colors.blue
                                          : const Color.fromARGB(255, 80, 80, 80),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: CustomRichText(
                                      richTextData: textTransformation(
                                        context: context,
                                        text: message.message,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                  }),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: SizedBox(
                      height: 60,
                      child: RawScrollbar(
                        scrollbarOrientation: ScrollbarOrientation.top,
                        controller: _scrollController,
                        interactive: false,
                        thumbVisibility: true,
                        child: ListView.builder(
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          itemCount: chatController.sampleQuestions.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: chatController.isLoading.value
                                  ? null
                                  : () {
                                      final message = chatController.sampleQuestions[index];
                                      chatController.addMessage(message, true);
                                    },
                              child: Container(
                                margin: EdgeInsets.only(
                                  right: 8.0,
                                  left: 8.0,
                                  bottom: 8.0,
                                  top: 8.0,
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey[700],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    chatController.sampleQuestions[index],
                                    style:
                                        const TextStyle(color: Color.fromARGB(255, 230, 230, 230)),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 70,
                    right: 16,
                    child: chatController.showScrollDownButton.value
                        ? FadeTransition(
                            opacity: AlwaysStoppedAnimation(1.0),
                            child: FloatingActionButton(
                              onPressed: chatController.animateToBottom,
                              child: const Icon(Icons.arrow_downward),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 8.0,
                left: 8.0,
                bottom: 8.0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      enabled: !chatController.isLoading.value,
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.chatScreenInputHint,
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: chatController.isLoading.value
                        ? null
                        : () {
                            final message = _controller.text;
                            if (message.isNotEmpty) {
                              chatController.addMessage(message, true);
                              _controller.clear();
                            }

                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Warning'),
                                  content: Text('Are you sure?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/other-screen');
                                      },
                                      child: Text('Send'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

extension AppLocalizationsExtension on AppLocalizations {
  String getString(String key) {
    //TODO Deniz, yeni lokasyonlar eklendiğinde burayı güncelle, önemli.
    final map = {
      'loc_1': loc_1,
      'loc_2': loc_2,
      'loc_3': loc_3,
      'loc_4': loc_4,
      'loc_5': loc_5,
      'loc_6': loc_6,
      'loc_7': loc_7,
      'loc_8': loc_8,
      'loc_9': loc_9,
      'loc_10': loc_10,
      'loc_11': loc_11,
      'loc_12': loc_12,
      'loc_13': loc_13,
      'loc_14': loc_14,
      'loc_15': loc_15,
      'loc_16': loc_16,
      'loc_17': loc_17,
      'loc_18': loc_18,
      'loc_19': loc_19,
      'loc_20': loc_20,
      'loc_21': loc_21,
      'loc_22': loc_22,
      'loc_23': loc_23,
      'loc_24': loc_24,
      'loc_25': loc_25,
      'loc_26': loc_26,
      'loc_27': loc_27,
      'loc_28': loc_28,
      'loc_29': loc_29,
      'loc_30': loc_30,
      'loc_31': loc_31,
      'loc_32': loc_32,
      'loc_33': loc_33,
      'loc_34': loc_34,
      'loc_35': loc_35,
      'loc_36': loc_36,
      'loc_37': loc_37,
      'loc_38': loc_38,
      'loc_39': loc_39,
      'loc_40': loc_40,
      'loc_41': loc_41,
      'loc_42': loc_42,
      'loc_43': loc_43,
      'loc_44': loc_44,
      'loc_45': loc_45,
      'loc_46': loc_46,
      'loc_47': loc_47,
      'loc_48': loc_48,
      'loc_49': loc_49,
      'loc_50': loc_50,
      'loc_51': loc_51,
      'loc_52': loc_52,
      'loc_53': loc_53,
      'loc_54': loc_54,
      'loc_55': loc_55,
      'loc_56': loc_56,
    };
    return map[key] ?? key;
  }
}
