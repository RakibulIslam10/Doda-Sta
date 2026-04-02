part of 'aditional_screen.dart';

class ProviderPreviewWidget extends StatelessWidget {
  final AditionalController controller;

  const ProviderPreviewWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.radius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _buildSectionTitle("General Information"),
          _buildInfoRow("Website", controller.linkController.text.isEmpty ? "N/A" : controller.linkController.text),
          _buildInfoRow("Contact", controller.contactPersonController.text),
          _buildInfoRow("Address", controller.selectedAddress.value),
          
          const Divider(height: 30),
          
          _buildSectionTitle("Services Offered"),
          _buildServiceList(),
          
          const Divider(height: 30),
          
          _buildSectionTitle("Availability"),
          _buildAvailabilityList(),
          
          const Divider(height: 30),
          
          _buildSectionTitle("License & Certificates"),
          _buildPhotoPreview(),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextWidget(
        title,
        fontSize: Dimensions.titleMedium,
        fontWeight: FontWeight.bold,
        color: CustomColors.primary,
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100.w,
            child: TextWidget(
              "$label:",
              fontSize: Dimensions.bodyMedium,
              fontWeight: FontWeight.w500,
              color: CustomColors.grayShade,
            ),
          ),
          Expanded(
            child: TextWidget(
              value,
              fontSize: Dimensions.bodyMedium,
              fontWeight: FontWeight.w400,
              color: CustomColors.blackColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceList() {
    final selectedNames = controller.serviceCategoryList
        .where((s) => controller.selectedServiceList.contains(s.id))
        .map((s) => s.name)
        .join(", ");
    
    return TextWidget(
      selectedNames.isEmpty ? "None selected" : selectedNames,
      fontSize: Dimensions.bodyMedium,
      color: CustomColors.blackColor,
    );
  }

  Widget _buildAvailabilityList() {
    final data = controller.getAvailabilityData();
    if (data.isEmpty) return const TextWidget("None set", color: Colors.grey);

    return Column(
      children: data.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(item['day'], fontWeight: FontWeight.w500),
              TextWidget("${item['startTime']} - ${item['endTime']}"),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPhotoPreview() {
    if (controller.photos.isEmpty) {
      return const TextWidget("No photos added", color: Colors.grey);
    }
    return SizedBox(
      height: 100.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.photos.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 8),
            width: 120.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: FileImage(controller.photos[index]),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
