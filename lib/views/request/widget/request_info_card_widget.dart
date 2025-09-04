part of '../screen/request_screen.dart';

class RequestInfoCard extends StatelessWidget {
  final String requestId;
  final String category;
  final String subcategory;
  final String priority;
  final String customerName;
  final String address;

  const RequestInfoCard({
    super.key,
    required this.requestId,
    required this.category,
    required this.subcategory,
    required this.priority,
    required this.customerName,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.defaultHorizontalSize * 0.8,
        vertical: Dimensions.verticalSize * 0.5,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 6,
            offset: Offset(0, 3), // shadow position
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabelValue('Request ID', requestId),
          _buildLabelValue('Service category', category),
          _buildLabelValue('Subcategory', subcategory),
          _buildLabelValue('Priority', priority),
          _buildLabelValue('Customer Name', customerName),
          _buildLabelValue('Address', address),
        ],
      ),
    );
  }

  Widget _buildLabelValue(String label, String value) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: Dimensions.verticalSize * 0.1),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$label: ',
              style: TextStyle(
                color: CustomColors.primary, // tagline in primary color
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
            TextSpan(
              text: value,
              style: TextStyle(
                color: Colors.black, // value in black
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
