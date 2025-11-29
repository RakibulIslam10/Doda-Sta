import '../../../core/utils/app_storage.dart';
import '../../../core/utils/basic_import.dart';
import '../../../core/utils/extensions.dart';
import '../../navigation/controller/navigation_controller.dart';
import '../../profile/controller/profile_controller.dart';

class HomeAppBarWidgetView extends GetView<ProfileController> {
  const HomeAppBarWidgetView({super.key});

  @override
  Widget build(BuildContext context) {
    final isVendor = AppStorage.isProvider; // role-based check

    // Get name dynamically based on role
    final userName = isVendor
        ? controller.providerProfileModel?.companyName ?? 'Provider'
        : controller.userProfileModel?.data?.name ?? 'User';

    // Get email dynamically based on role
    final userEmail = isVendor
        ? controller.providerProfileModel?.authId.email ?? 'Email'
        : controller.userProfileModel?.data?.email ?? 'Email';

    // Role label
    final roleLabel = isVendor ? 'Vendor' : 'User';

    return SafeArea(
      child: Padding(
        padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Get.find<NavigationController>().goToProfile(),
              child: SvgPicture.asset(Assets.logo.appLogo, height: 50.h),
            ),
            Space.width.v10,

            /// USER GREETING
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Wrap(
                    children: [
                      TextWidget(
                        "Hello ",
                        color: CustomColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                      TextWidget(
                        userName,
                        fontSize: Dimensions.titleSmall,
                        fontWeight: FontWeight.w500,
                        color: CustomColors.primary,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
