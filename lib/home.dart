import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class Home_Page extends StatefulWidget {
  @override
  _Home_PageState createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {

  static const platform=const MethodChannel('doc_Scanner/Crop');

  File _image;
  var decodedBytes;
  String base64;
  String cropped_photo;
  String base64_;
  int f=0;
  final picker=ImagePicker();
  Future getimg() async {
    var picked_file=await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image=File(picked_file.path);
      var bytes=_image.readAsBytesSync();
      base64=base64Encode(bytes);
      print("base64=");
      print(base64);
    });
  }
    get_it_cropped (String string)async{
    bool x=false;
    try{
      await platform.invokeMethod('get_it_cropped',base64);
    }catch(e)
    {
      print(e+"wtf");
    }
    while(!x){
      x=await platform.invokeMethod("check");
    }
    cropped_photo=await platform.invokeMethod("get_cropped_img");
    String s=cropped_photo.replaceAll("\n", "");
    setState(() {
      decodedBytes = base64Decode(s);
    });
    return;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(
            height: 500,
            width: 400,
            fit: BoxFit.fill,
            image:_image==null?AssetImage('images/r&m.jpg'):
            decodedBytes==null?FileImage(_image):MemoryImage(decodedBytes),
          ),
          RaisedButton(
              child: Text('Get_Image'),
              onPressed: (){
                getimg();
          }),
          RaisedButton(
              child: Text('Crop_img'),
              onPressed: () async{
                if(_image!=null){
                 get_it_cropped(base64);
                }
                else{
                  print("F--off");
                }
              }),
        ],
      ),
    );
  }
}
