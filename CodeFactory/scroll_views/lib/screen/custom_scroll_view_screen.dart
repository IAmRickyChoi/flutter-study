import 'package:flutter/material.dart';
import 'package:scroll_views/const/colors.dart';

class _SliverFixedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double maxHeight;
  final double minHeight;

  _SliverFixedHeaderDelegate({
    required this.child,
    required this.maxHeight,
    required this.minHeight,
  });
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => maxHeight;
  @override
  // TODO: implement minExtent
  double get minExtent => minHeight;
  @override
  bool shouldRebuild(_SliverFixedHeaderDelegate oldDelegate) {
    return oldDelegate.minExtent != minHeight ||
        oldDelegate.maxExtent != maxHeight ||
        oldDelegate.child != child;
  }
}

class CustomScrollViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);
  CustomScrollViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          renderSliverAppbar(),
          renderHeader(),
          renderBuilderSliverList(),
          renderHeader(),
          renderSliverGridBuilder(),
          renderHeader(),
          renderBuilderSliverList(),
        ],
      ),
    );
  }

  SliverPersistentHeader renderHeader() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverFixedHeaderDelegate(
        child: Container(
          color: Colors.black,
          child: Center(
            child: Text('test', style: TextStyle(color: Colors.white)),
          ),
        ),
        maxHeight: 250,
        minHeight: 70,
      ),
    );
  }

  SliverAppBar renderSliverAppbar() {
    return SliverAppBar(
      backgroundColor: Colors.blue,
      floating: true,
      pinned: false,
      snap: true,
      stretch: true,
      expandedHeight: 250,
      collapsedHeight: 150,
      flexibleSpace: FlexibleSpaceBar(
        title: Text('Mint'),
        background: Image.asset('asset/img/test.HEIC', fit: BoxFit.cover),
      ),
      title: Text('CustomScrollViewScreen'),
    );
  }

  SliverList renderChildSliverList() {
    return SliverList(
      delegate: SliverChildListDelegate(
        numbers
            .map(
              (e) => renderContaier(
                color: rainbowColors[e % rainbowColors.length],
                index: e,
              ),
            )
            .toList(),
      ),
    );
  }

  SliverList renderBuilderSliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return renderContaier(
          color: rainbowColors[index % rainbowColors.length],
          index: index,
        );
      }, childCount: 30),
    );
  }

  SliverGrid renderChildSliverGrid() {
    return SliverGrid(
      delegate: SliverChildListDelegate(
        numbers
            .map(
              (e) => renderContaier(
                color: rainbowColors[e % rainbowColors.length],
                index: e,
              ),
            )
            .toList(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
    );
  }

  SliverGrid renderSliverGridBuilder() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate((context, index) {
        return renderContaier(
          color: rainbowColors[index % rainbowColors.length],
          index: index,
        );
      }, childCount: 100),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150,
      ),
    );
  }

  Widget renderContaier({
    required Color color,
    required int index,
    double? height,
  }) {
    print(index);
    return Container(
      height: height ?? 300,
      color: color,
      child: Center(
        child: Text(
          index.toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
