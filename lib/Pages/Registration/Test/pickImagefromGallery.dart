import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePicture extends StatefulWidget {
  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  Uint8List? _file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: _file == null
              ? Container(
                  color: Colors.orange,
                  child: InkWell(
                    onTap: () {
                      _imageSelect(context);
                    },
                    child: Icon(
                      Icons.image,
                      size: 300,
                    ),
                  ))
              : Column(
                  children: [
                    const Divider(),
                    SizedBox(
                        height: 300,
                        width: 300,
                        child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                          image: MemoryImage(_file!),
                          fit: BoxFit.fill,
                          alignment: FractionalOffset.topCenter,
                        )))),
                  ],
                )),
    );
  }

  pickImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: source);
    if (file != null) {
      return await file.readAsBytes();
    }
    print("No Image Selected");
  }

  _imageSelect(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(title: Text('Select Image'), children: [
            SimpleDialogOption(
              padding: EdgeInsets.all(20),
              child: Text('Take a Photo'),
              onPressed: () async {
                Uint8List file = await pickImage(
                  ImageSource.camera,
                );
                Navigator.of(context).pop();
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: EdgeInsets.all(20),
              child: Text('Choose From Gallery'),
              onPressed: () async {
                Uint8List file = await pickImage(
                  ImageSource.gallery,
                );
                Navigator.of(context).pop();
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: EdgeInsets.all(20),
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ]);
        });
  }
}
