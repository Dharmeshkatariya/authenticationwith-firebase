import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled5/common.dart';
import 'package:untitled5/controller/addpost_controller.dart';
import 'package:untitled5/utils/utills.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key, required this.path});

  final String path;

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final _addPostController = Get.put(AddPostController());

  @override
  void initState() {
    _addPostController.setValue(widget.path);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => SafeArea(
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
    ));
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
      key: _addPostController.form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: GestureDetector(
              onTap: () {
                _addPostController.getImageGallery();
              },
              child: _addPostController.loading.value
                  ? const CircularProgressIndicator()
                  : Container(
                      color: Colors.blue.shade50,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 90, vertical: 10),
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      child: _addPostController.imagePath.value.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.file(
                                  File(_addPostController.imagePath.value)))
                          : _addPostController.selectedImage.value.isEmpty
                              ? const CircularProgressIndicator(
                                  strokeWidth: 6,
                                )
                              : Image.network(
                                  _addPostController.selectedImage.value),
                    ),
            ),
          ),
          _textStyle(text: "FullName"),
          const SizedBox(
            height: 10,
          ),
          _textField(
              text: "Full name",
              controller: _addPostController.nameController,
              validator: (value) {
                if (_addPostController.nameController.value.text.isEmpty) {
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
            controller: _addPostController.emailController,
            validator: (value) {
              if (_addPostController.emailController.value.text.isEmpty) {
                return 'Email is required';
              }
              if (!RegExp(r'\S+@\S+\.\S+')
                  .hasMatch(_addPostController.emailController.value.text)) {
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
            controller: _addPostController.mobileController,
            validator: (value) {
              if (_addPostController.mobileController.value.text.isEmpty) {
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
            controller: _addPostController.addressController,
            maxline: 4,
            validator: (value) {
              if (_addPostController.addressController.value.text.isEmpty) {
                return 'Address is required';
              }
            },
          ),
          const SizedBox(
            height: 30,
          ),
          Common.updateButton(
              loading: _addPostController.loading.value,
              text: "Update",
              textcolor: Colors.white,
              color: Colors.black87,
              onTap: () {
                if (_addPostController.imagePath.value.isEmpty &&
                    _addPostController.selectedImage.value.isEmpty) {
                  Utils.toastMessage("select image");
                } else if (_addPostController.form.currentState!.validate()) {
                  _addPostController.loading.value = true;
                  _addPostController.imageUpdate();
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
      hint: _addPostController.genderValue.value.isNotEmpty
          ? Text(
              _addPostController.genderValue.value,
              style: const TextStyle(fontSize: 14),
            )
          : const Text(
              "Select the gender",
              style: TextStyle(fontSize: 14),
            ),
      items: _addPostController.genderItems
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
        _addPostController.selectedGenderValue.value = value.toString();
      },
      onSaved: (value) {
        _addPostController.selectedGenderValue.value = value.toString();
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
}
