import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({required this.onOpenCategory, super.key});

  final VoidCallback onOpenCategory;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const _rankingTabs = ['推荐', '点击', '新书', '收藏', '完本'];
  int _selectedRanking = 0;

  static const _libraries = <_LibraryData>[
    _LibraryData(shortName: '电击', name: '电击文库', color: Color(0xFFD83236)),
    _LibraryData(shortName: '富士', name: '富士见', color: Color(0xFFBD4F10)),
    _LibraryData(shortName: '角川', name: '角川文库', color: Color(0xFFB32621)),
    _LibraryData(shortName: 'MF', name: 'MF文库J', color: Color(0xFFC83F2B)),
    _LibraryData(shortName: 'Fami', name: 'Fami通', color: Color(0xFF946400)),
    _LibraryData(shortName: 'GA', name: 'GA文库', color: Color(0xFFA13A5D)),
  ];

  static const _books = <_BookData>[
    _BookData(
      rank: '1',
      title: 'Re:从零开始的异世界生活',
      author: '长月达平 · MF文库J',
      metric: '553.5万',
      cover: 'UI-design/app-ui-design/assets/c01.jpg',
    ),
    _BookData(
      rank: '2',
      title: '败北女角太多了！',
      author: '雨森焚火 · 小学馆',
      metric: '304.0万',
      cover: 'UI-design/app-ui-design/assets/c03.jpg',
    ),
    _BookData(
      rank: '3',
      title: '无职转生 ～到了异世界就拿出真本事～',
      author: '理不尽な孫の手 · 角川文库',
      metric: '409.4万',
      cover: 'UI-design/app-ui-design/assets/c08.jpg',
    ),
    _BookData(
      rank: '4',
      title: '欢迎来到实力至上主义的教室',
      author: '衣笠彰梧 · MF文库J',
      metric: '858万',
      cover: 'UI-design/app-ui-design/assets/c07.jpg',
    ),
  ];

  void _showUnavailable(String feature) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('$feature将在后续阶段开放'),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _HomeHeader(onSearchTap: () => _showUnavailable('搜索功能')),
          Expanded(
            child: SingleChildScrollView(
              key: const PageStorageKey<String>('home-scroll'),
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _HeroBanner(),
                  _SectionHeader(
                    title: '热门文库',
                    actionLabel: '全部',
                    onAction: widget.onOpenCategory,
                  ),
                  _LibraryStrip(
                    libraries: _libraries,
                    onTap: widget.onOpenCategory,
                  ),
                  const _SectionHeader(title: '榜单'),
                  _RankingTabs(
                    labels: _rankingTabs,
                    selectedIndex: _selectedRanking,
                    onSelected: (index) =>
                        setState(() => _selectedRanking = index),
                  ),
                  for (final book in _books) _RankingRow(book: book),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader({required this.onSearchTap});

  final VoidCallback onSearchTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.brand,
              borderRadius: BorderRadius.circular(9),
            ),
            child: const Text(
              '哔',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 17,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: onSearchTap,
                child: SizedBox(
                  height: 48,
                  child: Center(
                    child: Container(
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.field,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Row(
                        children: [
                          SizedBox(width: 14),
                          Icon(
                            Icons.search,
                            size: 20,
                            color: AppColors.mutedText,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '搜索书名、作者或文库',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: AppColors.mutedText,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroBanner extends StatelessWidget {
  const _HeroBanner();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          height: 144,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'UI-design/app-ui-design/assets/c01.jpg',
                fit: BoxFit.cover,
                alignment: const Alignment(0, -0.25),
                errorBuilder: (context, error, stackTrace) =>
                    const ColoredBox(color: Color(0xFF344B76)),
                excludeFromSemantics: true,
              ),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0x22000000),
                      Color(0x33000000),
                      Color(0xD9000000),
                    ],
                    stops: [0, 0.42, 1],
                  ),
                ),
              ),
              const Positioned(
                left: 12,
                top: 12,
                child: _HeroBadge(label: '本周强推'),
              ),
              const Positioned(
                left: 14,
                right: 14,
                bottom: 17,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Re:从零开始的异世界生活',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        height: 1.25,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '长月达平 · MF文库J · 553.5 万字',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        height: 1.25,
                      ),
                    ),
                  ],
                ),
              ),
              const Positioned(right: 13, bottom: 13, child: _BannerDots()),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroBadge extends StatelessWidget {
  const _HeroBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0x990F2A49),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _BannerDots extends StatelessWidget {
  const _BannerDots();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _BannerDot(active: true),
        SizedBox(width: 5),
        _BannerDot(),
        SizedBox(width: 5),
        _BannerDot(),
        SizedBox(width: 5),
        _BannerDot(),
        SizedBox(width: 5),
        _BannerDot(),
      ],
    );
  }
}

class _BannerDot extends StatelessWidget {
  const _BannerDot({this.active = false});

  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: active ? 12 : 5,
      height: 5,
      decoration: BoxDecoration(
        color: active ? Colors.white : Colors.white.withValues(alpha: 0.48),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, this.actionLabel, this.onAction});

  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 19, 16, 0),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.primaryText,
              fontSize: 17,
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
          ),
          const Spacer(),
          if (actionLabel != null)
            Semantics(
              button: true,
              label: '$actionLabel，打开分类',
              child: InkWell(
                onTap: onAction,
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  height: 48,
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          actionLabel!,
                          style: const TextStyle(
                            color: AppColors.mutedText,
                            fontSize: 13,
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right,
                          size: 18,
                          color: AppColors.mutedText,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _LibraryStrip extends StatelessWidget {
  const _LibraryStrip({required this.libraries, required this.onTap});

  final List<_LibraryData> libraries;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 78,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
        scrollDirection: Axis.horizontal,
        itemCount: libraries.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final library = libraries[index];
          return Semantics(
            button: true,
            label: '${library.name}，打开分类',
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: 54,
                child: Column(
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: library.color,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        library.shortName,
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      library.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 11,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _RankingTabs extends StatelessWidget {
  const _RankingTabs({
    required this.labels,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(13, 8, 13, 8),
      child: Row(
        children: [
          for (var index = 0; index < labels.length; index++)
            Expanded(
              child: Semantics(
                key: Key('ranking-tab-${labels[index]}'),
                button: true,
                selected: index == selectedIndex,
                label: '${labels[index]}榜',
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () => onSelected(index),
                  child: SizedBox(
                    height: 48,
                    child: Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 140),
                        curve: Curves.easeOut,
                        height: 32,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: index == selectedIndex
                              ? AppColors.brand
                              : AppColors.field,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          labels[index],
                          maxLines: 1,
                          style: TextStyle(
                            color: index == selectedIndex
                                ? Colors.white
                                : AppColors.secondaryText,
                            fontSize: 14,
                            fontWeight: index == selectedIndex
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _RankingRow extends StatelessWidget {
  const _RankingRow({required this.book});

  final _BookData book;

  @override
  Widget build(BuildContext context) {
    final rank = int.tryParse(book.rank) ?? 0;

    return SizedBox(
      height: 64,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            SizedBox(
              width: 18,
              child: Text(
                book.rank,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: rank <= 3 ? AppColors.brand : AppColors.mutedText,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            const SizedBox(width: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                book.cover,
                width: 38,
                height: 54,
                fit: BoxFit.cover,
                semanticLabel: '${book.title}封面',
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 38,
                  height: 54,
                  color: AppColors.field,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.menu_book_outlined,
                    size: 18,
                    color: AppColors.mutedText,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 15,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    book.author,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.mutedText,
                      fontSize: 12,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 6),
            Text(
              book.metric,
              style: const TextStyle(
                color: AppColors.accent,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LibraryData {
  const _LibraryData({
    required this.shortName,
    required this.name,
    required this.color,
  });

  final String shortName;
  final String name;
  final Color color;
}

class _BookData {
  const _BookData({
    required this.rank,
    required this.title,
    required this.author,
    required this.metric,
    required this.cover,
  });

  final String rank;
  final String title;
  final String author;
  final String metric;
  final String cover;
}
