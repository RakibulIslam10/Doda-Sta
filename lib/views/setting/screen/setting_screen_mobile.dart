part of 'setting_screen.dart';

class SettingScreenMobile extends GetView<SettingController> {
  const SettingScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: 'Account Setting'),
      body: SafeArea(
        child: ListView(
          padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
          children: [
            Space.height.v10,
            _buildSectionCard(
              Icons.lock,
              'Change Password',
              () => Get.toNamed(Routes.changePasswordScreen),
              false,
            ),
            _buildSectionCard(Icons.person, 'Delete Account', () {
              Get.dialog(
                AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      Dimensions.radius * 0.8,
                    ),
                  ),
                  title: TextWidget(
                    'Delete Account',
                    fontSize: Dimensions.titleLarge,
                    fontWeight: FontWeight.w500,
                  ),
                  content: const TextWidget(
                    'Are you sure you want to Delete Account ?',
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(
                            Dimensions.radius * 0.8,
                          ),
                        ),
                      ),
                      child: TextWidget('No', color: CustomColors.whiteColor),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.whiteColor,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: CustomColors.rejected),
                          borderRadius: BorderRadiusGeometry.circular(
                            Dimensions.radius * 0.8,
                          ),
                        ),
                      ),
                      child: TextWidget('Yes', color: CustomColors.rejected),
                    ),
                  ],
                ),
                barrierDismissible: true,
              );
            }, true),
          ],
        ),
      ),
    );
  }

  _buildSectionCard(
    IconData icon,
    String title,
    void Function()? onTap,
    bool isRed,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsetsGeometry.only(top: Dimensions.heightSize),
        height: Dimensions.heightSize * 4.4,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.radius * 0.8),
          border: Border.all(color: Colors.grey.withAlpha(555)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              spreadRadius: 1,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),

        child: Row(
          mainAxisAlignment: mainSpaceBet,
          children: [
            Wrap(
              spacing: Dimensions.defaultHorizontalSize * 0.2,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                IconButton(
                  onPressed: null,
                  icon: Icon(
                    icon,
                    color: isRed ? CustomColors.rejected : CustomColors.primary,
                  ),
                ),

                TextWidget(
                  title,
                  fontSize: Dimensions.titleSmall * 1.1,
                  color: isRed
                      ? CustomColors.rejected
                      : CustomColors.blackColor,
                ),
              ],
            ),

            IconButton(
              onPressed: null,
              icon: Icon(
                Icons.arrow_forward_ios,
                color: isRed ? CustomColors.rejected : CustomColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
