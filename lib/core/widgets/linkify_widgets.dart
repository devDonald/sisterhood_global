import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Text buildTextWithLinks(String textToLink) =>
    Text.rich(TextSpan(children: linkify(textToLink)));

Future<void> openUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

const String urlPattern = 'https?:/\/\\S+';
const String _userTagRegex = r'^(.*?)(?<![\w@])@([\w@]+(?:[.!][\w@]+)*)';
const String emailPattern = r'\S+@\S+';
const String phonePattern = r'[\d-]{9,}';
final RegExp linkRegExp = RegExp(
    '($urlPattern)|($emailPattern)|($phonePattern)|($_userTagRegex)',
    caseSensitive: false);

WidgetSpan buildLinkComponent(String text, String linkToOpen) => WidgetSpan(
        child: InkWell(
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.blueAccent,
          decoration: TextDecoration.underline,
        ),
      ),
      onTap: () => openUrl(linkToOpen),
    ));

List<InlineSpan> linkify(String text) {
  final List<InlineSpan> list = <InlineSpan>[];
  final RegExpMatch? match = linkRegExp.firstMatch(text);
  if (match == null) {
    list.add(TextSpan(text: text));
    return list;
  }

  if (match.start > 0) {
    list.add(TextSpan(text: text.substring(0, match.start)));
  }

  final String? linkText = match.group(0);
  if (linkText!.contains(RegExp(urlPattern, caseSensitive: false))) {
    list.add(buildLinkComponent(linkText, linkText));
  } else if (linkText.contains(RegExp(emailPattern, caseSensitive: false))) {
    list.add(buildLinkComponent(linkText, 'mailto:$linkText'));
  } else if (linkText.contains(RegExp(phonePattern, caseSensitive: false))) {
    list.add(buildLinkComponent(linkText, 'tel:$linkText'));
  } else if (linkText.contains(RegExp(_userTagRegex, caseSensitive: false))) {
    list.add(buildLinkComponent(linkText, linkText));
  } else {
    throw 'Unexpected match: $linkText';
  }

  list.addAll(linkify(text.substring(match.start + linkText.length)));

  return list;
}
