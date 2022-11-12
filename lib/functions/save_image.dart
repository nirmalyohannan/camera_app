import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:media_scanner/media_scanner.dart';
import 'package:path_provider/path_provider.dart';

saveImage(XFile image) async {
  if (Platform.isAndroid) {
    log(":::::Platform is Android:::::");

    DateTime name = DateTime.now();

    String savePath = "/storage/emulated/0/Pictures/Flutter Camera/";
    String fileName =
        "img_${name.year}_${name.month}_${name.day}_${name.hour}_${name.minute}_${name.second}.jpg";

    Directory directory = Directory(savePath);

    await directory
        .create(); //Creates the directory of path savePath if it doesnt exists

    await image.saveTo(savePath + fileName);
    await MediaScanner.loadMedia(
        path: savePath +
            fileName); //This refreshes galleries to display the image in gallery without rebooting phone
    log(":::::FileName::::$fileName");
    log(":::::saveDirectory:::::$savePath");
    log(":::::Image path :::::: ${image.path}");
    // log("MediaScanner Message:::: $loadMediaMessage");
  } else {
    //getExternalStorageDirecory() is only available for android
    //so if run in an OS which is not android file will be saved in AppDocument which is available for all platforms

    //This code for IOS and other platforms are inComplete for now
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    DateTime name = DateTime.now();
    String fileName =
        "img_${name.year}_${name.month}_${name.day}_${name.hour}_${name.minute}_${name.second}.jpg";

    String savePath = "${documentsDirectory.path}/$fileName";
    image.saveTo(savePath);
    print(":::::saveDirectory:::::${savePath}");
    print(":::::Image path :::::: ${image.path}");
  }
}
