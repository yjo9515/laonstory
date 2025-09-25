enum StatusCode { success, notFound, unAuthorized, badRequest, timeout, forbidden, error }

enum CommonStatus { initial, success, loading, failure }

enum UploadStatus { initial, success, loading, failure }

enum TokenStatus { initial, hasToken, noToken, guestToken }

enum SignUpStatus { initial, oauth, oauthSuccess, success, failure }

enum MyPageStatus { initial, profile, needs, done, failure }

enum FilterType { createdAt, price, payTime, serialNumber, out, active, amount }

enum OrderType { desc, asc }

enum NavRailItem { stat, user, event, pay, setting }

enum NavbarItem { home, myPage }

enum ColorType { first, second, text }

enum StatStatus { initial, success, typing, failure }

enum ViewType { list, detail }

enum Reaction { adopt, good, well }

enum DataType { gender, age, user, positive }

enum LoginStatus { login, logout }

enum Path { left, right }

enum TileType { first, second, third }

enum AlertType { notice, needs, like, comment }

enum BrandStatus { initial, add, addFailure, emotion, typeNeed, keyword, done, loading, needFailure }

enum TypingStatus { initial, typing, loading, keywords, done, fail }

enum DetailStatus { initial, success, edit, done, failure }

enum EmotionType { awesome, good, well, bad }

enum NeedsStatus { initial, done, fail }

enum ImageType { camera, gallery }

enum PositionEnum { all, member, delegate }

enum ChartType { user, point }

enum ChartDataType { increase, accrue }
