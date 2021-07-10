# Find ✨
> 2nd SOPT-TERM 2021.05.07 ~ 2021.05.30

<img width=100% src=https://user-images.githubusercontent.com/42789819/125160498-2c654b00-e1b8-11eb-8657-7372f0019c70.png>

<br />
<br />

### `Find` 는 이런 서비스입니다!  

난 직접 만나봐야 더 진국이야.  
의미있고 가치있는 만남   
안전한 MBTI 기반 매칭 오프라인 소개팅    

<img src="https://user-images.githubusercontent.com/71601985/120090436-7b41ae80-c13d-11eb-9bb7-45910ea128a6.png" width=20%>


<br/>
<br/>

### 🪜 Development Environment and Using Library
![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg) ![iOS](https://img.shields.io/badge/Platform-iOS-black.svg)

```swift
  pod 'Moya'
  pod 'Kingfisher'
  pod 'lottie-ios'
```
<br/>

### 🗂 Project Structure

```
💻 Find-iOS
 ┣ 🗂 Global
 ┃ ┣ 🗂 Extension
 ┃ ┃ ┗ 📑 UIFont+Extension.swift
 ┃ ┃ ┗ 📑 UIColor+Extension.swift
 ┃ ┃ ┗ 📑 UIView+Extension.swift
 ┃ ┃ ┗ 📑 UIBotton+Extension.swift
 ┃ ┃ ┗ 📑 UILabel+Extension.swift
 ┃ ┃ ┗ 📑 UIDevice+Extension.swift
 ┃ ┃ ┗ 📑 UITextField+Extension.swift
 ┃ ┃ ┗ 📑 UIViewController+Extension.swift
 ┃ ┣ 🗂 Model
 ┃ ┃ ┗ 📑 GenericResponse.swift
 ┃ ┃ ┗ 📑 PlainData.swift
 ┃ ┗ 🗂 Service
 ┃ ┃ ┗ 📑 APIService.swift
 ┃ ┃ ┗ 📑 APITarget.swift
 ┃ ┃ ┗ 📑 NetworkResult.swift
 ┣ 🗂 Screen
 ┃ ┣ 🗂 FindFound
 ┃ ┃ ┣ 🗂 Cell
 ┃ ┃ ┃ ┗ 📑 FindFoundSegueCVC.swift
 ┃ ┃ ┣ 🗂 Storyboard
 ┃ ┃ ┃ ┗ 📑 FindFound.storyboard
 ┃ ┃ ┗ 🗂 ViewController
 ┃ ┃ ┃ ┗ 📑 FindFoundVC.swift
 ┃ ┃ ┗ 🗂 View
 ┃ ┃ ┃ ┗ 📑 FindView.xib
 ┃ ┃ ┃ ┗ 📑 FindView.swift
 ┃ ┃ ┗ 🗂 Model
 ┃ ┃ ┃ ┗ 📑 ProfileCardDataModel.swift
 ┃ ┣ 🗂 MatchingStatus
 ┃ ┣ 🗂 ValueTest
 ┃ ┣ 🗂 YourProfile
 ┃ ┣ 🗂 Interview
 ┃ ┣ 🗂 MyProfile
 ┃ ┣ 🗂 ProfileWriting
 ┃ ┣ 🗂 TabBar
 ┃ ┃    .
 ┃ ┃    .
 ┃ ┃    .
 ┃ ┃
 ┗ 🗂 Support
 ┃ ┣ 🗂 Font
 ┃ ┣ 🗂 Assets.xcassets
 ┃ ┣ 📑 LaunchScreen.storyboard
 ┃ ┣ 📑 AppDelegate.swift
 ┃ ┣ 📑 SceneDelegate.swift
 ┃ ┗ 📑 Info.plist
 ┗ 🗂 Find-iOS.xcodeproj
```
  
<br/>

### 🔖 Convention, Strategy

* Github mangement
  - Main 브랜치에 릴리즈 버전 관리
  - Develop 브랜치에 개발 중인 버전 관리
  - Feat/`이슈번호` 브랜치에서 기능 구현  
    <img src="https://user-images.githubusercontent.com/71601985/119228433-f7406300-bb4d-11eb-857c-79eb18f6ff64.png" width = 60%>

<br/>

* Commit Messge Rules
  ```
    - init : 초기화 
    - feat : 기능 추가 
    - update : 기능 보완 (업그레이드)
    - fix : 버그 수정 
    - refactor: 리팩토링 
    - style : 스타일 (코드 형식, 세미콜론 추가: 비즈니스 로직에 변경 없음) 
    - docs : 문서 (문서 추가(Add), 수정, 삭제) 
    - test : 테스트 (테스트 코드 추가, 수정, 삭제: 비즈니스 로직에 변경 없음) 
    - chore : 기타 변경사항 (빌드 스크립트 수정, 에셋 추가 등)
  ```

<br />

### 👨‍👩‍👧‍👧 Find iOS Developers

| 사진 |<img src="https://user-images.githubusercontent.com/71601985/120094091-4fccbd00-c159-11eb-89e6-ed984bfb093c.png" width=200>|<img src="https://user-images.githubusercontent.com/71601985/120094088-4a6f7280-c159-11eb-9922-43d4e1ef4b64.png" width=200>|<img src="https://user-images.githubusercontent.com/71601985/120094090-4d6a6300-c159-11eb-975b-164db3a81a7e.png" width=200>|<img src="https://user-images.githubusercontent.com/71601985/120094093-522f1700-c159-11eb-82bb-774552d28edd.png" width=200>|
|:---:|:---:|:---:|:---:|:---:|
| 이름 |박세은|이다은|이원석|장서현|
| gitHub |<a href="https://github.com/pk33n">pk33n<a>|<a href="https://github.com/Daeun-Danna-Lee">Daeun-Danna-Lee<a>|<a href="https://github.com/snowedev">snowedev<a>|<a href="https://github.com/seohyun-106">seohyun-106<a>|

  
<br/>
  
### 💻 Task
> 솝텀 기간 내에 구현된 부분(서비스 전체❌)

| 우선 순위 | 구분 | 상세 | 담당자 | 폴더 /파일 이름 | 완료 |
| :----: | :----: | :----: | :----: | :----: | :----: |
|`p1`|`스플래시`|스플래시|이다은|LaunchScreen| ✅ |
|`p1`|`탭바`|탭바 연결|이원석|TabBar| ✅ |
|`p1`|`마이페이지`|프로필 작성/수정|박세은|ProfileWriting| ✅ |
|`p1`|`마이페이지`|내 프로필|이원석|MyProfile| ✅ |
|`p1`|`마이페이지`|인터뷰|이원석|Interview| ✅ |
|`p1`|`상대찾기`|Find/Found|장서현|FindFound| ✅ |
|`p1`|`상대찾기`|매칭 로딩 로티|이다은|MatchingLottie| ✅ |
|`p1`|`상대찾기`|가치관 문답 설문|이다은|ValueTest| ✅ |
|`p1`|`상대찾기`|선택된 가치관 보기|이다은|ValueTest| ✅ |
|`p1`|`상대찾기`|상대 프로필 보기|장서현|YourProfile| ✅ |
|`p1`|`상대찾기`|상대의 같은/다른 가치관 보기|이다은|YourProfile| ✅ |
|`p2`|`매칭현황`|매칭현황 탭(호감/찜)|이원석|MatchingStatus| ✅ |

  
<br/>

### 👀 View Description
> Not yet..

<!-- 
**뷰 이름**  
\- 설명  
<img src="" width=30%> -->
