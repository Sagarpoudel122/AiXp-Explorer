part of 'options_menu.dart';

/// Base option menu item class.
class BaseMenuItem {
  const BaseMenuItem();
}

/// Item that displays an interactible option tile.
class MenuOptionItem extends BaseMenuItem {
  const MenuOptionItem({
    required this.onTap,
    required this.child,
    this.leading,
    this.trailing,
    this.color = ColorStyles.light100,
  });

  final AsyncCallback onTap;
  final Widget child;
  final Widget? leading;
  final Widget? trailing;
  final Color color;
}

/// Item that displays an interactible option tile.
/// Similar [MenuOptionItem], but allows better customization of the tile's content.
class MenuOptionBuilderItem extends BaseMenuItem {
  const MenuOptionBuilderItem({
    required this.onTap,
    required this.builder,
    this.child,
  });

  final void Function() onTap;
  final Widget Function(BuildContext context, Widget? child) builder;
  final Widget? child;
}

/// Item that displays a header-style text label.
class MenuHeaderItem extends BaseMenuItem {
  const MenuHeaderItem({
    required this.text,
  });

  final String text;
}

/// Item that displays a border-colored divider.
class MenuDividerItem extends BaseMenuItem {
  const MenuDividerItem();
}

/// Item used for adding vertical whitespace between items.
class MenuWhitespaceItem extends BaseMenuItem {
  const MenuWhitespaceItem({
    required this.height,
  });

  final double height;
}

/// Item that displays a custom widget inside the option menu.
/// Use this if there are no other item types that match the desired behaviour.
class MenuWidgetItem extends BaseMenuItem {
  const MenuWidgetItem({
    required this.child,
  });

  final Widget child;
}
