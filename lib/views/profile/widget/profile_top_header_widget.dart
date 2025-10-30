part of '../screen/profile_screen.dart';

class ProfileTopHeaderWidgetView extends GetView<ProfileController> {
  const ProfileTopHeaderWidgetView({super.key});

  @override
  Widget build(BuildContext context) {
    final double imageWidth = MediaQuery.of(context).size.width * 0.28;
    final double cardHeight = MediaQuery.of(context).size.height * 0.12;

    return Obx(() {
      final vendor = AppStorage.isVendor == true;
      return Container(
        height: cardHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.radius * 0.8),
          border: Border.all(color: Colors.grey.withAlpha(555)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Image
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius * 0.8),
                bottomLeft: Radius.circular(Dimensions.radius * 0.8),
              ),
              child: CachedNetworkImage(
                imageUrl: controller.userProfileModel.data.profileImage.isEmpty
                    ? 'https://picsum.photos/200/300?random='
                    : "${ApiEndPoints.baseUrl}${controller.userProfileModel.data.profileImage}",
                width: imageWidth * 0.85,
                height: cardHeight,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Container(color: Colors.grey.shade300),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey.shade400,
                  child: const Icon(Icons.image_not_supported, size: 40),
                ),
              ),
            ),
            Space.width.v10,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Space.height.v10,
                  TextWidget(
                    padding: EdgeInsets.only(bottom: Dimensions.verticalSize * 0.2),
                    vendor ? controller.providerProfileModel.data.companyName : controller.userProfileModel.data.name,
                    fontSize: Dimensions.titleSmall,
                    fontWeight: FontWeight.w500,
                  ),
                  Row(
                    children: [
                      TextWidget("@", color: CustomColors.primary, fontSize: Dimensions.titleSmall * 0.8),
                      TextWidget(
                        vendor ? controller.providerProfileModel.data.authId.email : controller.userProfileModel.data.email,

                        fontSize: Dimensions.titleSmall * 0.8,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.call, size: Dimensions.iconSizeSmall * 1.2, color: CustomColors.primary),
                      TextWidget(
                        padding: EdgeInsets.only(left: Dimensions.defaultHorizontalSize * 0.1),
                        vendor ? '' : controller.userProfileModel.data.phoneNumber,

                        fontSize: Dimensions.titleSmall * 0.8,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Edit Button
            InkWell(
              onTap: () => Get.toNamed(vendor ? Routes.vendor_profileScreen : Routes.updateScreen),
              child: Container(
                margin: EdgeInsets.all(Dimensions.paddingSize * 0.2),
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.defaultHorizontalSize * 0.2,
                  vertical: Dimensions.verticalSize * 0.1,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: CustomColors.primary),
                  borderRadius: BorderRadius.circular(Dimensions.radius * 0.4),
                ),
                child: Row(
                  children: [
                    Icon(Icons.edit, color: CustomColors.primary, size: Dimensions.iconSizeSmall * 1.4),
                    TextWidget(
                      padding: EdgeInsets.only(left: Dimensions.defaultHorizontalSize * 0.1),
                      'Edit Profile',
                      fontSize: Dimensions.titleSmall * 0.6,
                      color: CustomColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ).withShadifyLoading(loading: controller.isLoading.value);
    });
  }
}
