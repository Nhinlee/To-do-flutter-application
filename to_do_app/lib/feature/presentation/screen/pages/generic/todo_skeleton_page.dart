import 'package:flutter/material.dart';
import 'package:to_do_app/feature/presentation/screen/theme/app_theme.dart';

class TodoSkeletonPage extends StatelessWidget {
  final String title;
  final Widget listviewWidget;

  const TodoSkeletonPage({
    Key key,
    this.listviewWidget,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 20, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: AppTheme.paragraphFontSize),
          ),
          const SizedBox(height: 16),
          Expanded(child: listviewWidget),
        ],
      ),
    );
  }
}
