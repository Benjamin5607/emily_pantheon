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
    'tarot_topic': { AppLanguage.korean: '1. 주제 선택', AppLanguage.english: '1. Topic', AppLanguage.chinese: '1. 主题', AppLanguage.japanese: '1. テーマ', AppLanguage.vietnamese: '1. Chủ đề' },
    'timeframe': { AppLanguage.korean: '2. 기간 선택', AppLanguage.english: '2. Time', AppLanguage.chinese: '2. 时间', AppLanguage.japanese: '2. 期間', AppLanguage.vietnamese: '2. Thời gian' },
    'label_query': { AppLanguage.korean: '3. 상세 고민', AppLanguage.english: '3. Question', AppLanguage.chinese: '3. 问题', AppLanguage.japanese: '3. 悩み', AppLanguage.vietnamese: '3. Câu hỏi' },
    'tarot_pick': { AppLanguage.korean: '카드 3장 선택', AppLanguage.english: 'Pick 3 Cards', AppLanguage.chinese: '请选3张', AppLanguage.japanese: '3枚選んで', AppLanguage.vietnamese: 'Chọn 3 lá' },
    'tarot_hint_query': {
      AppLanguage.korean: '구체적으로 적으면 AI가,\n짧게 적으면 에밀리 노트가 답해요.',
      AppLanguage.english: 'Detailed query calls AI.\nShort query calls Basic Note.',
      AppLanguage.chinese: '详细问题由AI回答，\n简短问题由艾米丽笔记回答。',
      AppLanguage.japanese: '詳しく書くとAIが、\n短く書くとエミリーノートが答えます。',
      AppLanguage.vietnamese: 'Câu hỏi chi tiết gọi AI.\nCâu ngắn dùng Ghi chú Emily.',
    },
    'tarot_loading': {
      AppLanguage.korean: '에밀리가 카드를 해석하고 있어요...',
      AppLanguage.english: 'Emily is reading the cards...',
      AppLanguage.chinese: '艾米丽正在解读卡牌...',
      AppLanguage.japanese: 'エミリーがカードを読んでいます...',
      AppLanguage.vietnamese: 'Emily đang đọc bài...',
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
      AppLanguage.korean: '에밀리가 당신 공간의 기운을 친구처럼 읽어드려요.',
      AppLanguage.english: 'Emily reads the energy of your space like a friend.',
      AppLanguage.chinese: '艾米丽像朋友一样解读你空间的能量。',
      AppLanguage.japanese: 'エミリーがあなたの空間の気を友達のように読み解きます。',
      AppLanguage.vietnamese: 'Emily đọc năng lượng không gian của bạn như một người bạn.',
    },
    'fs_birth_year': { AppLanguage.korean: '출생년도 (예: 1990)', AppLanguage.english: 'Birth Year (e.g. 1990)', AppLanguage.chinese: '出生年份（如1990）', AppLanguage.japanese: '生年（例: 1990）', AppLanguage.vietnamese: 'Năm sinh (vd: 1990)' },
    'fs_house_info': { AppLanguage.korean: '집 정보', AppLanguage.english: 'House Info', AppLanguage.chinese: '房屋信息', AppLanguage.japanese: '家の情報', AppLanguage.vietnamese: 'Thông tin nhà' },
    'fs_door_dir': { AppLanguage.korean: '현관 방향', AppLanguage.english: 'Front Door Direction', AppLanguage.chinese: '大门方向', AppLanguage.japanese: '玄関の方向', AppLanguage.vietnamese: 'Hướng cửa chính' },
    'fs_head_dir': { AppLanguage.korean: '잠잘 때 머리 방향', AppLanguage.english: 'Sleeping Head Direction', AppLanguage.chinese: '睡觉时头部方向', AppLanguage.japanese: '就寝時の頭の方向', AppLanguage.vietnamese: 'Hướng đầu khi ngủ' },
    'fs_location': { AppLanguage.korean: '거주 지역', AppLanguage.english: 'Location (City)', AppLanguage.chinese: '居住地区', AppLanguage.japanese: '居住地域', AppLanguage.vietnamese: 'Khu vực sống' },
    'fs_location_hint': { AppLanguage.korean: '예: 서울시 강남구', AppLanguage.english: 'e.g. Seoul, New York', AppLanguage.chinese: '例：首尔江南区', AppLanguage.japanese: '例: ソウル江南区', AppLanguage.vietnamese: 'vd: Seoul, Hà Nội' },
    'fs_query_hint': {
      AppLanguage.korean: '인테리어, 가구 배치 등 궁금한 점을 적어주세요.',
      AppLanguage.english: 'Ask about interior, layout, energy flow, etc.',
      AppLanguage.chinese: '请写下关于装修、家具摆放等问题。',
      AppLanguage.japanese: 'インテリア、家具配置など気になることを書いてください。',
      AppLanguage.vietnamese: 'Hỏi về nội thất, bố trí, dòng năng lượng, v.v.',
    },
    'fs_analyzing': {
      AppLanguage.korean: '에밀리가 기운을 읽고 있어요...',
      AppLanguage.english: 'Emily is reading the energy...',
      AppLanguage.chinese: '艾米丽正在解读能量...',
      AppLanguage.japanese: 'エミリーが気を読んでいます...',
      AppLanguage.vietnamese: 'Emily đang đọc năng lượng...',
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
      AppLanguage.korean: '신내림 받은 20살 에밀리가 신령님의 공수를 전해드려요.',
      AppLanguage.english: 'Emily, 20, spirit-initiated in Korea, delivers the oracle for you.',
      AppLanguage.chinese: '在韩国受神启的20岁艾米丽为你传达神谕。',
      AppLanguage.japanese: '韓国で神降ろしを受けた20歳のエミリーが神託を伝えます。',
      AppLanguage.vietnamese: 'Emily 20 tuổi, được thần giáng tại Hàn Quốc, truyền thần dụ.',
    },
    'sj_pick_date': { AppLanguage.korean: '날짜 선택', AppLanguage.english: 'Pick Date', AppLanguage.chinese: '选择日期', AppLanguage.japanese: '日付を選ぶ', AppLanguage.vietnamese: 'Chọn ngày' },
    'sj_pick_time': { AppLanguage.korean: '시간 선택', AppLanguage.english: 'Pick Time', AppLanguage.chinese: '选择时间', AppLanguage.japanese: '時間を選ぶ', AppLanguage.vietnamese: 'Chọn giờ' },
    'sj_calendar_type': { AppLanguage.korean: '양력/음력', AppLanguage.english: 'Calendar Type', AppLanguage.chinese: '阳历/阴历', AppLanguage.japanese: '太陽暦/太陰暦', AppLanguage.vietnamese: 'Dương/Lịch âm' },
    'sj_query_hint': {
      AppLanguage.korean: '무엇이 궁금해요? 편하게 적어주세요.',
      AppLanguage.english: 'What do you want to know? Write freely.',
      AppLanguage.chinese: '有什么想知道的？随意写下吧。',
      AppLanguage.japanese: '何が気になりますか？自由に書いてください。',
      AppLanguage.vietnamese: 'Bạn muốn biết gì? Cứ viết thoải mái.',
    },
    'sj_ritual_loading': {
      AppLanguage.korean: '에밀리가 신령님과 연결 중이에요...',
      AppLanguage.english: 'Emily is connecting with the spirits...',
      AppLanguage.chinese: '艾米丽正在与神灵连接...',
      AppLanguage.japanese: 'エミリーが神霊と繋がっています...',
      AppLanguage.vietnamese: 'Emily đang kết nối với thần linh...',
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
