import 'package:doda_work/core/utils/extensions.dart';
import 'package:doda_work/routes/routes.dart';
import 'package:doda_work/views/home/controller/home_controller.dart';
import 'package:doda_work/views/home/model/home_model.dart';
import 'package:doda_work/views/summary/model/summary_model.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../core/utils/basic_import.dart';
import 'home_screen.dart';

class HomeScreenMobile extends GetView<HomeController> {
  const HomeScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> statusText = ['Pending', 'Ongoing', 'Completed'];

    return DefaultTabController(
      length: statusText.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Dimensions.appBarHeight * 1.25),
          child: AppBar(
            automaticallyImplyLeading: false,
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
                child: Column(
                  children: [
                    const SearchBarWidgetView(),
                    SizedBox(height: 12,),
                    const CategoryWidgetView(),
                    Obx(() => _buildTabBar(controller, statusText)),
                  ],
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
                        onTap: (){
                          Get.toNamed(Routes.summaryScreen, arguments: SummaryModel(
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

  Widget _buildTabBar(HomeController controller, List<String> statusText) {
    return TabBar(
      tabAlignment: TabAlignment.fill,
      isScrollable: false,
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
          margin: EdgeInsets.symmetric(horizontal: Dimensions.defaultHorizontalSize * 0.4),
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.widthSize * 1.2,
            vertical: Dimensions.verticalSize * 0.32,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? CustomColors.primary
                : CustomColors.primary.withAlpha(858),
            borderRadius: BorderRadius.circular(Dimensions.radius * 0.8),
          ),
          child: Center(
            child: TextWidget(
              statusText[index],
              fontWeight: FontWeight.w500,
              fontSize: Dimensions.titleSmall,
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