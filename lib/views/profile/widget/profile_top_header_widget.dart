import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:shadify/shadify.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/utils/app_storage.dart';
import '../../../core/utils/basic_import.dart';
import '../../../routes/routes.dart';
import '../controller/profile_controller.dart';

class ProfileTopHeaderWidgetView extends GetView<ProfileController> {
  const ProfileTopHeaderWidgetView({super.key});

  @override
  Widget build(BuildContext context) {
    final double imageWidth = MediaQuery.of(context).size.width * 0.28;
    final double cardHeight = MediaQuery.of(context).size.height * 0.12;

    return Obx(() {
      final bool isVendor = AppStorage.isProvider;

      // Get profile based on role
      final profile = isVendor
          ? controller.providerProfileModel
          : controller.userProfileModel?.data; // for user model

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
          children: [
            // Profile Image
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius * 0.8),
                bottomLeft: Radius.circular(Dimensions.radius * 0.8),
              ),
              child: CachedNetworkImage(
                imageUrl: isVendor
                    ? (controller
                                  .providerProfileModel
                                  ?.companyName
                                  .isNotEmpty ??
                              false
                          ? "${ApiEndPoints.baseUrl}${controller.providerProfileModel!.companyName}"
                          : 'https://picsum.photos/200/300?random=')
                    : (controller
                                  .userProfileModel
                                  ?.data
                                  ?.profileImage
                                  ?.isNotEmpty ??
                              false
                          ? "${ApiEndPoints.baseUrl}${controller.userProfileModel!.data!.profileImage}"
                          : 'https://picsum.photos/200/300?random='),

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
                    isVendor
                        ? controller.providerProfileModel?.companyName ??
                              "Provider Name"
                        : controller.userProfileModel?.data?.name ??
                              "User Name",
                    fontSize: Dimensions.titleSmall,
                    fontWeight: FontWeight.w500,
                    color: CustomColors.primary,
                  ),
                  Space.height.v5,
                  TextWidget(
                    isVendor
                        ? controller.providerProfileModel?.authId.email ??
                              "Provider Email"
                        : controller.userProfileModel?.data?.email ??
                              "User Email",
                    fontSize: Dimensions.titleSmall,
                    fontWeight: FontWeight.w500,
                    color: CustomColors.primary,
                  ),
                  Space.height.v5,
                  if (!isVendor)
                    TextWidget(
                      controller.userProfileModel?.data?.phoneNumber ?? "",
                      fontSize: Dimensions.titleSmall * 0.8,
                      fontWeight: FontWeight.w500,
                    ),
                  if (isVendor &&
                      controller.providerProfileModel?.rating != null)
                    TextWidget(
                      "Rating: ${controller.providerProfileModel!.rating} (${controller.providerProfileModel!.totalReviews} reviews)",
                      fontSize: Dimensions.titleSmall * 0.8,
                    ),
                ],
              ),
            ),

            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () => Get.toNamed(
                  isVendor ? Routes.vendor_profileScreen : Routes.updateScreen,
                ),
                child: Container(
                  margin: EdgeInsets.all(Dimensions.paddingSize * 0.2),
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.defaultHorizontalSize * 0.2,
                    vertical: Dimensions.verticalSize * 0.1,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: CustomColors.primary),
                    borderRadius: BorderRadius.circular(
                      Dimensions.radius * 0.4,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.edit,
                        color: CustomColors.primary,
                        size: Dimensions.iconSizeSmall * 1.4,
                      ),
                      TextWidget(
                        'Edit',
                        fontSize: Dimensions.titleSmall * 0.6,
                        color: CustomColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ).withShadifyLoading(loading: controller.isLoading.value);
    });
  }
}
