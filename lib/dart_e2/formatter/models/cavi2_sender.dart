class Cavi2Sender {
  final String id;
  final String instanceId;
  final String? hostId;

  Cavi2Sender({
    required this.id,
    required this.instanceId,
    required this.hostId,
  });

  factory Cavi2Sender.fromMap(Map<String, dynamic> json) => Cavi2Sender(
        id: json["id"],
        instanceId: json["instanceId"],
        hostId: json["hostId"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "instanceId": instanceId,
        "hostId": hostId,
      };
}
