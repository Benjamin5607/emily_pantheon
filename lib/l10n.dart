enum AppLanguage { korean, english, chinese, japanese, vietnamese }

class AppLocalizations {
  static final Map<String, Map<AppLanguage, String>> _values = {
    // --- [공통 버튼] ---
    // 🔥 [수정됨] 앱 타이틀 변경
    'title': { 
      AppLanguage.korean: '에밀리 : 만신전', 
      AppLanguage.english: "Emily's Pantheon", 
      AppLanguage.chinese: "Emily's Pantheon", 
      AppLanguage.japanese: "Emily's Pantheon", 
      AppLanguage.vietnamese: "Emily's Pantheon" 
    },
    'btn_start': { AppLanguage.korean: '시작하기', AppLanguage.english: 'Start', AppLanguage.chinese: '开始', AppLanguage.japanese: '開始', AppLanguage.vietnamese: 'Bắt đầu' },
    'btn_next': { AppLanguage.korean: '다음', AppLanguage.english: 'Next', AppLanguage.chinese: '下一步', AppLanguage.japanese: '次へ', AppLanguage.vietnamese: 'Tiếp' },
    'btn_analyze': { AppLanguage.korean: '결과 보기', AppLanguage.english: 'Analyze', AppLanguage.chinese: '分析', AppLanguage.japanese: '鑑定', AppLanguage.vietnamese: 'Phân tích' },
    'btn_reveal': { AppLanguage.korean: '운명 확인', AppLanguage.english: 'Reveal', AppLanguage.chinese: '揭示', AppLanguage.japanese: '確認', AppLanguage.vietnamese: 'Xem' },
    'btn_reset': { AppLanguage.korean: '처음으로', AppLanguage.english: 'Reset', AppLanguage.chinese: '重置', AppLanguage.japanese: '最初に戻る', AppLanguage.vietnamese: 'Làm lại' },

    // --- [탭 이름] ---
    'tab_tarot': { AppLanguage.korean: '타로', AppLanguage.english: 'Tarot', AppLanguage.chinese: '塔罗', AppLanguage.japanese: 'タロット', AppLanguage.vietnamese: 'Tarot' },
    'tab_fengshui': { AppLanguage.korean: '풍수', AppLanguage.english: 'Feng Shui', AppLanguage.chinese: '风水', AppLanguage.japanese: '風水', AppLanguage.vietnamese: 'Phong Thủy' },
    'tab_saju': { AppLanguage.korean: '신점', AppLanguage.english: 'Shaman', AppLanguage.chinese: '神占', AppLanguage.japanese: '神占い', AppLanguage.vietnamese: 'Thần Bói' },

    // --- [1. 타로 화면] ---
    'tarot_topic': { AppLanguage.korean: '1. 주제 선택', AppLanguage.english: '1. Topic', AppLanguage.chinese: '1. 主题', AppLanguage.japanese: '1. テーマ', AppLanguage.vietnamese: '1. Chủ đề' },
    'timeframe': { AppLanguage.korean: '2. 기간 선택', AppLanguage.english: '2. Time', AppLanguage.chinese: '2. 时间', AppLanguage.japanese: '2. 期間', AppLanguage.vietnamese: '2. Thời gian' },
    'label_query': { AppLanguage.korean: '3. 상세 고민', AppLanguage.english: '3. Question', AppLanguage.chinese: '3. 问题', AppLanguage.japanese: '3. 悩み', AppLanguage.vietnamese: '3. Câu hỏi' },
    'tarot_pick': { AppLanguage.korean: '카드 3장 선택', AppLanguage.english: 'Pick 3 Cards', AppLanguage.chinese: '请选3张', AppLanguage.japanese: '3枚選んで', AppLanguage.vietnamese: 'Chọn 3 lá' },

    // 타로 선택지
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

    // --- [2. 풍수 화면] ---
    'fs_step1': { AppLanguage.korean: '기본 정보', AppLanguage.english: 'Info', AppLanguage.chinese: '信息', AppLanguage.japanese: '情報', AppLanguage.vietnamese: 'Thông tin' },
    'fs_step2': { AppLanguage.korean: '상담 목적', AppLanguage.english: 'Purpose', AppLanguage.chinese: '目的', AppLanguage.japanese: '目的', AppLanguage.vietnamese: 'Mục đích' },
    'fs_step3': { AppLanguage.korean: '공간 정보', AppLanguage.english: 'Space', AppLanguage.chinese: '空间', AppLanguage.japanese: '空間', AppLanguage.vietnamese: 'Không gian' },
    
    'label_name': { AppLanguage.korean: '이름', AppLanguage.english: 'Name', AppLanguage.chinese: '姓名', AppLanguage.japanese: '名前', AppLanguage.vietnamese: 'Tên' },
    'label_birth': { AppLanguage.korean: '생년월일', AppLanguage.english: 'Birth', AppLanguage.chinese: '生日', AppLanguage.japanese: '誕生日', AppLanguage.vietnamese: 'Ngày sinh' },
    'label_gender': { AppLanguage.korean: '성별', AppLanguage.english: 'Gender', AppLanguage.chinese: '性别', AppLanguage.japanese: '性別', AppLanguage.vietnamese: 'Giới tính' },
    'label_addr': { AppLanguage.korean: '주소', AppLanguage.english: 'Address', AppLanguage.chinese: '地址', AppLanguage.japanese: '住所', AppLanguage.vietnamese: 'Địa chỉ' },
    'label_fam': { AppLanguage.korean: '가족구성', AppLanguage.english: 'Family', AppLanguage.chinese: '家庭', AppLanguage.japanese: '家族', AppLanguage.vietnamese: 'Gia đình' },
    'label_door': { AppLanguage.korean: '현관방향', AppLanguage.english: 'Door Dir', AppLanguage.chinese: '大门', AppLanguage.japanese: '玄関', AppLanguage.vietnamese: 'Cửa' },
    'label_floor': { AppLanguage.korean: '층수', AppLanguage.english: 'Floor', AppLanguage.chinese: '楼层', AppLanguage.japanese: '階', AppLanguage.vietnamese: 'Tầng' },
    'label_structure': { AppLanguage.korean: '구조', AppLanguage.english: 'Structure', AppLanguage.chinese: '结构', AppLanguage.japanese: '構造', AppLanguage.vietnamese: 'Cấu trúc' },

    'male': { AppLanguage.korean: '남성', AppLanguage.english: 'Male', AppLanguage.chinese: '男', AppLanguage.japanese: '男性', AppLanguage.vietnamese: 'Nam' },
    'female': { AppLanguage.korean: '여성', AppLanguage.english: 'Female', AppLanguage.chinese: '女', AppLanguage.japanese: '女性', AppLanguage.vietnamese: 'Nữ' },
    'purpose_live': { AppLanguage.korean: '거주 점검', AppLanguage.english: 'Live', AppLanguage.chinese: '居住', AppLanguage.japanese: '居住', AppLanguage.vietnamese: 'Sống' },
    'purpose_move': { AppLanguage.korean: '이사', AppLanguage.english: 'Move', AppLanguage.chinese: '搬家', AppLanguage.japanese: '引越', AppLanguage.vietnamese: 'Chuyển' },
    'purpose_biz': { AppLanguage.korean: '사업', AppLanguage.english: 'Biz', AppLanguage.chinese: '商业', AppLanguage.japanese: '事業', AppLanguage.vietnamese: 'Kinh doanh' },
    'north': { AppLanguage.korean: '북', AppLanguage.english: 'N', AppLanguage.chinese: '北', AppLanguage.japanese: '北', AppLanguage.vietnamese: 'Bắc' },
    'south': { AppLanguage.korean: '남', AppLanguage.english: 'S', AppLanguage.chinese: '南', AppLanguage.japanese: '南', AppLanguage.vietnamese: 'Nam' },
    'east': { AppLanguage.korean: '동', AppLanguage.english: 'E', AppLanguage.chinese: '东', AppLanguage.japanese: '東', AppLanguage.vietnamese: 'Đông' },
    'west': { AppLanguage.korean: '서', AppLanguage.english: 'W', AppLanguage.chinese: '西', AppLanguage.japanese: '西', AppLanguage.vietnamese: 'Tây' },

    // --- [3. 신점 화면] ---
    'sj_step1_title': { AppLanguage.korean: '기본 정보 (매개체)', AppLanguage.english: 'Basic Info', AppLanguage.chinese: '基本信息', AppLanguage.japanese: '基本情報', AppLanguage.vietnamese: 'Thông tin cơ bản' },
    'label_age': { AppLanguage.korean: '나이', AppLanguage.english: 'Age', AppLanguage.chinese: '年龄', AppLanguage.japanese: '年齢', AppLanguage.vietnamese: 'Tuổi' },
    'label_location_rough': { AppLanguage.korean: '거주지', AppLanguage.english: 'Region', AppLanguage.chinese: '居住地', AppLanguage.japanese: '居住地', AppLanguage.vietnamese: 'Nơi sống' },
    'label_reason_short': { AppLanguage.korean: '상담 이유', AppLanguage.english: 'Reason', AppLanguage.chinese: '理由', AppLanguage.japanese: '理由', AppLanguage.vietnamese: 'Lý do' },
    'shaman_summon': { AppLanguage.korean: '신령님을 부르는 중...', AppLanguage.english: 'Summoning...', AppLanguage.chinese: '请神...', AppLanguage.japanese: '降霊...', AppLanguage.vietnamese: 'Gọi thần...' },
    'sj_ritual_1': { AppLanguage.korean: '향을 피웁니다...', AppLanguage.english: 'Incense...', AppLanguage.chinese: '焚香...', AppLanguage.japanese: '香...', AppLanguage.vietnamese: 'Hương...' },
    'sj_ritual_2': { AppLanguage.korean: '방울을 흔듭니다...', AppLanguage.english: 'Bell...', AppLanguage.chinese: '摇铃...', AppLanguage.japanese: '鈴...', AppLanguage.vietnamese: 'Chuông...' },
    'sj_ritual_3': { AppLanguage.korean: '공수가 내립니다!', AppLanguage.english: 'Message!', AppLanguage.chinese: '神谕!', AppLanguage.japanese: 'お告げ!', AppLanguage.vietnamese: 'Lời thần!' },
    'sj_result_title': { AppLanguage.korean: '신령님의 공수', AppLanguage.english: 'Spirit Message', AppLanguage.chinese: '神谕', AppLanguage.japanese: '神のお告げ', AppLanguage.vietnamese: 'Lời thần' },
  };

  static String get(String key, AppLanguage lang) {
    return _values[key]?[lang] ?? key;
  }
  
  static String getLangName(AppLanguage lang) {
    return lang.toString().split('.').last;
  }
}