import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class PostImage extends StatefulWidget {
  const PostImage({Key? key}) : super(key: key);

  @override
  _PostImageState createState() => _PostImageState();
}

class _PostImageState extends State<PostImage> {
  TextEditingController txtname = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
          //width: MediaQuery.of(context).size.width*0.9,
          child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //TextFormField(),
              //AssetImage(image: "images/noimage.png", control),
              this.imageFile == null
                  ? Image.asset("images/noimage.png", width: 500)
                  : Image.file(this.imageFile!, width: 500),
              ElevatedButton(
                  onPressed: () {
                    this._getFromGallery();
                  },
                  child: Text("select image")),
              ElevatedButton(
                  onPressed: () async {
                    Dio dioPost = new Dio();
                    FormData formData = FormData.fromMap(
                      {
                        "image":await MultipartFile.fromFile(
                          this.imageFile!.path,
                          filename: "testimage.jpg",
                        ),
                        "name": "testimage.jpg",
                        "price": 10.50
                      },
                    );
        
                    //-- do post data
                    dioPost
                        .post(
                      "http://119.59.116.70/flutter/test/save_image.php",
                      data: formData,
                      options: Options(contentType: 'multipart/form-data'),
                    )
                        .then((value) {
                      print("Response Data : " + value.data);
                    });
                  },
                  child: Text("Sent Image..")),
              // TextFormField(
              //   controller: this.txtname,
              //   style: TextStyle(),
              // ),
            ],
          ),
        ),
      )),
    );
  }

  //---- image
  File? imageFile;
  void _showImageDialog() {
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
      this.setState(() {
        this.imageFile = croppedImage;
      });
    }
  }
}
