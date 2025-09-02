part of '../screen/profile_screen.dart';

class ProfileCardSectionWidgetView extends GetView<ProfileController> {
  const ProfileCardSectionWidgetView({super.key});

  @override
  Widget build(BuildContext context) {
    final double cardHeight = MediaQuery.of(context).size.height * 0.065;
    return Column(
      children: [
        _buildSectionCard(cardHeight, Icons.settings, 'Account Setting'),
        _buildSectionCard(
          cardHeight,
          Icons.reviews_outlined,
          'Reviews & Ratings',
        ),
        _buildSectionCard(cardHeight, Icons.dataset_outlined, 'ADocuments'),
        _buildSectionCard(
          cardHeight,
          Icons.notification_add_outlined,
          'Notification',
        ),
        _buildSectionCard(
          cardHeight,
          Icons.menu_book_outlined,
          'Terms & Condition',
        ),
        _buildSectionCard(
          cardHeight,
          Icons.my_library_books_outlined,
          'Privacy policy',
        ),
        _buildSectionCard(cardHeight, Icons.logout, 'Log Out'),
      ],
    );
  }

  _buildSectionCard(double cardHeight, IconData icon, String title) {
    return GestureDetector(
      // onTap: () => Get.toNamed(Routes.chatScreen),
      child: Container(
        margin: EdgeInsetsGeometry.only(top: Dimensions.heightSize),
        height: cardHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.radius * 0.8),
          border: Border.all(color: Colors.grey.withAlpha(555)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02), // shadow color
              spreadRadius: 1, // how wide the shadow spreads
              blurRadius: 6, // softness of the shadow
              offset: const Offset(0, 3), // position of shadow (x, y)
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
                  icon: Icon(icon, color: CustomColors.primary),
                ),

                TextWidget(title, fontSize: Dimensions.titleSmall * 1.1),
              ],
            ),

            IconButton(
              onPressed: null,
              icon: Icon(Icons.arrow_forward_ios, color: CustomColors.primary),
            ),
          ],
        ),
      ),
    );
  }
}
