import 'package:flutter/material.dart';

class ViewModeBottomSheet extends StatelessWidget {
  const ViewModeBottomSheet({
    Key? key,
    required this.favMode,
    required this.gridMode,
  }) : super(key: key);
  final bool favMode;
  final bool gridMode;

  String favMenuTitle(bool favMode) {
    return favMode ? '「すべて」表示に切り替え' : '「お気に入り」表示に切り替え';
  }

  String favMenuSubtitle(bool favMode) {
    return favMode ? 'すべてのポケモンが表示されます' : 'お気に入りに登録したポケモンのみが表示されます';
  }

  String gridMenuTitle(bool gridMode) {
    return gridMode ? 'リスト表示に切り替え' : 'グリッド表示に切り替え';
  }

  String gridMenuSubtitle(bool gridMode) {
    return gridMode ? 'ポケモンをリスト表示します' : 'ポケモンをグリッド表示します';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Center(
        child: Column(
          children: [
            Container(
              height: 5,
              width: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).colorScheme.background,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Text(
                '表示設定',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.swap_horiz),
              title: Text(favMenuTitle(favMode)),
              subtitle: Text(favMenuSubtitle(favMode)),
              onTap: () => Navigator.pop(context, 'fav'),
            ),
            ListTile(
              leading: const Icon(Icons.grid_3x3),
              title: Text(gridMenuTitle(gridMode)),
              subtitle: Text(gridMenuSubtitle(gridMode)),
              onTap: () => Navigator.pop(context, 'grid'),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              child: const Text('キャンセル'),
              onPressed: () => Navigator.pop(context, false),
            ),
          ],
        ),
      ),
    );
  }
}
