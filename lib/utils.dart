// import 'dart:typed_data';

import 'dart:math';

import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

class Utils {
  Size getScreenSize() {
    // ignore: deprecated_member_use
    return MediaQueryData.fromView(WidgetsBinding.instance.window).size;
  }

  // void showSnackBar({required BuildContext context, required String content}) {}

  showSnackBar({required BuildContext context, required String content}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.orange,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        content: SizedBox(
          width: getScreenSize().width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                content,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future<Uint8List?> pickImage() async {
  //   ImagePicker picker = ImagePicker();
  //   XFile? file = await picker.pickImage(source: ImageSource.gallery);
  //   return file!.readAsBytes();
  // }

  String getUid() {
    return (100000 + Random().nextInt(10000)).toString();
  }
}