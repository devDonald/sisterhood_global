import 'package:flutter/material.dart';

import '../../core/widgets/menu_drawer.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text(''),
      ),
      drawer: MenuDrawer(),
      backgroundColor: Colors.black,
      body: Container(),
    );
  }
}
