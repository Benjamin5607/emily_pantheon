enum AppLanguage { korean, english, chinese, japanese, vietnamese }

class AppLocalizations {
  static final Map<String, Map<AppLanguage, String>> _values = {
    // --- [공통] ---
    'title': {
      AppLanguage.korean: '에밀리 : 만신전',
      AppLanguage.english: "Emily's Pantheon",
      AppLanguage.chinese: '艾米丽 : 万神殿',
      AppLanguage.japanese: 'エミリー : 万神殿',
      AppLanguage.vietnamese: 'Emily : Điện Vạn Thần',
    },
    'btn_start': { AppLanguage.korean: '시작하기', AppLanguage.english: 'Start', AppLanguage.chinese: '开始', AppLanguage.japanese: '開始', AppLanguage.vietnamese: 'Bắt đầu' },
    'btn_next': { AppLanguage.korean: '다음', AppLanguage.english: 'Next', AppLanguage.chinese: '下一步', AppLanguage.japanese: '次へ', AppLanguage.vietnamese: 'Tiếp' },
    'btn_analyze': { AppLanguage.korean: '결과 보기', AppLanguage.english: 'Analyze', AppLanguage.chinese: '分析', AppLanguage.japanese: '鑑定', AppLanguage.vietnamese: 'Phân tích' },
    'btn_reveal': { AppLanguage.korean: '운명 확인', AppLanguage.english: 'Reveal', AppLanguage.chinese: '揭示', AppLanguage.japanese: '確認', AppLanguage.vietnamese: 'Xem' },
    'btn_reset': { AppLanguage.korean: '처음으로', AppLanguage.english: 'Reset', AppLanguage.chinese: '重置', AppLanguage.japanese: '最初に戻る', AppLanguage.vietnamese: 'Làm lại' },

    // --- [웰컴 / 엔트리] ---
    'welcome_tagline': {
      AppLanguage.korean: '한국에서 신내림 받은\n20살 미국 소녀 에밀리의 만신전',
      AppLanguage.english: 'A 20-year-old American girl\nwho found her calling in Korea',
      AppLanguage.chinese: '在韩国找到天命的\n20岁美国女孩艾米丽',
      AppLanguage.japanese: '韓国で神託を受けた\n20歳のアメリカ人少女エミリー',
      AppLanguage.vietnamese: 'Cô gái Mỹ 20 tuổi\nnhận thần giáng tại Hàn Quốc',
    },
    'welcome_subtitle': {
      AppLanguage.korean: '타로 · 풍수 철학 · 신점 — 세 가지 길로 당신의 운명을 읽어드려요',
      AppLanguage.english: 'Tarot · Feng Shui · Spirit Oracle — three paths to read your destiny',
      AppLanguage.chinese: '塔罗 · 风水哲学 · 神占 — 三条道路解读你的命运',
      AppLanguage.japanese: 'タロット · 風水哲学 · 神占い — 三つの道で運命を読み解く',
      AppLanguage.vietnamese: 'Tarot · Phong Thủy · Thần Bói — ba con đường đọc vận mệnh',
    },
    'welcome_enter': {
      AppLanguage.korean: '만신전 들어가기',
      AppLanguage.english: 'Enter the Pantheon',
      AppLanguage.chinese: '进入万神殿',
      AppLanguage.japanese: '万神殿へ入る',
      AppLanguage.vietnamese: 'Vào Điện Vạn Thần',
    },
    'welcome_footer': {
      AppLanguage.korean: '※ 오락 목적의 AI 상담입니다. 중요한 결정은 전문가와 상의하세요.',
      AppLanguage.english: '※ For entertainment only. Consult professionals for important decisions.',
      AppLanguage.chinese: '※ 仅供娱乐。重要决定请咨询专业人士。',
      AppLanguage.japanese: '※ 娯楽目的のAI相談です。重要な決断は専門家にご相談ください。',
      AppLanguage.vietnamese: '※ Chỉ mang tính giải trí. Hãy tham khảo chuyên gia cho quyết định quan trọng.',
    },
    'welcome_tarot_desc': {
      AppLanguage.korean: '홍대에서 배운 타로로, 당신의 고민에 카드가 답해요',
      AppLanguage.english: 'Tarot learned in Hongdae — cards answer what weighs on your heart',
      AppLanguage.chinese: '在弘大学到的塔罗，用卡牌回答你的烦恼',
      AppLanguage.japanese: '弘大で学んだタロットで、あなたの悩みにカードが答える',
      AppLanguage.vietnamese: 'Tarot học ở Hongdae — lá bài trả lời nỗi lo của bạn',
    },
    'welcome_fengshui_desc': {
      AppLanguage.korean: '공간의 기운을 철학처럼 풀어주는, 에밀리의 풍수 카페',
      AppLanguage.english: 'Emily\'s cafe where space energy meets life philosophy',
      AppLanguage.chinese: '艾米丽的空间能量哲学馆，像咖啡馆一样温暖',
      AppLanguage.japanese: '空間の気を哲学のように語る、エミリーの風水カフェ',
      AppLanguage.vietnamese: 'Quán Phong Thủy của Emily — năng lượng không gian gặp triết học',
    },
    'welcome_shaman_desc': {
      AppLanguage.korean: '신령님의 목소리를 전하는, 젊은 무당 에밀리의 신점',
      AppLanguage.english: 'Young shaman Emily channels the spirits\' oracle for you',
      AppLanguage.chinese: '年轻萨满艾米丽为你传达神灵的谕示',
      AppLanguage.japanese: '若き巫女エミリーが神霊のお告げを伝える',
      AppLanguage.vietnamese: 'Emily trẻ truyền thần dụ từ linh hồn cho bạn',
    },

    // --- [언어 메뉴] ---
    'lang_korean': { AppLanguage.korean: '한국어', AppLanguage.english: 'Korean', AppLanguage.chinese: '韩语', AppLanguage.japanese: '韓国語', AppLanguage.vietnamese: 'Tiếng Hàn' },
    'lang_english': { AppLanguage.korean: 'English', AppLanguage.english: 'English', AppLanguage.chinese: '英语', AppLanguage.japanese: 'English', AppLanguage.vietnamese: 'English' },
    'lang_chinese': { AppLanguage.korean: '中文', AppLanguage.english: 'Chinese', AppLanguage.chinese: '中文', AppLanguage.japanese: '中国語', AppLanguage.vietnamese: 'Tiếng Trung' },
    'lang_japanese': { AppLanguage.korean: '日本語', AppLanguage.english: 'Japanese', AppLanguage.chinese: '日语', AppLanguage.japanese: '日本語', AppLanguage.vietnamese: 'Tiếng Nhật' },
    'lang_vietnamese': { AppLanguage.korean: 'Tiếng Việt', AppLanguage.english: 'Vietnamese', AppLanguage.chinese: '越南语', AppLanguage.japanese: 'ベトナム語', AppLanguage.vietnamese: 'Tiếng Việt' },

    // --- [탭] ---
    'tab_tarot': { AppLanguage.korean: '타로', AppLanguage.english: 'Tarot', AppLanguage.chinese: '塔罗', AppLanguage.japanese: 'タロット', AppLanguage.vietnamese: 'Tarot' },
    'tab_fengshui': { AppLanguage.korean: '풍수', AppLanguage.english: 'Feng Shui', AppLanguage.chinese: '风水', AppLanguage.japanese: '風水', AppLanguage.vietnamese: 'Phong Thủy' },
    'tab_saju': { AppLanguage.korean: '신점', AppLanguage.english: 'Shaman', AppLanguage.chinese: '神占', AppLanguage.japanese: '神占い', AppLanguage.vietnamese: 'Thần Bói' },

    // --- [타로] ---
    'tarot_intro_title': {
      AppLanguage.korean: '에밀리의 타로',
      AppLanguage.english: "Emily's Tarot",
      AppLanguage.chinese: '艾米丽的塔罗',
      AppLanguage.japanese: 'エミリーのタロット',
      AppLanguage.vietnamese: 'Tarot của Emily',
    },
    'tarot_intro_desc': {
      AppLanguage.korean: '마음속 질문을 카드에 맡겨보세요.\n에밀리가 세 장의 카드로 이야기를 풀어드릴게요.',
      AppLanguage.english: 'Leave your question to the cards.\nEmily will weave a story from three of them.',
      AppLanguage.chinese: '把心中的问题交给卡牌吧。\n艾米丽会用三张牌为你讲述故事。',
      AppLanguage.japanese: '心の中の問いをカードに託して。\nエミリーが三枚のカードで物語を紡ぎます。',
      AppLanguage.vietnamese: 'Giao câu hỏi trong lòng cho lá bài.\nEmily sẽ dệt câu chuyện từ ba lá.',
    },
    'tarot_topic': { AppLanguage.korean: '어떤 고민인가요?', AppLanguage.english: 'What\'s on your mind?', AppLanguage.chinese: '什么在困扰你？', AppLanguage.japanese: 'どんな悩みですか？', AppLanguage.vietnamese: 'Bạn lo gì?' },
    'tarot_topic_sub': {
      AppLanguage.korean: '주제를 골라주세요',
      AppLanguage.english: 'Pick a topic',
      AppLanguage.chinese: '请选择主题',
      AppLanguage.japanese: 'テーマを選んでください',
      AppLanguage.vietnamese: 'Chọn chủ đề',
    },
    'timeframe': { AppLanguage.korean: '언제까지 궁금해요?', AppLanguage.english: 'How far ahead?', AppLanguage.chinese: '想看多久以后？', AppLanguage.japanese: 'いつまで見たい？', AppLanguage.vietnamese: 'Muốn xem bao lâu?' },
    'timeframe_sub': {
      AppLanguage.korean: '기간을 선택해 주세요',
      AppLanguage.english: 'Choose a timeframe',
      AppLanguage.chinese: '请选择时间范围',
      AppLanguage.japanese: '期間を選んでください',
      AppLanguage.vietnamese: 'Chọn khoảng thời gian',
    },
    'label_query': { AppLanguage.korean: '마음속 이야기를 들려주세요', AppLanguage.english: 'Tell me your story', AppLanguage.chinese: '告诉我你的故事', AppLanguage.japanese: '心の中の話を聞かせて', AppLanguage.vietnamese: 'Kể cho tôi nghe' },
    'tarot_pick': { AppLanguage.korean: '마음이 이끄는 카드 3장', AppLanguage.english: 'Pick 3 cards that call to you', AppLanguage.chinese: '选3张吸引你的牌', AppLanguage.japanese: '心が惹かれるカード3枚', AppLanguage.vietnamese: 'Chọn 3 lá bạn cảm thấy' },
    'tarot_hint_query': {
      AppLanguage.korean: '예) 그 사람과 다시 연락이 올까요?\n자세히 쓸수록 에밀리 AI가, 짧으면 기본 노트가 답해요.',
      AppLanguage.english: 'e.g. Will they reach out again?\nDetailed = AI reading. Short = Basic Note.',
      AppLanguage.chinese: '例）那个人会再联系我吗？\n详细=AI解读，简短=基础笔记。',
      AppLanguage.japanese: '例）あの人から連絡は来る？\n詳しく=AI鑑定、短く=基本ノート。',
      AppLanguage.vietnamese: 'VD: Người đó có liên lạc lại?\nChi tiết=AI, ngắn=Ghi chú cơ bản.',
    },
    'tarot_loading': {
      AppLanguage.korean: '카드가 속삭이고 있어요... 잠깐만요 ✨',
      AppLanguage.english: 'The cards are whispering... just a moment ✨',
      AppLanguage.chinese: '卡牌在低语...请稍等 ✨',
      AppLanguage.japanese: 'カードがささやいています...少々 ✨',
      AppLanguage.vietnamese: 'Lá bài đang thì thầm... chờ chút ✨',
    },
    'tarot_reading_title': {
      AppLanguage.korean: '에밀리의 해석',
      AppLanguage.english: "Emily's Reading",
      AppLanguage.chinese: '艾米丽的解读',
      AppLanguage.japanese: 'エミリーの鑑定',
      AppLanguage.vietnamese: 'Emily giải bài',
    },
    'tier1_header': {
      AppLanguage.korean: '💡 에밀리 노트(기본 해석)를 참고하여 답변드립니다.',
      AppLanguage.english: "💡 Reading from Emily's Basic Notes.",
      AppLanguage.chinese: '💡 参考艾米丽笔记（基础解读）回答。',
      AppLanguage.japanese: '💡 エミリーノート（基本鑑定）を参考に回答します。',
      AppLanguage.vietnamese: '💡 Trả lời dựa trên Ghi chú cơ bản của Emily.',
    },
    'tier1_error': {
      AppLanguage.korean: '데이터를 불러올 수 없습니다.',
      AppLanguage.english: 'Error loading data.',
      AppLanguage.chinese: '无法加载数据。',
      AppLanguage.japanese: 'データを読み込めません。',
      AppLanguage.vietnamese: 'Không thể tải dữ liệu.',
    },

    'topic_love': { AppLanguage.korean: '연애', AppLanguage.english: 'Love', AppLanguage.chinese: '爱情', AppLanguage.japanese: '恋愛', AppLanguage.vietnamese: 'Tình yêu' },
    'topic_money': { AppLanguage.korean: '금전', AppLanguage.english: 'Money', AppLanguage.chinese: '金钱', AppLanguage.japanese: '金運', AppLanguage.vietnamese: 'Tiền bạc' },
    'topic_work': { AppLanguage.korean: '직장', AppLanguage.english: 'Work', AppLanguage.chinese: '工作', AppLanguage.japanese: '仕事', AppLanguage.vietnamese: 'Công việc' },
    'topic_health': { AppLanguage.korean: '건강', AppLanguage.english: 'Health', AppLanguage.chinese: '健康', AppLanguage.japanese: '健康', AppLanguage.vietnamese: 'Sức khỏe' },

    'time_1m': { AppLanguage.korean: '1개월', AppLanguage.english: '1 Month', AppLanguage.chinese: '1个月', AppLanguage.japanese: '1ヶ月', AppLanguage.vietnamese: '1 tháng' },
    'time_3m': { AppLanguage.korean: '3개월', AppLanguage.english: '3 Months', AppLanguage.chinese: '3个月', AppLanguage.japanese: '3ヶ月', AppLanguage.vietnamese: '3 tháng' },
    'time_6m': { AppLanguage.korean: '6개월', AppLanguage.english: '6 Months', AppLanguage.chinese: '6个月', AppLanguage.japanese: '6ヶ月', AppLanguage.vietnamese: '6 tháng' },
    'time_1y': { AppLanguage.korean: '1년', AppLanguage.english: '1 Year', AppLanguage.chinese: '1年', AppLanguage.japanese: '1年', AppLanguage.vietnamese: '1 năm' },

    'pos_past': { AppLanguage.korean: '과거', AppLanguage.english: 'Past', AppLanguage.chinese: '过去', AppLanguage.japanese: '過去', AppLanguage.vietnamese: 'Quá khứ' },
    'pos_present': { AppLanguage.korean: '현재', AppLanguage.english: 'Present', AppLanguage.chinese: '现在', AppLanguage.japanese: '現在', AppLanguage.vietnamese: 'Hiện tại' },
    'pos_future': { AppLanguage.korean: '미래', AppLanguage.english: 'Future', AppLanguage.chinese: '未来', AppLanguage.japanese: '未来', AppLanguage.vietnamese: 'Tương lai' },

    // --- [풍수] ---
    'birth_date': { AppLanguage.korean: '생년월일', AppLanguage.english: 'Birth Info', AppLanguage.chinese: '出生信息', AppLanguage.japanese: '生年月日', AppLanguage.vietnamese: 'Ngày sinh' },
    'fs_intro_title': {
      AppLanguage.korean: '풍수지리 철학관',
      AppLanguage.english: 'Feng Shui Philosophy Cafe',
      AppLanguage.chinese: '风水哲学馆',
      AppLanguage.japanese: '風水哲学カフェ',
      AppLanguage.vietnamese: 'Quán Triết Học Phong Thủy',
    },
    'fs_intro_desc': {
      AppLanguage.korean: '집, 방, 침대 방향까지.\n공간에 흐르는 기운을 에밀리가 친구처럼 읽어드려요.',
      AppLanguage.english: 'Your home, room, even bed direction.\nEmily reads your space energy like a close friend.',
      AppLanguage.chinese: '家、房间、甚至床头方向。\n艾米丽像朋友一样解读你空间的能量。',
      AppLanguage.japanese: '家、部屋、寝る向きまで。\nエミリーが空間の気を友達のように読み解きます。',
      AppLanguage.vietnamese: 'Nhà, phòng, hướng giường ngủ.\nEmily đọc năng lượng không gian như bạn thân.',
    },
    'fs_birth_year': { AppLanguage.korean: '출생년도 (예: 1990)', AppLanguage.english: 'Birth Year (e.g. 1990)', AppLanguage.chinese: '出生年份（如1990）', AppLanguage.japanese: '生年（例: 1990）', AppLanguage.vietnamese: 'Năm sinh (vd: 1990)' },
    'fs_house_info': { AppLanguage.korean: '집 정보', AppLanguage.english: 'House Info', AppLanguage.chinese: '房屋信息', AppLanguage.japanese: '家の情報', AppLanguage.vietnamese: 'Thông tin nhà' },
    'fs_door_dir': { AppLanguage.korean: '현관 방향', AppLanguage.english: 'Front Door Direction', AppLanguage.chinese: '大门方向', AppLanguage.japanese: '玄関の方向', AppLanguage.vietnamese: 'Hướng cửa chính' },
    'fs_head_dir': { AppLanguage.korean: '잠잘 때 머리 방향', AppLanguage.english: 'Sleeping Head Direction', AppLanguage.chinese: '睡觉时头部方向', AppLanguage.japanese: '就寝時の頭の方向', AppLanguage.vietnamese: 'Hướng đầu khi ngủ' },
    'fs_location': { AppLanguage.korean: '거주 지역', AppLanguage.english: 'Location (City)', AppLanguage.chinese: '居住地区', AppLanguage.japanese: '居住地域', AppLanguage.vietnamese: 'Khu vực sống' },
    'fs_location_hint': { AppLanguage.korean: '예: 서울시 강남구', AppLanguage.english: 'e.g. Seoul, New York', AppLanguage.chinese: '例：首尔江南区', AppLanguage.japanese: '例: ソウル江南区', AppLanguage.vietnamese: 'vd: Seoul, Hà Nội' },
    'fs_query_hint': {
      AppLanguage.korean: '예) 거실 소파 위치가 맞나요? 이사 가도 될까요?',
      AppLanguage.english: 'e.g. Is my sofa placement okay? Should I move?',
      AppLanguage.chinese: '例）客厅沙发位置对吗？可以搬家吗？',
      AppLanguage.japanese: '例）ソファの位置は合ってる？引っ越していい？',
      AppLanguage.vietnamese: 'VD: Vị trí sofa ổn không? Có nên chuyển nhà?',
    },
    'fs_analyzing': {
      AppLanguage.korean: '공간의 기운을 읽는 중이에요... 🌿',
      AppLanguage.english: 'Reading the energy of your space... 🌿',
      AppLanguage.chinese: '正在解读空间能量... 🌿',
      AppLanguage.japanese: '空間の気を読んでいます... 🌿',
      AppLanguage.vietnamese: 'Đang đọc năng lượng không gian... 🌿',
    },
    'fs_result_title': { AppLanguage.korean: '에밀리의 풍수 조언', AppLanguage.english: "Emily's Feng Shui Advice", AppLanguage.chinese: '艾米丽的风水建议', AppLanguage.japanese: 'エミリーの風水アドバイス', AppLanguage.vietnamese: 'Lời khuyên Phong Thủy của Emily' },

    'label_name': { AppLanguage.korean: '이름', AppLanguage.english: 'Name', AppLanguage.chinese: '姓名', AppLanguage.japanese: '名前', AppLanguage.vietnamese: 'Tên' },
    'label_birth': { AppLanguage.korean: '생년월일', AppLanguage.english: 'Birth', AppLanguage.chinese: '生日', AppLanguage.japanese: '誕生日', AppLanguage.vietnamese: 'Ngày sinh' },
    'label_gender': { AppLanguage.korean: '성별', AppLanguage.english: 'Gender', AppLanguage.chinese: '性别', AppLanguage.japanese: '性別', AppLanguage.vietnamese: 'Giới tính' },
    'male': { AppLanguage.korean: '남성', AppLanguage.english: 'Male', AppLanguage.chinese: '男', AppLanguage.japanese: '男性', AppLanguage.vietnamese: 'Nam' },
    'female': { AppLanguage.korean: '여성', AppLanguage.english: 'Female', AppLanguage.chinese: '女', AppLanguage.japanese: '女性', AppLanguage.vietnamese: 'Nữ' },

    // --- [신점] ---
    'sj_intro_title': {
      AppLanguage.korean: '에밀리의 신점',
      AppLanguage.english: "Emily's Spirit Oracle",
      AppLanguage.chinese: '艾米丽的神占',
      AppLanguage.japanese: 'エミリーの神占い',
      AppLanguage.vietnamese: 'Thần Bói của Emily',
    },
    'sj_intro_desc': {
      AppLanguage.korean: '향을 피우고 신령님께 여쭤볼게요.\n20살 에밀리가 받은 공수를 그대로 전해드려요.',
      AppLanguage.english: 'I\'ll light incense and ask the spirits.\nEmily, 20, delivers their oracle to you.',
      AppLanguage.chinese: '我会焚香请示神灵。\n20岁的艾米丽将神谕传达给你。',
      AppLanguage.japanese: 'お香を焚いて神霊に伺います。\n20歳のエミリーが神託をそのまま伝えます。',
      AppLanguage.vietnamese: 'Tôi thắp hương hỏi thần linh.\nEmily 20 tuổi truyền thần dụ cho bạn.',
    },
    'sj_pick_date': { AppLanguage.korean: '날짜 선택', AppLanguage.english: 'Pick Date', AppLanguage.chinese: '选择日期', AppLanguage.japanese: '日付を選ぶ', AppLanguage.vietnamese: 'Chọn ngày' },
    'sj_pick_time': { AppLanguage.korean: '시간 선택', AppLanguage.english: 'Pick Time', AppLanguage.chinese: '选择时间', AppLanguage.japanese: '時間を選ぶ', AppLanguage.vietnamese: 'Chọn giờ' },
    'sj_calendar_type': { AppLanguage.korean: '양력/음력', AppLanguage.english: 'Calendar Type', AppLanguage.chinese: '阳历/阴历', AppLanguage.japanese: '太陽暦/太陰暦', AppLanguage.vietnamese: 'Dương/Lịch âm' },
    'sj_query_hint': {
      AppLanguage.korean: '예) 올해 연애운이 어떨까요? 이직해도 될까요?',
      AppLanguage.english: 'e.g. How\'s my love life this year? Should I change jobs?',
      AppLanguage.chinese: '例）今年爱情运如何？可以换工作吗？',
      AppLanguage.japanese: '例）今年の恋愛運は？転職していい？',
      AppLanguage.vietnamese: 'VD: Tình duyên năm nay thế nào? Có nên đổi việc?',
    },
    'sj_ritual_loading': {
      AppLanguage.korean: '신령님이 내려오고 있어요... 🕯️',
      AppLanguage.english: 'The spirits are descending... 🕯️',
      AppLanguage.chinese: '神灵正在降临... 🕯️',
      AppLanguage.japanese: '神霊が降りてきています... 🕯️',
      AppLanguage.vietnamese: 'Thần linh đang giáng... 🕯️',
    },
    'sj_oracle_title': {
      AppLanguage.korean: '신령님의 공수',
      AppLanguage.english: "Spirit Oracle",
      AppLanguage.chinese: '神谕',
      AppLanguage.japanese: '神託',
      AppLanguage.vietnamese: 'Thần dụ',
    },
    'shaman_summon': { AppLanguage.korean: '신령님을 부르는 중...', AppLanguage.english: 'Summoning...', AppLanguage.chinese: '请神...', AppLanguage.japanese: '降霊...', AppLanguage.vietnamese: 'Gọi thần...' },
    'sj_ritual_1': { AppLanguage.korean: '향을 피웁니다...', AppLanguage.english: 'Incense...', AppLanguage.chinese: '焚香...', AppLanguage.japanese: '香...', AppLanguage.vietnamese: 'Hương...' },
    'sj_ritual_2': { AppLanguage.korean: '방울을 흔듭니다...', AppLanguage.english: 'Bell...', AppLanguage.chinese: '摇铃...', AppLanguage.japanese: '鈴...', AppLanguage.vietnamese: 'Chuông...' },
    'sj_ritual_3': { AppLanguage.korean: '공수가 내립니다!', AppLanguage.english: 'Message!', AppLanguage.chinese: '神谕!', AppLanguage.japanese: 'お告げ!', AppLanguage.vietnamese: 'Lời thần!' },
    'sj_result_title': { AppLanguage.korean: '신령님의 공수', AppLanguage.english: 'Spirit Message', AppLanguage.chinese: '神谕', AppLanguage.japanese: '神のお告げ', AppLanguage.vietnamese: 'Lời thần' },
  };

  static const Map<AppLanguage, String> _serverLang = {
    AppLanguage.korean: '한국어',
    AppLanguage.english: 'English',
    AppLanguage.chinese: '中文',
    AppLanguage.japanese: '日本語',
    AppLanguage.vietnamese: 'Vietnamese',
  };

  static const Map<AppLanguage, String> _langMenuKey = {
    AppLanguage.korean: 'lang_korean',
    AppLanguage.english: 'lang_english',
    AppLanguage.chinese: 'lang_chinese',
    AppLanguage.japanese: 'lang_japanese',
    AppLanguage.vietnamese: 'lang_vietnamese',
  };

  static String get(String key, AppLanguage lang) {
    return _values[key]?[lang] ?? key;
  }

  /// API 서버가 기대하는 언어 코드 (예: "한국어", "English")
  static String getServerLang(AppLanguage lang) {
    return _serverLang[lang] ?? '한국어';
  }

  /// 언어 선택 메뉴 표시명
  static String getLangDisplayName(AppLanguage lang, AppLanguage uiLang) {
    final key = _langMenuKey[lang];
    if (key == null) return lang.name;
    return get(key, uiLang);
  }

  @Deprecated('Use getServerLang instead')
  static String getLangName(AppLanguage lang) {
    return getServerLang(lang);
  }

  /// 주제 라벨 → tier1 JSON 키 매핑
  static String topicToTier1Key(String topicLabel, AppLanguage lang) {
    final pairs = [
      ('topic_love', 'love'),
      ('topic_money', 'money'),
      ('topic_work', 'work'),
      ('topic_health', 'health'),
    ];
    for (final pair in pairs) {
      if (topicLabel == get(pair.$1, lang)) return pair.$2;
    }
    return 'work';
  }
}
