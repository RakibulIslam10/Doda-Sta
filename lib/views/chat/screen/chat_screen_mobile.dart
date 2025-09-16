part of 'chat_screen.dart';

class ChatScreenMobile extends GetView<ChatController> {
  const ChatScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        toolbarHeight: Dimensions.appBarHeight * 1.6,
      flexibleSpace: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: Dimensions.defaultHorizontalSize),
          child: Row(
            mainAxisAlignment: mainSpaceBet,
            children: [
            GestureDetector(
              onTap: () => Get.find<NavigationController>().goToProfile(),
              child: SvgPicture.asset(Assets.logo.appLogo, height: 45.h),
            ),
            TextWidget(
              'Chat',
              color:
                CustomColors.blackColor,
              fontSize: Dimensions.titleMedium * 1.2,
              fontWeight: FontWeight.w600,
            ),
            GestureDetector(
              onTap: () => Get.toNamed(Routes.notificationScreen),
              child: Container(
                margin: Dimensions.defaultHorizontalSize.edgeRight,
                padding: EdgeInsets.all(Dimensions.paddingSize * 0.35),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: CustomColors.primary),
                ),
                child: SvgPicture.asset(Assets.icons.group),
              ),
            ),
          ],),
        ),
      ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: 10,
                  (context, index) => ListTile(
                    onTap: () => Get.toNamed(Routes.inboxScreen),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: Dimensions.verticalSize * 0.2,
                    ),
                    leading: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: "https://picsum.photos/200/300?rsdandom=",
                        width: 50.w,
                        height: 50.h,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Container(color: Colors.grey.shade300),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey.shade300,
                          child: const Icon(Icons.error, color: Colors.red),
                        ),
                      ),
                    ),
                    title: TextWidget(
                      'Maximillian Jacobson',
                      maxLines: 1,
                      fontWeight: FontWeight.w500,
                    ),
                    subtitle: TextWidget(
                      "Actually I wanted to check with you about your online business plan on our…",
                      fontSize: Dimensions.titleSmall * 0.8,
                      maxLines: 1,
                      fontWeight: FontWeight.w400,
                      color: CustomColors.grayShade,
                    ),

                    trailing: TextWidget(
                      '10/05/2024',
                      fontSize: Dimensions.titleSmall * 0.8,
                      fontWeight: FontWeight.w400,
                      color: CustomColors.grayShade,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
