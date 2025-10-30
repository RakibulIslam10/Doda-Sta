part of '../screen/home_screen.dart';

class SearchBarWidgetView extends GetView<HomeController> {
  const SearchBarWidgetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: CustomColors.primary, width: 1.4),
          borderRadius: BorderRadius.circular(Dimensions.radius * 0.8),
        ),
        child: TextField(
          onChanged: (value){

          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            prefixIcon: Icon(Icons.search),
            hintText: "Search"
          ),
        ),
      ),
    );
  }
}
