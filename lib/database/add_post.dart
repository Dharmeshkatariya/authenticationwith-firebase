import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled5/common.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  var imagePath = "";

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _addressController = TextEditingController();

  final databaseRef = FirebaseDatabase.instance.ref("Post");
  String selectedImage = "";
  final List<String> genderItems = [
    'Male',
    'Female',
    "Other",
  ];
  String selectedValue = "";
  String genderValue = "";
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  @override
  void initState() {
    // TODO: implement initState
    _setValue();
    super.initState();
  }

  _setValue() async {
    DatabaseReference starCountRef =
        FirebaseDatabase.instance.ref('Post').child('Profile');
    starCountRef.onValue.listen((DatabaseEvent event) {
      Object? data = event.snapshot.value;
      var user = data! as Map;
      selectedImage = user["userimage"];
      genderValue = user["gender"];
      _nameController.text = user['fullName'];
      _emailController.text = user['email'];
      _mobileController.text = user['Mobile'];
      _addressController.text = user['address'];
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 30, top: 10),
              width: double.infinity,
              color: Colors.orange,
              child: Column(
                children: [
                  _editRow(),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10, top: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: _column(),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _getImageGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    imagePath = image!.path;
    setState(() {});
  }

  Widget _editRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.chevron_left)),
        _textStyle(text: "Edit Profile"),
        const Icon(Icons.share),
      ],
    );
  }

  String networkImage = '';

  Widget _column() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: GestureDetector(
            onTap: () {
              _getImageGallery();
            },
            child: Container(
                color: Colors.blue.shade50,
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 90, vertical: 10),
                margin: const EdgeInsets.symmetric(vertical: 12),
                child: selectedImage.isEmpty
                    ? Container(
                        decoration: BoxDecoration(
                            color: Colors.orange.shade50,
                            shape: BoxShape.circle),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 25),
                        child: const Icon(Icons.person),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          selectedImage,
                          fit: BoxFit.fill,
                          height: 100,
                        ))),
          ),
        ),
        _textStyle(text: "FullName"),
        const SizedBox(
          height: 10,
        ),
        _textField(text: "Full name", controller: _nameController),
        const SizedBox(
          height: 10,
        ),
        _textStyle(text: "Email"),
        const SizedBox(
          height: 10,
        ),
        _textField(text: "Email", controller: _emailController),
        const SizedBox(
          height: 10,
        ),
        _textStyle(text: "Number"),
        const SizedBox(
          height: 10,
        ),
        _textField(text: "Mobile", controller: _mobileController),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            _textStyle(text: "Gender"),
            const SizedBox(
              width: 20,
            ),
            Expanded(child: _dropDown()),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        _textStyle(text: "Address"),
        const SizedBox(
          height: 10,
        ),
        _textField(text: "Address", controller: _addressController, maxline: 4),
        const SizedBox(
          height: 30,
        ),
        Common.updateButton(
            text: "Update",
            textcolor: Colors.white,
            color: Colors.black87,
            onTap: () {
              _imageUpdate();
            })
      ],
    );
  }

  Widget _dropDown() {
    return DropdownButtonFormField2(
      decoration: InputDecoration(
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      isExpanded: true,
      hint: genderValue.isNotEmpty? Text(
        genderValue,
        style: const TextStyle(fontSize: 14),
      ) : const Text(
        "Select the gender",
        style:  TextStyle(fontSize: 14),
      ),
      items: genderItems
          .map((item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select gender.';
        }
        return null;
      },
      onChanged: (value) {
        selectedValue = value.toString();
      },
      onSaved: (value) {
        selectedValue = value.toString();
      },
      buttonStyleData: const ButtonStyleData(
        height: 30,
        padding: EdgeInsets.only(left: 10, right: 10),
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  Widget _textField(
      {String? text, TextEditingController? controller, int? maxline}) {
    return Common.custumtextfield(
        maxline: maxline,
        bordercolor: Colors.black87,
        fillColor: Colors.white,
        hintcolor: Colors.black87,
        color: Colors.black87,
        text: text,
        controller: controller);
  }

  Widget _textStyle({String? text}) {
    return Text(
      text!,
      style: const TextStyle(
          fontWeight: FontWeight.w500, color: Colors.black87, fontSize: 16),
    );
  }

  _imageUpdate() async {
    var id = DateTime.now().microsecondsSinceEpoch.toString();
    firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.ref("/filename$id ");
    firebase_storage.UploadTask uploadTask = ref.putFile(File(imagePath));
    await Future.value(uploadTask);
    var newImageUrl = await ref.getDownloadURL();
    networkImage = newImageUrl;
    setState(() {});
    databaseRef.child("Profile").set({
      "userimage": networkImage,
      "fullName": _nameController.text,
      "email": _emailController.text,
      "Mobile": _mobileController.text,
      "address": _addressController.text,
      "gender": selectedValue,
    });
  }
}
