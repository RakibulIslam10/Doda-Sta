part of 'register_screen.dart';

class RegisterScreenMobile extends GetView<RegisterController> {
  const RegisterScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        isBack: false,
          title: ''),
      body: SafeArea(
        child: ListView(
          padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
          children: [
            Space.height.v10,
            TextWidget(
              'Sign Up',
              fontSize: Dimensions.titleLarge,
              fontWeight: FontWeight.bold,
            ),
            TextWidget(
              "Let's get you set up and ready to go.",
              color: CustomColors.primary,
              fontWeight: FontWeight.w500,
            ),
            FieldsSectionView(),
            ButtonAndTextSectionView(),
            Space.height.v10,
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                TextWidget(
                  // padding: Dimensions.widthSize.edgeLeft,
                  'Already have an account?',
                  color: CustomColors.secondaryDarkText,
                  fontWeight: FontWeight.w400,
                  fontSize: Dimensions.titleMedium * 0.96,
                ),
                TextWidget(
                  padding: Dimensions.widthSize.edgeLeft * 0.24,
                  'Sign In',
                  onTap: () {
                    Get.offAllNamed(Routes.loginScreen);
                  },
                  color: CustomColors.primary,
                  fontWeight: FontWeight.w500,
                  fontSize: Dimensions.titleMedium * 0.96,
                ),
              ],
            ),
            Space.height.v40,
          ],
        ),
      ),
    );
  }
}

class ShakeWidget extends StatefulWidget {
  final Widget child;

  const ShakeWidget({super.key, required this.child});

  @override
  State<ShakeWidget> createState() => _ShakeWidgetState();
}

class _ShakeWidgetState extends State<ShakeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _offsetAnimation = Tween(
      begin: 0.0,
      end: 8.0,
    ).chain(CurveTween(curve: Curves.elasticIn)).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _offsetAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_offsetAnimation.value, 0),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
