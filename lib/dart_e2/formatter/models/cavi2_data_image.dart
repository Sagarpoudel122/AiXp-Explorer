class Cavi2DataImage {
  final int? id;
  final int? height;
  final int? width;

  Cavi2DataImage({
    this.id,
    this.height,
    this.width,
  });

  factory Cavi2DataImage.fromMap(Map<String, dynamic> json) => Cavi2DataImage(
        id: json["id"] as int?,
        height: json["height"] as int?,
        width: json["width"] as int?,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "height": height,
        "width": width,
      };
}
