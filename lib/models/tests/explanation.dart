class Explanation {
  final String id, title, explanation;

  Explanation(this.id, this.title, this.explanation);

  Explanation.fromJson(Map<String, dynamic> json)
      : this.id = json['id'],
        this.title = json['title'],
        this.explanation = json['explanation'];

  Map<String, dynamic> toJson() =>
      {"id": this.id, "title": this.title, "explanation": this.explanation};
}

// Explanation List Model
class ExplanationList {
  final List<Explanation> explanations;
  ExplanationList(this.explanations);

  ExplanationList.fromJson(List<dynamic> explanationsJson)
      : explanations = explanationsJson
            .map((explanation) => Explanation.fromJson(explanation))
            .toList();
}

const List MBTI = [
  {
    "id": "E",
    "title": "Extroversion",
    "explanation":
        "Ưa thích hướng ngoại, cảm giác được thúc đẩy và giàu năng lượng dành cho những người xunh quanh"
  },
  {
    "id": "I",
    "title": "Introversion",
    "explanation":
        "Ưa thích hướng nội nên thường có xu hướng thích sự yên tĩnh, chỉ thích tương tác với những người bạn thân thiết. Việc tiếp xúc xã hội với những người không quen khiến họ tổn thất nhiều năng lượng"
  },
  {
    "id": "S",
    "title": "Sensing",
    "explanation":
        "Dùng cảm nhận cụ thể nhiều hơn là trực giác, vì vậy họ tập trung sự chú ý vào những chi tiết nhỏ nhặt hơn là bức tranh toàn cảnh, cũng như là những điều xảy ra ngay tại thực tại hơn là những thứ có thể đến trong tương lai"
  },
  {
    "id": "N",
    "title": "iNtuition",
    "explanation":
        "Dùng trực giác nhiều hơn là cảm nhận cụ thể, vì vậy họ tập trung sự chú ý vào bức tranh toàn cảnh hơn là những chi tiết nhỏ nhặt, cũng như là những điều có thể xảy ra trong tương lai hơn là chú ý vào thực tại"
  },
  {
    "id": "T",
    "title": "Thinking",
    "explanation":
        "Suy nghĩ lý trí hơn là cảm xúc, xu hướng coi trọng các tiêu chí khách quan hơn là sở thích cá nhân. Khi đưa ra một quyết định thì thường dựa vào sự logic hơn là yếu tố xã hội"
  },
  {
    "id": "F",
    "title": "Feeling",
    "explanation":
        "Đưa ra quyết định dựa vào cảm nhận, trạng thái cảm xúc tình cảm, giá trị cá nhân hơn là dựa vào các yếu tố khách quan hoặc quy luật logic"
  },
  {
    "id": "J",
    "title": "Judgement",
    "explanation":
        "Họ đánh giá một cách rất nguyên tắc và khả năng dự đoán của mình, sớm lập kế hoặch và tuân thủ theo nó thay vì là những quyết định tự phát, linh hoạt"
  },
  {
    "id": "P",
    "title": "Perception",
    "explanation":
        "Họ không vội đánh giá hay sớm ra một quyết định phán xét quan trọng nào đó , thay vào đó luôn nhìn nhận một cách linh hoạt vấn đề và có thể thay đổi tùy hoàn cảnh"
  }
];
const List Holland = [
  {
    "id": "R",
    "title": "Realistic",
    "explanation":
        "Khả năng: kỹ thuật, công nghệ, hệ thống; ưa thích làm việc với đồ vật, máy móc, động thực vật; thích làm các công việc ngoài trời.\nNgành nghề phù hợp: Các nghề về kiến trúc, an toàn lao động, nghề mộc, xây dựng, thủy sản, kỹ thuật, máy tàu thủy, lái xe, huấn luyện viên, nông – lâm nghiệp (quản lý trang trại, nhân giống cá, lâmnghiệp…), cơ khí (chế tạo máy, bảo trì và sữa chữa thiết bị, luyện kim, cơ khí ứng dụng, tự động...), điện - điện tử, địa lý - địa chất (đo đạc, vẽ bản đồ địa chính), dầu khí, hải dương học, quản lý công nghiệp..."
  },
  {
    "id": "I",
    "title": "Investigative",
    "explanation":
        "Họ không vội đánh giá hay sớm ra một quyết định phán xét quan trọng nào đó , thay vào đó luôn nhìn nhận một cách linh hoạt vấn đề và có thể thay đổi tùy hoàn cảnh"
  },
  {
    "id": "A",
    "title": "Artistic",
    "explanation":
        "Họ không vội đánh giá hay sớm ra một quyết định phán xét quan trọng nào đó , thay vào đó luôn nhìn nhận một cách linh hoạt vấn đề và có thể thay đổi tùy hoàn cảnh"
  },
  {
    "id": "S",
    "title": "Social",
    "explanation":
        "Họ không vội đánh giá hay sớm ra một quyết định phán xét quan trọng nào đó , thay vào đó luôn nhìn nhận một cách linh hoạt vấn đề và có thể thay đổi tùy hoàn cảnh"
  },
  {
    "id": "E",
    "title": "Enterprising",
    "explanation":
        "Họ không vội đánh giá hay sớm ra một quyết định phán xét quan trọng nào đó , thay vào đó luôn nhìn nhận một cách linh hoạt vấn đề và có thể thay đổi tùy hoàn cảnh"
  },
  {
    "id": "C",
    "title": "Conventional",
    "explanation":
        "Họ không vội đánh giá hay sớm ra một quyết định phán xét quan trọng nào đó , thay vào đó luôn nhìn nhận một cách linh hoạt vấn đề và có thể thay đổi tùy hoàn cảnh"
  }
];
