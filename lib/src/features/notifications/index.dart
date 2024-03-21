library notifications;

import 'dart:async';

import 'package:carbon_icons/carbon_icons.dart';
import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:e2_explorer/src/styles/text_styles.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import '../../../http_client/index.dart';
import '../../utils/screen_type.dart';
import '../common_widgets/table/flr_table.dart';

part 'domain/toast.dart';
part 'domain/toast_type.dart';
part 'application/toast_manager.dart';
part 'presentation/widgets/common/toast_card.dart';
part 'presentation/widgets/common/toasts_rail.dart';
part 'presentation/widgets/desktop/toasts_rail_desktop.dart';
part 'presentation/widgets/mobile/toasts_rail_mobile.dart';
