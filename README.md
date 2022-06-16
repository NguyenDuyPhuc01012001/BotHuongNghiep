# Bot Hướng Nghiệp

Bot Hướng Nghiệp là một ứng dụng cung cấp cho người dùng những thông tin về ngành Công nghệ thông tin, và Chatbot liên quan đến ngành Công nghệ thông tin

## Mục lục
- [1. Cài đặt](#caidat)
- [2. Danh sách chức năng](#chucnang)
- [3. Danh sách màn hình](#manhinh)
- [4. Liên hệ](#lienhe)

<a name="caidat"></a>
## Cài đặt

### Flutter

Bạn có thể cài đặt Flutter tại [đây](https://flutter.dev/?gclid=CjwKCAjw46CVBhB1EiwAgy6M4nTb2uy74066sKOHwFImW3CircIaI2uyjttAbwkPIhm2ostGPm27nRoC1AsQAvD_BwE&gclsrc=aw.ds)

### Firebase

Bạn có thể cài đặt Firebase tại [đây](https://firebase.flutter.dev/docs/overview/)

### Hướng dẫn cài đặt

```
$ git clone https://github.com/NguyenDuyPhuc01012001/BotHuongNghiep.git
$ cd BotHubNghiep
$ flutter pub get
$ flutter run lib/main.dart
```

<a name="chucnang"></a>
## Danh sách chức năng

Có hai vai trò chính trong ứng dụng:
1. Người dùng
2. Quản trị viên

Trong đó **người dùng** có thể thực hiện các chức năng như:
1. **Đăng ký**: Người dùng có thể đăng ký tài khoản nếu chưa có tài khoản
2. **Đăng nhập**: Người dùng có thể đăng nhập vào ứng dụng nếu đã có tài khoản
3. **Thay đổi mật khẩu**: Người dùng có thể thay đổi mật khấu nếu quên mật khẩu
4. **Làm bài kiểm tra**: Người dùng có thể thực hiện các bài kiểm tra về MBTI và Holland
5. **Xem thông tin trường nghề**: Người dùng có thể xem thông tin trường nghề về ngành công nghệ thông tin
6. **Xem tin tức**: Người dùng có thể xem tin tức liên quan tới công nghệ thông tin
7. **Giải đáp thắc mắc**: Người dùng có đặt câu hỏi cho quản trị viên cũng như phản hồi câu hỏi đó
8. **Yêu thích**: Người dùng có thể yêu thích một bài đăng trường nghề hoặc tin tức để xem lại trong tương lai
9. **Trò chuyện ChatBot**: Người dùng có thể trò chuyển với ChatBot để giáp đáp những thắc mắc liên quan tới ngành công nghệ thông tin
10. **Cập nhật thông tin**: Người dùng có thể cập nhật thông tin của mình

Ngoài những tính năng của **người dùng**, **quản trị viên** còn có thể thực hiện các chức năng sau:
1. **Quản lý vai trò tài khoản**: Quản trị viên có thể theo dõi và cập nhật vai trò của tài khoản trong hệ thống
2. **Quản lý bài đăng**: Quản trị viên có thể thêm, xoá, sửa cũng như xem thông tin bài đăng
3. **Quản lý tin tức**: Quản trị viên có thể thêm, xoá, sửa cũng như xem tin tức
4. **Quản lý thắc mắc**: Quản trị viên có xem và xoá các thắc mắc của người dùng

<a name="manhinh"></a>
## Danh sách màn hình

### Xác thực

Đăng nhập|Đăng ký|
:-------------------------:|:-------------------------:|
<img src="https://firebasestorage.googleapis.com/v0/b/huong-nghiep.appspot.com/o/app%2Flogin.jpg?alt=media&token=245b7d6c-d055-439a-89a3-f9b1fc9d2b62" width="200" />|<img src="https://firebasestorage.googleapis.com/v0/b/huong-nghiep.appspot.com/o/app%2Fsignup.jpg?alt=media&token=2540dae8-fdee-4e0b-ab69-74d6e48f8cbd" width="200" />|

### Trang chủ

Trắc nghiệm|Trường nghề|Tin tức|Giải đáp thắc mắc|
:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:|
<img src="https://firebasestorage.googleapis.com/v0/b/huong-nghiep.appspot.com/o/app%2Fquiz2.jpg?alt=media&token=8261db07-9292-455f-95ad-b852717a6ad1" width="200" />|<img src="https://firebasestorage.googleapis.com/v0/b/huong-nghiep.appspot.com/o/app%2Fjobscreen.jpg?alt=media&token=3beee52b-9fac-48df-86de-63121fcc8ef9" width="200" />|<img src="https://firebasestorage.googleapis.com/v0/b/huong-nghiep.appspot.com/o/app%2Fnewscreen.jpg?alt=media&token=27e60fa7-6b57-4a10-b8fe-9ea6e2e1ffa8" width="200" />|<img src="https://firebasestorage.googleapis.com/v0/b/huong-nghiep.appspot.com/o/app%2FqAsscreen.jpg?alt=media&token=8ec25063-13f5-4259-bd1f-c1fa0ce580bc" width="200" />|

### Chatbot
<img src="https://firebasestorage.googleapis.com/v0/b/huong-nghiep.appspot.com/o/app%2Fchatbot.jpg?alt=media&token=72c9ed53-cb3f-426b-99b3-b6b4b93fa8d5" width="200" />

### Quản lý

Quản lý vai trò|Quản lý bài đăng|Quản lý tin tức|Quản lý thắc mắc|
:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:|
<img src="https://firebasestorage.googleapis.com/v0/b/huong-nghiep.appspot.com/o/app%2FmanageAccount.jpg?alt=media&token=b1e982dc-836d-422c-b4d2-26f21c8e7533" width="200" />|<img src="https://firebasestorage.googleapis.com/v0/b/huong-nghiep.appspot.com/o/app%2FmanageJob.jpg?alt=media&token=8a4a1e39-e59a-443e-a8a6-ca6a0407e6d3" width="200" />|<img src="https://firebasestorage.googleapis.com/v0/b/huong-nghiep.appspot.com/o/app%2FmanageNews.jpg?alt=media&token=84116158-4a33-45a3-ba60-13e77a8d34b4" width="200" />|<img src="https://firebasestorage.googleapis.com/v0/b/huong-nghiep.appspot.com/o/app%2FmanageQaS.jpg?alt=media&token=a9a7aa67-d1d4-4b45-838f-ad81354abf1d" width="200" />|


<a name="lienhe"></a>
## Liên hệ

|STT|Họ và tên|MSSV|Contact|
|---|-------------------------|------------|-------|
|1|Nguyễn Duy Phúc|19522038|[duyphuc](https://github.com/NguyenDuyPhuc01012001)|
|2|Cao Nguyễn Minh Quân|19522074|[minhquan](https://github.com/minhquancn18)|
