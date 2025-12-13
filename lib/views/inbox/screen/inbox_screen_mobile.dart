import 'dart:io';
import 'package:shimmer/shimmer.dart';
import '../../../core/utils/basic_import.dart';
import '../../../core/utils/extensions.dart';
import '../../chat/widget/avatar.dart';
import '../controller/inbox_controller.dart';

class InboxScreenMobile extends GetView<InboxController> {
  InboxScreenMobile({super.key});

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // Pagination: scroll listener
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        controller.fetchMessages(isPagination: true);
      }
    });

    ever(controller.messagesList, (_) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    });

    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! < 0) {
          Get.close(1);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: Dimensions.appBarHeight * 1.4,
          automaticallyImplyLeading: false,
          scrolledUnderElevation: 0,
          flexibleSpace: Padding(
            padding: Dimensions.defaultHorizontalSize.edgeHorizontal,
            child: SafeArea(
              child: Row(
                crossAxisAlignment: crossCenter,
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(Icons.arrow_back_ios),
                  ),
                  SizedBox(width: 10),

                  ProfileAvatarWidget(
                    imageUrl: '${ApiEndPoints.mainDomain}/${controller.avatar}',
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: mainCenter,
                    children: [
                      Text(
                        controller.name ?? '',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Active now",
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ------------------ MESSAGES ------------------
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value &&
                    controller.messagesList.isEmpty) {
                  return const Center(child: InboxShimmerWidget());
                }

                if (controller.messagesList.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 64,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "No messages yet",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return Stack(
                  children: [
                    ListView.builder(
                      controller: _scrollController,
                      reverse: true,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      itemCount: controller.messagesList.length,
                      itemBuilder: (context, index) {
                        final msg =
                            controller.messagesList[controller
                                    .messagesList
                                    .length -
                                1 -
                                index];
                        final isMe = msg["isMe"] as bool;
                        final messageType = msg["type"] ?? "text";
                        final isLoading = msg["isLoading"] ?? false;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            mainAxisAlignment: isMe
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              if (!isMe) ...[
                                ProfileAvatarWidget(
                                  size: 40.r,
                                  imageUrl: controller.avatar,
                                ),
                                const SizedBox(width: 6),
                              ],
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: isMe
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                                  children: [
                                    // IMAGE BUBBLE
                                    if (messageType == "file" &&
                                        msg["files"] != null)
                                      Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            child:
                                                (msg["files"] as List)[0]
                                                    .toString()
                                                    .startsWith('http')
                                                ? Image.network(
                                                    (msg["files"] as List)[0],
                                                    width: width * 0.6,
                                                    fit: BoxFit.cover,
                                                  )
                                                : Image.file(
                                                    File(
                                                      (msg["files"] as List)[0],
                                                    ),
                                                    width: width * 0.6,
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                          if (isLoading)
                                            Positioned.fill(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.black45,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: const Center(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      CircularProgressIndicator(
                                                        color: Colors.white,
                                                        strokeWidth: 3,
                                                      ),
                                                      SizedBox(height: 8),
                                                      Text(
                                                        "Sending...",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),

                                    if (messageType == "file" &&
                                        msg["files"] != null)
                                      const SizedBox(height: 5),

                                    // TEXT BUBBLE
                                    if (msg["message"] != null &&
                                        msg["message"].toString().isNotEmpty)
                                      Container(
                                        constraints: BoxConstraints(
                                          maxWidth: width * 0.7,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 16,
                                        ),
                                        decoration: BoxDecoration(
                                          gradient: isMe
                                              ? const LinearGradient(
                                                  colors: [
                                                    Color(0xFF0084FF),
                                                    Color(0xFF0066FF),
                                                  ],
                                                )
                                              : null,
                                          color: isMe ? null : Colors.grey[200],
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: Text(
                                          msg["message"],
                                          style: TextStyle(
                                            color: isMe
                                                ? Colors.white
                                                : Colors.black87,
                                            fontSize: 15,
                                            height: 1.3,
                                          ),
                                        ),
                                      ),

                                    const SizedBox(height: 4),

                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            msg["formattedTime"] ?? "",
                                            style: TextStyle(
                                              color: Colors.grey[500],
                                              fontSize: 11,
                                            ),
                                          ),
                                          if (isMe) ...[
                                            const SizedBox(width: 4),
                                            Icon(
                                              (msg["isSent"] ?? true)
                                                  ? Icons.done_all
                                                  : Icons.access_time,
                                              size: 14,
                                              color: (msg["isSent"] ?? true)
                                                  ? Colors.blue[600]
                                                  : Colors.grey[500],
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    // PAGINATION LOADING
                    if (controller.isPaginationLoading.value)
                      const Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                      ),
                  ],
                );
              }),
            ),

            // ------------------ SELECTED IMAGE PREVIEW ------------------
            Obx(() {
              if (controller.selectedImage.value == null) {
                return const SizedBox.shrink();
              }

              return Container(
                height: 100,
                padding: const EdgeInsets.all(8),
                color: Colors.grey[100],
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        File(controller.selectedImage.value!.path),
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: GestureDetector(
                        onTap: controller.removeImage,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),

            // ------------------ INPUT FIELD ------------------
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: SafeArea(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.camera_alt, color: Colors.blue[600]),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.photo, color: Colors.blue[600]),
                      onPressed: controller.pickImageFromGallery,
                    ),
                    Expanded(
                      child: Container(
                        constraints: const BoxConstraints(maxHeight: 120),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextField(
                          controller: controller.textController,
                          maxLines: null,
                          minLines: 1,
                          textInputAction: TextInputAction.newline,
                          decoration: InputDecoration(
                            hintText: "Aa",
                            hintStyle: TextStyle(color: Colors.grey[500]),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                          ),
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: controller.sendMessage,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF0084FF), Color(0xFF0066FF)],
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InboxShimmerWidget extends StatelessWidget {
  const InboxShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      period: const Duration(milliseconds: 1200),
      child: SafeArea(
        child: Column(
          children: [
            Space.height.v20,
            // -------- CHAT MESSAGES SHIMMER --------
            Expanded(
              child: ListView.separated(
                reverse: true,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                itemCount: 20,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final isMe = index % 2 == 0;

                  return Row(
                    mainAxisAlignment: isMe
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isMe)
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.grey.shade300,
                          ),
                        ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: isMe
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            // Text bubble shimmer
                            Container(
                              width: width * 0.4,
                              height: 25,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              width: width * 0.15,
                              height: 15,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
