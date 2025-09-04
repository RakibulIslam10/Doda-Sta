part of 'summary_screen.dart';


class SummaryScreenMobile extends GetView<SummaryController> {
  const SummaryScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: 'Service Summary'),
      body: SafeArea(
        child: ListView(
          padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
          children: [
            Space.height.v10,
            ImageHeaderWidget(),
            Space.height.v10,

            RequestInfoCard(
              requestId: '112222',
              category: 'Induction In Kitchen',
              subcategory: 'Induction In Kitchen',
              priority: 'Urgency',
              customerName: 'Chime Alozie',
              address: 'Oldesloer Strasse 82',
            ),

            TextWidget(
              padding: EdgeInsetsGeometry.symmetric(
                vertical: Dimensions.verticalSize * 0.25,
              ),
              'Would you like to tell us more about your request?',
              fontWeight: FontWeight.bold,
              fontSize: Dimensions.titleMedium,
            ),
            RequestTextBoxWidget(),

            AddPhotoGrid(title: 'Attachments'),

            ButtonsSectionWidget()
          ],
        ),
      ),
    );
  }
}
