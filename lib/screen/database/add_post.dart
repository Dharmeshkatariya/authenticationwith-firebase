import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled5/common.dart';
import 'package:untitled5/controller/addpost_controller.dart';
import 'package:untitled5/utils/utills.dart';

class AddPost extends GetView<AddPostController> {
  AddPost({super.key, required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    controller.setValue(path);
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
                  _editRow(context),
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

  Widget _editRow(BuildContext context) {
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
      key: controller.form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: GestureDetector(
              onTap: () {
                controller.getImageGallery();
              },
              child: controller.loading.value
                  ? const CircularProgressIndicator()
                  : Container(
                      color: Colors.blue.shade50,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 90, vertical: 10),
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      child: controller.imagePath.value.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child:
                                  Image.file(File(controller.imagePath.value)))
                          : controller.selectedImage.value.isEmpty
                              ? const CircularProgressIndicator(
                                  strokeWidth: 6,
                                )
                              : Image.network(controller.selectedImage.value),
                    ),
            ),
          ),
          _textStyle(text: "FullName"),
          const SizedBox(
            height: 10,
          ),
          _textField(
              text: "Full name",
              controller: controller.nameController,
              validator: (value) {
                if (controller.nameController.value.text.isEmpty) {
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
            controller: controller.emailController,
            validator: (value) {
              if (controller.emailController.value.text.isEmpty) {
                return 'Email is required';
              }
              if (!RegExp(r'\S+@\S+\.\S+')
                  .hasMatch(controller.emailController.value.text)) {
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
            controller: controller.mobileController,
            validator: (value) {
              if (controller.mobileController.value.text.isEmpty) {
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
            controller: controller.addressController,
            maxline: 4,
            validator: (value) {
              if (controller.addressController.value.text.isEmpty) {
                return 'Address is required';
              }
            },
          ),
          const SizedBox(
            height: 30,
          ),
          Common.updateButton(
              loading: controller.loading.value,
              text: "Update",
              textcolor: Colors.white,
              color: Colors.black87,
              onTap: () {
                if (controller.imagePath.value.isEmpty &&
                    controller.selectedImage.value.isEmpty) {
                  Utils.toastMessage("select image");
                } else if (controller.form.currentState!.validate()) {
                  controller.loading.value = true;
                  controller.imageUpdate();
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
      hint: controller.genderValue.value.isNotEmpty
          ? Text(
              controller.genderValue.value,
              style: const TextStyle(fontSize: 14),
            )
          : const Text(
              "Select the gender",
              style: TextStyle(fontSize: 14),
            ),
      items: controller.genderItems
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
        controller.selectedGenderValue.value = value.toString();
      },
      onSaved: (value) {
        controller.selectedGenderValue.value = value.toString();
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
