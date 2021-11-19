import 'package:flutter/material.dart';
import 'package:sisterhood_global/core/themes/theme_colors.dart';
import 'package:sisterhood_global/core/themes/theme_text.dart';

class PrimaryButton extends StatefulWidget {
  final Color color;
  final String buttonTitle;
  final double blurRadius;
  final double roundedEdge;
  final double width;
  final double height;
  final void Function() onTap;
  final bool busy;
  final bool enabled;

  const PrimaryButton({
    Key? key,
    required this.buttonTitle,
    required this.blurRadius,
    required this.roundedEdge,
    required this.color,
    required this.onTap,
    this.busy = false,
    this.enabled = false,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: InkWell(
        child: Container(
          width: (widget.width != null) ? widget.width : 30,
          height: (widget.height != null) ? widget.height : 30,
          // height: widget.busy ? 40 : 45.0,
          // width: widget.busy ? 40 : double.infinity,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: widget.color.withOpacity(0.30),
                blurRadius: (widget.blurRadius != null) ? widget.blurRadius : 4,
              ),
            ],
            borderRadius: BorderRadius.circular(
                (widget.roundedEdge != null) ? widget.roundedEdge : 4),
            color: (widget.color != null)
                ? widget.color
                : JanguAskColors.primaryColor,
          ),
          child: Center(
            child: !widget.busy
                ? Text(
                    (widget.buttonTitle != null) ? widget.buttonTitle : '',
                    style: TextStyle(
                      color: JanguAskColors.whiteColor,
                      fontWeight: JanguAskFontWeight.kBoldText,
                    ),
                  )
                : CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      JanguAskColors.whiteColor,
                    )),
          ),
        ),
      ),
    );
  }
}
