import 'package:e2_explorer/src/data/constant_string_code.dart';
import 'package:e2_explorer/src/features/e2_status/application/e2_client.dart';
import 'package:e2_explorer/src/features/e2_status/application/e2_listener.dart';
import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:e2_explorer/src/styles/text_styles.dart';
import 'package:e2_explorer/src/widgets/xml_viewer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Comms extends StatefulWidget {
  const Comms({super.key, required this.boxName});

  final String boxName;

  @override
  State<Comms> createState() => _CommsState();
}

class _CommsState extends State<Comms> {
  get itemBuilder => null;

  int selectedIndex = 0;
  void changeImdex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final session = E2Client();

    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: NotificationAndPayloadList(boxName: widget.boxName),
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: 2,
            child: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.containerBgColor,
              ),
              child: XMLViwer(
                content: xml,
                type: "xml",
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationAndPayloadList extends StatefulWidget {
  final String boxName;
  const NotificationAndPayloadList({super.key, required this.boxName});

  @override
  State<NotificationAndPayloadList> createState() =>
      _NotificationAndPayloadListState();
}

class _NotificationAndPayloadListState
    extends State<NotificationAndPayloadList> {
  @override
  Widget build(BuildContext context) {
    final e2Client = E2Client();
    final data = e2Client.boxMessages[widget.boxName];
    print(data?.notificationMessages);

    List<NotificationData> notficationData = [
      ...(data?.notificationMessages ?? []).map(
        (e) => NotificationData(
            id: "",
            data: e.payload,
            dateTime: DateTime.now(),
            notificationType: NotificationType.Notification),
      ),
      ...(data?.payloadMessages ?? []).map(
        (e) => NotificationData(
            id: "",
            data: e.payload.toMap(),
            dateTime: e.localTimestamp,
            notificationType: NotificationType.Payload),
      ),
    ];
    notficationData.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    return E2Listener(
      onPayload: (a) {
        setState(() {});
      },
      onNotification: (a) {
        setState(() {});
      },
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 17),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.containerBgColor,
          ),
          child: ListView.separated(
            itemBuilder: (context, index) {
              return InkWell(
                // onTap: () => changeOmdex(index),
                child: _NotificationListItem(
                  notificationData: notficationData[index],
                  isSelected: false,
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemCount: notficationData.length,
          ),
        );
      },
    );
  }
}

class _NotificationListItem extends StatelessWidget {
  final NotificationData notificationData;
  final bool isSelected;
  const _NotificationListItem({
    super.key,
    required this.notificationData,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF2E2C6A) : null,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            notificationData.notificationType.name,
            style: TextStyles.small14regular(color: const Color(0xFFDFDFDF)),
          ),
          Text(
            DateFormat('HH:mm:ss:ms').format(notificationData.dateTime),
            style: TextStyles.small14regular(color: const Color(0xFFDFDFDF)),
          ),
        ],
      ),
    );
    ;
  }
}

enum NotificationType { Payload, Notification }

class NotificationData {
  final NotificationType notificationType;
  final Map<String, dynamic> data;
  final DateTime dateTime;
  final String id;

  NotificationData({
    required this.id,
    required this.notificationType,
    required this.data,
    required this.dateTime,
  });
}
