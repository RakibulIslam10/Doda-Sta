part of '../screen/request_screen.dart';

class AddPhotoGrid extends GetView<RequestController> {
  final String? title;

  const AddPhotoGrid({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossStart,
      children: [
        TextWidget(
          title ?? 'Add Photo or video',
          fontWeight: FontWeight.w500,
          padding: EdgeInsetsGeometry.symmetric(vertical: Dimensions.heightSize * 0.8),
        ),
        Obx(() {
          final items = [...controller.photos];
          return Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (var photo in items)
                Container(
                  width: 100.w,
                  height: 90.h,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.orange,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(
                      Dimensions.radius * 0.8,
                    ),
                    image: DecorationImage(
                      image: FileImage(photo),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              GestureDetector(
                onTap: controller.pickImage,
                child: Container(
                  width: 100.w,
                  height: 90.h,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.orange,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(
                      Dimensions.radius * 0.8,
                    ),
                    color: Colors.grey.shade200,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.add_circle_outline,
                      color: Colors.orange,
                      size: Dimensions.iconSizeLarge,
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ],
    );
  }
}
