import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled5/common.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _addressController = TextEditingController();
  final databaseRef = FirebaseDatabase.instance.ref("Post");
  final List<String> genderItems = [
    'Male',
    'Female',
    "Other",
  ];
  String? selectedValue;

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.asset(
              "assets/images/b.jpg",
              fit: BoxFit.cover,
              height: 90,
            ),
          ),
        ),
        _textStyle(text: "FullName"),
        const SizedBox(
          height: 10,
        ),
        Common.custumtextfield(
            fillColor: Colors.white,
            hintcolor: Colors.black87,
            color: Colors.black87,
            text: "name",
            controller: _nameController),
        const SizedBox(
          height: 10,
        ),
        _textStyle(text: "Email"),
        const SizedBox(
          height: 10,
        ),
        Common.custumtextfield(
            fillColor: Colors.white,
            hintcolor: Colors.black87,
            color: Colors.black87,
            text: "Email",
            controller: _emailController),
        const SizedBox(
          height: 10,
        ),
        _textStyle(text: "Number"),
        const SizedBox(
          height: 10,
        ),
        Common.custumtextfield(
            fillColor: Colors.white,
            hintcolor: Colors.black87,
            color: Colors.black87,
            text: "Number",
            controller: _mobileController),
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
        Common.custumtextfield(
            fillColor: Colors.white,
            hintcolor: Colors.black87,
            color: Colors.black87,
            text: "Address",
            controller: _addressController),
        const SizedBox(
          height: 30,
        ),
        Common.updateButton(
            text: "Update",
            textcolor: Colors.white,
            color: Colors.black87,
            onTap: () {
              _dataProfile();
            })
      ],
    );
  }

  _dataProfile() {
    if (_nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _mobileController.text.isNotEmpty &&
        _addressController.text.isNotEmpty) {
      databaseRef.child("Profile").set({
        "fullName": _nameController.text,
        "email": _emailController.text,
        "Mobile": _mobileController.text,
        "address": _addressController.text,
      });
    }
  }

  Widget _dropDown() {
    return DropdownButtonFormField2(
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      isExpanded: true,
      hint: const Text(
        'Select Your Gender',
        style: TextStyle(fontSize: 14),
      ),
      items: genderItems
          .map((item) => DropdownMenuItem<String>(
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
      onChanged: (value) {},
      onSaved: (value) {
        selectedValue = value.toString();
      },
      buttonStyleData: const ButtonStyleData(
        height: 60,
        padding: EdgeInsets.only(left: 20, right: 10),
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.black45,
        ),
        iconSize: 30,
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  Widget _textStyle({String? text}) {
    return Text(
      text!,
      style: const TextStyle(
          fontWeight: FontWeight.w500, color: Colors.black87, fontSize: 16),
    );
  }
}
