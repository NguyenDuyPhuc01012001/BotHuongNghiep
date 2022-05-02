import '../models/jobs/jobs.dart';
import '../models/news/news.dart';

class StaticValues {
  List<News> news = [
    News(
        title:
            "Top Cryptocurrentcy Prices Today: Bitcoin, Binance Coin up; Dogecoin surges 25",
        description:
            "New Delhi: Major cryptocurrencies were trading higher on Friday. Eight out of the top 10 digital tokens were trading with solid gains at 9.30 hours IST, led by Dogecoin which gained as much as 25 per cent.The heads of some of the world’s biggest cryptocurrency exchanges say Bitcoin miners are shifting operations out of China as authorities intensify their crackdown on the space. China’s moves had injected uncertainty into the cryptocurrency market and helped pull Bitcoin down.",
        image:
            "https://images.unsplash.com/photo-1605792657660-596af9009e82?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=991&q=80",
        source: "The Economic Times",
        sourceImage:
            "https://yt3.ggpht.com/ytc/AAUvwngucVKXeH6T2_0PfZbyB2XJ3Toff5CfTnZ1alshs_4=s900-c-k-c0x00ffffff-no-rj",
        time: "Today, 8:28 AM"),
    News(
        title:
            "Covid-19: ICMR studying vaccine effect on Delta plus, result likely soon",
        image:
            "https://static.toiimg.com/thumb/msid-83804061,imgsize-56060,width-400,resizemode-4/83804061.jpg",
        source: "Times of India",
        sourceImage: "https://static.toiimg.com/photo/47529300.cms",
        time: "3 Days Ago",
        description:
            "PUNE: Experts from the Indian Council of Medical Research are currently examining how effective vaccines available in the country are against the Delta-plus varient of SARS-COV-2. Dr Samiran Panda, an ICMR scientist, said the research body is closely monitoring neutralisation capabilities of antibodies drawn from vaccine recipients."),
    News(
        title: "Covid shaves off household savings for 2nd straight quarter",
        image:
            "https://images.indianexpress.com/2021/06/rupee-bloomberg-1200-2.jpg",
        source: "Indian Express",
        sourceImage:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYl2TxpCA39qFBqA2U2vVYj005OIalFxAwkg&usqp=CAU",
        time: "4 Days Ago",
        description:
            "With Covid playing havoc, financial savings of households, especially bank deposits and equity investments, are on the decline. The Reserve bank of India’s preliminary estimate of household financial savings is at 8.2 per cent of GDP in the third quarter of 2020-21, exhibiting a sequential moderation for the second consecutive quarter after having spiked in the pandemic-hit first quarter of 2020-21.")
  ];

  List<Jobs> jobs = [
    Jobs(
        title: "Kỹ sư phần mềm",
        image:
            "https://topdev.vn/blog/wp-content/uploads/2020/07/ky-thuat-phan-mem-la-gi.jpg",
        time: "3 minutes ago",
        description:
            "Kỹ sư phần mềm (Software Engineer) là những người có kiến thức sâu rộng về ngôn ngữ lập trình, phát triển phần mềm, hệ điều hành máy tính. Ứng dụng những nguyên tắc, công nghệ trong từng giai đoạn phát triển phần mềm (Software Development Life Cycle), họ tạo ra sản phẩm phần mềm và các hệ thống khác trên máy tính. Các kỹ sư phần mềm sử dụng các kĩ thuật toán học, khoa học, công nghệ, thiết kế và thường phải kiểm tra, đánh giá phần mềm của mình hoặc của người khác. Kỹ sư phần mềm thường có bằng cấp về khoa học máy tính. Họ có kĩ năng phân tích và giải quyết vấn đề. Ngoài ra, họ luôn muốn chủ động trong tìm kiếm, học hỏi những kiến thức mới và có kĩ năng giao tiếp."),
    Jobs(
        title: "Nhà quản lý sản phẩm (PM)",
        image:
            "https://lh6.googleusercontent.com/JS-mLzZJl0ytmFiXn9fC3E-L8fIvBbodzaMGkFcfH2I-QPVoGZl0O33AEVQ-mV9AlmTYSf_z3eOjjEjtoRRsfLy23qUQE8Hq4tnkBBu71V_PjyDerUI8h7F51Blbi9hqpXBTCMp8",
        time: "2 days ago",
        description:
            "Product Manager (PM) (Tạm dịch: Giám đốc sản phẩm, hay Chuyên viên quản lý sản phẩm) là người chịu trách nhiệm cho việc nghiên cứu, khai thác nhu cầu, thiết kế, thử nghiệm và xây dựng các chiến lược hiệu quả để quản lý và phát triển sản phẩm, dịch vụ, hoặc phần mềm cho doanh nghiệp."),
    Jobs(
        title: "Kỹ sư BlockChain",
        image:
            "https://itguru.vn/blog/wp-content/uploads/2018/04/ung_dung_blockchain.jpeg.webp",
        time: "1 month ago",
        description:
            "Lập trình viên blockchain là người chịu trách nhiệm phát triển và cải tiến các ứng dụng liên quan đến blockchain, nổi tiếng là dApps (Decentralized Applications), hợp đồng thông minh (smart contract), thiết kế kiến trúc và giao thức blockchain. Họ cũng xử lý mô hình 3D, thiết kế 3D, phát triển nội dung 3D, chẳng hạn như trong phát triển game."),
    Jobs(
        title: "Người quản lý sản phẩm (PO)",
        image:
            "https://itguru.vn/blog/wp-content/uploads/2018/04/ung_dung_blockchain.jpeg.webp",
        time: "21 days ago",
        description:
            "Trong Scrum, Product Owner (PO) một thành viên rất quan trọng trong team, chịu trách nhiệm mọi mặt về sản phẩm như lập kế hoạch, lựa chọn tính năng, giải quyết vấn đề từ phía user. Nhiệm vụ của Product Owner là tối ưu hóa giá trị của sản phẩm thông qua việc tận dụng tốt nhất khả năng sản xuất của Nhà Phát Triển (Scrum Team). Trong một dự án Agile, Product Owner sẽ là đại diện cho nhóm Scrum để đứng giữa doanh nghiệp, user và khách hàng.")
  ];
}
