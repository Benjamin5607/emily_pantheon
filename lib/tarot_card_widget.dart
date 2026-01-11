// lib/tarot_card_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TarotCardWidget extends StatelessWidget {
  final String cardName;
  final String imageUrl;
  final bool isSelected;
  final bool isResultMode;
  final VoidCallback onTap;
  final FlipCardController controller;

  const TarotCardWidget({
    super.key,
    required this.cardName,
    required this.imageUrl,
    required this.isSelected,
    required this.isResultMode,
    required this.onTap,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: FlipCard(
        rotateSide: RotateSide.right,
        onTapFlipping: false,
        axis: FlipAxis.vertical,
        controller: controller,
        frontWidget: _buildCardBack(),
        backWidget: _buildCardFace(),
      ),
    );
  }

  // 🌑 카드 뒷면 (웹에서도 잘 나오는 안전한 이미지로 교체함!)
  Widget _buildCardBack() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? Colors.cyanAccent : const Color(0xFF8B4513),
          width: isSelected ? 3 : 1,
        ),
        boxShadow: isSelected
            ? [BoxShadow(color: Colors.cyanAccent.withOpacity(0.6), blurRadius: 10, spreadRadius: 1)]
            : [const BoxShadow(color: Colors.black, blurRadius: 4)],
        // 👇 여기가 바뀜! (Wikimedia의 안전한 패턴 이미지 사용)
        image: const DecorationImage(
          image: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/thumb/8/88/RWS_Tarot_02_High_Priestess.jpg/344px-RWS_Tarot_02_High_Priestess.jpg"), 
          // (일단 뒷면으로 여사제 카드 뒷모습 느낌이나 패턴을 써야하는데, 테스트를 위해 확실한 이미지 사용)
          // 더 좋은 패턴 이미지를 원하시면 아래 주소를 쓰세요:
          // "https://upload.wikimedia.org/wikipedia/commons/5/59/Tarot_Back_Design.jpg" (이게 진짜 뒷면)
          fit: BoxFit.cover,
        ),
      ),
      child: isSelected 
        ? Center(child: Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
            child: const Icon(Icons.check, color: Colors.cyanAccent, size: 20)
          ))
        : null,
    );
  }

  // 🌕 카드 앞면 (이전과 동일)
  Widget _buildCardFace() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.amber, width: 1.5),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (imageUrl.isNotEmpty)
              CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: SizedBox(
                    width: 20, 
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.amber),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[900],
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.broken_image, color: Colors.white24),
                      SizedBox(height: 4),
                      Text("Load Fail", style: TextStyle(color: Colors.white24, fontSize: 8)),
                    ],
                  ),
                ),
              )
            else
              Container(color: const Color(0xFF2D1B4E)), 
            
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black.withOpacity(0.8),
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    cardName,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cinzel(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}