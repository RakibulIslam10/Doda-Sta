part of '../screen/home_screen.dart';

class CustomStatusCardWidget extends StatelessWidget {
  final int index;
  final String requestId;
  final String category;
  final String subCategory;
  final String address;
  final String status;

  const CustomStatusCardWidget({
    super.key,
    required this.index,
    required this.requestId,
    required this.category,
    required this.subCategory,
    required this.address,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    // Responsive sizing
    final double cardHeight = MediaQuery.of(context).size.height * 0.12;
    final double imageWidth = MediaQuery.of(context).size.width * 0.28;

    return Container(
      margin: EdgeInsets.only(bottom: Dimensions.verticalSize * 0.5),
      height: cardHeight,
      decoration: BoxDecoration(
        color: Colors.white, // optional background for better shadow visibility
        border: Border.all(
          color:Colors.grey.withAlpha(555),
        ),
        borderRadius: BorderRadius.circular(Dimensions.radius * 0.8),
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
                      Wrap(
                        children: [
                          TextWidget(
                            'Request ID: ',
                            color: CustomColors.primary,
                            fontSize: Dimensions.titleSmall * 0.85,
                          ),
                          TextWidget(
                            requestId,
                            fontSize: Dimensions.titleSmall * 0.9,
                          ),
                        ],
                      ),
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
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Icon(
                            Icons.location_pin,
                            color: CustomColors.primary,
                            size: Dimensions.iconSizeSmall * 1.6,
                          ),
                          SizedBox(width: Dimensions.horizontalSize * 0.3),
                          TextWidget(
                            address,
                            color: CustomColors.primary,
                            maxLines: 1,
                            textOverflow: TextOverflow.ellipsis,
                            fontSize: Dimensions.titleSmall * 0.9,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Status badge
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.defaultHorizontalSize * 0.3,
                    vertical: Dimensions.verticalSize * 0.1,
                  ),
                  decoration: BoxDecoration(
                    color: CustomColors.primary,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimensions.radius * 0.4),
                      bottomRight: Radius.circular(Dimensions.radius * 0.4),
                      bottomLeft: Radius.circular(Dimensions.radius * 0.4),
                    ),
                  ),
                  child: TextWidget(
                    status,
                    fontSize: Dimensions.titleSmall * 0.8,
                    color: CustomColors.whiteColor,
                    fontWeight: FontWeight.w500,
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
