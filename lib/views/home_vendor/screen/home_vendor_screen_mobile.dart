part of 'home_vendor_screen.dart';

class HomeVendorScreenMobile extends GetView<HomeVendorController> {
  const HomeVendorScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: HomeVendorController.statusTypes.length,
      child: Scaffold(appBar: _buildAppBar(), body: _buildBody()),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(Dimensions.appBarHeight * 1.25),
      child: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        flexibleSpace: HomeAppBarWidgetView(),
        actions: [_buildNotificationIcon()],
      ),
    );
  }

  Widget _buildNotificationIcon() {
    return Row(
      children: [
        GestureDetector(
          onTap: _navigateToNotifications,
          child: Container(
            margin: Dimensions.defaultHorizontalSize.edgeRight * 0.2,
            padding: EdgeInsets.all(Dimensions.paddingSize * 0.3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: CustomColors.primary),
            ),
            child: SvgPicture.asset(Assets.icons.group),
          ),
        ),
        Space.width.v10,
      ],
    );
  }

  void _navigateToNotifications() {
    Get.toNamed(Routes.notificationScreen);
  }

  Widget _buildBody() {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [_buildTabBarSection()];
      },
      body: _buildTabViews(),
    );
  }

  SliverToBoxAdapter _buildTabBarSection() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(children: [Obx(() => _buildTabBar(controller))]),
      ),
    );
  }

  Widget _buildTabBar(HomeVendorController controller) {
    return TabBar(
      tabAlignment: TabAlignment.start,
      isScrollable: true,
      indicatorColor: Colors.transparent,
      dividerColor: Colors.transparent,
      labelPadding: EdgeInsets.zero,
      enableFeedback: false,
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      onTap: _onTabChanged,
      tabs: List.generate(
        HomeVendorController.statusTypes.length,
        (index) => _buildTabItem(controller, index),
      ),
    );
  }

  void _onTabChanged(int value) {
    controller.selectedStatus.value = value;
    final status = HomeVendorController.statusTypes[value];
    final pagingController = controller.pagingControllers[status]!;

    // Refresh if empty, has error, or needs update
    if (pagingController.itemList == null ||
        pagingController.itemList!.isEmpty ||
        pagingController.error != null) {
      controller.fetch(status, 1);
    }
  }

  Widget _buildTabItem(HomeVendorController controller, int index) {
    final isSelected = controller.selectedStatus.value == index;
    final statusText = HomeVendorController.statusTypes[index];

    return Container(
      margin: const EdgeInsets.only(left: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected
            ? CustomColors.primary
            : CustomColors.primary.withAlpha(858),
        borderRadius: BorderRadius.circular(Dimensions.radius * 0.8),
      ),
      child: Center(
        child: TextWidget(
          statusText,
          fontWeight: FontWeight.w400,
          fontSize: Dimensions.bodySmall,
          color: isSelected ? CustomColors.whiteColor : CustomColors.blackColor,
        ),
      ),
    );
  }

  Widget _buildTabViews() {
    return TabBarView(
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(HomeVendorController.statusTypes.length, (index) {
        final status = HomeVendorController.statusTypes[index];
        return KeepAlivePage(child: _buildRequestList(status));
      }),
    );
  }

  Widget _buildRequestList(String status) {
    return RefreshIndicator(
      onRefresh: () => _refreshStatusList(status),
      child: PagedListView<int, HomeServiceItem>(
        pagingController: controller.pagingControllers[status]!,
        builderDelegate: PagedChildBuilderDelegate<HomeServiceItem>(
          firstPageProgressIndicatorBuilder: (_) => _buildLoadingIndicator(),
          newPageProgressIndicatorBuilder: (_) => _buildLoadingIndicator(),
          noItemsFoundIndicatorBuilder: (_) => _buildEmptyState(status),
          firstPageErrorIndicatorBuilder: (_) => _buildErrorState(status),
          itemBuilder: (context, item, itemIndex) {
            return _buildRequestCard(item, status, itemIndex);
          },
        ),
      ),
    );
  }

  Future<void> _refreshStatusList(String status) async {
    controller.pagingControllers[status]!.refresh();
  }

  Widget _buildRequestCard(HomeServiceItem item, String status, int itemIndex) {
    return CustomStatusCardWidget(
        index: itemIndex,
        customerId: item.customerId,
        requestId: item.requestId ?? "N/A",
        category: item.subcategory ?? "No Category",
        subCategory: item.serviceCategory?.name ?? "No Subcategory",
        address: item.address ?? "No Address",
        image: (item.attachments.isNotEmpty)
            ? item.attachments.first
            : '',
        leadPrice: item.leadPrice,
        status: status,
        isUser: false,
        onTapAccept: () => _handleStatusChange(item, "ACCEPT"),
        onTapDecline: () => _handleStatusChange(item, "DECLINED"),
        onTapComplete: () => _handleStatusChange(item, "COMPLETED"),
        onTap: () => status == "PENDING"
            ? _showErrorSnackbar("Request not yet accepted")
            : _navigateToSummary(item)
    );
  }

  void _handleStatusChange(HomeServiceItem item, String newStatus) {
    if (item.id != null) {
      controller.changeStatus(status: newStatus, id: item.id!);
    } else {
      _showErrorSnackbar("Unable to process request - Invalid ID");
    }
  }

  void _navigateToSummary(HomeServiceItem item) {
    Get.toNamed(
      Routes.summaryScreen,
      arguments: SummaryModel(
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
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildEmptyState(String status) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: SizedBox(
        height: Get.height * 0.6,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.inbox_outlined,
                  size: 80,
                  color: Colors.grey.shade400,
                ),
                Space.height.v20,
                TextWidget(
                  "No ${status.toLowerCase()} requests",
                  fontWeight: FontWeight.w600,
                  fontSize: Dimensions.bodyLarge,
                  color: Colors.grey.shade700,
                ),
                Space.height.v5,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: TextWidget(
                    "When you have ${status.toLowerCase()} requests, they'll appear here",
                    fontWeight: FontWeight.w400,
                    fontSize: Dimensions.bodySmall,
                    color: Colors.grey.shade500,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState(String status) {
    return SizedBox(
      height: Get.height * 0.6,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 80,
              color: Colors.red.shade400,
            ),
            Space.height.v20,
            TextWidget(
              "Failed to load requests",
              fontWeight: FontWeight.w600,
              fontSize: Dimensions.bodyLarge,
              color: Colors.grey.shade700,
            ),
            Space.height.v5,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: TextWidget(
                "Please check your connection and try again",
                fontWeight: FontWeight.w400,
                fontSize: Dimensions.bodySmall,
                color: Colors.grey.shade500,
                textAlign: TextAlign.center,
              ),
            ),
            Space.height.v10,
            ElevatedButton(
              onPressed: () => controller.fetch(status, 1),
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              child: const Text("Try Again"),
            ),
          ],
        ),
      ),
    );
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar(
      "Error",
      message,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
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
