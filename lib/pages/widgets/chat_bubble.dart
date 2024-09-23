import 'package:chatapp_ai/pages/widgets/avatar.dart';
import 'package:flutter/material.dart';

enum BubbleType { top, middle, bottom, single }

enum Direction { left, right }

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.direction,
    required this.message,
    required this.type,
    this.photoUrl,
  });
  final Direction direction;
  final String message;
  final String? photoUrl;
  final BubbleType type;

  @override
  Widget build(BuildContext context) {
    final isOnLeft = direction == Direction.left;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment:
            isOnLeft ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isOnLeft) _buildLeading(type),
          SizedBox(width: isOnLeft ? 6 : 0),
          Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: _borderRadius(direction, type),
              color: isOnLeft ? Colors.grey[700] : Colors.indigoAccent,
            ),
            child: Text(
              message,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: isOnLeft ? Colors.white : Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLeading(BubbleType type) {
    if (type == BubbleType.single || type == BubbleType.bottom) {
      if (photoUrl != null) {
        return CircleAvatar(
          radius: 15,
          backgroundImage: NetworkImage(photoUrl!),
        );
      }
      return const Avatar(
        radius: 15,
      );
    }
    return const SizedBox(width: 24);
  }

  BorderRadius _borderRadius(Direction dir, BubbleType type) {
    const radius1 = Radius.circular(10);
    const radius2 = Radius.circular(5);
    switch (type) {
      case BubbleType.top:
        return dir == Direction.left
            ? const BorderRadius.only(
                topLeft: radius1,
                topRight: radius1,
                bottomLeft: radius2,
                bottomRight: radius1,
              )
            : const BorderRadius.only(
                topLeft: radius1,
                topRight: radius1,
                bottomLeft: radius1,
                bottomRight: radius2,
              );
      case BubbleType.middle:
        return dir == Direction.left
            ? const BorderRadius.only(
                topLeft: radius2,
                topRight: radius1,
                bottomLeft: radius2,
                bottomRight: radius1,
              )
            : const BorderRadius.only(
                topLeft: radius1,
                topRight: radius2,
                bottomLeft: radius1,
                bottomRight: radius2,
              );
      case BubbleType.bottom:
        return dir == Direction.left
            ? const BorderRadius.only(
                topLeft: radius2,
                topRight: radius1,
                bottomLeft: radius1,
                bottomRight: radius1,
              )
            : const BorderRadius.only(
                topLeft: radius1,
                topRight: radius2,
                bottomLeft: radius1,
                bottomRight: radius1,
              );
      case BubbleType.single:
        return BorderRadius.circular(10);
    }
  }
}
