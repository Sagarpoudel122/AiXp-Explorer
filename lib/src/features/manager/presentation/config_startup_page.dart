import 'package:data_table_2/data_table_2.dart';
import 'package:e2_explorer/src/features/manager/presentation/widgets/config_startup_setting_dialog.dart';
import 'package:e2_explorer/src/features/manager/presentation/widgets/selection_bar.dart';
import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:e2_explorer/src/styles/text_styles.dart';
import 'package:e2_explorer/src/widgets/hf_input_field.dart';
import 'package:flutter/material.dart';

class ConfigStartupPage extends StatelessWidget {
  const ConfigStartupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.dark800,
      body: Column(
        children: [
          const SizedBox(height: 30),
          Text(
            'Config Startup',
            style: TextStyles.h2(),
          ),
          const SizedBox(height: 50),
          Expanded(
            child: DataTable2(
              border: TableBorder.all(
                color: ColorStyles.grey,
              ),
              columns: const [
                DataColumn2(
                  label: Text('Edge Node'),
                  size: ColumnSize.S,
                ),
                DataColumn2(
                  label: Text('Config Startup File'),
                  size: ColumnSize.S,
                ),
              ],
              rows: [
                DataRow(
                  cells: [
                    const DataCell(Text('Goliath')),
                    DataCell(
                      const Text('View/Edit file'),
                      onTap: () {
                        ConfigStartupSettingDialog.show(context, 'gts-staging');
                      },
                    ),
                  ],
                ),
                DataRow(
                  cells: [
                    const DataCell(Text('gts-test1')),
                    DataCell(
                      const Text('View/Edit file'),
                      onTap: () {
                        ConfigStartupSettingDialog.show(context, 'gts-staging');
                      },
                    ),
                  ],
                ),
                DataRow(
                  cells: [
                    const DataCell(Text('gts-staging')),
                    DataCell(
                      const Text('View/Edit file'),
                      onTap: () {
                        ConfigStartupSettingDialog.show(context, 'gts-staging');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
