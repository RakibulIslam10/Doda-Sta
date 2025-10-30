part of 'home_vendor_screen.dart';

class HomeVendorScreenMobile extends GetView<HomeVendorController> {
  const HomeVendorScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> statusText = ['PENDING', 'ACCEPTED', 'COMPLETED', 'DECLINED'];

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Dimensions.appBarHeight * 1.25),
          child: AppBar(
            automaticallyImplyLeading: false,
            scrolledUnderElevation: 0,
            flexibleSpace: const HomeAppBarWidgetView(),
            actions: [
              GestureDetector(
                onTap: () => Get.toNamed(Routes.notificationScreen),
                child: Container(
                  margin: Dimensions.defaultHorizontalSize.edgeRight,
                  padding: EdgeInsets.all(Dimensions.paddingSize * 0.35),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: CustomColors.primary),
                  ),
                  child: SvgPicture.asset(Assets.icons.group),
                ),
              ),
              Space.width.v10,
            ],
          ),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Obx(() => _buildTabBar(controller, statusText)),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: List.generate(statusText.length, (index) {
              final status = statusText[index].toUpperCase();
              return KeepAlivePage(
                child: PagedListView<int, HomeServiceItem>(
                  pagingController: controller.pagingControllers[status]!,
                  builderDelegate: PagedChildBuilderDelegate<HomeServiceItem>(
                    itemBuilder: (context, item, itemIndex) {
                      return CustomStatusCardWidget(
                        index: itemIndex,
                        requestId: item.requestId ?? "",
                        category: item.subcategory ?? "",
                        subCategory: item.serviceCategory?.name ?? "",
                        address: item.address ?? "",
                        image: item.attachments?.firstOrNull,
                        status: status,
                        isUser: false,
                        onTapAccept: (){
                          if(item.id != null){
                            controller.changeStatus(status: "ACCEPTED", id: item.id ?? "");
                          }else{
                            print("ID NULL");
                          }
                        },
                        onTapDecline: (){
                          if(item.id != null){
                            controller.changeStatus(status: "DECLINED", id: item.id ?? "");
                          }else{
                            print("ID NULL");
                          }
                        },
                        onTapComplete: (){
                          if(item.id != null){
                            controller.changeStatus(status: "COMPLETED", id: item.id ?? "");
                          }else{
                            print("ID NULL");
                          }
                        },
                        onTap: (){
                          Get.toNamed(Routes.summaryScreen, arguments: SummaryModel(
                            isUser: false,
                            requestId: item.requestId,
                            categoryIcon: item.serviceCategory?.icon,
                            categoryName: item.serviceCategory?.name,
                            customerPhone: item.customerPhone,
                            customerName: item.customerId?.name,
                            priority: item.priority,
                            address: item.address,
                            subcategory: item.subcategory,
                            description: item.description,
                            attachments: item.attachments,
                          ));
                        },
                      );
                    },
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar(HomeVendorController controller, List<String> statusText) {
    return TabBar(
      tabAlignment: TabAlignment.start,
      isScrollable: true,
      indicatorColor: Colors.transparent,
      dividerColor: Colors.transparent,
      labelPadding: EdgeInsets.zero,
      enableFeedback: false,
      overlayColor: WidgetStatePropertyAll(Colors.transparent),
      onTap: (value) {
        controller.selectedStatus.value = value;

        final status = statusText[value].toUpperCase();
        final controllerList = controller.pagingControllers[status]!;
        if (controllerList.itemList == null || controllerList.itemList!.isEmpty) {
          controller.fetch(status, 1);
        }
      },
      tabs: List.generate(statusText.length, (index) {
        final isSelected = controller.selectedStatus.value == index;
        return Container(
          margin: EdgeInsets.only(left: 6),
          padding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: isSelected ? CustomColors.primary : CustomColors.primary.withAlpha(858),
            borderRadius: BorderRadius.circular(Dimensions.radius * 0.8),
          ),
          child: Center(
            child: TextWidget(
              statusText[index],
              fontWeight: FontWeight.w400,
              fontSize: Dimensions.bodySmall,
              color: isSelected ? CustomColors.whiteColor : CustomColors.blackColor,
            ),
          ),
        );
      }),
    );
  }
}

class KeepAlivePage extends StatefulWidget {
  final Widget child;
  const KeepAlivePage({required this.child, super.key});

  @override
  State<KeepAlivePage> createState() => _KeepAlivePageState();
}

class _KeepAlivePageState extends State<KeepAlivePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
