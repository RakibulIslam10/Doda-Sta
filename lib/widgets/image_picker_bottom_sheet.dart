import 'package:flutter/material.dart';


// showModalBottomSheet(
//   context: context,
//   builder: (context) {
//     return ImagePickerBottomSheet(
//       onGalleryPressed: () {
//         Get.back();
//         controller.pickImage(ImageSource.gallery);
//       },
//       onCameraPressed: () {
//         Get.back();
//         controller.pickImage(ImageSource.camera);
//       },
//     );
//   },
// );





class ImagePickerBottomSheet extends StatelessWidget {
  final VoidCallback onGalleryPressed;
  final VoidCallback onCameraPressed;
  final double iconSize;
  final EdgeInsetsGeometry padding;

  const ImagePickerBottomSheet({super.key,
    required this.onGalleryPressed,
    required this.onCameraPressed,
    this.iconSize = 50.0,
    this.padding = const EdgeInsets.all(8.0),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.15,
      margin: EdgeInsets.all(8.0), // You can also customize this
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: padding,
            child: IconButton(
              onPressed: onGalleryPressed,
              icon: Icon(
                Icons.image,
                color: Colors.blue, // Use your custom color here
                size: iconSize,
              ),
            ),
          ),
          Padding(
            padding: padding,
            child: IconButton(
              onPressed: onCameraPressed,
              icon: Icon(
                Icons.camera,
                color: Colors.blue, // Use your custom color here
                size: iconSize,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
