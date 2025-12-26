import 'package:flutter/material.dart';

class HomeSliverAppBar extends StatelessWidget {
  const HomeSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: const Text("Mini Chat"),
      centerTitle: false,
      floating: true,
      pinned: true,
      snap: false,
      // Increase height slightly to accommodate the padding
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(54),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              // TRICK: Use a Row with MainAxisSize.min to force the container to shrink
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min, // This stops it from stretching
                children: [
                  Container(
                    height: 46,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.grey[200], // Now this only wraps the tabs
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TabBar(
                      isScrollable: true, // Required to make tabs shrink
                      tabAlignment:
                          TabAlignment.center, // Centers tabs inside the bubble
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: Colors.transparent,
                      indicator: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      labelColor: Colors.black87,
                      labelStyle: const TextStyle(fontWeight: FontWeight.w600),
                      unselectedLabelColor: Colors.grey[600],
                      labelPadding: const EdgeInsets.symmetric(horizontal: 24),
                      tabs: const [
                        Tab(text: "Users"),
                        Tab(text: "Chat History"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: Colors.black12, thickness: 0.5, height: 2),
          ],
        ),
      ),
    );
  }
}
