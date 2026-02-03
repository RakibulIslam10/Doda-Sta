import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../core/utils/basic_import.dart';
import '../../../core/utils/extensions.dart';
import '../../../routes/routes.dart';
import '../../summary/model/summary_model.dart';
import '../controller/home_controller.dart';
import '../model/home_model.dart';
import '../widget/category_widget.dart';
import '../widget/home_app_bar_widget.dart';
import 'home_screen.dart';

class HomeScreenMobile extends GetView<HomeController> {
  const HomeScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {

    final List<String> statusText = ['Pending', 'Ongoing', 'Completed'];
    final List<String> statusApi = ['PENDING', 'IN_PROGRESS', 'COMPLETED'];

    return DefaultTabController(
      length: statusText.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Dimensions.appBarHeight * 1.25),
          child: AppBar(
            scrolledUnderElevation: 0,
            automaticallyImplyLeading: false,
            flexibleSpace: HomeAppBarWidgetView(),
            actions: [
              GestureDetector(
                onTap: () => Get.toNamed(Routes.notificationScreen),
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
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await controller.refreshRequestList();
          },
          child: Column(
            children: [
              SizedBox(height: 12),
              CategoryWidgetView(),
              Obx(() => _buildTabBar(controller, statusText)),
              Space.height.v10,
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(statusText.length, (index) {
                    final status = statusApi[index];
                    return KeepAlivePage(
                      child: RefreshIndicator(
                        onRefresh: () async =>
                            controller.refreshStatusData(status),
                        child: CustomScrollView(
                          slivers: [
                            PagedSliverList<int, HomeServiceItem>(
                              pagingController: controller.pagingControllers[status]!,
                              builderDelegate:
                              PagedChildBuilderDelegate<HomeServiceItem>(
                                itemBuilder: (context, item, itemIndex) {
                                  String extractPostalCode(String? address) {
                                    if (address == null || address.isEmpty) {
                                      return "No Postal Code";
                                    }
                                    final RegExp postalCodeRegex = RegExp(r'\b\d{6}\b');
                                    final match = postalCodeRegex.firstMatch(address);

                                    return match != null ? match.group(0)! : "No Postal Code";
                                  }
                                  return CustomStatusCardWidget(
                                    index: itemIndex,
                                    requestId: item.requestId ?? "",
                                    category: item.subcategory ?? "",
                                    subCategory:
                                    item.serviceCategory?.name ?? "",
                                    address: extractPostalCode(item.address),
                                    image: item.attachments.first,
                                    isUser: true,
                                    status: status,
                                    customerId: item.customerId,

                                    onTap: () {
                                      Get.toNamed(
                                        Routes.summaryScreen,
                                        arguments: SummaryModel(
                                          isUser: true,
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
                                          completionProof: item.completionProof,
                                          providerNotes: item.providerNotes,
                                          id: item.id,
                                          status: item.status,
                                        ),
                                      );
                                    },

                                  );
                                },

                                noItemsFoundIndicatorBuilder: (_) => Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Text(
                                      "No ${statusText[index]} requests found",
                                      style: TextStyle(
                                        fontSize: Dimensions.titleSmall,
                                        color: CustomColors.grayShade,
                                      ),
                                    ),
                                  ),
                                ),
                                firstPageErrorIndicatorBuilder: (_) =>
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Text(
                                          "Error loading ${statusText[index]} requests",
                                          style: TextStyle(
                                            fontSize: Dimensions.titleSmall,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                newPageErrorIndicatorBuilder: (_) => Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Text(
                                      "Error loading more ${statusText[index]} requests",
                                      style: TextStyle(
                                        fontSize: Dimensions.titleSmall,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar(HomeController controller, List<String> statusText) {
    return TabBar(
      tabAlignment: TabAlignment.fill,
      isScrollable: false,
      indicatorColor: Colors.transparent,
      dividerColor: Colors.transparent,
      labelPadding: EdgeInsets.zero,
      enableFeedback: false,
      overlayColor: const MaterialStatePropertyAll(Colors.transparent),
      onTap: (index) => controller.selectedStatus.value = index,
      tabs: List.generate(statusText.length, (index) {
        final isSelected = controller.selectedStatus.value == index;
        return Container(
          margin: EdgeInsets.symmetric(
            horizontal: Dimensions.defaultHorizontalSize * 0.4,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.widthSize * 1.2,
            vertical: Dimensions.verticalSize * 0.32,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? CustomColors.primary
                : CustomColors.primary.withAlpha(85),
            borderRadius: BorderRadius.circular(Dimensions.radius * 0.8),
          ),
          child: Center(
            child: TextWidget(
              statusText[index],
              fontWeight: FontWeight.w500,
              fontSize: Dimensions.titleSmall,
              color: isSelected
                  ? CustomColors.whiteColor
                  : CustomColors.blackColor,
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
