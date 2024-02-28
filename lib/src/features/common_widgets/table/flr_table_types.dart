import 'package:flutter/cupertino.dart';

typedef FLRTableRowBuilder<ItemType, ColumnType> = List<Widget> Function(
    ItemType item,
    List<ColumnType> columns,
    );

class FLRHeaderInfo<ColumnType> {
  // is this column currently used for sorting
  FLRHeaderInfo({
    required this.columnType,
    required this.title,
    required this.canSortBy,
    required this.isSortedBy,
  });

  ColumnType columnType;
  String title; // header title
  bool canSortBy; // can sort by this column
  bool isSortedBy;
}

typedef FLRTableHeaderBuilder<ColumnType> = Widget Function(
    FLRHeaderInfo<ColumnType> header,
    );

typedef FLRTableHeaderTitle<ColumnType> = String Function(
    ColumnType columnType,
    );

typedef FLRTableColumnWidth<ColumnType> = double Function(
    ColumnType columnType,
    );

typedef FLRTableRowHeightCallback<ItemType> = double Function(ItemType item);

typedef FLRColumnsListCallback<ColumnType> = List<ColumnType> Function();
