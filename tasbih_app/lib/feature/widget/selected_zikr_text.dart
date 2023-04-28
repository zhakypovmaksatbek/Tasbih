import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/color_constants.dart';

class SelectedTitleZikr extends StatelessWidget {
  SelectedTitleZikr({
    Key? key,
  }) : super(key: key);

  String selectedItem = '.';

  void setSelectedItem(String item) {
    selectedItem = item;
  }

  @override
  Widget build(BuildContext context) {
    return Text(selectedItem,
        style: context.theme.textTheme.headlineMedium?.copyWith(
            color: ColorConstants.white, fontWeight: FontWeight.bold));
  }
}
