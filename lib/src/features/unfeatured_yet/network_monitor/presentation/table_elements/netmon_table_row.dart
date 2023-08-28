import 'package:e2_explorer/dart_e2/models/netmon/netmon_box_details.dart';
import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:e2_explorer/src/styles/text_styles.dart';
import 'package:flutter/material.dart';

TableRow createNetmonTableRow(String boxName, NetmonBoxDetails details) {
  return TableRow(
    children: [
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Center(
          child: Text(
            boxName,
            style: TextStyles.small14(),
          ),
        ),
      ),
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Center(
          child: Text(
            '${details.working}',
            style: TextStyles.small14(),
          ),
        ),
      ),
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Center(
          child: Text(
            '${details.trust}',
            style: TextStyles.small14(),
          ),
        ),
      ),
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Center(
          child: Text(
            '${details.score}',
            style: TextStyles.small14(),
          ),
        ),
      ),
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Center(
          child: Text(
            '${details.availDisk}',
            style: TextStyles.small14(),
          ),
        ),
      ),
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Center(
          child: Text(
            '${details.availMem}',
            style: TextStyles.small14(),
          ),
        ),
      ),
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Center(
          child: Text(
            '${details.isSupervisor}',
            style: TextStyles.small14(),
          ),
        ),
      ),
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Center(
          child: Text(
            '${details.cpuPast1h}',
            style: TextStyles.small14(),
          ),
        ),
      ),
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Center(
          child: Text(
            '${details.gpuLoadPast1h}',
            style: TextStyles.small14(),
          ),
        ),
      ),
    ],
  );
}

TableRow createNetmonHeader() {
  return TableRow(
    decoration: BoxDecoration(
      color: ColorStyles.dark600,
    ),
    children: [
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Center(
          child: Text(
            'Box name',
            style: TextStyles.small14(),
          ),
        ),
      ),
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Center(
          child: Text(
            'Working',
            style: TextStyles.small14(),
          ),
        ),
      ),
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Center(
          child: Text(
            'Trust',
            style: TextStyles.small14(),
          ),
        ),
      ),
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Center(
          child: Text(
            'Score',
            style: TextStyles.small14(),
          ),
        ),
      ),
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Center(
          child: Text(
            'Available Disk',
            style: TextStyles.small14(),
          ),
        ),
      ),
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Center(
          child: Text(
            'Available Mem',
            style: TextStyles.small14(),
          ),
        ),
      ),
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Center(
          child: Text(
            'Supervisor',
            style: TextStyles.small14(),
          ),
        ),
      ),
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Center(
          child: Text(
            'Cpu load past 1h',
            style: TextStyles.small14(),
          ),
        ),
      ),
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Center(
          child: Text(
            'Gpu load past 1h',
            style: TextStyles.small14(),
          ),
        ),
      ),
    ],
  );
}
