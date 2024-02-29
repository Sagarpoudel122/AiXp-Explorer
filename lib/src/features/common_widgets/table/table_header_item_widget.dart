import 'dart:math';

import 'package:e2_explorer/src/styles/color_styles.dart';
import 'package:flutter/material.dart';

class TableHeaderItemWidget extends StatelessWidget {
  const TableHeaderItemWidget({
    super.key,
    required this.title,
    this.showCheckbox = false,
    this.checkBoxValue = false,
    this.onCheckedChanged,
    this.showSort = false,
    this.isSorted = false,
    this.isSortSeparated = false,
    this.sortIsAscending = true,
    this.onSortClick,
  });

  final String title;
  final bool showCheckbox;
  final bool checkBoxValue;
  final void Function({bool? value})? onCheckedChanged;
  final bool showSort;
  final VoidCallback? onSortClick;
  final bool sortIsAscending;
  final bool isSortSeparated;
  final bool isSorted;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: showSort ? onSortClick : null,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 12,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Visibility(
                    visible: showCheckbox,
                    child: Checkbox(
                      value: checkBoxValue,
                      checkColor: Colors.white,
                      onChanged: (bool? checked) =>
                          onCheckedChanged!(value: checked),
                    ),
                  ),
                  SizedBox(width: showCheckbox ? 12 : 0),
                  Flexible(
                    child: Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.tableHeaderTextColor,
                      ),
                      // style: HFTextStyles.bodyStrong(
                      //   color: TableColors.tableHeaderTextColor,
                      //   // : HFColors.light900,
                      // ),
                    ),
                  ),
                ],
              ),
            ),
            if (showSort) ...<Widget>[
              if (isSortSeparated) const Spacer(),
              const SizedBox(width: 8),
              Image.asset(
                'assets/icons/png/th_sort_arrow_down.png',
                height: 16,
                color: showSort && isSorted && sortIsAscending
                    ? AppColors.tableHeaderSortIconActiveColor
                    : AppColors.tableHeaderSortIconInactiveColor,
              ),
              Transform.rotate(
                angle: pi,
                child: Image.asset(
                  'assets/icons/png/th_sort_arrow_down.png',
                  height: 16,
                  color: showSort && isSorted && !sortIsAscending
                      ? AppColors.tableHeaderSortIconActiveColor
                      : AppColors.tableHeaderSortIconInactiveColor,
                ),
              ),
              // Stack(
              //   children: <Widget>[
              //     Icon(
              //       CarbonIcons.caret_sort,
              //       color: HFColors.grey,
              //       size: 16,
              //     ),
              //     if (showSort && isSorted && sortIsAscending)
              //       Icon(
              //         CarbonIcons.caret_sort_up,
              //         color: HFColors.light100,
              //         size: 16,
              //       ),
              //     if (showSort && isSorted && !sortIsAscending)
              //       Icon(
              //         CarbonIcons.caret_sort_down,
              //         color: HFColors.light100,
              //         size: 16,
              //       ),
              //   ],
              // ),
            ],
          ],
        ),
      ),
    );
  }
}