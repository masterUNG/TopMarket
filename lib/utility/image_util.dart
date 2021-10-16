import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';


class ImageUtil {

  //Function setState(); 
  State state;

  BuildContext context;
  ImageUtil(this.context, this.state);
  //---- image 
  File? imageFile;
  void showImageDialog() {
    showDialog(
        context: this.context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("กรุณาเลือก"),
            content: Column(
              children: [
                InkWell(
                  onTap: () {
                    this._getFromCamera();
                  },
                  child: Row(
                    children: [
                      Padding(
                          //padding: EdgeInsets.all(4.0),
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                          child: Icon(
                            Icons.camera,
                            color: Colors.purple,
                          )),
                      Text(
                        "ถ่ายรูป",
                        style: TextStyle(color: Colors.purple, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    this._getFromGallery();
                  },
                  child: Row(
                    children: [
                      Padding(
                          //padding: EdgeInsets.all(4.0),
                          padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                          child: Icon(
                            Icons.image,
                            color: Colors.purple,
                          )),
                      Text(
                        "เลือกจาก Gallery",
                        style: TextStyle(color: Colors.purple, fontSize: 24),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  void _getFromGallery() async {
    PickedFile? imageFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxHeight: 1000,
      maxWidth: 1000,
    );

    //-- ส่งไป Crop
    this._cropImage(imageFile!.path);
    Navigator.pop(this.context);
  }

  void _getFromCamera() async {
    
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxHeight: 1000,
      maxWidth: 1000,
    );

    //-- ส่งไป Crop
    this._cropImage(pickedFile!.path);
    Navigator.pop(this.context);
  }

  void _cropImage(String filePath) async {
    File? croppedImage = await ImageCropper.cropImage(
      sourcePath: filePath,
      maxHeight: 1000,
      maxWidth: 1000,
    );

    if (croppedImage != null) {
      this.state.setState(() {
        this.imageFile = croppedImage;
      });
    }
  }


}