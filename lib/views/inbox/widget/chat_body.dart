import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:doda_work/core/themes/token.dart';
import 'package:doda_work/views/inbox/controller/inbox_controller.dart';
import '../../../core/utils/basic_import.dart';
import '../../../widgets/text_widget.dart';

class ChatBodyWidget extends GetView<InboxController> {
  const ChatBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Expanded(
      child: Obx(() {
        return ListView.builder(
          controller: controller.scrollController,
          reverse: true, // 👈 latest messages stick to bottom
          physics: const BouncingScrollPhysics(), // 👈 smooth physics
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.04,
            vertical: MediaQuery.of(context).size.height * 0.02,
          ),
          itemCount: controller.messageList.length,
          itemBuilder: (context, index) {
            // 👇 Because reverse:true, flip the index
            final message =
            controller.messageList[controller.messageList.length - 1 - index];
            final isMe = message.isMe;

            if (isMe) {
              return Align(
                alignment:
                isRtl ? Alignment.centerLeft : Alignment.centerRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7,
                      ),
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          vertical: Dimensions.verticalSize * 0.2,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: CustomColors.primary,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(Dimensions.radius * 0.85),
                            topRight: Radius.circular(Dimensions.radius * 0.85),
                            bottomLeft: Radius.circular(Dimensions.radius * 0.85),
                          ),
                        ),
                        child: message.imageUrl != null
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            File(message.imageUrl!),
                            width:
                            MediaQuery.of(context).size.width * 0.5,
                            fit: BoxFit.cover,
                          ),
                        )
                            : TextWidget(
                          message.text ?? '',
                          fontSize:
                          MediaQuery.of(context).size.width * 0.04,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    TextWidget(
                      '13.47',
                      color: CustomColors.grayShade,
                      fontWeight: FontWeight.w600,
                      fontSize: Dimensions.titleSmall * 0.7,
                    ),
                  ],
                ),
              );
            } else {
              return Align(
                alignment:
                isRtl ? Alignment.centerRight : Alignment.centerLeft,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl:
                                'https://t4.ftcdn.net/jpg/04/31/64/75/360_F_431647519_usrbQ8Z983hTYe8zgA7t1XVc5fEtqcpa.jpg',
                                fit: BoxFit.cover,
                                height: 50,
                                width: 50,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Icon(
                              Icons.circle,
                              color: Colors.green,
                              size: Dimensions.iconSizeSmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            'Stevano Clirover',
                            fontWeight: FontWeight.w600,
                            fontSize: Dimensions.titleSmall * 0.9,
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth:
                              MediaQuery.of(context).size.width * 0.7,
                            ),
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                vertical: Dimensions.verticalSize * 0.25,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(Dimensions.radius),
                                  topRight: Radius.circular(Dimensions.radius),
                                  bottomRight:
                                  Radius.circular(Dimensions.radius),
                                ),
                              ),
                              child: message.imageUrl != null
                                  ? ClipRRect(
                                borderRadius: BorderRadius.circular(Dimensions.radius * 0.85),
                                child: Image.file(
                                  File(message.imageUrl!),
                                  width:
                                  MediaQuery.of(context).size.width *
                                      0.5,
                                  fit: BoxFit.cover,
                                ),
                              )
                                  : TextWidget(
                                message.text ?? '',
                                fontSize: MediaQuery.of(context)
                                    .size
                                    .width *
                                    0.04,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          TextWidget(
                            '09.00',
                            fontSize: Dimensions.titleSmall * 0.8,
                            color: CustomColors.grayShade,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        );
      }),
    );
  }
}
