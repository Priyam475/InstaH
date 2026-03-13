import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerPost extends StatelessWidget {
  const ShimmerPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const CircleAvatar(backgroundColor: Colors.white),
            title: Container(height: 10, width: 100, color: Colors.white),
          ),
          Container(
            height: 400,
            width: double.infinity,
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 10, width: 150, color: Colors.white),
                const SizedBox(height: 5),
                Container(height: 10, width: 100, color: Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
