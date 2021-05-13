import 'dart:io';
import 'package:accialert/widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Popup extends StatefulWidget {
  @override
  _PopupState createState() => _PopupState();
}
class _PopupState extends State<Popup>with TickerProviderStateMixin {
  File img;
  var location = "";
  bool isLoading = false;
  AnimationController animationController;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();
  }
  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    animationController =
        AnimationController(duration: new Duration(seconds: 2), vsync: this);
    animationController.repeat();
  }
  void getCurrentLocation() async {
    var position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var lastPosition = await Geolocator().getLastKnownPosition();
    print(lastPosition);
    var lat = position.latitude;
    var long = position.longitude;
    setState((){
      location = "Accident Location \n Latitude: $lat, And Longitude: $long";
    });
  }

  uploadPic()async{
    setState((){
      isLoading = true;
    });
    String filename = basename(img.path);
    StorageReference firebaseStorageref=FirebaseStorage.instance.ref().child(filename);
    StorageUploadTask uploadTask=firebaseStorageref.putFile(img);
    StorageTaskSnapshot taskSnapshot= await uploadTask.onComplete;
    setState((){
      isLoading = false;
      Fluttertoast.showToast(
          msg: "Picture Uploaded",
          toastLength: Toast.LENGTH_SHORT,
          );
      _sendSMS();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AccialertAppLog(context),
      body: Column(
        children: [
          img == null ? Container(alignment: Alignment.center, padding: EdgeInsets.symmetric(vertical: 70),child: Text("To Click a Picture.\n Click on Camera Button.",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 25,color: Colors.black54),),) : Container(padding: EdgeInsets.symmetric(vertical: 20,horizontal: 30),child: Image.file(img)),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20,horizontal: 40),
            child: isLoading ? Container(child: Center(child: indicator(animationController),),) :Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 RaisedButton(
                   onPressed: (){
                      img == null ? Fluttertoast.showToast(
                        msg: "Click The image first.",
                        toastLength: Toast.LENGTH_SHORT,
                      ):uploadPic();
                   },
                   color: Colors.deepOrangeAccent,
                   child: Text('Upload',style: TextStyle(color: Colors.white),),
                 ),
                 RaisedButton(
                   onPressed: (){
                     Navigator.pop(context);
                   },
                   color: Colors.deepOrangeAccent,
                   child: Text('Cancel',style: TextStyle(color: Colors.white),),
                 ),

               ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrangeAccent,
        child: Icon(Icons.camera,color: Colors.white,),
        onPressed: (){
          CameraPic();
        },
      ),
    );
  }
  CameraPic() async {
    final file = await ImagePicker().getImage(source: ImageSource.camera);
    setState((){
      img = File(file.path);
    });
  }
  _sendSMS() async {
    List<String> recipients = ["7977533677","8169134758"];
    String _result = await sendSMS(message: '$location', recipients: recipients).catchError((onError) {
      print(onError);
    });
    print(_result);
  }
}

