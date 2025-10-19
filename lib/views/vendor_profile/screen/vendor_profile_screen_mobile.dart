part of 'vendor_profile_screen.dart';

class VendorProfileScreenMobile extends GetView<VendorProfileController> {
  const VendorProfileScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: 'Edit Profile'),
      body: SafeArea(
        child: ListView(
          padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
          children: [
            Space.height.v20,
            Center(
              child: Stack(
                children: [
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: 'https://picsum.photos/200/300?random=',
                      height: 110.h,
                      // make height = width
                      width: 110.h,
                      // use same value for width
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          Container(color: Colors.grey.shade300),
                      errorWidget: (context, error, stackTrace) => Icon(
                        Icons.person,
                        size: 110.h,
                        color: CustomColors.secondary,
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 4,
                    right: 0,
                    child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        controller.pickImg();
                      },
                      child: Container(
                        padding: EdgeInsets.all(Dimensions.paddingSize * 0.1),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: CustomColors.whiteColor.withAlpha(88),
                          ),
                          color: CustomColors.primary,
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: CustomColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Space.height.betweenInputBox,
            PrimaryInputFieldWidget(
              label: "Name",
              controller: controller.nameController,
              focusNode: controller.nameFocus,
              hintText: "Enter your name",
            ),
            Space.height.betweenInputBox,

            PrimaryInputFieldWidget(
              label: "Email",
              isEmail: true,
              controller: controller.emailController,
              focusNode: controller.emailFocus,
              nextFocusNode: controller.numberFocus,
              hintText: "Enter your email",
            ),
            Space.height.betweenInputBox,
            PrimaryInputFieldWidget(
              label: "Contact Number",
              keyBoardType: TextInputType.number,
              controller: controller.numberController,
              focusNode: controller.numberFocus,
              nextFocusNode: controller.locationFocus,
              hintText: "Enter your number",
            ),
            Space.height.betweenInputBox,

            PrimaryInputFieldWidget(
              label: "Location",
              controller: controller.locationController,
              focusNode: null,
              nextFocusNode: controller.numberFocus,
              hintText: "Enter your Location",
            ),
            Space.height.betweenInputBox,

            CustomDropDownWidget(
              label: 'Category',
              hint: 'Select Categoryu',
              items: [],
              onChanged: (value) {},
            ),
            Space.height.betweenInputBox,

            CustomDropDownWidget(
              label: 'Sub Category',
              hint: 'Select Sub Categoryu',
              items: [],
              onChanged: (value) {},
            ),

            Space.height.betweenInputBox,
            Space.height.betweenInputBox,

            PrimaryButtonWidget(title: 'Update', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
