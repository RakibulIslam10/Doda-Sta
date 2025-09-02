part of '../screen/home_screen.dart';

class StatusWidgetView extends StatelessWidget {
  const StatusWidgetView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> statusText = ['Pending', 'Ongoing', 'Complete'];

    return DefaultTabController(
      length: statusText.length,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          // Space.height.v10,
          // SizedBox(
          //   height: MediaQuery.of(context).size.height,
          //   child: ListView.builder(
          //     itemBuilder: (context, index) {
          //       return Container(
          //         margin: EdgeInsetsGeometry.only(
          //           bottom: Dimensions.verticalSize * 0.5,
          //         ),
          //         height: MediaQuery.of(context).size.height * 0.15,
          //         decoration: BoxDecoration(
          //           color: CustomColors.primary,
          //           borderRadius: BorderRadius.circular(Dimensions.radius),
          //         ),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
