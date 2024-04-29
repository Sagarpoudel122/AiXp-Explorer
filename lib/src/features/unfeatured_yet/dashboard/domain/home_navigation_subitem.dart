import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class HomeNavigationSubItem extends Equatable {
  const HomeNavigationSubItem({
    required this.label,
    required this.routeNamePrefix,
    required this.onNavigate,
  });

  final WidgetBuilder label;
  final String routeNamePrefix;
  final void Function() onNavigate;

  @override
  List<Object?> get props => <Object?>[routeNamePrefix];
}
