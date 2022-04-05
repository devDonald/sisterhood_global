import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sisterhood_global/core/themes/theme_colors.dart';

// import 'package:standart/features/store/data/models/store_model.dart';
// import 'package:standart/features/store/presentation/bloc/store_bloc.dart';

class TalkDetails extends StatefulWidget {
  static const routeName = "TalkDetails";

  const TalkDetails({Key? key}) : super(key: key);
  @override
  _TalkDetailsState createState() => _TalkDetailsState();
}

class _TalkDetailsState extends State<TalkDetails> {
  GlobalKey<ScaffoldState>? _scaffoldKey;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
  }

  @override //landingDataController
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
              color: JanguAskColors.whiteColor,
              boxShadow: [
                BoxShadow(
                  color: JanguAskColors.shadowColor,
                  blurRadius: 5,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                const SizedBox(height: 15),
                Row(
                  children: [
                    Flexible(
                        flex: 1,
                        child: IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.of(context).pop();
                            })),
                    const SizedBox(width: 15),
                    Flexible(
                      flex: 10,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: JanguAskColors.whiteColor, //5
                        ),
                        child: Container(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
        preferredSize: const Size.fromHeight(140),
      ),
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Container(),
    );
  }
}
