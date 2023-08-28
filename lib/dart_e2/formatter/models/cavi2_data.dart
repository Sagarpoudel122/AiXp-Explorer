/*

          "identifiers": {},
          "value": {},
          "specificValue": {},
          "time": null,
          "img": {
               "id": null,
               "height": null,
               "width": null
          }
 */

import 'cavi2_data_image.dart';

class Cavi2Data {
  final Map<String, dynamic> identifiers;
  final Map<String, dynamic> value;
  final Map<String, dynamic> specificValue;
  final String? time;
  final Cavi2DataImage image;

  Cavi2Data({
    required this.identifiers,
    required this.value,
    required this.specificValue,
    this.time,
    required this.image,
  });

  factory Cavi2Data.fromMap(Map<String, dynamic> json) => Cavi2Data(
        identifiers: (json["identifiers"] ?? {}) as Map<String, dynamic>,
        value: json["value"] as Map<String, dynamic>,
        specificValue: json["specificValue"] as Map<String, dynamic>,
        time: json["time"] as String?,
        image: Cavi2DataImage.fromMap(json["img"]),
      );

  Map<String, dynamic> toMap() => {
        "identifiers": identifiers,
        "value": value,
        "specificValue": specificValue,
        "time": time,
        "img": image.toMap(),
      };
}
