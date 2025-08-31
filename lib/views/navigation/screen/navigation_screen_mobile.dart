part of 'navigation_screen.dart';

class NavigationScreenMobile extends GetView<NavigationController> {
  const NavigationScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    final List<Widget> pages = [
      Center(child: Text('Home Page')),
      Center(child: Text('Categories Page')),
      Center(child: Text('Chat Page')),
      Center(child: Text('Profile Page')),
    ];

    return Scaffold(
      body: Obx(() => pages[controller.selectedIndex.value]),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -2),
            )
          ],
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Obx(
              () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, 0),
              _buildNavItem(Icons.grid_view, 1),
              _buildMiddleNavItem(Icons.add), // highlighted middle button
              _buildNavItem(Icons.chat, 2),
              _buildNavItem(Icons.person, 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    bool isSelected = controller.selectedIndex.value == index;

    return GestureDetector(
      onTap: () => controller.changeIndex(index),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: isSelected ? 55 : 40,
        width: isSelected ? 55 : 40,
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.grey,
          size: isSelected ? 30 : 24,
        ),
      ),
    );
  }

  Widget _buildMiddleNavItem(IconData icon) {
    return GestureDetector(
      onTap: () => controller.changeIndex(0), // or any desired index
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          color: Colors.orange,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.orange.withOpacity(0.5),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: 35),
      ),
    );
  }
}
