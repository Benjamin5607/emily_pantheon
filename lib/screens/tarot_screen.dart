import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart'; // 웹 이미지 캐싱용
import '../api_service.dart';
import '../l10n.dart';
import '../main.dart'; 
import '../routing_service.dart'; // 알뜰 라우팅 서비스

class CyberTarotScreen extends StatefulWidget {
  final AppLanguage lang;
  const CyberTarotScreen({super.key, required this.lang});

  @override
  State<CyberTarotScreen> createState() => _CyberTarotScreenState();
}

class _CyberTarotScreenState extends State<CyberTarotScreen> with TickerProviderStateMixin {
  int _step = 0; 
  String _selectedTopic = '';
  String _selectedTime = '';
  final TextEditingController _queryController = TextEditingController();
  List<dynamic> _deck = [];
  final List<String> _selectedCards = [];
  final Map<String, FlipCardController> _flipControllers = {};
  bool _isLoading = false;
  String _result = '';

  // 1. 위키백과(Wikimedia) 타로 이미지 주소 (앞면용 - 자동 캐싱됨)
  final Map<String, String> _cardImageMap = {
    "The Fool": "https://upload.wikimedia.org/wikipedia/commons/9/90/RWS_Tarot_00_Fool.jpg",
    "The Magician": "https://upload.wikimedia.org/wikipedia/commons/d/de/RWS_Tarot_01_Magician.jpg",
    "The High Priestess": "https://upload.wikimedia.org/wikipedia/commons/8/88/RWS_Tarot_02_High_Priestess.jpg",
    "The Empress": "https://upload.wikimedia.org/wikipedia/commons/d/d2/RWS_Tarot_03_Empress.jpg",
    "The Emperor": "https://upload.wikimedia.org/wikipedia/commons/c/c3/RWS_Tarot_04_Emperor.jpg",
    "The Hierophant": "https://upload.wikimedia.org/wikipedia/commons/8/8d/RWS_Tarot_05_Hierophant.jpg",
    "The Lovers": "https://upload.wikimedia.org/wikipedia/commons/3/3a/RWS_Tarot_06_Lovers.jpg",
    "The Chariot": "https://upload.wikimedia.org/wikipedia/commons/9/9b/RWS_Tarot_07_Chariot.jpg",
    "Strength": "https://upload.wikimedia.org/wikipedia/commons/f/f5/RWS_Tarot_08_Strength.jpg",
    "The Hermit": "https://upload.wikimedia.org/wikipedia/commons/4/4d/RWS_Tarot_09_Hermit.jpg",
    "Wheel of Fortune": "https://upload.wikimedia.org/wikipedia/commons/3/3c/RWS_Tarot_10_Wheel_of_Fortune.jpg",
    "Justice": "https://upload.wikimedia.org/wikipedia/commons/e/e0/RWS_Tarot_11_Justice.jpg",
    "The Hanged Man": "https://upload.wikimedia.org/wikipedia/commons/2/2b/RWS_Tarot_12_Hanged_Man.jpg",
    "Death": "https://upload.wikimedia.org/wikipedia/commons/d/d7/RWS_Tarot_13_Death.jpg",
    "Temperance": "https://upload.wikimedia.org/wikipedia/commons/f/f8/RWS_Tarot_14_Temperance.jpg",
    "The Devil": "https://upload.wikimedia.org/wikipedia/commons/5/55/RWS_Tarot_15_Devil.jpg",
    "The Tower": "https://upload.wikimedia.org/wikipedia/commons/5/53/RWS_Tarot_16_Tower.jpg",
    "The Star": "https://upload.wikimedia.org/wikipedia/commons/d/db/RWS_Tarot_17_Star.jpg",
    "The Moon": "https://upload.wikimedia.org/wikipedia/commons/7/7f/RWS_Tarot_18_Moon.jpg",
    "The Sun": "https://upload.wikimedia.org/wikipedia/commons/1/17/RWS_Tarot_19_Sun.jpg",
    "Judgement": "https://upload.wikimedia.org/wikipedia/commons/d/dd/RWS_Tarot_20_Judgement.jpg",
    "The World": "https://upload.wikimedia.org/wikipedia/commons/f/ff/RWS_Tarot_21_World.jpg",
  };

  // 2. 로컬 이미지 경로 (배경 & 뒷면)
  final String _bgImageAsset = "assets/images/bg_tarot.jpg";
  final String _cardBackAsset = "assets/images/card_back.jpg";

  @override
  void initState() {
    super.initState();
    _loadDeck();
  }

  Future<void> _loadDeck() async {
    final deck = await ApiService.getTarotDeck();
    setState(() => _deck = deck);
  }

  Future<void> _analyzeTarot() async {
    if (_queryController.text.isEmpty) return;
    setState(() => _isLoading = true);
    try {
      // 🔥 [확인 완료] 이미 여기서 AppLocalizations.getLangName()을 쓰고 계셨습니다!
      // 현재 언어("Vietnamese", "Japanese" 등)가 그대로 서버로 전달됩니다.
      final result = await RoutingService.getConsultation(
        cards: _selectedCards,
        topic: _selectedTopic,
        query: _queryController.text,
        lang: AppLocalizations.getLangName(widget.lang),
      );
      if (!mounted) return;
      setState(() {
        _result = result;
        _step = 4;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(_bgImageAsset),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.darken),
        ),
      ),
      child: Column(
        children: [
          LinearProgressIndicator(value: (_step + 1) / 5, backgroundColor: Colors.black, color: Colors.amber),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: _buildBody(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_step) {
      case 0: return _buildStep0_Topic();
      case 1: return _buildStep1_Time();
      case 2: return _buildStep2_Query();
      case 3: return _buildStep3_PickCards();
      case 4: return _buildStep4_Result();
      default: return const SizedBox();
    }
  }

  Widget _buildStep0_Topic() {
    final topics = [
      {'key': 'topic_love', 'icon': Icons.favorite, 'label': 'Love'},
      {'key': 'topic_money', 'icon': Icons.attach_money, 'label': 'Money'},
      {'key': 'topic_work', 'icon': Icons.work, 'label': 'Work'},
      {'key': 'topic_health', 'icon': Icons.health_and_safety, 'label': 'Health'},
    ];
    return Column(
      children: [
        const SizedBox(height: 20),
        GoldAvatar(asset: 'assets/images/tarot.png'), 
        const SizedBox(height: 20),
        Text(AppLocalizations.get('tarot_topic', widget.lang), style: GoogleFonts.cinzel(fontSize: 24, color: Colors.white)),
        const SizedBox(height: 30),
        Wrap(spacing: 15, runSpacing: 15, children: topics.map((t) => _buildOptionBtn(t['icon'] as IconData, AppLocalizations.get(t['key'] as String, widget.lang), (val) {
          setState(() { _selectedTopic = val; _step = 1; });
        })).toList())
      ],
    );
  }

  Widget _buildStep1_Time() {
    final times = ['time_1m', 'time_3m', 'time_6m', 'time_1y'];
    return Column(
      children: [
        Text(AppLocalizations.get('timeframe', widget.lang), style: GoogleFonts.cinzel(fontSize: 24, color: Colors.white)),
        const SizedBox(height: 30),
        Wrap(spacing: 15, runSpacing: 15, children: times.map((k) => _buildOptionBtn(Icons.timer, AppLocalizations.get(k, widget.lang), (val) {
          setState(() { _selectedTime = val; _step = 2; });
        })).toList())
      ],
    );
  }

  Widget _buildStep2_Query() {
    return Column(
      children: [
        Text(AppLocalizations.get('label_query', widget.lang), style: GoogleFonts.cinzel(fontSize: 24, color: Colors.white)),
        const SizedBox(height: 20),
        GoldCard(
          child: TextField(
            controller: _queryController,
            maxLines: 3,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: widget.lang == AppLanguage.korean 
                ? "구체적으로 적으면 AI가,\n짧게 적으면 에밀리 노트가 답해요." 
                : "Detailed query calls AI.\nShort query calls Basic Note.",
              hintStyle: TextStyle(color: Colors.grey.shade500), border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () { if (_queryController.text.isNotEmpty) setState(() => _step = 3); },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15)),
          child: Text(AppLocalizations.get('btn_next', widget.lang), style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        )
      ],
    );
  }

  Widget _buildStep3_PickCards() {
    return Column(
      children: [
        Text("${AppLocalizations.get('tarot_pick', widget.lang)} (${_selectedCards.length}/3)", style: GoogleFonts.cinzel(fontSize: 22, color: Colors.white)),
        const SizedBox(height: 20),
        SizedBox(
          height: 400,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 2/3, crossAxisSpacing: 10, mainAxisSpacing: 10),
            itemCount: _deck.length,
            itemBuilder: (context, index) {
              final card = _deck[index];
              final isSelected = _selectedCards.contains(card['name']);
              return GestureDetector(
                onTap: () {
                  if (_selectedCards.length < 3 && !isSelected) {
                    setState(() => _selectedCards.add(card['name']));
                    if (_selectedCards.length == 3) _analyzeTarot();
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: isSelected ? Border.all(color: Colors.amber, width: 3) : null,
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(image: AssetImage(_cardBackAsset), fit: BoxFit.cover),
                  ),
                  child: isSelected ? const Center(child: Icon(Icons.check_circle, color: Colors.amber, size: 40)) : null,
                ),
              );
            },
          ),
        ),
        if (_isLoading) ...[
          const SizedBox(height: 20),
          const CircularProgressIndicator(color: Colors.amber),
          const SizedBox(height: 10),
          Text(
            widget.lang == AppLanguage.korean 
                ? "에밀리가 카드를 해석하고 있습니다..." 
                : "Emily is reading the cards...",
            style: const TextStyle(color: Colors.amberAccent, fontSize: 16)
          ),
        ]
      ],
    );
  }

  Widget _buildStep4_Result() {
    return Column(
      children: [
        Text("✨ ${AppLocalizations.get('btn_reveal', widget.lang)} ✨", style: GoogleFonts.cinzel(fontSize: 26, color: Colors.amber, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        SizedBox(
          height: 180,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _selectedCards.length,
            separatorBuilder: (_,__) => const SizedBox(width: 15),
            itemBuilder: (context, index) {
              final cardName = _selectedCards[index];
              final imgUrl = _cardImageMap[cardName] ?? "";
              
              if (!_flipControllers.containsKey(cardName)) _flipControllers[cardName] = FlipCardController();

              return Column(
                children: [
                  SizedBox(
                    width: 100, height: 150,
                    child: FlipCard(
                      controller: _flipControllers[cardName]!,
                      rotateSide: RotateSide.right,
                      onTapFlipping: true,
                      frontWidget: Image.asset(_cardBackAsset, fit: BoxFit.cover),
                      backWidget: CachedNetworkImage(
                        imageUrl: imgUrl, 
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                        errorWidget: (context, url, error) => Container(color: Colors.grey, child: const Icon(Icons.error)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(cardName, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        GoldCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔥 [수정] "에밀리의 해석"이라는 한글 텍스트도 언어에 따라 바뀌게 수정!
              Text(
                widget.lang == AppLanguage.korean ? "에밀리의 해석:" : "Emily's Reading:",
                style: const TextStyle(color: Colors.amber, fontSize: 18, fontWeight: FontWeight.bold)
              ),
              const SizedBox(height: 10),
              Text(_result, style: const TextStyle(color: Colors.white, height: 1.6, fontSize: 15)),
            ],
          ),
        ),
        const SizedBox(height: 30),
        ElevatedButton.icon(
          onPressed: () {
            setState(() { _step = 0; _selectedCards.clear(); _selectedTopic = ''; _queryController.clear(); _result = ''; _flipControllers.clear(); });
          },
          icon: const Icon(Icons.refresh, color: Colors.black),
          label: Text(AppLocalizations.get('btn_reset', widget.lang), style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
        )
      ],
    );
  }

  Widget _buildOptionBtn(IconData icon, String label, Function(String) onTap) {
    return GestureDetector(
      onTap: () => onTap(label),
      child: Container(
        width: 140, height: 100,
        decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.amber.shade700)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, color: Colors.amber, size: 30), const SizedBox(height: 10), Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))]),
      ),
    );
  }
}