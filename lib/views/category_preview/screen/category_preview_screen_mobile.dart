part of 'category_preview_screen.dart';

class CategoryPreviewScreenMobile extends GetView<CategoryPreviewController> {
  const CategoryPreviewScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: 'Favorite'),
      body: SafeArea(
        child: ListView(
          padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
          children: [
            ListTile(
              trailing: Icon(Icons.favorite, color: CustomColors.primary),
              contentPadding: EdgeInsetsGeometry.zero,
              title: TextWidget(
                'Category ',
                fontWeight: FontWeight.w500,
                color: CustomColors.primary,
              ),

              subtitle: TextWidget(
                'Dlkfajsdlkdjsfladsfds',
                fontSize: Dimensions.titleSmall,
              ),
            ),
            DividerWidget(),
            ListTile(
              trailing: Icon(Icons.favorite, color: CustomColors.primary),
              contentPadding: EdgeInsetsGeometry.zero,
              title: TextWidget(
                'SubCatgegory ',
                fontWeight: FontWeight.w500,
                color: CustomColors.primary,
              ),

              subtitle: TextWidget(
                'Dlkfajsdlkdjsfladsfds',
                fontSize: Dimensions.titleSmall,
              ),
            ),
            DividerWidget(),
          ],
        ),
      ),
    );
  }
}
