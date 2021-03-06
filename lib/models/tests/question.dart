class Question {
  final int id;
  final String question;
  final List<String> options;

  Question(this.id, this.question, this.options);

  Question.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        question = json['question'],
        options = json['options'].cast<String>();

  Map<String, dynamic> toJson() =>
      {"id": id, "question": question, "options": options};
}

// Question List Model
class QuestionList {
  final List<Question> questions;

  QuestionList(this.questions);

  QuestionList.fromJson(List<dynamic> questionsJson)
      : questions = questionsJson
            .map((question) => Question.fromJson(question))
            .toList();
}

const List testMBTI = [
  {
    "id": 1,
    "question": "Trong một buổi tiệc, bạn sẽ:",
    "options": [
      "Nói chuyện với tất cả mọi người, kể cả người lạ",
      "Nói chuyện với những người bạn quen"
    ]
  },
  {
    "id": 2,
    "question": "Xu hướng nào trong bạn mạnh hơn?",
    "options": [
      "Hướng tới những điều thực tế và cụ thể",
      "Hướng tới các dự đoán trong tương lai"
    ]
  },
  // {
  //   "id": 3,
  //   "question": "Tình huống nào khiến bạn cảm thấy tệ hơn?",
  //   "options": ["Mọi thứ mông lung, không rõ ràng", "Nhàm chán, đơn điệu"]
  // },
  // {
  //   "id": 4,
  //   "question": "Bạn thấy ấn tượng bởi:",
  //   "options": ["Nguyên lý, nguyên tắc", "Cảm xúc, tình cảm"]
  // },
  // {
  //   "id": 5,
  //   "question": "Bạn có xu hướng nghiêng về:",
  //   "options": ["Những gì có tính thuyết phục", "Những gì cảm động"]
  // },
  // {
  //   "id": 6,
  //   "question": "Bạn thích làm việc:",
  //   "options": ["Theo thời hạn (deadline)", "Tùy hứng"]
  // },
  // {
  //   "id": 7,
  //   "question": "Khi lựa chọn, bạn thường:",
  //   "options": [
  //     "Khá cẩn thận, xem xét kĩ lưỡng",
  //     "Tin vào cảm giác lúc lựa chọn"
  //   ]
  // },
  // {
  //   "id": 8,
  //   "question": "Tại các buổi gặp mặt, bạn sẽ:",
  //   "options": [
  //     "Ở lại đến cuối buổi, càng lúc càng phấn khích",
  //     "Ra về sớm và cảm thấy mệt"
  //   ]
  // },
  // {
  //   "id": 9,
  //   "question": "Tuýp người nào sẽ thu hút bạn hơn?",
  //   "options": [
  //     "Người có đầu óc xét đoán, biết điều",
  //     "Người có khả năng tưởng tượng phong phú"
  //   ]
  // },
  // {
  //   "id": 10,
  //   "question": "Bạn hứng thú hơn với:",
  //   "options": ["Những việc thực tế xảy ra", "Những việc có khả năng xảy ra"]
  // },
  // {
  //   "id": 11,
  //   "question": "Khi đánh giá người khác, bạn thường:",
  //   "options": ["Dựa trên các quy định, luật lệ", "Dựa trên hoàn cảnh cụ thể"]
  // },
  // {
  //   "id": 12,
  //   "question": "Khi tiếp cận người khác, bạn nghiêng về:",
  //   "options": ["Tiếp cận khách quan", "Tiếp cận cá nhân"]
  // },
  // {
  //   "id": 13,
  //   "question": "Phong cách đúng với bạn hơn?",
  //   "options": ["Đúng giờ", "Nhàn nhã, thoải mái"]
  // },
  // {
  //   "id": 14,
  //   "question": "Bạn bồn chồn khi có những việc:",
  //   "options": ["Chưa hoàn thiện", "Đã hoàn thiện"]
  // },
  // {
  //   "id": 15,
  //   "question": "Bạn là người:",
  //   "options": [
  //     "Luôn nắm bắt kịp thời thông tin về các vấn đề của mọi người",
  //     "Thường biết thông tin sau"
  //   ]
  // },
  // {
  //   "id": 16,
  //   "question": "Với các công việc thông thường, bạn nghiêng về cách:",
  //   "options": ["Làm theo cách thông thường", "Làm theo cách của riêng mình"]
  // },
  // {
  //   "id": 17,
  //   "question": "Theo bạn, các nhà văn nên:",
  //   "options": [
  //     "Viết những gì họ nghĩ, và nghĩ những gì họ viết, một cách rõ ràng",
  //     "Diễn đạt sự việc bằng cách so sánh, liên tưởng"
  //   ]
  // },
  // {
  //   "id": 18,
  //   "question": "Điều gì lôi cuốn bạn hơn:",
  //   "options": [
  //     "Sự nhất quán về tư duy, suy nghĩ",
  //     "Sự hòa hợp trong các mối quan hệ con người"
  //   ]
  // },
  // {
  //   "id": 19,
  //   "question": "Bạn cảm thấy thoải mái hơn khi đưa ra nhận xét:",
  //   "options": ["Một cách logic", "Một cách có ý nghĩa, có giá trị"]
  // },
  // {
  //   "id": 20,
  //   "question": "Bạn thích những điều:",
  //   "options": ["Được định trước", "Chưa được quyết định"]
  // },
  // {
  //   "id": 21,
  //   "question": "Bạn là người:",
  //   "options": ["Nghiêm túc và quyết đoán", "Dễ tính, thoải mái"]
  // },
  // {
  //   "id": 22,
  //   "question": "Khi nói chuyện điện thoại, bạn:",
  //   "options": [
  //     "Hiếm khi băn khoăn đến những điều mình sẽ nói",
  //     "Thường chuẩn bị trước những điều mình sẽ nói"
  //   ]
  // },
  // {
  //   "id": 23,
  //   "question": "Theo bạn, 'các sự việc, sự kiện':",
  //   "options": [
  //     "Bản thân nó giải thích cho chính nó",
  //     "Nó là bằng chứng giải thích cho các quy tắc, quy luật"
  //   ]
  // },
  // {
  //   "id": 24,
  //   "question": "Những người có tầm nhìn xa:",
  //   "options": [
  //     "Ở mức độ nào đó, họ thường gây khó chịu cho người khác",
  //     "Khá thú vị"
  //   ]
  // },
  // {
  //   "id": 25,
  //   "question": "Bạn là người:",
  //   "options": ["Có cái đầu lạnh", "Có trái tim ấm"]
  // },
  // {
  //   "id": 26,
  //   "question": "Điều nào tồi tệ hơn:",
  //   "options": ["Không công bằng", "Tàn nhẫn"]
  // },
  // {
  //   "id": 27,
  //   "question": "Mọi người nên để các sự kiện xảy ra:",
  //   "options": [
  //     "Theo sự lựa chọn và cân nhắc kĩ lưỡng",
  //     "Diễn ra ngẫu nhiên, tự nhiên"
  //   ]
  // },
  // {
  //   "id": 28,
  //   "question": "Bạn cảm thấy thoải mái hơn khi:",
  //   "options": ["Đã mua một thứ gì đó", "Có khả năng và có sự lựa chọn để mua"]
  // },
  // {
  //   "id": 29,
  //   "question": "Trong công ty, bạn là người:",
  //   "options": [
  //     "Khởi xướng các câu chuyện",
  //     "Đợi người khác khởi xướng để nói chuyện"
  //   ]
  // },
  // {
  //   "id": 30,
  //   "question": "Những logic được mọi người chấp nhận, bạn sẽ:",
  //   "options": [
  //     "Tin tưởng vào những điều đó và không nghi ngờ",
  //     "Xem xét lại tính đúng đắn của những điều đó"
  //   ]
  // },
  // {
  //   "id": 31,
  //   "question": "Trẻ em thường không:",
  //   "options": [
  //     "Tự mình phát huy hết năng lực",
  //     "Thỏa mãn hết trí tưởng tượng của mình"
  //   ]
  // },
  // {
  //   "id": 32,
  //   "question": "Khi đưa ra các quyết định, bạn thiên về:",
  //   "options": ["Các tiêu chuẩn, quy định", "Cảm xúc, cảm nhận"]
  // },
  // {
  //   "id": 33,
  //   "question": "Bạn nghiêng về tính cách:",
  //   "options": ["Chắc chắn hơn là nhẹ nhàng", "Nhẹ nhàng hơn là chắc chắn"]
  // },
  // {
  //   "id": 34,
  //   "question": "Khả năng nào đáng khâm phục hơn:",
  //   "options": [
  //     "Khả năng tổ chức và làm việc có phương pháp",
  //     "Khả năng thích ứng và xoay xở trước mọi tình huống"
  //   ]
  // },
  // {
  //   "id": 35,
  //   "question": "Bạn đề cao:",
  //   "options": ["Sự chắc chắn", "Sự cởi mở"]
  // },
  // {
  //   "id": 36,
  //   "question": "Đối mặt với những vấn đề mới, bạn thường",
  //   "options": ["Thấy kích thích và hào hứng", "Cảm thấy mệt mỏi"]
  // },
  // {
  //   "id": 37,
  //   "question": "Thường thì bạn là:",
  //   "options": ["Người thực tế", "Người có khả năng tưởng tượng phong phú"]
  // },
  // {
  //   "id": 38,
  //   "question": "Bạn thường có xu hướng xem người khác:",
  //   "options": [
  //     "Có thể làm được việc gì hữu ích",
  //     "Xem người khác sẽ nghĩ và cảm nhận như thế nào"
  //   ]
  // },
  // {
  //   "id": 39,
  //   "question": "Bạn cảm thấy thoải mái hơn khi:",
  //   "options": [
  //     "Thảo luận một vân đề kĩ lưỡng, triệt để",
  //     "Đạt được thỏa thuận, sự nhất trí về vấn đề"
  //   ]
  // },
  // {
  //   "id": 40,
  //   "question": "Cái đầu hay trái tim chi phối bạn nhiều hơn",
  //   "options": ["Cái đầu", "Trái tim"]
  // },
  // {
  //   "id": 41,
  //   "question": "Bạn thích công việc:",
  //   "options": [
  //     "Được giao trọn gói, làm xong hết rồi bàn giao",
  //     "Công việc làm hàng ngày, theo lịch"
  //   ]
  // },
  // {
  //   "id": 42,
  //   "question": "Bạn có xu hướng tìm kiếm những điều:",
  //   "options": ["Theo trật tự, thứ tự", "Ngẫu nhiên"]
  // },
  // {
  //   "id": 43,
  //   "question": "Bạn thích kiểu nào hơn:",
  //   "options": [
  //     "Nhiều bạn bè với mức độ tiếp xúc ngắn gọn",
  //     "Một vài bạn thân với mức độ tiếp xúc sâu"
  //   ]
  // },
  // {
  //   "id": 44,
  //   "question": "Bạn thường dựa vào:",
  //   "options": ["Sự kiện, thông tin", "Nguyên lí, nguyên tắc"]
  // },
  // {
  //   "id": 45,
  //   "question": "Bạn hứng thú với việc gì hơn:",
  //   "options": ["Sản xuất và phân phối", "Thiết kế, nghiên cứu"]
  // },
  // {
  //   "id": 46,
  //   "question": "Bạn thích được khen là:",
  //   "options": ["Một người có logic rất tốt", "Một người rất tình cảm, tinh tế"]
  // },
  // {
  //   "id": 47,
  //   "question": "Bạn thấy điều nào ở mình giá trị hơn:",
  //   "options": ["Kiên định, vững vàng", "Toàn tâm, cống hiến"]
  // },
  // {
  //   "id": 48,
  //   "question": "Bạn thường thích:",
  //   "options": [
  //     "Một tuyên bố cuối cùng, không thay đổi",
  //     "Một tuyên bố dự kiến, ban đầu"
  //   ]
  // },
  // {
  //   "id": 49,
  //   "question": "Bạn thấy thoải mái hơn:",
  //   "options": ["Trước khi đưa ra quyết định", "Sau khi đưa ra quyết định"]
  // },
  // {
  //   "id": 50,
  //   "question": "Bạn có thấy mình:",
  //   "options": [
  //     "Dễ dàng bắt chuyện với người lạ",
  //     "Có ít điều để nói với người lạ"
  //   ]
  // },
  // {
  //   "id": 51,
  //   "question": "Bạn có xu hướng tin tưởng vào",
  //   "options": ["Kinh nghiệm của mình", "Linh cảm của mình"]
  // },
  // {
  //   "id": 52,
  //   "question": "Bạn cho mình là người như thế nào?",
  //   "options": [
  //     "Là người thực tế hơn là khéo léo, mưu trí",
  //     "Là người khéo léo, mưu trí hơn là thực tế"
  //   ]
  // },
  // {
  //   "id": 53,
  //   "question": "Theo bạn ai sẽ là người đáng được khen ngợi:",
  //   "options": ["Một người giàu lý trí", "Một người giàu cảm xúc"]
  // },
  // {
  //   "id": 54,
  //   "question": "Bạn có xu hướng nhiều hơn về:",
  //   "options": ["Công bằng, vô tư", "Thông cảm, đồng cảm"]
  // },
  // {
  //   "id": 55,
  //   "question": "Mọi việc sẽ hợp lý hơn nếu:",
  //   "options": ["Được chuẩn bị trước", "Diễn ra tự nhiên"]
  // },
  // {
  //   "id": 56,
  //   "question": "Mọi việc:",
  //   "options": [
  //     "Có thể nói chuyện để giải quyết được",
  //     "Nên để mọi việc diễn ra ngẫu nhiên theo điều kiện hoàn cảnh"
  //   ]
  // },
  // {
  //   "id": 57,
  //   "question": "Khi chuông điện thoại reo, bạn sẽ:",
  //   "options": [
  //     "Là người đầu tiên nhấc máy để nghe",
  //     "Hi vọng có người khác sẽ nhấc máy"
  //   ]
  // },
  // {
  //   "id": 58,
  //   "question": "Bạn đánh giá cao điều gì trong mình hơn:",
  //   "options": [
  //     "Cảm nhận tốt các yếu tố thực tế",
  //     "Trí tưởng tượng phong phú, rực rỡ"
  //   ]
  // },
  // {
  //   "id": 59,
  //   "question": "Bạn sẽ chú tâm hơn đến:",
  //   "options": ["Các nguyên tắc, nguyên lý cơ bản", "Các ngụ ý, hàm ý, ẩn ý"]
  // },
  // {
  //   "id": 60,
  //   "question": "Bạn không thích những người:",
  //   "options": ["Quá nồng nhiệt, thiết tha", "Quá khách quan"]
  // },
  // {
  //   "id": 61,
  //   "question": "Bạn sẽ đánh giá mình là người thế nào?",
  //   "options": ["Thiết thực, ít bị chi phối bởi tình cảm", "Từ tâm, đa cảm"]
  // },
  // {
  //   "id": 62,
  //   "question": "Tình huống nào sẽ lôi cuốn bạn:",
  //   "options": [
  //     "Tình huống rõ ràng, có kế hoạch",
  //     "Tình huống không xác định, không có kế hoạch"
  //   ]
  // },
  // {
  //   "id": 63,
  //   "question": "Bạn là người có xu hướng nào hơn:",
  //   "options": ["Theo thói quen", "Hay thay đổi"]
  // },
  // {
  //   "id": 64,
  //   "question": "Bạn có xu hướng:",
  //   "options": ["Là người dễ tiếp cận", "Ở mức độ nào đó là người kín đáo"]
  // },
  // {
  //   "id": 65,
  //   "question": "Khi viết, bạn thích:",
  //   "options": [
  //     "Viết theo hướng văn chương hơn",
  //     "Viết theo số liệu, dữ liệu hơn"
  //   ]
  // },
  // {
  //   "id": 66,
  //   "question": "Điều gì khó thực hiện hơn:",
  //   "options": ["Hiểu và chia sẻ với người khác", "Sử dụng người khác"]
  // },
  // {
  //   "id": 67,
  //   "question": "Bạn mong ước mình sẽ có thêm:",
  //   "options": ["Lí trí suy xét rõ ràng", "Tình thương, lòng trắc ẩn sâu sắc"]
  // },
  // {
  //   "id": 68,
  //   "question": "Điều gì sẽ là lỗi lớn hơn:",
  //   "options": [
  //     "Hành động bừa bãi, không cân nhắc",
  //     "Hành động chỉ trích, phê phán"
  //   ]
  // },
  {
    "id": 69,
    "question": "Bạn sẽ thích:",
    "options": ["Sự kiện có kế hoạch trước", "Sự kiện không có kế hoạch trước"]
  },
  {
    "id": 70,
    "question": "Bạn thiên về xu hướng hành động:",
    "options": ["Cân nhắc thận trọng", "Tự nhiên, tự phát"]
  }
];

const List testHolland = [
  {
    "id": 1,
    "question": "Tôi có tính tự lập",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 2,
    "question": "Tôi suy nghĩ thực tế",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 3,
    "question": "Tôi là người thích nghi với môi trường mới",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 4,
    "question": "Tôi có thể vận hành, điều khiển các máy móc thiết bị",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 5,
    "question": "Tôi làm các công việc thủ công như gấp giấy, đan, móc",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 6,
    "question": "Tôi thích tiếp xúc với thiên nhiên, động vật, cây cỏ",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 7,
    "question": "Tôi thích những công việc sử dụng tay chân hơn là trí óc",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 8,
    "question": "Tôi thích những công việc thấy ngay kết quả",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 9,
    "question":
        "Tôi thích làmviệc ngoài trời hơn là trong phòng học, văn phòng",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 10,
    "question": "Tôi có tìm hiểu khám phá nhiều vấn đề mới",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 11,
    "question": "Tôi có khả năng phân tích vấn đề",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 12,
    "question": "Tôi biết suy nghĩ một cách mạch lạc, chặt chẽ",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 13,
    "question": "Tôi thích thực hiện các thí nghiệm hay nghiên cứu",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 14,
    "question": "Tôi có khả năng tổng hợp, khái quát, suy đoán những vấn đề",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 15,
    "question":
        "Tôi thích những hoạt động điều tra, phân loại, kiểm tra, đánh giá",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 16,
    "question": "Tôi tự tổ chức công việc mình phái làm",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 17,
    "question":
        "Tôi thích suy nghĩ về những vấn đề phức tạp, làm những công việc phức tạp",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 18,
    "question": "Tôi có khả năng giải quyết các vấn đề",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 19,
    "question": "Tôi là người dễ xúc động",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 20,
    "question": "Tôi có óc tưởng tượng phong phú",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 21,
    "question": "Tôi thích sự tự do, không theo những quy định , quy tắc",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 22,
    "question": "Tôi có khả năng thuyết trình, diễn xuất",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 23,
    "question": "Tôi có thể chụp hình hoặc vẽ tranh, trang trí, điêu khắc",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 24,
    "question": "Tôi có năng khiếu âm nhạc",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 25,
    "question": "Tôi có khả năng viết, trình bày những ý tưởng của mình",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 26,
    "question":
        "Tôi thích làm những công việc mới, những công việc đòi hỏi sự sáng tạo",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 27,
    "question": "Tôi thoải mái bộc lộ những ý thích",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 28,
    "question": "Tôi là người thân thiện, hay giúp đỡ người khác",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 29,
    "question": "Tôi thích gặp gỡ, làm việc với con người",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 30,
    "question": "Tôi là người lịch sự, tử tế",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 31,
    "question":
        "Tôi thích khuyên bảo, huấn luyện hay giảng giái cho người khác",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 32,
    "question": "Tôi là người biệt lắng nghe",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 33,
    "question":
        "Tôi thích các hoạt động chăm sóc sức khỏe của bản thân và người khác",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 34,
    "question":
        "Tôi thích các hoạt độngvì mục tiêu chung của công đồng, xã hội",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 35,
    "question": "Tôi mong muốn mình có thể đóng góp để xã hội tốt đẹp hơn",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 36,
    "question": "Tôi có khả năng hòa giải, giải quyết những sự viêc mâu thuẫn",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 37,
    "question": "Tôi là người có tính phiêu lưu, mạo hiểm",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 38,
    "question": "Tôi có tính quyết đoán",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 39,
    "question": "Tôi là người năng động",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 40,
    "question":
        "Tôi có khả năng diễn đạt, tranh luận, và thuyết phục người khác",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 41,
    "question": "Tôi thíc các việc quản lý, đánh giá",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 42,
    "question": "Tôi thường đặt ra các mục tiêu, kế hoạch trong cuộc sống",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 43,
    "question": "Tôi thích gây ảnh hưởng đến người khác",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 44,
    "question":
        "Tôi là người thích cạnh tranh, và muốn mình giói hơn người khác",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 45,
    "question": "Tôi muốn người khác phải kính trọng, nể phục tôi",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 46,
    "question": "Tôi là người có đầu óc sắp xếp, tổ chức",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 47,
    "question": "Tôi có tính cẩn thận",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 48,
    "question": "Tôi là người chu đáo, chính xác và đáng tin cậy",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 49,
    "question": "Tôi thích công việc tính toán sổ sách, ghi chép số liệu",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 50,
    "question": "Tôi thíc các công việc lưu trữ, phân loại, cập nhất thông tin",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 51,
    "question": "Tôi thường đặt ra những mục tiêu, kế hoạch trong cuộc sống",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 52,
    "question": "Tôi thích dự kiến các khoản thu chi",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 53,
    "question": "Tôi thích lập thời khóa biểu, sắp xếp lịch làm việc",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  },
  {
    "id": 54,
    "question":
        "Tôi thích làm việc với các con số, làm việc theo hướng dẫn, quy trình",
    "options": [
      "Rất đúng",
      "Hầu như đúng",
      " Bình thường",
      "Hầu như không đúng",
      "Không đúng"
    ]
  }
];
