import 'package:flutter/material.dart';

import '../widgets/training_block/training_block_content.dart';

class TrainingBlockScreen extends StatelessWidget {
  const TrainingBlockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: CONTINUE
    return DefaultTabController(
      length: 12,
      child: Column(
        children: [
          Material(
            color: Colors.transparent,
            child: TabBar(
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              indicatorColor: Theme.of(context).colorScheme.primary,
              labelColor: Theme.of(context).colorScheme.primary,
              unselectedLabelColor: Colors.grey,
              tabs: List.generate(12, (i) => Tab(text: "Week ${i + 1}")),
            ),
          ),

          const SizedBox(height: 16),

          // CONTENT (your actual training planner)
          Expanded(
            child: TabBarView(
              children: List.generate(
                12,
                (i) => TrainingBlockContent(week: i + 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
