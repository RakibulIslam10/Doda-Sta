part of 'summary_screen.dart';


class SummaryScreenMobile extends GetView<SummaryController> {
  const SummaryScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final SummaryModel model = Get.arguments;

    return Scaffold(
      appBar: CommonAppBar(title: 'Service Summary'),
      body: SafeArea(
        child: ListView(
          padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
          children: [
            Space.height.v10,
            ImageHeaderWidget(
              image: model.attachments?.firstOrNull,
            ),
            Space.height.v10,

            RequestInfoCard(
              requestId: model.requestId ?? "",
              category: model.categoryName ?? "",
              subcategory: model.subcategory ?? "",
              priority: model.priority ?? "",
              customerName: model.customerName ?? "",
              address: model.address ?? "",
            ),

            TextWidget(
              padding: EdgeInsetsGeometry.symmetric(
                vertical: Dimensions.verticalSize * 0.25,
              ),
              'Would you like to tell us more about your request?',
              fontWeight: FontWeight.bold,
              fontSize: Dimensions.titleMedium,
            ),
            RequestTextBoxWidget(
              description: model.description,
            ),

            // AddPhotoGrid(title: 'Attachments'),

           if(AppStorage.isVendor == false)...[
             ButtonsSectionWidget()
           ]
          ],
        ),
      ),
    );
  }
}
