part of 'home_vendor_screen.dart';

class HomeVendorScreenMobile extends GetView<HomeVendorController> {
  const HomeVendorScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HomeVendor", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: ListView(
          padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
          children: const [
            // Add your widgets here
          ],
        ),
      ),
    );
  }
}
