class NodeHistoryModel {
  bool collected;
  String currentServer;
  bool debugPayloadSaved;
  String e2TargetAddr;
  String e2TargetId;
  String eeEventType;
  String eeFormatter;
  String eeHash;
  String eeId;
  bool eeIsEncrypted;
  String eeMessageId;
  int eeMessageSeq;
  List<String> eePayloadPath;
  String eeSender;
  String eeSign;
  String eeTimestamp;
  String eeTimezone;
  int eeTotalMessages;
  String eeTz;
  String eeVersion;
  int id;
  List<String> idTags;
  bool imgInPayload;
  dynamic imgOrig;
  dynamic initiatorAddr;
  dynamic initiatorId;
  String instanceId;
  bool isAlert;
  bool isAlertNewLower;
  bool isAlertNewRaise;

  bool isAlertStatusChanged;
  bool isNewLower;
  bool isNewRaise;
  String modifiedByAddr;
  String modifiedById;
  NodeUsageHistory nodeHistory;
  String pipeline;
  String request;
  dynamic sessionId;
  String signature;
  String status;
  String stream;
  String streamName;
  String tags;
  String timestampArrival;
  String timestampExecution;
  String pAlertHelper;
  double pAliveTimeMins;
  bool pDatasetBuilderUsed;
  bool pDebugSavePayload;
  bool pDemoMode;
  List<dynamic> pGraphType;
  int pPluginLoopResolution;
  double pPluginRealResolution;
  int pProcessDelay;
  String pVersion;

  NodeHistoryModel({
    required this.collected,
    required this.currentServer,
    required this.debugPayloadSaved,
    required this.e2TargetAddr,
    required this.e2TargetId,
    required this.eeEventType,
    required this.eeFormatter,
    required this.eeHash,
    required this.eeId,
    required this.eeIsEncrypted,
    required this.eeMessageId,
    required this.eeMessageSeq,
    required this.eePayloadPath,
    required this.eeSender,
    required this.eeSign,
    required this.eeTimestamp,
    required this.eeTimezone,
    required this.eeTotalMessages,
    required this.eeTz,
    required this.eeVersion,
    required this.id,
    required this.idTags,
    required this.imgInPayload,
    required this.imgOrig,
    required this.initiatorAddr,
    required this.initiatorId,
    required this.instanceId,
    required this.isAlert,
    required this.isAlertNewLower,
    required this.isAlertNewRaise,
    required this.isAlertStatusChanged,
    required this.isNewLower,
    required this.isNewRaise,
    required this.modifiedByAddr,
    required this.modifiedById,
    required this.nodeHistory,
    required this.pipeline,
    required this.request,
    required this.sessionId,
    required this.signature,
    required this.status,
    required this.stream,
    required this.streamName,
    required this.tags,
    required this.timestampArrival,
    required this.timestampExecution,
    required this.pAlertHelper,
    required this.pAliveTimeMins,
    required this.pDatasetBuilderUsed,
    required this.pDebugSavePayload,
    required this.pDemoMode,
    required this.pGraphType,
    required this.pPluginLoopResolution,
    required this.pPluginRealResolution,
    required this.pProcessDelay,
    required this.pVersion,
  });

  factory NodeHistoryModel.fromJson(Map<String, dynamic> json) {
    return NodeHistoryModel(
      collected: json['COLLECTED'] ?? false,
      currentServer: json['CURRENT_SERVER'] ?? '',
      debugPayloadSaved: json['DEBUG_PAYLOAD_SAVED'] ?? false,
      e2TargetAddr: json['E2_TARGET_ADDR'] ?? '',
      e2TargetId: json['E2_TARGET_ID'] ?? '',
      eeEventType: json['EE_EVENT_TYPE'] ?? '',
      eeFormatter: json['EE_FORMATTER'] ?? '',
      eeHash: json['EE_HASH'] ?? '',
      eeId: json['EE_ID'] ?? '',
      eeIsEncrypted: json['EE_IS_ENCRYPTED'] ?? false,
      eeMessageId: json['EE_MESSAGE_ID'] ?? '',
      eeMessageSeq: json['EE_MESSAGE_SEQ'] ?? 0,
      eePayloadPath: List<String>.from(json['EE_PAYLOAD_PATH'] ?? []),
      eeSender: json['EE_SENDER'] ?? '',
      eeSign: json['EE_SIGN'] ?? '',
      eeTimestamp: json['EE_TIMESTAMP'] ?? '',
      eeTimezone: json['EE_TIMEZONE'] ?? '',
      eeTotalMessages: json['EE_TOTAL_MESSAGES'] ?? 0,
      eeTz: json['EE_TZ'] ?? '',
      eeVersion: json['EE_VERSION'] ?? '',
      id: json['ID'] ?? 0,
      idTags: List<String>.from(json['ID_TAGS'] ?? []),
      imgInPayload: json['IMG_IN_PAYLOAD'] ?? false,
      imgOrig: json['IMG_ORIG'],
      initiatorAddr: json['INITIATOR_ADDR'],
      initiatorId: json['INITIATOR_ID'],
      instanceId: json['INSTANCE_ID'] ?? '',
      isAlert: json['IS_ALERT'] ?? false,
      isAlertNewLower: json['IS_ALERT_NEW_LOWER'] ?? false,
      isAlertNewRaise: json['IS_ALERT_NEW_RAISE'] ?? false,
      isAlertStatusChanged: json['IS_ALERT_STATUS_CHANGED'] ?? false,
      isNewLower: json['IS_NEW_LOWER'] ?? false,
      isNewRaise: json['IS_NEW_RAISE'] ?? false,
      modifiedByAddr: json['MODIFIED_BY_ADDR'] ?? '',
      modifiedById: json['MODIFIED_BY_ID'] ?? '',
      nodeHistory: NodeUsageHistory.fromJson(json['NODE_HISTORY'] ?? {}),
      pipeline: json['PIPELINE'] ?? '',
      request: json['REQUEST'] ?? '',
      sessionId: json['SESSION_ID'],
      signature: json['SIGNATURE'] ?? '',
      status: json['STATUS'] ?? '',
      stream: json['STREAM'] ?? '',
      streamName: json['STREAM_NAME'] ?? '',
      tags: json['TAGS'] ?? '',
      timestampArrival: json['TIMESTAMP_ARRIVAL'] ?? '',
      timestampExecution: json['TIMESTAMP_EXECUTION'] ?? '',
      pAlertHelper: json['_P_ALERT_HELPER'] ?? '',
      pAliveTimeMins: json['_P_ALIVE_TIME_MINS'] ?? 0.0,
      pDatasetBuilderUsed: json['_P_DATASET_BUILDER_USED'] ?? false,
      pDebugSavePayload: json['_P_DEBUG_SAVE_PAYLOAD'] ?? false,
      pDemoMode: json['_P_DEMO_MODE'] ?? false,
      pGraphType: List<dynamic>.from(json['_P_GRAPH_TYPE'] ?? []),
      pPluginLoopResolution: json['_P_PLUGIN_LOOP_RESOLUTION'] ?? 0,
      pPluginRealResolution: json['_P_PLUGIN_REAL_RESOLUTION'] ?? 0.0,
      pProcessDelay: json['_P_PROCESS_DELAY'] ?? 0,
      pVersion: json['_P_VERSION'] ?? '',
    );
  }
}

class NodeUsageHistory {
  List<double> cpuHist;
  List<int> gpuLoadHist;
  List<double> gpuMemAvailHist;
  double gpuMemTotal;
  List<double> memAvailHist;
  double totalDisk;
  double totalMem;

  NodeUsageHistory({
    required this.cpuHist,
    required this.gpuLoadHist,
    required this.gpuMemAvailHist,
    required this.gpuMemTotal,
    required this.memAvailHist,
    required this.totalDisk,
    required this.totalMem,
  });

  factory NodeUsageHistory.fromJson(Map<String, dynamic> json) {
    return NodeUsageHistory(
      cpuHist: json['cpu_hist'],
      gpuLoadHist: json['gpu_load_hist'],
      gpuMemAvailHist: json['gpu_mem_avail_hist'],
      gpuMemTotal: json['gpu_mem_total'],
      memAvailHist: json['mem_avail_hist'],
      totalDisk: json['total_disk'],
      totalMem: json['total_mem'],
    );
  }
}

final dummyNodeHistoryData = {
  "COLLECTED": false,
  "CURRENT_SERVER": "aixp_A_VwF0hrQjqPXGbOVJqSDqvkwmVwWBBVQV3KXscvyXHC",
  "DEBUG_PAYLOAD_SAVED": false,
  "E2_TARGET_ADDR": "aixp_AsDgjzMe9ocJltghYaSzruTf4o8iPmesWWp_lVhq-DFe",
  "E2_TARGET_ID": "gts-ws",
  "EE_EVENT_TYPE": "PAYLOAD",
  "EE_FORMATTER": "cavi2",
  "EE_HASH": "211cedecddd1623390358a95a46d9622c02072e9c996cfa40fd01cd78b1655d8",
  "EE_ID": "stg_super",
  "EE_IS_ENCRYPTED": false,
  "EE_MESSAGE_ID": "ba62b409-083f-4789-ad0d-23331a1de82d",
  "EE_MESSAGE_SEQ": 23,
  "EE_PAYLOAD_PATH": [
    "aid_hpc",
    "admin_pipeline",
    "NET_MON_01",
    "NET_MON_01_INST"
  ],
  "EE_SENDER": "aixp_A_VwF0hrQjqPXGbOVJqSDqvkwmVwWBBVQV3KXscvyXHC",
  "EE_SIGN":
      "MEUCIQCBiu0jalSWnP5cpY3EkCtHl1_JKuZrq7voUKOzr_R1rgIgUxEpME74KvO6aqRj3u0Rf6PKb31N-vVjPRGuHMu1oaw=",
  "EE_TIMESTAMP": "2024-03-01 11:30:38.535013",
  "EE_TIMEZONE": "UTC+2",
  "EE_TOTAL_MESSAGES": 23,
  "EE_TZ": "Europe/Bucharest",
  "EE_VERSION": "3.29.432",
  "ID": 3,
  "ID_TAGS": [],
  "IMG_IN_PAYLOAD": false,
  "IMG_ORIG": null,
  "INITIATOR_ADDR": null,
  "INITIATOR_ID": null,
  "INSTANCE_ID": "NET_MON_01_INST",
  "IS_ALERT": false,
  "IS_ALERT_NEW_LOWER": false,
  "IS_ALERT_NEW_RAISE": false,
  "IS_ALERT_STATUS_CHANGED": false,
  "IS_NEW_LOWER": false,
  "IS_NEW_RAISE": false,
  "MODIFIED_BY_ADDR": "aixp_A6IrUO8pNoZrezX7UhYSjD7mAhpqt-p8wTVNHfuTzg-G",
  "MODIFIED_BY_ID": "SolisClient_SolisClient_bf2d",
  "NODE_HISTORY": {
    "cpu_hist": [
      10.7,
      10.3,
      10.4,
      10.2,
      10.6,
      10.3,
      9.4,
      10.3,
      10.2,
      10.5,
      9.8,
      10.0,
      9.8,
      10.4,
      11.4,
      10.0,
      10.0,
      10.4,
      10.0,
      9.8,
      10.3,
      10.7,
      10.0,
      9.7,
      9.9,
      10.2,
      10.6,
      10.0,
      10.1,
      10.3,
      9.8,
      10.2,
      10.2,
      10.4,
      11.7,
      10.3,
      9.6,
      10.5,
      9.9,
      10.2,
      9.8,
      10.6,
      9.9
    ],
    "gpu_load_hist": [
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0
    ],
    "gpu_mem_avail_hist": [
      7.78,
      7.78,
      7.78,
      7.78,
      7.78,
      7.78,
      7.78,
      7.78,
      7.78,
      7.78,
      7.78,
      7.78,
      7.78,
      7.78,
      7.78,
      7.78,
      7.78,
      7.78,
      7.78,
      7.78,
      7.78,
      7.78,
      7.78,
      7.78,
      7.78,
      7.78,
      7.78,
      7.78,
      7.78,
      7.78,
      7.78,
      7.78,
      7.78,
      7.78,
      7.78,
      7.78,
      7.78,
      7.78,
      7.78,
      7.78,
      7.78,
      7.78,
      7.78
    ],
    "gpu_mem_total": 7.79,
    "mem_avail_hist": [
      0.9192411229329573,
      0.9192731701063965,
      0.9189206511985643,
      0.9193693116267144,
      0.9194654531470324,
      0.9194975003204717,
      0.9195936418407896,
      0.9197538777079861,
      0.9190808870657607,
      0.9196256890142289,
      0.9194334059735931,
      0.9195936418407896,
      0.9191449814126395,
      0.9196577361876682,
      0.9193372644532752,
      0.9196256890142289,
      0.9190808870657607,
      0.9196577361876682,
      0.9192411229329573,
      0.9195936418407896,
      0.9188245096782464,
      0.9196577361876682,
      0.9196577361876682,
      0.9195615946673503,
      0.9188245096782464,
      0.9191129342392,
      0.9191449814126395,
      0.919529547493911,
      0.9190167927188821,
      0.9193693116267144,
      0.9194654531470324,
      0.919850019228304,
      0.9193693116267144,
      0.9194334059735931,
      0.9198820664017434,
      0.9195615946673503,
      0.9187604153313678,
      0.9191449814126395,
      0.9192411229329573,
      0.9196256890142289,
      0.9190808870657607,
      0.9195615946673503,
      0.9193052172798359
    ],
    "total_disk": 456.884,
    "total_mem": 31.204
  },
  "PIPELINE": "admin_pipeline",
  "REQUEST": "history",
  "SESSION_ID": null,
  "SIGNATURE": "NET_MON_01",
  "STATUS": "N/A",
  "STREAM": "admin_pipeline",
  "STREAM_NAME": "admin_pipeline",
  "TAGS": "",
  "TIMESTAMP_ARRIVAL": "2024-03-01 11:30:38.557046",
  "TIMESTAMP_EXECUTION": "2024-03-01 11:30:38.527497",
  "_P_ALERT_HELPER": "A=0, N=0, CT=NA, E=A[0, 0, 0]=0.00 (in 60.0s) vs >=0.50 ",
  "_P_ALIVE_TIME_MINS": 1.23,
  "_P_DATASET_BUILDER_USED": false,
  "_P_DEBUG_SAVE_PAYLOAD": false,
  "_P_DEMO_MODE": false,
  "_P_GRAPH_TYPE": [],
  "_P_PLUGIN_LOOP_RESOLUTION": 50,
  "_P_PLUGIN_REAL_RESOLUTION": 0.0,
  "_P_PROCESS_DELAY": 30,
  "_P_VERSION": "1.0.1"
};
