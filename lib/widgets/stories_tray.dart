import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class StoriesTray extends StatelessWidget {
  const StoriesTray({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!),
        ),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Stack(
                    children: [
                      const CircleAvatar(
                        radius: 35,
                        backgroundImage: CachedNetworkImageProvider('https://picsum.photos/id/1/200/200'),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.add, color: Colors.white, size: 20),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text('Your story', style: TextStyle(fontSize: 12)),
                ],
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Colors.purple, Colors.orange, Colors.yellow],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: CachedNetworkImageProvider('https://picsum.photos/id/${index + 10}/200/200'),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text('user_$index', style: const TextStyle(fontSize: 12)),
              ],
            ),
          );
        },
      ),
    );
  }
}
