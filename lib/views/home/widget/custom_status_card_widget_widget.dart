part of '../screen/home_screen.dart';

class CustomStatusCardWidget extends StatelessWidget {
  final int index;
  final String requestId;
  final String category;
  final String subCategory;
  final String address;
  final String? image;
  final String status;
  final void Function()? onTap;

  const CustomStatusCardWidget({
    super.key,
    required this.index,
    required this.requestId,
    required this.category,
    required this.subCategory,
    this.image,
    required this.address,
    required this.status,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double cardHeight = MediaQuery.of(context).size.height * 0.12;
    final double imageWidth = MediaQuery.of(context).size.width * 0.28;
    final url = "${ApiEndPoints.baseUrl}$image";
    final fixedUrl = url.replaceAll(r'\', '/');

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(
          bottom: 8,
          right: 8,
          left: 8,
          top: 6,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.withAlpha(555)),
          borderRadius: BorderRadius.circular(Dimensions.radius * 0.8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius * 0.8),
                bottomLeft: Radius.circular(Dimensions.radius * 0.8),
              ),
              child: CachedNetworkImage(
                imageUrl: image != null? fixedUrl : 'https://picsum.photos/200/300?random=${index + 1}',
                width: imageWidth,
                height: cardHeight,
                placeholder: (context, url) => Container(color: Colors.grey.shade300),
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
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
                  Row(
                    children: [
                      TextWidget(
                        'Request ID: ',
                        color: CustomColors.primary,
                        fontSize: Dimensions.titleSmall * 0.85,
                      ),
                      Flexible(
                        child: TextWidget(
                          requestId,
                          maxLines: 1,
                          fontSize: Dimensions.titleSmall * 0.9,
                        ),
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
                  Row(
                    children: [
                      Icon(
                        Icons.location_pin,
                        color: CustomColors.primary,
                        size: Dimensions.iconSizeSmall * 1.6,
                      ),
                      Flexible(
                        child: TextWidget(
                          address,
                          color: CustomColors.primary,
                          maxLines: 1,
                          textOverflow: TextOverflow.ellipsis,
                          fontSize: Dimensions.titleSmall * 0.9,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
