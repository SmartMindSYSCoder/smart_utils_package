import 'package:flutter/material.dart';
import 'package:smart_utils_package/smart_utils_package.dart';

class UiUtilitiesDemo extends StatelessWidget {
  const UiUtilitiesDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('UI Utilities Demo')),
      body: CustomScrollView(
        slivers: [
          // 1. SliverExtensions Demo
          const Text(
            'Sliver Extensions Demo',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ).toPaddedSliver(padding: const EdgeInsets.all(16)),

          Text(
            'This text is converted to a sliver using .toPaddedSliver()',
            style: TextStyle(color: Colors.grey[600]),
          ).toPaddedSliver(padding: const EdgeInsets.symmetric(horizontal: 16)),

          16.height.toSliver(), // SpacingExtension + SliverExtension!
          // 2. Padding & Spacing Demo
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.blue.shade50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Spacing Extension Demo',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                16.height, // Vertical Spacing
                Row(
                  children: [
                    Container(color: Colors.blue, width: 40, height: 40),
                    16.width, // Horizontal Spacing
                    Container(color: Colors.red, width: 40, height: 40),
                    16.width,
                    Container(color: Colors.green, width: 40, height: 40),
                  ],
                ),
                16.height,
                const Text('Horizontal Divider:'),
                8.height,
                24.hDivider(color: Colors.blue, thickness: 2),
                8.height,
                SizedBox(
                  height: 40,
                  child: Row(
                    children: [
                      const Text('Vertical Divider:'),
                      16.width,
                      Container(color: Colors.grey, width: 20, height: 20),
                      16.vDivider(
                        color: Colors.red,
                        thickness: 2,
                        indent: 4,
                        endIndent: 4,
                      ),
                      Container(color: Colors.grey, width: 20, height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ).toPaddedSliver(padding: const EdgeInsets.all(16)),

          // 3. AppWrapper Concept Demo
          const Text(
            'AppWrapper & DoubleTapExitWrapper',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ).toPaddedSliver(padding: const EdgeInsets.all(16)),

          const Text(
            'These wrappers are applied at the root level (in main.dart).\n\n'
            '• DoubleTapExitWrapper: Try pressing back button!\n'
            '• AppWrapper: Handles text scaling and safe areas automatically.',
          ).toPaddedSliver(padding: const EdgeInsets.symmetric(horizontal: 16)),

          // Fill remaining space
          Container(
            color: Colors.grey.shade100,
            alignment: Alignment.center,
            child: const Text(
              'This area fills existing space using .toSliverFillRemaining()',
            ),
          ).toSliverFillRemaining(hasScrollBody: false),
        ],
      ),
    );
  }
}
