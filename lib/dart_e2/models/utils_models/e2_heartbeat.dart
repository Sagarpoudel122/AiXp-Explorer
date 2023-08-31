import 'package:e2_explorer/dart_e2/models/e2_message_new.dart';
import 'package:e2_explorer/dart_e2/models/utils_models/e2_active_plugin.dart';
import 'package:e2_explorer/dart_e2/models/utils_models/e2_comm_stats.dart';
import 'package:e2_explorer/dart_e2/models/utils_models/e2_config_pipelines.dart';
import 'package:e2_explorer/dart_e2/models/utils_models/e2_dct_stats.dart';
import 'package:e2_explorer/dart_e2/models/utils_models/e2_gpu.dart';
import 'package:e2_explorer/dart_e2/models/utils_models/e2_loop_timing.dart';

class E2Heartbeat extends E2Message {
  E2Heartbeat({
    required super.payloadPath,
    required super.formatter,
    required super.sign,
    required super.sender,
    required super.hash,
    required this.timestamp,
    required this.timezone,
    required this.totalMessages,
    required this.messageId,
    required this.gpus,
    required this.gpuInfo,
    required this.defaultCuda,
    required this.version,
    required this.loggerVersion,
    required this.activePlugins,
    required this.noInferences,
    required this.noPayloads,
    required this.noStreamsData,
    required this.gitBranch,
    required this.condaEnv,
    required this.configPipelines,
    required this.dctStats,
    required this.commStats,
    required this.servingPids,
    required this.loopsTimings,
    required this.timers,
    required this.deviceLog,
    required this.errorLog,
    this.deviceStatus,
    this.machineIp,
    this.machineMemory,
    this.availableMemory,
    this.processMemory,
    this.cpuUsed,
    this.cpu,
    this.uptime,
    this.totalDisk,
    this.availableDisk,
  });

  final String timestamp;
  final String timezone;
  final int totalMessages;
  final int messageId;
  final String? deviceStatus;
  final String? machineIp;
  final double? machineMemory;
  final double? availableMemory;
  final double? processMemory;
  final double? cpuUsed;
  final List<E2Gpu> gpus;
  final String gpuInfo;
  final String defaultCuda;
  final String? cpu;
  final double? uptime;
  final String version;
  final String loggerVersion;
  final double? totalDisk;
  final double? availableDisk;
  final List<E2ActivePlugin> activePlugins;
  final int noInferences;
  final int noPayloads;
  final int noStreamsData;
  final String gitBranch;
  final String condaEnv;
  final E2ConfigPipelines configPipelines;
  final E2DctStats dctStats;
  final E2CommStats commStats;
  final List<int> servingPids;
  final E2LoopTiming loopsTimings;
  final String timers;
  final String deviceLog;
  final String errorLog;

  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp,
      'totalMessages': totalMessages,
      'messageId': messageId,
      'deviceStatus': deviceStatus,
      'machineIp': machineIp,
      'machineMemory': machineMemory,
      'availableMemory': availableMemory,
      'processMemory': processMemory,
      'cpuUsed': cpuUsed,
      'gpus': gpus,
      'gpuInfo': gpuInfo,
      'defaultCuda': defaultCuda,
      'cpu': cpu,
      'uptime': uptime,
      'version': version,
      'loggerVersion': loggerVersion,
      'totalDisk': totalDisk,
      'availableDisk': availableDisk,
      'activePlugins': activePlugins,
      'noInferences': noInferences,
      'noPayloads': noPayloads,
      'noStreamsData': noStreamsData,
      'gitBranch': gitBranch,
      'condaEnv': condaEnv,
      'configPipelines': configPipelines,
      'dctStats': dctStats,
      'commStats': commStats,
      'servingPids': servingPids,
      'loopsTimings': loopsTimings,
      'timers': timers,
      'deviceLog': deviceLog,
      'errorLog': errorLog,
    };
  }

  factory E2Heartbeat.fromMap(Map<String, dynamic> map) {
    return E2Heartbeat(
      payloadPath: (map['EE_PAYLOAD_PATH'] as List).map((e) => e as String).toList(),
      formatter: map['EE_FORMATTER'] as String,
      sign: map['EE_SIGN'] as String,
      sender: map['EE_SENDER'] as String,
      hash: map['EE_HASH'] as String,
      timestamp: map['EE_TIMESTAMP'] as String,
      timezone: map['EE_TIMEZONE'] as String,
      totalMessages: map['EE_TOTAL_MESSAGES'] as int,
      messageId: map['EE_MESSAGE_ID'] as int,
      deviceStatus: map['DEVICE_STATUS'] as String,
      machineIp: map['MACHINE_IP'] as String?,
      machineMemory: map['MACHINE_MEMORY'] as double?,
      availableMemory: map['AVAILABLE_MEMORY'] as double?,
      processMemory: map['PROCESS_MEMORY'] as double,
      cpuUsed: map['CPU_USED'] as double,
      gpus: E2Gpu.fromList(map['GPUS'] as List),
      gpuInfo: map['GPU_INFO'] as String,
      defaultCuda: map['DEFAULT_CUDA'] as String,
      cpu: map['CPU'] as String,
      uptime: map['UPTIME'] as double,
      version: map['VERSION'] as String,
      loggerVersion: map['LOGGER_VERSION'] as String,
      totalDisk: map['TOTAL_DISK'] as double,
      availableDisk: map['AVAILABLE_DISK'] as double,
      activePlugins: E2ActivePlugin.fromList(map['ACTIVE_PLUGINS'] as List),
      noInferences: map['NR_INFERENCES'] as int,
      noPayloads: map['NR_PAYLOADS'] as int,
      noStreamsData: map['NR_STREAMS_DATA'] as int,
      gitBranch: map['GIT_BRANCH'] as String,
      condaEnv: map['CONDA_ENV'] as String,
      configPipelines: E2ConfigPipelines.fromList(map['CONFIG_STREAMS'] as List),
      dctStats: E2DctStats.fromMap(map['DCT_STATS']),
      commStats: E2CommStats.fromMap(map['COMM_STATS']),
      servingPids: map['SERVING_PIDS'] as List<int>,
      loopsTimings: E2LoopTiming.fromMap(map['LOOPS_TIMINGS']),
      timers: map['TIMERS'] as String,
      deviceLog: map['DEVICE_LOG'] as String,
      errorLog: map['ERROR_LOG'] as String,
    );
  }
}
