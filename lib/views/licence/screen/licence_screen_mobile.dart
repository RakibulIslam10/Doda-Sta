part of 'licence_screen.dart';

class LicenceScreenMobile extends GetView<LicenceController> {
  const LicenceScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: 'Licence'),
      body: SafeArea(
        child: ListView(
          padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
          children: [
            Obx(() {
              final items = controller.photos;
              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ...items.map(
                        (photo) => Container(
                      width: 100.w,
                      height: 90.h,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.orange),
                        borderRadius: BorderRadius.circular(Dimensions.radius * 0.8),
                        image: DecorationImage(
                          image: FileImage(photo),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: controller.pickImage,
                    child: Container(
                      width: 100.w,
                      height: 90.h,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.orange),
                        borderRadius: BorderRadius.circular(Dimensions.radius * 0.8),
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
            Space.height.v20,
            Obx(() {
              final isLoading = controller.isUpdateLoading.value;
              return Row(
                children: [
                  Expanded(
                    child: PrimaryButtonWidget(
                      title: isLoading ? 'Updating...' : 'Update',
                      onPressed: () {
                        if (!isLoading) {
                          controller.updateProfile(body: {});
                        }
                      },
                    ),
                  ),
                  Space.width.v10,
                  /*     Expanded(
                    child: PrimaryButtonWidget(
                      title: 'Add More',
                      outlineButton: true,
                      onPressed: controller.pickImage,
                    ),
                  ),*/
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
