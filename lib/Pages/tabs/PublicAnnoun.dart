import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:circlight/Pages/Nav.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart';

class PublicAnnoun extends StatefulWidget {
  @override
  State<PublicAnnoun> createState() => _PublicAnnoun();
}

enum MenuItem { item1, item2 }

class _PublicAnnoun extends State<PublicAnnoun> with TickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();

  //Controllers
  TextEditingController Address = TextEditingController();
  TextEditingController content = TextEditingController();
  bool ischecked = false;
   File? img;
  String imgurl = '';
  bool isLoadFile = false;
  UploadTask? task;
  String? FireUrlForImage;



  uploadImageToStorage(PickedFile? pickedFile) async {
    //conditoin for web
    if(kIsWeb){
      setState(() {
        isLoadFile = true;
      });
      Reference _reference = FirebaseStorage.instance
          .ref()
          .child('images/${Path.basename(pickedFile!.path)}');
      await _reference
          .putData(
        await pickedFile!.readAsBytes(),
        SettableMetadata(contentType: 'image/jpeg'),
      )
          .whenComplete(() async {
        await _reference.getDownloadURL().then((value) {
          FireUrlForImage = value;
          setState(() {
            isLoadFile = false;
          });
          print("i am download link ==${FireUrlForImage.toString()}");
        });
      });
    }else{
      //else Android and iOS

      uploadFile();
    }

  }





  Future uploadFile() async {
    setState(() {
      isLoadFile = true;
    });
    if (img! == null) return;
    final fileName = Path.basename(img!.path);
    final destination = 'images/$fileName';

    task = FirebaseApi.uploadFile(destination, img!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
    FireUrlForImage = urlDownload;
    setState(() {
      isLoadFile = false;
    });
  }

  Future pickercamera() async {
    await showModalBottomSheet(
        context: context,
        builder: (context) => BottomSheet(
            onClosing: () {},
            builder: (context) => Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: Icon(Icons.camera),
                        title: Text("الكاميرا"),
                        onTap: () async {
                          Navigator.of(context).pop();
                          final myimg = await ImagePicker()
                              .getImage(source: ImageSource.camera);
                          setState(() {
                            img = File(myimg!.path);
                            print(img);
                            uploadImageToStorage(myimg);
                           //uploadFile();
                          });
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.filter),
                        title: Text("مكتبة الصور"),
                        onTap: () async {
                          Navigator.of(context).pop();
                          final myimg = await ImagePicker()
                              .getImage(source: ImageSource.gallery);
                          setState(() {
                            img = File(myimg!.path);
                            uploadImageToStorage(myimg);
                           // uploadFile();
                            print(img);
                          });
                        },
                      )
                    ],
                  ),
                )));
  }

  String uniqueFileName = DateTime.now().microsecondsSinceEpoch.toString();
  @override
  Widget build(BuildContext context) {
    CollectionReference Announ =
        FirebaseFirestore.instance.collection("Announcement");

    // Future uplodeimg(String path) async {
    //   Reference referenceRoot = FirebaseStorage.instance.ref();
    //   Reference Dirimgs = referenceRoot.child("images");
    //   Reference ReferenceImageToUpload = Dirimgs.child(uniqueFileName);
    //
    //   await ReferenceImageToUpload.putFile(File(path));
    //   imgurl = await ReferenceImageToUpload.getDownloadURL();
    // }

///////here img can not be nulllll
    try {} catch (error) {}
    return SingleChildScrollView(

      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 35),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Column(
                children: [
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      onChanged: (val) => formKey.currentState?.validate(),
                      controller: Address, //..text = parentx.Name,

                      //  controller: parentUserName..text = parentx.PUserName,
                      //to take text from user input
                      textAlign: TextAlign.right,

                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          //fontWeight: FontWeight.w600,
                          color: Colors.grey),
                      showCursor: true,
                      cursorColor: const Color(0xff42c98d),

                      decoration: InputDecoration(
                        labelText: "العنوان",
                        hintText: "العنوان",
                        hintStyle:
                            const TextStyle(color: Colors.grey, fontSize: 12),
                        labelStyle: const TextStyle(
                            color: const Color(0xff42c98d),
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                        prefixIcon: Padding(
                          padding:
                              const EdgeInsets.only(right: 12, top: 9, left: 9),
                          child: Container(
                            //  padding: const EdgeInsets.only(right: 5),

                            child: Column(children: [
                              Icon(
                                Icons.title,
                                color: Color(0xff42c98d),
                              ),
                              /* Image.asset(
                                "assets/icons/name.png",
                                width: 20,
                                height: 20,
                                color: const Color(0xff42c98d),
                              )*/
                            ]),
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: const Color(0xff42c98d), width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        floatingLabelStyle: const TextStyle(
                            color: const Color(0xff42c98d),
                            fontSize: 12,
                            fontWeight: FontWeight.w300),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color(0xff42c98d), width: 2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty)
                          return "أرجو منك تعبئه الحقل الفارغ ";
                        else {
                          return null;
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      maxLines: 10,
                      minLines: 1,

                      onChanged: (val) => formKey.currentState?.validate(),
                      controller: content, //..text = parentx.Name,

                      //  controller: parentUserName..text = parentx.PUserName,
                      //to take text from user input
                      textAlign: TextAlign.right,

                      style: GoogleFonts.poppins(
                          fontSize: 14,

                          //fontWeight: FontWeight.w600,
                          color: Colors.grey),
                      showCursor: true,
                      cursorColor: const Color(0xff42c98d),

                      decoration: InputDecoration(
                        labelText: "المحتوى",
                        hintText: "المحتوى",
                        hintStyle:
                            const TextStyle(color: Colors.grey, fontSize: 12),
                        labelStyle: const TextStyle(
                            color: const Color(0xff42c98d),
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                        prefixIcon: Padding(
                          padding:
                              const EdgeInsets.only(right: 12, top: 9, left: 9),
                          child: Container(
                            //  padding: const EdgeInsets.only(right: 5),

                            child: Column(children: [
                              Image.asset(
                                "assets/icons/name.png",
                                width: 20,
                                height: 20,
                                color: const Color(0xff42c98d),
                              )
                            ]),
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: const Color(0xff42c98d), width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        floatingLabelStyle: const TextStyle(
                            color: const Color(0xff42c98d),
                            fontSize: 12,
                            fontWeight: FontWeight.w300),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color(0xff42c98d), width: 2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty)
                          return "أرجو منك تعبئه الحقل الفارغ ";
                        else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Directionality(
                      textDirection: TextDirection.rtl,
                      child: CheckboxListTile(
                        title: Text("هل ترغب في وضع الإعلان ذا أولوية عالية؟"),
                        value: ischecked,
                        onChanged: (newValue) {
                          setState(() {
                            ischecked = newValue!;
                          });
                        },
                        //  <-- leading Checkbox
                      ) /*CheckboxListTile(
                      title: Text("هل ترغب في جعل الاعلان مهم؟"),
                      value: ischecked,
                      onChanged: (value) {
                        setState(() {
                          ischecked = value!;
                        });
                      },
                    ),*/
                      ),
                  SizedBox(
                    height: 30,
                  ),
                  Hero(
                      tag: "btn123",
                      child: Center(
                          child: Container(
                              height: 40,
                              width: 150,
                              child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        const Color(0xff42c98d),
                                        //const Color(0xff42c98d),
                                        const Color(0xff0da6c2),

                                        //add more colors
                                      ]),
                                      borderRadius: BorderRadius.circular(400),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            color: Color.fromRGBO(0, 0, 0,
                                                0.57), //shadow for button
                                            blurRadius: 5) //blur radius of shadow
                                      ]),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Color.fromARGB(0, 204, 24, 24),
                                        onSurface: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                        //make color or elevated button transparent
                                      ),
                                      onPressed: () {
                                        pickercamera();
                                      },
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                            left: 18,
                                            right: 10,
                                          ),
                                          child: Row(
                                            children: [
                                              Text(
                                                "رفع صورة",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 236, 232, 232)),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Icon(
                                                // <-- Icon
                                                Icons.download,
                                                size: 20.0,
                                                color: Color.fromARGB(
                                                    255, 236, 232, 232),
                                              ),
                                            ],
                                          ))))))),
                  SizedBox(height: 20,),
                  // display image
                  Container(
                      height: 150,
                      width: 300,
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                          ),
                          color: Colors.black12),
                      child:
                      isLoadFile
                          ? Center(child: CircularProgressIndicator()):
                           img != null
                          ?
                      kIsWeb?
                      Image.network(
                        img!.path,
                        fit: BoxFit.cover,
                      ):

                      Image.file(
                        img!,
                        fit: BoxFit.cover,
                      ):
                          Image.network(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4e2w7sqLN7wNvah3rnc3RbSILIsG7Bfdwa7haC-mEzRmj8bqeseg0241dzcF1W4yGkoU&usqp=CAU",
                         fit: BoxFit.cover,
                       )
        ),
                  SizedBox(
                    height: 60,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Hero(
                    tag: "btn",
                    child: Center(
                      child: Container(
                        height: 50,
                        width: 400,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                const Color(0xff42c98d),
                                const Color(0xff42c98d),
                                const Color(0xff0da6c2),

                                //add more colors
                              ]),
                              borderRadius: BorderRadius.circular(22),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Color.fromRGBO(
                                        0, 0, 0, 0.57), //shadow for button
                                    blurRadius: 5) //blur radius of shadow
                              ]),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(0, 255, 255, 255),
                              onSurface: Colors.transparent,
                              shadowColor: Colors.transparent,
                              //make color or elevated button transparent
                            ),
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                await Announ.add({
                                  "Address": Address.text,
                                  "important": ischecked,
                                  "message": content.text,
                                  "status": "Public",
                                  "Date": DateTime.now(),
                                  "image": FireUrlForImage,

                                  //add img
                                });

                                await showCupertinoDialog(
                                    context: context, builder: CreateDialog);
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 18,
                                right: 18,
                              ),
                              child: Text(
                                "send ",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                ],
              ),
              //////////////////////////////////////////////
              ///
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget CreateDialog(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      title: Text("إرسال المحتوى",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18,
              color: Color.fromRGBO(31, 31, 31, 1),
              fontWeight: FontWeight.bold)),
      content: Text(
        "تم إرسال المحتوى بنجاح",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14),
      ),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              Navigator.pop(context);
              /* Navigator.of(context).push(CupertinoPageRoute(
                builder: (context) => Nav(
                  TabValue: 0,
                  documentId: "",
                ),
              ));*/
            },
            child: Text("موافق",
                style: TextStyle(
                    color: const Color(0xff57d77a),
                    fontWeight: FontWeight.bold))),
      ],
    );
  }
}



class FirebaseApi {
  static UploadTask? uploadFile(String destination, File file ) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
     // SettableMetadata(contentType: 'image/jpeg');

      return ref.putFile(

          file,
          //SettableMetadata(contentType: 'image/jpeg'),
      );
    } on FirebaseException catch (e) {
      return null;
    }
  }

  static UploadTask? uploadBytes(String destination, Uint8List data) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putData(data,
          SettableMetadata(contentType: 'image/jpeg'),
      );
    } on FirebaseException catch (e) {
      return null;
    }
  }
}
