import 'package:flutter/material.dart';

import '../utils/colors.dart';

class CustomFilter extends StatelessWidget {
  final List<Map<String, dynamic>> filterOptions;
  final Function(String label, bool isSelected) onFilterSelected;

  const CustomFilter({
    super.key,
    required this.filterOptions,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: filterOptions.map((option) {
          return ChipTheme(
            data: ChipTheme.of(context).copyWith(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
            ),
            child: FilterChip(
              label: Text(option['label'] as String),
              selected: option['selected'] as bool,
              backgroundColor: AppColors.whiteBg,
              selectedColor: AppColors.primaryBlue,
              onSelected: (bool value) {
                onFilterSelected(option['label'] as String, value);
              },
              showCheckmark: false,
              side: BorderSide.none,
              labelStyle: TextStyle(
                color: (option['selected'] as bool)
                    ? Colors.white
                    : Theme.of(context).disabledColor,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
