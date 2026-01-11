import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';

class TarotCardWidget extends StatelessWidget {
  final String cardName;
  final String imageUrl;
  final bool isSelected;
  final bool isResultMode;
  final FlipCardController controller;
  final VoidCallback onTap;

  // ✅ 안정적인 이미지 URL
  final String _backUrl = "https://upload.wikimedia.org/wikipedia/commons/thumb/3/30/Card_back_05a.svg/200px-Card_back_05a.svg.png";

  const TarotCardWidget({
    super.key,
    required this.cardName,
    required this.imageUrl,
    required this.isSelected,
    required this.isResultMode,
    required this.controller,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // 1. 카드 뒷면
    final backWidget = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? Colors.cyanAccent : Colors.white24,
          width: 2,
        ),
        color: const Color(0xFF1A237E), // 남색 배경
        boxShadow: isSelected
            ? [BoxShadow(color: Colors.cyanAccent.withOpacity(0.6), blurRadius: 10)]
            : [],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Image.network(
          _backUrl,
          fit: BoxFit.cover,
          // ✅ 이미지 실패 시 안전장치
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: const Color(0xFF1A237E),
              child: const Center(child: Icon(Icons.auto_awesome, color: Colors.white24, size: 20)),
            );
          },
        ),
      ),
    );

    // 2. 카드 앞면
    final frontWidget = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.amber, width: 2),
        color: Colors.black,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: imageUrl.isNotEmpty
            ? Image.network(imageUrl, fit: BoxFit.cover,
                errorBuilder: (c, e, s) => const Center(child: Icon(Icons.broken_image, color: Colors.white54)))
            : Center(child: Text(cardName, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 10))),
      ),
    );

    if (isResultMode) {
      return FlipCard(
        rotateSide: RotateSide.right,
        onTapFlipping: false,
        axis: FlipAxis.vertical,
        controller: controller,
        frontWidget: backWidget,
        backWidget: frontWidget,
      );
    } else {
      return GestureDetector(onTap: onTap, child: backWidget);
    }
  }
}