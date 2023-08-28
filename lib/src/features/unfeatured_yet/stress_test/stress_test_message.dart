import 'dart:convert';

import 'package:e2_explorer/dart_e2/formatter/models/cavi2_message.dart';

final stressHb = Cavi2Message.fromMap(jsonDecode(stressRaw));

String getMessage(int senderNumber) {
  final stressTestMessage = jsonDecode(stressRaw) as Map<String, dynamic>;
  stressTestMessage['sender']['hostId'] = 'stress_test_$senderNumber';
  return jsonEncode(stressTestMessage);
}

const String stressRaw = r'''{
    "messageID": "stress-id",
    "type": "heartbeat",
    "category": "",
    "version": "3.24.190",
    "data": {
        "identifiers": {},
        "value": {},
        "specificValue": {},
        "time": null,
        "img": {
            "id": null,
            "height": null,
            "width": null
        }
    },
    "metadata": {
        "sbTotalMessages": 6835,
        "sbCurrentMessage": 6835,
        "ee_timezone": "UTC+3",
        "ee_tz": "'No time zone found with key usr/share/zoneinfo/Europe/Bucharest'",
        "sb_id": "gts-stress-test",
        "sb_event_type": "HEARTBEAT",
        "current_time": "2023-07-06 13:04:13.842560",
        "is_alert_ram": false,
        "nr_inferences": 0,
        "nr_payloads": 2,
        "nr_streams_data": 0,
        "py_ver": "3.10.0",
        "ee_hb_time": 15,
        "device_status": "ONLINE",
        "machine_ip": "10.10.10.249",
        "machine_memory": 31.276,
        "available_memory": 26.362,
        "process_memory": 0.41,
        "cpu_used": 12.9,
        "gpus": [
            {
                "NAME": "NVIDIA GeForce RTX 2060 SUPER",
                "TOTAL_MEM": 7.79,
                "PROCESSES": [
                    {
                        "PID": 2176662,
                        "GPUINSTANCEID": 4294967295,
                        "COMPUTEINSTANCEID": 4294967295,
                        "ALLOCATED_MEM": 1.08
                    }
                ],
                "USED_BY_PROCESS": false,
                "ALLOCATED_MEM": 1.28,
                "FREE_MEM": 6.72,
                "MEM_UNIT": "GB",
                "GPU_USED": 0,
                "GPU_TEMP": 40,
                "GPU_TEMP_MAX": 96
            }
        ],
        "gpu_info": "\n\n======================================== Basic load Info ========================================\n  Used CPU: ' Intel(R) Core(TM) i7-9700F CPU @ 3.00GHz'\n    Avg. CPU load:       8.8% ( 8.7  8.3  8.6  8.9  8.2  9.0  8.5  8.9  8.4 12.9 %load)\n    Proc mem over time: [0.4096, 0.4096, 0.4096, 0.4096, 0.4096, 0.4096, 0.4096, 0.4096, 0.4096, 0.4096] (GB))\n  Used GPU: [0] 'NVIDIA GeForce RTX 2060 SUPER'\n    Avg. GPU core used:  0.0% ( 0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0 %load)\n    Avg. GPU mem load:  16.4% ( 1.3  1.3  1.3  1.3  1.3  1.3  1.3  1.3  1.3  1.3 GB)",
        "default_cuda": "cuda:0",
        "cpu": " Intel(R) Core(TM) i7-9700F CPU @ 3.00GHz",
        "timestamp": "20230706130413842512",
        "uptime": 102773.75825991202,
        "version": "3.24.190 L:9.8.14 L-5.15.0-75-generic-x86_64-with-glibc2.31",
        "logger_version": "9.8.14",
        "total_disk": 937.33,
        "available_disk": 831.385,
        "active_plugins": [],
        "stop_log": [],
        "git_branch": "main",
        "conda_env": "exe_eng_env",
        "config_streams": [
            {
                "CAP_RESOLUTION": 27,
                "DEFAULT_PLUGIN": true,
                "INITIATOR_ID": "edm-service-qa",
                "LIVE_FEED": true,
                "NAME": "6086d20e-9199",
                "PLUGINS": [
                    {
                        "INSTANCES": [
                            {
                                "INSTANCE_ID": "VS",
                                "PROCESS_DELAY": 30
                            }
                        ],
                        "SIGNATURE": "VIEW_SCENE_01"
                    },
                    {
                        "INSTANCES": [
                            {
                                "INSTANCE_ID": "RECE01_DFLT"
                            }
                        ],
                        "SIGNATURE": "REST_CUSTOM_EXEC_01"
                    }
                ],
                "RECONNECTABLE": "YES",
                "SESSION_ID": "6086d20e-9199",
                "TYPE": "VideoStream",
                "URL": "rtsp://admin:Parola12345@10.10.31.20:554/Streaming/Channels/0101"
            },
            {
                "CAP_RESOLUTION": 27,
                "DEFAULT_PLUGIN": true,
                "INITIATOR_ID": "edm-service-qa",
                "LIVE_FEED": true,
                "NAME": "63916a33-0590",
                "PLUGINS": [
                    {
                        "INSTANCES": [
                            {
                                "INSTANCE_ID": "VS",
                                "PROCESS_DELAY": 30
                            }
                        ],
                        "SIGNATURE": "VIEW_SCENE_01"
                    },
                    {
                        "INSTANCES": [
                            {
                                "INSTANCE_ID": "RECE01_DFLT"
                            }
                        ],
                        "SIGNATURE": "REST_CUSTOM_EXEC_01"
                    }
                ],
                "RECONNECTABLE": "YES",
                "SESSION_ID": "63916a33-0590",
                "TYPE": "VideoStream",
                "URL": "rtsp://admin:Parola12345@10.10.31.20:554/Streaming/Channels/0102"
            },
            {
                "COLLECTED_STREAMS": [
                    "6086d20e-9199"
                ],
                "INITIATOR_ID": "edm-service-qa",
                "NAME": "d725857a-71c2",
                "PLUGINS": [
                    {
                        "INSTANCES": [
                            {
                                "FORCED_PAUSE": false,
                                "ID_TAGS": {
                                    "cameraName": "Solo",
                                    "cameraUuid": "b3366c9a-a2aa-447c-939e-cc8c009652cb",
                                    "location": "6e7fffaa-2080-44de-bba7-db8cbcfff3fd"
                                },
                                "INSTANCE_ID": "9383dd06",
                                "POINTS": [
                                    [
                                        929,
                                        352
                                    ],
                                    [
                                        1572,
                                        352
                                    ],
                                    [
                                        1572,
                                        1017
                                    ],
                                    [
                                        929,
                                        1017
                                    ],
                                    [
                                        929,
                                        352
                                    ]
                                ],
                                "WORKING_HOURS": []
                            }
                        ],
                        "SIGNATURE": "LUGGAGE_01"
                    },
                    {
                        "INSTANCES": [
                            {
                                "INSTANCE_ID": "RECE01_DFLT"
                            }
                        ],
                        "SIGNATURE": "REST_CUSTOM_EXEC_01"
                    }
                ],
                "SESSION_ID": "default-session-id",
                "STREAM_CONFIG_METADATA": {},
                "TYPE": "MetaStream"
            },
            {
                "NAME": "admin_pipeline",
                "PLUGINS": [
                    {
                        "INSTANCES": [
                            {
                                "INSTANCE_ID": "admin_inst_01",
                                "MINIO_ACCESS_KEY": null,
                                "MINIO_HOST": null,
                                "MINIO_SECRET_KEY": null,
                                "MINIO_SECURE": null
                            }
                        ],
                        "SIGNATURE": "MINIO_MONIT_01"
                    },
                    {
                        "INSTANCES": [
                            {
                                "INSTANCE_ID": "admin_inst_02",
                                "PROCESS_DELAY": 10
                            }
                        ],
                        "SIGNATURE": "NET_MON_01"
                    },
                    {
                        "INSTANCES": [
                            {
                                "ALLOW_EMPTY_INPUTS": true,
                                "INSTANCE_ID": "admin_inst_03",
                                "RUN_WITHOUT_IMAGE": true,
                                "SEND_MANIFEST_EACH": 55
                            }
                        ],
                        "SIGNATURE": "REST_CUSTOM_EXEC_01"
                    },
                    {
                        "INSTANCES": [
                            {
                                "INSTANCE_ID": "admin_inst_04",
                                "PROCESS_DELAY": 60,
                                "VERSION_TOKEN": "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",
                                "VERSION_URL": "https://raw.githubusercontent.com/Lummetry/AiXp-EE/{}/core/main/ver.py"
                            }
                        ],
                        "SIGNATURE": "UPDATE_MONITOR_01"
                    }
                ],
                "TYPE": "VOID"
            }
        ],
        "dct_stats": {
            "6086d20e-9199": {
                "TYPE": "VideoStream",
                "FLOW": "live",
                "IDLE": 102753.0,
                "IDLE_ALERT": true,
                "DPS": 0.031,
                "CFG_DPS": 27,
                "TGT_DPS": 27,
                "RUNSTATS": "loop 32.597 [30.184, 27.158], proc 32.597 [30.183, 27.158], sleep 0.001 [0.0, 0.0]",
                "COLLECTING": null,
                "FAILS": 9524,
                "NOW": "2023-07-06 13:04:13"
            },
            "63916a33-0590": {
                "TYPE": "VideoStream",
                "FLOW": "live",
                "IDLE": 102753.0,
                "IDLE_ALERT": true,
                "DPS": 0.031,
                "CFG_DPS": 27,
                "TGT_DPS": 27,
                "RUNSTATS": "loop 32.194 [23.146, 33.18], proc 32.194 [23.145, 33.179], sleep 0.000 [0.001, 0.0]",
                "COLLECTING": null,
                "FAILS": 9488,
                "NOW": "2023-07-06 13:04:13"
            },
            "d725857a-71c2": {
                "TYPE": "MetaStream",
                "FLOW": "meta",
                "IDLE": 102753.0,
                "DPS": -1,
                "CFG_DPS": -1,
                "TGT_DPS": -1,
                "RUNSTATS": -1,
                "COLLECTING": [
                    "6086d20e-9199"
                ],
                "FAILS": -1,
                "NOW": "2023-07-06 13:04:13"
            }
        },
        "comm_stats": {
            "COMMANDCONTROL": {
                "SVR": true,
                "RCV": true,
                "SND": true,
                "ACT": 1688637839.726047,
                "ADDR": "mosquitto.gts-qa.intranet:31883",
                "FAILS": 0,
                "ERROR": null,
                "ERRTM": null,
                "IN_KB": 0.77,
                "OUT_KB": 0
            },
            "DEFAULT": {
                "SVR": true,
                "RCV": true,
                "SND": true,
                "ACT": 1688637852.6859279,
                "ADDR": "mosquitto.gts-qa.intranet:31883",
                "FAILS": 0,
                "ERROR": null,
                "ERRTM": null,
                "IN_KB": 0,
                "OUT_KB": 0.2
            },
            "HEARTBEATS": {
                "SVR": true,
                "RCV": false,
                "SND": true,
                "ACT": 1688637839.7188082,
                "ADDR": "mosquitto.gts-qa.intranet:31883",
                "FAILS": 0,
                "ERROR": null,
                "ERRTM": null,
                "IN_KB": 0,
                "OUT_KB": 0.77
            },
            "NOTIFICATIONS": {
                "SVR": true,
                "RCV": false,
                "SND": true,
                "ACT": 1688637853.7622788,
                "ADDR": "mosquitto.gts-qa.intranet:31883",
                "FAILS": 0,
                "ERROR": null,
                "ERRTM": null,
                "IN_KB": 0,
                "OUT_KB": 0.12
            }
        },
        "in_kb": 0.77,
        "out_kb": 1.0899999999999999,
        "serving_pids": [
            2176662
        ],
        "loops_timings": {
            "main_loop_avg_time": 0.43611985648749396,
            "comm_loop_avg_time": 0.000012993812561035156
        },
        "timers": "Timers not available in summary",
        "device_log": "Device log available only upon request or in special situations",
        "error_log": "Error log available only upon request or in special situations",
        "heartbeat_version": "v1",
        "initiator_id": null
    },
    "time": {
        "deviceTime": "",
        "hostTime": "2023-07-06 13:04:14.762212",
        "internetTime": ""
    },
    "sender": {
        "id": "AiXp-ExecutionEngine",
        "instanceId": "AiXp-EE-v3.24.190",
        "hostId": "gts-stress-test"
    },
    "demoMode": false,
    "EE_FORMATTER": "cavi2",
    "SB_IMPLEMENTATION": "cavi2",
    "EE_PAYLOAD_PATH": [
        "gts-stress-test",
        null,
        null,
        null
    ]
}''';
