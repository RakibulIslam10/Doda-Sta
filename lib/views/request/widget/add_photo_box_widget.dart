part of '../screen/request_screen.dart';

class AddPhotoGrid extends StatelessWidget {
  final String? title;
  final RequestController controller;

  const AddPhotoGrid({super.key, this.title, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossStart,
      children: [
        TextWidget(
          title ?? 'Add Photo or video',
          fontSize: Dimensions.titleSmall,
          fontWeight: FontWeight.w500,
          color: CustomColors.blackColor.withAlpha(888),
        ),
        SizedBox(
          height: Dimensions.spaceBetweenInputTitleAndBox * 0.6,
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

