import 'package:flutter/material.dart';
import 'package:sisterhood_global/core/widgets/vertical_divider.dart';

class NumbersWidget extends StatelessWidget {
  final String? nPost, nFollowing, nFollowers;
  const NumbersWidget(
      {Key? key,
      required this.nPost,
      required this.nFollowing,
      required this.nFollowers})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildButton(context, nPost!, 'Posts'),
          const VertDivider(),
          buildButton(context, nFollowing!, 'Following'),
          const VertDivider(),
          buildButton(context, nFollowers!, 'Followers'),
        ],
      );

  Widget buildButton(BuildContext context, String value, String text) =>
      MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 2),
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}
