import 'dart:io';


import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:globalinfocloud_task/utils/widget_comman.dart';
import 'package:globalinfocloud_task/views/admin/controllers/vendor_product_conttroller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ImageTab extends StatefulWidget {
  const ImageTab({super.key});

  @override
  State<ImageTab> createState() => _ImageTabState();
}

class _ImageTabState extends State<ImageTab> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();
  final List<File> _imageFilesList = <File>[];
  final List<String> _imageUrlsList = <String>[];

  _choosImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _imageFilesList.add(File(pickedImage.path));
      });
    } else {
      // ignore: use_build_context_synchronously
      getMySnakBar(context: context, masage: "Please select an image");
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    VendorProductController vendorProductController = Provider.of<VendorProductController>(context);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          GridView.builder(
              shrinkWrap: true,
              itemCount: _imageFilesList.length + 1,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 3,
                mainAxisSpacing: 8,
                childAspectRatio: 4 / 4,
              ),
              itemBuilder: (context, index) {
                return index == 0
                    ? IconButton(
                        onPressed: () {
                          _choosImage();
                        },
                        icon: const Icon(Icons.add_a_photo_rounded))
                    : Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: FileImage(
                            _imageFilesList[index - 1],
                          ),
                          fit: BoxFit.cover,
                        )),
                      );
              }),
          const SizedBox(
            height: 30,
          ),
          TextButton(
              onPressed: () async {
                if (_imageFilesList.isNotEmpty) {
                  EasyLoading.show(status: "Saving the image...");
                  for (var img in _imageFilesList) {
                    Reference ref =
                        _storage.ref().child("ProductImage").child(const Uuid().v4());
                    await ref.putFile(img).then((value) async {
                      await value.ref.getDownloadURL().then((value) {
                        setState(() {
                          _imageUrlsList.add(value);
                         
                        });
                      });
                    });
                  }
                  setState(() {
                     vendorProductController.getFormData(
                              imagUrlList: _imageUrlsList);
                        
                      EasyLoading.showSuccess(
                              "Images Uploadded Successesfully!");
                          EasyLoading.dismiss();
                  });
                }
                else{
                  _choosImage();
                }
              },
              child: _imageFilesList.isNotEmpty
                  ? const Text("Upload")
                  : const Text("Please select an image file"))
        ],
      ),
    );
  }
}
