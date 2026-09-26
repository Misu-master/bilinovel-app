import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class AppBottomNavigation extends StatelessWidget {
  const AppBottomNavigation({
    required this.selectedIndex,
    required this.onSelected,
    super.key,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelected;

  static const _items = <_NavigationItemData>[
    _NavigationItemData(label: '首页', icon: Icons.home_outlined),
    _NavigationItemData(label: '分类', icon: Icons.grid_view_outlined),
    _NavigationItemData(label: '书架', icon: Icons.bookmark_border),
    _NavigationItemData(label: '我的', icon: Icons.person_outline),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Material(
        color: AppColors.surface,
        child: Container(
          height: 58,
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: AppColors.divider)),
          ),
          child: Row(
            children: [
              for (var index = 0; index < _items.length; index++)
                Expanded(
                  child: _NavigationItem(
                    data: _items[index],
                    selected: selectedIndex == index,
                    onTap: () => onSelected(index),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavigationItemData {
  const _NavigationItemData({required this.label, required this.icon});

  final String label;
  final IconData icon;
}

class _NavigationItem extends StatelessWidget {
  const _NavigationItem({
    required this.data,
    required this.selected,
    required this.onTap,
  });

  final _NavigationItemData data;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.brand : AppColors.mutedText;

    return Semantics(
      button: true,
      selected: selected,
      label: data.label,
      child: InkWell(
        key: Key('bottom-tab-${data.label}'),
        onTap: onTap,
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(data.icon, size: 23, color: color),
              const SizedBox(height: 2),
              Text(
                data.label,
                style: TextStyle(
                  color: color,
                  fontSize: 11,
                  height: 1.2,
                  fontWeight: selected ? FontWeight.w500 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
