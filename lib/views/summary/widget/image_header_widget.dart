part of '../screen/summary_screen.dart';

class ImageHeaderWidget extends GetView<SummaryController> {
  const ImageHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(
        Dimensions.radius * 0.8,
      ),
      child: CachedNetworkImage(
        imageUrl:
        'https://picsum.photos/200/300?random=asdfgadhfdsagds',
        width: double.infinity,
        height: 120.h,
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
    );
  }
}
