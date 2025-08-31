import 'package:doda_work/routes/routes.dart';
import 'package:doda_work/widgets/text_widget.dart';
import '../core/themes/token.dart';
import '../core/utils/basic_import.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isBack;

  // ✅ Optional Color Parameters
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? iconColor;
  final Color? borderColor;
  final bool isSkip;

  const CommonAppBar({
    super.key,
    required this.title,
    this.isBack = true,
    this.isSkip = true,
    this.backgroundColor,
    this.titleColor,
    this.iconColor,
    this.borderColor,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.transparent,
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      centerTitle: true,
      leading: isBack
          ? Icon(Icons.arrow_back_ios, color: CustomColors.primary)
          : null,
      title: TextWidget(
        title,
        color: titleColor ?? CustomColors.whiteColor,
        fontSize: Dimensions.titleMedium * 1.2,
        fontWeight: FontWeight.bold,
      ),

      actions: [
        isSkip
            ? TextWidget(
                onTap: () => Get.offAllNamed(Routes.loginScreen),
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: Dimensions.defaultHorizontalSize,
                ),
                'Skip',
                color: CustomColors.primary,
              )
            : Container(),
      ],
    );
  }
}
