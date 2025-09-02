part of '../screen/profile_screen.dart';

class ProfileTopHeaderWidgetView extends GetView<ProfileController> {
  const ProfileTopHeaderWidgetView({super.key});

  @override
  Widget build(BuildContext context) {
      final double imageWidth = MediaQuery.of(context).size.width * 0.28;
      final double cardHeight = MediaQuery.of(context).size.height * 0.12;
    return Container(
      height: cardHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.radius * 0.8),
        border: Border.all(color: Colors.grey.withAlpha(555)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05), // shadow color
            spreadRadius: 1, // how wide the shadow spreads
            blurRadius: 6, // softness of the shadow
            offset: const Offset(0, 3), // position of shadow (x, y)
          ),
        ],
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radius * 0.8),
              bottomLeft: Radius.circular(Dimensions.radius * 0.8),
            ),
            child: CachedNetworkImage(
              imageUrl: 'https://picsum.photos/200/300?random=',
              width: imageWidth * 0.85,
              height: cardHeight,
              placeholder: (context, url) =>
                  Container(color: Colors.grey.shade300),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey.shade400,
                child: const Icon(
                  Icons.image_not_supported,
                  color: Colors.grey,
                  size: 40,
                ),
              ),
              fit: BoxFit.cover,
            ),
          ),

          Space.width.v10,

          // Text + status
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Text part
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Space.height.v10,

                      TextWidget(
                        padding: EdgeInsetsGeometry.only(
                          bottom: Dimensions.verticalSize * 0.2,
                        ),
                        "Kieron Dotson",
                        fontSize: Dimensions.titleSmall,
                        fontWeight: FontWeight.w500,
                      ),
                      Row(
                        children: [
                          TextWidget(
                            "@",
                            color: CustomColors.primary,
                            fontSize: Dimensions.titleSmall * 0.8,
                            padding: EdgeInsetsGeometry.only(
                              right: Dimensions.widthSize * 0.4,
                            ),
                          ),
                          TextWidget(
                            "raibk10.devs@gmail.com",
                            fontSize: Dimensions.titleSmall * 0.8,
                            fontWeight: FontWeight.w500,
                            padding: EdgeInsetsGeometry.only(
                              bottom: Dimensions.widthSize * 0.4,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.call,
                            size: Dimensions.iconSizeSmall * 1.2,
                            color: CustomColors.primary,
                          ),
                          TextWidget(
                            padding: EdgeInsetsGeometry.only(
                              left: Dimensions.defaultHorizontalSize * 0.1,
                            ),
                            fontWeight: FontWeight.w500,

                            "(6854) 545",
                            fontSize: Dimensions.titleSmall * 0.8,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Status badge
                Container(
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
                    children: [
                      Icon(
                        Icons.edit,
                        color: CustomColors.primary,
                        size: Dimensions.iconSizeSmall * 1.4,
                      ),
                      TextWidget(
                        padding: EdgeInsetsGeometry.only(
                          left: Dimensions.defaultHorizontalSize * 0.1,
                        ),
                        'Edit Profile',
                        fontSize: Dimensions.titleSmall * 0.6,
                        color: CustomColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
