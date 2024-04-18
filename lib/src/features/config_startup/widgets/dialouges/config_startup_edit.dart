import 'dart:convert';

import 'package:basic_utils/basic_utils.dart';
import 'package:collection/collection.dart';
import 'package:e2_explorer/dart_e2/commands/e2_commands.dart';
import 'package:e2_explorer/dart_e2/formatter/format_decoder.dart';
import 'package:e2_explorer/dart_e2/utils/xpand_utils.dart';
import 'package:e2_explorer/main.dart';
import 'package:e2_explorer/src/features/common_widgets/app_dialog_widget.dart';
import 'package:e2_explorer/src/features/common_widgets/layout/loading_parent_widget.dart';
import 'package:e2_explorer/src/features/config_startup/widgets/dialouges/edit_dialouges.dart';
import 'package:e2_explorer/src/features/config_startup/widgets/form_builder.dart';
import 'package:e2_explorer/src/features/e2_status/application/e2_client.dart';
import 'package:e2_explorer/src/features/e2_status/application/e2_listener.dart';
import 'package:e2_explorer/src/styles/text_styles.dart';
import 'package:e2_explorer/src/utils/app_utils.dart';
import 'package:e2_explorer/src/widgets/custom_drop_down.dart';

import 'package:flutter/material.dart';

const _name = 'admin_pipeline';
const _signature = 'UPDATE_MONITOR_01';
const _instanceId = 'UPDATE_MONITOR_01_INST';

class ConfigStartUpEditDialog {
  static viewConfigLog(BuildContext context, {required String targetId}) {
    E2Client().session.sendCommand(
          ActionCommands.updatePipelineInstance(
            targetId: targetId,
            payload: E2InstanceConfig(
              instanceConfig: {
                "INSTANCE_COMMAND": {"COMMAND": "GET_CONFIG"}
              },
              instanceId: _instanceId,
              name: _name,
              signature: _signature,
            ),
          ),
        );
    _showDialog(context, targetId: targetId);
  }

  static Future<void> _showDialog(
    BuildContext context, {
    required String targetId,
  }) async {
    await showAppDialog(
      context: context,
      content: ConfigStartUpEdit(
        targetId: targetId,
      ),
    );
  }
}

class ConfigStartUpEdit extends StatefulWidget {
  final String targetId;

  const ConfigStartUpEdit({
    super.key,
    required this.targetId,
  });

  @override
  State<ConfigStartUpEdit> createState() => _ConfigStartUpEditState();
}

class _ConfigStartUpEditState extends State<ConfigStartUpEdit> {
  bool isLoading = true;
  Map<String, dynamic> data = {};

  var a = {
    "EE_ID": "gts-test2",
    "SECURED": true,
    "IO_FORMATTER": "cavi2",
    "MAIN_LOOP_RESOLUTION": 12,
    "SECONDS_HEARTBEAT": 15,
    "HEARTBEAT_TIMERS": false,
    "HEARTBEAT_LOG": false,
    "PLUGINS_ON_THREADS": true,
    "CAPTURE_STATS_DISPLAY": 60,
    "SHUTDOWN_NO_STREAMS": false,
    "CAPTURE_ENVIRONMENT": {
      "CAP_RESOLUTION": 10,
      "FORCE_CAP_RESOLUTION": -1,
      "DEFAULT_PLUGIN": true,
      "DISALLOWED_URL_DUPLICATES": ["VideoStream"]
    },
    "SERVING_ENVIRONMENT": {
      "COMM_ENGINE": "queue",
      "COMM_METHOD": "shm",
      "DEFAULT_DEVICE": "cuda:0",
      "SERVER_COLLECTOR_TIMEDELTA": 600,
      "#AUTO_WARMUPS": {"general_detector": {}},
      "SERVING_IN_PROCESS": false,
      "SERVING_TIMERS_IDLE_DUMP": 90,
      "SERVING_TIMERS_PREDICT_DUMP": 120,
      "CHECK_BLOCKED_INPROCESS_SERVING": true,
      "MODEL_ZOO_CONFIG": {
        "endpoint": "\$EE_MINIO_ENDPOINT",
        "access_key": "\$EE_MINIO_ACCESS_KEY",
        "secret_key": "\$EE_MINIO_SECRET_KEY",
        "secure": "\$EE_MINIO_SECURE",
        "bucket_name": "model-zoo"
      }
    },
    "PLUGINS_ENVIRONMENT": {
      "DEMO_MODE": false,
      "DEBUG_OBJECTS": false,
      "SEND_MANIFEST_EACH": 30,
      "DEBUG_SAVE_PAYLOADS": false
    },
    "COMMUNICATION_ENVIRONMENT": {
      "QOS": 2,
      "CONN_MAX_RETRY_ITERS": 5,
      "LOG_SEND_COMMANDS": false,
      "DEBUG_LOG_PAYLOADS": true
    },
    "HEAVY_OPS_CONFIG": {
      "ACTIVE_COMM_ASYNC": ["send_mail", "save_image_dataset"],
      "ACTIVE_ON_COMM_THREAD": []
    },
    "CONFIG_RETRIEVE": [
      {
        "TYPE": "remote",
        "APP_CONFIG_ENDPOINT":
            "https://www.dropbox.com/s/27pzvt0ni0f9ja5/config_app_gts_staging.txt?dl=1"
      }
    ]
  };
  var configStartup =
      "eNp1VV1v4kYUfW5+BXL7SAJJlVYbaVVN7BuYxp5x7TEpraIrL0xYuoBZPCTbjfjve2dssAm7vETyOffznDt5Pet0PADkgXfT8WamPDe6NFde135Pwc8SsIjZbLX7xCXeySRiSkHidShkkj/Pa3rEuMBQyhgTSGWYKS6F5VxeWbhOKEWQ4hBYom6BKQdfdyv08BUVjyBJLfiUL8qqcoOGcnAMxWE24CJFKVANE2CBCz307LNY0RyYKqZSDHgah2xsGb/1qzGHmQrkg0AhiUPx0XHpdg4QI55IEYFwvb8SVqHtmWkml5kQWpYP+AanwPPLmhDAHctChdUM7b4tyFMWhvIBAsySEIMsDrnPFLj+/vVG86kuUrPR+dJ7pIhd96zacjLiYvCjXmUUEUTFwEr+eau32uu2sAjUUDo7lB+X3ps2AxhxHyrlt9P8pr8n2KKQoC/DEHwlE6dhAKFi1ab3C/mZZUriA0uiLHZjvHozvdKbfIFTbfTEFBv3dbdrJbbTkLfiRPqQHovTYlSuISuHQKuKYq9T/2467/qVx07ZMRmc+6oVYA2779Yfgn+Pt6H070kDLuoOsE5yLFcVEkmaGv+RknYh7vigWT2BejVdF/OVsdv9hc4u4oIuCkQQS04qdfe8fDLRZYmf9P/HTOa78vcwbrilnmy0OeXSsSWgTrjbjT7hkbMbzoft5BPlW+VL7XReFlO9OP9aFJ5j7OpRa7Ptb+/IbI3bAogk2pW8FS2A22yA8vZPcst3FBUBRkzwO0gVAvOHlvFr/yg2ZSPAmI1DWR+8y9B0Zs2cCXsvdHM/OIa/pIu8OvhfCKr7Nx2rSsbIVf0KXdc4vTzoerO5mQjS709laYfGKoccL43estEYZZyeeMRjvuI0l7tElo6F70690W81xWU+X7QkzZ81zpf5TOM0N3mpTaXTY9uUdVbag0tcvZJN5sf21mxDbgEcRvaJqIvX9fZWJqoaxyTrT/bnzsbb6GVh9KE1WzeO6xEbk+9v0vtozLq86fVeXl4uppti/aH4cjEplr2yd/X7+uuz6a/m/ad3/+XXvUmxeprPMF+vkf5FYWny2Xw1uzBfzB/TxftLry64q/+e2Yl2Z98A5vy71Q==";

  var configStartup2 =
      "H4sIAAAAAAAAE2VUYVPaQBD9L9d+REE6ttPMdDpnssLV5C7NXbDUcXZiOJEKhJJDrQ7/vXtBRPFjdt/evn37Nk8MAEXEAjZ29YGzteuyFtMQ5hlQ1C1XtsWEwlOVJdwYyAhZFncTj0q4kBgrlWIGWsW5EUqy4Kjb1CsZaewDz8wJcEPh4xZ7+UQjEsg0C66LaW1fJ2LVe4mmcd4TUqOSaPoZ8EhvCYU8NUQQteFGYyR0GvMhCz53qHU/N5E6lygVpakq2bXZloEciEzJBCQRe/LhtxPQMzRvCLifOThqsQhOeR4b3LDbMiIOPI7VOUSYZzFGeRqLkBug5hdsMBnZSrulLWbscu3lyQZC9t7xUElCMXoVSOW/K7uypHITTcD0ld9SfTNjOw4RDEToweVqVAQdtnkaMgxVHENoVNYoHUFsuJeHBvvAc6PwnGdJnmrfdWzndllMcWSdLV21pNj6FUdacZqpEPROxm1qs0RyTww0cJKy4GvnXTYlH4nQPAOOuoQI+xCe4UmswjOSS8jn9/G5citpoog3/laKppGnoufJ2vloUU3mjkb+SMZNhCRvgoxSJUjDFivK0tY13tp/bxA8bBqcwZAwtS2X1r3DkGczMDvMamn38+Qdyl2tyluqnxczD5hVIzs9eKwq5lXbWnZvsxEkCv08LxpGcJL3UJ38oC29VlZGmHApTkEbBB72WfCps0VrPgBM+TBWzSk0NeuNQXLp3UYe3e/8UxGy60FS0su/yM4mG6IwzfnRTdLBYdPWP8NlpPco+vyup9/MurnXwRBVql+thodGEL/GrlwPZeidX9PCcFZMpl7T4s7iZFaMLY4KV9TWscvWtoyYN5WbQ6fSy2Yy/3hDWcCAxLt4YmaYesMv7axy/jx4mj6T2PkgYDfOLeqg3b6/vz8cLavFVfVwWFazdt3uflk83rnOfNK5/vqnOG6X1fx6MsZisUD6A2LtivFkPj50D+77aPrtiK0v1/8BLj+QjSQFAAA=";

  void save() {
    try {
      final base64Encoded = XpandUtils.encodeEncryptedGzipMessage(a);
      print(XpandUtils.decodeEncryptedGzipMessage(configStartup));
      print("\n\n\n");
      print(XpandUtils.decodeEncryptedGzipMessage(configStartup2));
      E2Client().session.sendCommand(
            ActionCommands.updatePipelineInstance(
              targetId: widget.targetId,
              payload: E2InstanceConfig(
                instanceConfig: {
                  "COMMAND": "SAVE_CONFIG",
                  "DATA": base64Encoded
                },
                instanceId: _instanceId,
                name: _name,
                signature: _signature,
              ),
              initiatorId: kAIXpWallet?.initiatorId,
            ),
          );
      debugPrint(' saved data: $base64Encoded');

      Navigator.of(context).pop();
    } catch (e) {
      // Handle errors, such as invalid JSON or encoding failures
      debugPrint('Error saving data: $e');
      // Optionally, you could show an error message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return E2Listener(
      onPayload: (data) {
        final Map<String, dynamic> convertedMessage =
            MqttMessageEncoderDecoder.raw(data);
        final EE_PAYLOAD_PATH = (convertedMessage['EE_PAYLOAD_PATH'] as List)
            .map((e) => e as String?)
            .toList();
        if (EE_PAYLOAD_PATH.length == 4) {
          if (EE_PAYLOAD_PATH[0] == widget.targetId &&
              EE_PAYLOAD_PATH[1] == _name &&
              EE_PAYLOAD_PATH[2] == _signature &&
              EE_PAYLOAD_PATH[3] == _instanceId) {
            convertedMessage.removeWhere((key, value) => value == null);
            this.data = XpandUtils.decodeEncryptedGzipMessage(
              convertedMessage['CONFIG_STARTUP'],
            );
            isLoading = false;
            setState(() {});
          }
        }
        if (this.data.containsKey('CONFIG_STARTUP') &&
            this.data['CONFIG_STARTUP'] is String) {
          final decodedConfig = XpandUtils.decodeEncryptedGzipMessage(
              this.data['CONFIG_STARTUP']);

          this.data.remove('CONFIG_STARTUP');
          this.data['CONFIG_STARTUP'] = decodedConfig;
          setState(() {});
        }
      },
      builder: (context) {
        return AppDialogWidget(
          appDialogType: AppDialogType.medium,
          positiveActionButtonText: "Save",
          negativeActionButtonText: "Close",
          positiveActionButtonAction: () {
            save();
          },
          title: "Config Startup file for ${widget.targetId}",
          content: SizedBox(
            height: size.height * 0.8,
            width: size.width * 0.8,
            child: LoadingParentWidget(
              isLoading: isLoading,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    JsonFormBuilder(
                      data: data,
                      onChanged: (newData) {
                        data = newData;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
