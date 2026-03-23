import '../../../core/utils/app_storage.dart';
import '../../../core/utils/basic_import.dart';
import '../../../core/utils/extensions.dart';
import '../../navigation/controller/navigation_controller.dart';
import '../../profile/controller/profile_controller.dart';

class HomeAppBarWidgetView extends GetView<ProfileController> {
  const HomeAppBarWidgetView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Get.find<NavigationController>().goToProfile(),
              child: Image.asset(Assets.logo.aaplogo.path, height: 60.h),
            ),
            Space.width.v10,

            /// USER GREETING
            Expanded(
              child: Obx(() {
                final isVendor = AppStorage.isProvider;

                final userName = isVendor
                    ? controller.providerProfileModel.value?.data.companyName ?? 'Provider'
                    : controller.userProfileModel.value?.data?.name ?? 'User';

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        TextWidget(
                          "Hello ",
                          color: CustomColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                        TextWidget(
                          userName,
                          fontSize: Dimensions.titleSmall,
                          fontWeight: FontWeight.w600,
                          color: CustomColors.blackColor,
                        ),
                      ],
                    ),
                    TextWidget(
                      'Welcome Back',
                      fontSize: Dimensions.titleSmall,
                      fontWeight: FontWeight.w400,
                      color: CustomColors.primary,
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}