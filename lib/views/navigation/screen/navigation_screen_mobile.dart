part of 'navigation_screen.dart';

class NavigationScreenMobile extends GetView<NavigationController> {
  const NavigationScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    final List<Widget> pages = [
      AppStorage.isVendor == true ? HomeVendorScreen() : const HomeScreen(),
      AppStorage.isVendor == true ? CategoryScreen() : const RequestScreen(),
      const ChatScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: Obx(() => pages[controller.selectedIndex.value]),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05,
            vertical: Dimensions.verticalSize * 0.4,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                offset: const Offset(0, -3),
                blurRadius: 6,
              ),
            ],
          ),
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                controller.navigationList.length,
                (index) => _buildNavItem(index),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildNavItem(int index) {
    bool isSelected = controller.selectedIndex.value == index;
    print(
      '******************************************************************************************',
    );

    print(AppStorage.isVendor);
    return GestureDetector(
      onTap: () => controller.changeIndex(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            alignment: Alignment.center,
            duration: const Duration(milliseconds: 300),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: isSelected ? Colors.orange : Colors.transparent,
              borderRadius: BorderRadius.circular(Dimensions.radius * 0.8),
            ),
            child: SizedBox(
              height: isSelected ? 20.h : 22.h,
              width: isSelected ? 20.w : 22.w,
              child: SvgPicture.asset(
                controller.navigationList[index].iconPath,
                color: isSelected ? Colors.white : Colors.grey,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Space.height.v5,
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              fontSize: Dimensions.titleSmall,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.orange : Colors.grey,
            ),
            child: Text(controller.navigationList[index].name),
          ),
        ],
      ),
    );
  }
}
