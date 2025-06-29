import 'package:flutter/material.dart';

class ScrollableGridView extends StatelessWidget {
  final List<Widget> children;

  const ScrollableGridView({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: (MediaQuery.of(context).size.width / 2 - 24) / 200,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return children[index];
            },
            childCount: children.length,
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: 20),
        ),
      ],
    );
  }
}