import 'package:flutter/material.dart';

class EmptyListView extends StatelessWidget {
  const EmptyListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.35),
      alignment: Alignment.center,
      child: const Text(
        'No Item Added',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
      ),
    );
  }
}
