import 'package:flutter/material.dart';

class SelectionBottomSheet<T> extends StatelessWidget {
  final String title;
  final List<T> items;
  final Widget Function(BuildContext context, T item) itemBuilder;

  const SelectionBottomSheet({
    Key? key,
    required this.title,
    required this.items,
    required this.itemBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return InkWell(
                  onTap: () {
                    Navigator.pop(context, item);
                  },
                  child: itemBuilder(context, item),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
