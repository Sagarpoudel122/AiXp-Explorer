part of ai;

class CameraStream {
  CameraStream({
    required this.name,
    required this.uuid,
    required this.cameraName,
    required this.cameraUUID,
    required this.boxName,
    required this.location,
    required this.url,
    this.pipeline,
  });
  final String name;
  final String uuid;
  final String cameraName;
  final String cameraUUID;
  final String boxName;
  final String location;
  AIPipeline? pipeline;
  final String url;

  String get pipelineKey {
    //final String validCameraName = cameraName.replaceAll(' ', '_');
    return 'cam-$cameraUUID-stream-$uuid';
  }

  CameraStream copyWith({
    String? name,
    String? uuid,
    String? cameraName,
    String? cameraUUID,
    String? boxName,
    String? location,
    String? url,
    AIPipeline? pipeline,
  }) {
    return CameraStream(
      name: name ?? this.name,
      uuid: uuid ?? this.uuid,
      cameraName: cameraName ?? this.cameraName,
      cameraUUID: cameraUUID ?? this.cameraUUID,
      boxName: boxName ?? this.boxName,
      location: location ?? this.location,
      pipeline: pipeline ?? this.pipeline,
      url: url ?? this.url,
    );
  }
}
