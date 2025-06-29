enum BottomNavigationTab {
  home(0),
  projects(1),
  requestPrices(2),
  ourProjects(3),
  contactUs(4);

  final int tabIndex;
  const BottomNavigationTab(this.tabIndex);

  static BottomNavigationTab fromIndex(int index) {
    return BottomNavigationTab.values.firstWhere(
      (tab) => tab.tabIndex == index,
      orElse: () => BottomNavigationTab.home,
    );
  }
}
