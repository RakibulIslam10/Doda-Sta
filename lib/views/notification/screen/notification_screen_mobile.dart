part of 'notification_screen.dart';

class NotificationScreenMobile extends GetView<NotificationController> {
  const NotificationScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final double cardHeight = MediaQuery.of(context).size.height * 0.08;

    return Scaffold(
      appBar: CommonAppBar(title: 'Notification'),
      body: SafeArea(
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Container(
                    margin: EdgeInsets.only(top: Dimensions.heightSize),
                    height: cardHeight,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        Dimensions.radius * 0.8,
                      ),
                      border: Border.all(color: Colors.grey.withAlpha(555)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: Dimensions.defaultHorizontalSize,
                        vertical: Dimensions.verticalSize * 0.2,
                      ),
                      title: TextWidget(
                        "Service Accepted / Matched",
                        color: CustomColors.primary,
                        maxLines: 1,
                        fontWeight: FontWeight.w500,
                      ),
                      subtitle: TextWidget(
                        "Please leave a review for your service at 04:00 PM Please leave a review for your service at 04:00 PM",
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
                  childCount: 100,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
