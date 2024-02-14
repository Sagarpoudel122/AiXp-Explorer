class AssetUtils {
  static String getSvgIconPath(String name) => 'assets/icons/svg/$name.svg';
  static String getPngIconPath(String name) => 'assets/icons/png/$name.png';

  static String getSidebarIconPath(String name) =>
      getSvgIconPath('sidenav/$name');

}
