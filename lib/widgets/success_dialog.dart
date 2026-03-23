import 'package:doda_work/core/utils/basic_import.dart';
import 'package:doda_work/widgets/primary_button_widget.dart';
import 'package:doda_work/widgets/text_widget.dart';

class SuccessDialog {
  static void show({
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    String buttonText = "OK",
  }) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius * 2),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(Dimensions.paddingSize),
          decoration: BoxDecoration(
            color: Theme.of(Get.context!).scaffoldBackgroundColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Dimensions.radius * 2),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 20.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              // Icon Wrapper
              Container(
                padding: EdgeInsets.all(Dimensions.paddingSize * 0.4),
                decoration: BoxDecoration(
                  color: CustomColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Container(
                  padding: EdgeInsets.all(Dimensions.paddingSize * 0.4),
                  decoration: BoxDecoration(
                    color: CustomColors.primary.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check_circle_rounded,
                    size: Dimensions.iconSizeLarge * 3,
                    color: CustomColors.primary, 
                  ),
                ),
              ),
              Space.height.v20,
              
              // Title
              TextWidget(
                title,
                fontSize: Dimensions.titleLarge,
                fontWeight: FontWeight.w800,
                color: CustomColors.primaryText,
                textAlign: TextAlign.center,
              ),
              Space.height.v10,
              
              // Subtitle
              TextWidget(
                subtitle,
                fontSize: Dimensions.titleSmall,
                color: CustomColors.secondaryDarkText ?? Colors.grey.shade600,
                textAlign: TextAlign.center,
                maxLines: 4,
              ),
              Space.height.v30,
              
              // Button
              PrimaryButtonWidget(
                title: buttonText,
                onPressed: onTap,
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
