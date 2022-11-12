import 'dart:developer';

import 'dart:io';

List readGallery() {
  List fileList =
      Directory("/storage/emulated/0/Pictures/Flutter Camera/").listSync();

  return fileList;
  // for (int index = 0; index < fileList.length; index++) {
  //   log("The File:::${fileList[index]}");
  // }
}
