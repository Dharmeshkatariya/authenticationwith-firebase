import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled5/common.dart';
import 'package:untitled5/utils/utills.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key, required this.path});

  final String path;

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _addressController = TextEditingController();
  final List<String> genderItems = [
    'Male',
    'Female',
    "Other",
  ];
  String selectedGenderValue = "";
  String selectedImage = "";
  var imagePath = "";
  String genderValue = "";
  String updateemail = "";
  final databaseRef = FirebaseDatabase.instance.ref("User");
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  bool loading = false;

  @override
  void initState() {
    _setValue();
    // TODO: implement initState
    super.initState();
  }

  _setValue() async {
    updateemail = widget.path.toString();
    var arrayEmail = updateemail.split("@");
    DatabaseReference starCountRef =
        FirebaseDatabase.instance.ref('User').child(arrayEmail[0]);
    starCountRef.onValue.listen((DatabaseEvent event) {
      Object? data = event.snapshot.value;
      var user = data! as Map;
      _nameController.text = user['fullName'];
      _emailController.text = updateemail;
      _mobileController.text = user['Mobile'];
      _addressController.text = user['address'];
      selectedImage = user["userimage"];
      genderValue = user["gender"];
      setState(() {});
    });
  }

  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 30, top: 10, left: 10),
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

  Widget _column() {
    return Form(
      key: _form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: GestureDetector(
              onTap: () {
                _getImageGallery();
              },
              child: loading
                  ? const CircularProgressIndicator()
                  : Container(
                      color: Colors.blue.shade50,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 90, vertical: 10),
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      child: imagePath.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.file(File(imagePath)))
                          : selectedImage.isEmpty
                              ? const CircularProgressIndicator(
                                  strokeWidth: 6,
                                )
                              : Image.network(selectedImage),
                    ),
            ),
          ),
          _textStyle(text: "FullName"),
          const SizedBox(
            height: 10,
          ),
          _textField(
              text: "Full name",
              controller: _nameController,
              validator: (value) {
                if (_nameController.text.isEmpty) {
                  return 'Name is required';
                }
              }),
          const SizedBox(
            height: 10,
          ),
          _textStyle(text: "Email"),
          const SizedBox(
            height: 10,
          ),
          _textField(
            text: "Email",
            controller: _emailController,
            validator: (value) {
              if (_emailController.text.isEmpty) {
                return 'Email is required';
              }
              if (!RegExp(r'\S+@\S+\.\S+').hasMatch(_emailController.text)) {
                return "Please enter a valid email address";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          _textStyle(text: "Number"),
          const SizedBox(
            height: 10,
          ),
          _textField(
            text: "Mobile",
            controller: _mobileController,
            validator: (value) {
              if (_mobileController.text.isEmpty) {
                return 'Mobile is required';
              }
            },
          ),
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
          _textField(
            text: "Address",
            controller: _addressController,
            maxline: 4,
            validator: (value) {
              if (_addressController.text.isEmpty) {
                return 'Address is required';
              }
            },
          ),
          const SizedBox(
            height: 30,
          ),
          Common.updateButton(
              loading: loading,
              text: "Update",
              textcolor: Colors.white,
              color: Colors.black87,
              onTap: () {
                if (imagePath.isEmpty && selectedImage.isEmpty) {
                  Utils.toastMessage("select image");
                } else if (_form.currentState!.validate()) {
                  setState(() {
                    loading = true;
                  });
                  _imageUpdate();
                }
              })
        ],
      ),
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
      hint: genderValue.isNotEmpty
          ? Text(
              genderValue,
              style: const TextStyle(fontSize: 14),
            )
          : const Text(
              "Select the gender",
              style: TextStyle(fontSize: 14),
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
        selectedGenderValue = value.toString();
      },
      onSaved: (value) {
        selectedGenderValue = value.toString();
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
      {String? text,
      TextEditingController? controller,
      int? maxline,
      dynamic validator}) {
    return Common.custumtextfield(
        validator: validator,
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
    try {
      String storeImage = '';
      var id = DateTime.now().microsecondsSinceEpoch.toString();
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref('/filename/' "$id");
      firebase_storage.UploadTask uploadTask =
          ref.putFile(File(imagePath.isEmpty ? selectedImage : imagePath));
      await Future.value(uploadTask);
      storeImage = await ref.getDownloadURL();
      setState(() {
        loading = true;
      });
      String email = _emailController.text;
      var strEmail = email.split("@");
      databaseRef
          .child(strEmail[0])
          .set({
            "userimage": storeImage,
            "fullName": _nameController.text,
            "email": _emailController.text,
            "Mobile": _mobileController.text,
            "address": _addressController.text,
            "gender": selectedGenderValue,
          })
          .then((value) => Utils.toastMessage("update profile"))
          .onError((error, stackTrace) => Utils.toastMessage(error.toString()));
      setState(() {
        loading = false;
      });
    } catch (e) {
      print(e);
    }
  }
}
