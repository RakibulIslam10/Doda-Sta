part of '../screen/home_vendor_screen.dart';

class VendorStatusCardWidget extends StatelessWidget {
  final int index;
  final String category;
  final String subCategory;
  final String dateTime;
  final void Function()? onTap;

  const VendorStatusCardWidget({
    super.key,
    required this.index,
    required this.category,
    required this.subCategory,
    required this.dateTime,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Responsive sizing
    final double cardHeight = MediaQuery.of(context).size.height * 0.14;
    final double imageWidth = MediaQuery.of(context).size.width * 0.28;

    return InkWell(
      onTap: onTap ?? () => Get.toNamed(Routes.summaryScreen),
      child: Container(
        margin: EdgeInsets.only(
          bottom: Dimensions.verticalSize * 0.5,
          right: Dimensions.defaultHorizontalSize,
          left: Dimensions.defaultHorizontalSize,
        ),
        height: cardHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.withAlpha(555)),
          borderRadius: BorderRadius.circular(Dimensions.radius * 0.8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05), // shadow color
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
                imageUrl: 'https://picsum.photos/200/300?random=${index + 1}',
                width: imageWidth,
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
                          'Category: $category',
                          maxLines: 1,
                          textOverflow: TextOverflow.ellipsis,
                          fontSize: Dimensions.titleSmall * 0.9,
                        ),
                        TextWidget(
                          'Sub Category: $subCategory',
                          maxLines: 1,
                          textOverflow: TextOverflow.ellipsis,
                          fontSize: Dimensions.titleSmall * 0.9,
                        ),
                        SizedBox(width: Dimensions.horizontalSize * 0.3),
                        TextWidget(
                          dateTime,
                          color: CustomColors.primary,
                          maxLines: 1,
                          textOverflow: TextOverflow.ellipsis,
                          fontSize: Dimensions.titleSmall * 0.9,
                        ),
                        Space.height.v5,
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.dialog(
                                  AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        Dimensions.radius * 0.8,
                                      ),
                                    ),
                                    content: Column(
                                      mainAxisSize: mainMin,
                                      children: [
                                        SvgPicture.asset(
                                          Assets
                                              .dummy
                                              .streamlineUltimateColorSelfPaymentTouch,
                                        ),
                                        Space.height.v5,

                                        TextWidget(
                                          'Pay Now',
                                          fontWeight: FontWeight.bold,
                                          fontSize: Dimensions.titleLarge,
                                        ),
                                        Space.height.v5,
                                        TextWidget(
                                          'Please complete payment to accept task',
                                          fontSize: Dimensions.titleSmall,
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      Padding(
                                        padding: EdgeInsetsGeometry.symmetric(
                                          horizontal:
                                              Dimensions.defaultHorizontalSize,
                                        ),
                                        child: Row(
                                          mainAxisAlignment: mainSpaceBet,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    CustomColors.whiteColor,
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                    color: CustomColors.primary,
                                                  ),
                                                  borderRadius:
                                                      BorderRadiusGeometry.circular(
                                                        Dimensions.radius * 0.8,
                                                      ),
                                                ),
                                              ),
                                              child: TextWidget(
                                                padding:
                                                    EdgeInsetsGeometry.symmetric(
                                                      horizontal: Dimensions
                                                          .defaultHorizontalSize,
                                                    ),

                                                'Yes',
                                                color: CustomColors.primary,
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    CustomColors.secondary,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadiusGeometry.circular(
                                                        Dimensions.radius * 0.8,
                                                      ),
                                                ),
                                              ),
                                              child: TextWidget(
                                                padding:
                                                    EdgeInsetsGeometry.symmetric(
                                                      horizontal: Dimensions
                                                          .defaultHorizontalSize,
                                                    ),
                                                'No',
                                                color: CustomColors.whiteColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  barrierDismissible: true,
                                );
                              },
                              child: Container(
                                padding: EdgeInsetsGeometry.symmetric(
                                  horizontal:
                                      Dimensions.defaultHorizontalSize * 0.5,
                                  vertical: Dimensions.verticalSize * 0.06,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    Dimensions.radius * 0.4,
                                  ),
                                  color: CustomColors.primary,
                                ),

                                child: TextWidget(
                                  'Accept',
                                  color: CustomColors.blueColor,
                                  fontSize: Dimensions.titleSmall,
                                ),
                              ),
                            ),
                            Space.width.v10,
                            InkWell(
                              onTap: () {
                                Get.dialog(
                                  AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        Dimensions.radius * 0.8,
                                      ),
                                    ),
                                    content: Column(
                                      mainAxisSize: mainMin,
                                      children: [
                                        TextWidget(
                                          'Decline',
                                          color: CustomColors.primary,
                                          fontSize: Dimensions.titleSmall,
                                        ),
                                        Space.height.v10,
                                        PrimaryInputFieldWidget(
                                          controller: TextEditingController(),
                                          hintText: 'Type Something',
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      Row(
                                        mainAxisAlignment: mainCenter,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsGeometry.symmetric(
                                                  horizontal: Dimensions
                                                      .defaultHorizontalSize,
                                                ),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    CustomColors.primary,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadiusGeometry.circular(
                                                        Dimensions.radius * 0.8,
                                                      ),
                                                ),
                                              ),
                                              child: TextWidget(
                                                padding:
                                                    EdgeInsetsGeometry.symmetric(
                                                      horizontal: Dimensions
                                                          .defaultHorizontalSize,
                                                    ),
                                                'Submit',
                                                color: CustomColors.whiteColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  barrierDismissible: true,
                                );
                              },
                              child: Container(
                                padding: EdgeInsetsGeometry.symmetric(
                                  horizontal:
                                      Dimensions.defaultHorizontalSize * 0.5,
                                  vertical: Dimensions.verticalSize * 0.06,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    Dimensions.radius * 0.4,
                                  ),
                                  color: CustomColors.secondary,
                                ),

                                child: TextWidget(
                                  'Decline',
                                  color: CustomColors.whiteColor,
                                  fontSize: Dimensions.titleSmall,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
