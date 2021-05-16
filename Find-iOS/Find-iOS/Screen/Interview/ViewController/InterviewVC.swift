//
//  InterviewVC.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/10.
//

import UIKit
import Photos

class InterviewVC: UIViewController {
    
    enum InterviewCategory {
        case pros, love, taste, life
    }
    var currentCategory: InterviewCategory?
    var beforeInterviewData = interviewQuestions // 저장 전 인터뷰 답변 데이터
    var beforeInterviewImgs = interviewImgs // 저장 전 이미지 데이터
    var receivedInt : Int? // 선택된 이미지의 인덱스 값 - preview View에서 사용하기 위함
    let picker = UIImagePickerController()
    
    @IBOutlet weak var interviewCV: UICollectionView!{
        didSet{
            interviewCV.delegate = self
            interviewCV.dataSource = self
            interviewCV.register(InterviewCVCell.nib(), forCellWithReuseIdentifier: InterviewCVCell.idientifier)
            interviewCV.register(InterviewPhotoCVCell.nib(), forCellWithReuseIdentifier: InterviewPhotoCVCell.identifier)
            interviewCV.register(photoPreviewCVCell.nib(), forCellWithReuseIdentifier: photoPreviewCVCell.identifier)
        }
    }
    @IBOutlet var segueIndicatiorView: [UIView]!
    @IBOutlet var segueBtns: [UIButton]!
    @IBOutlet var swipeRecognizer: UISwipeGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        setUPNoti()
        setSegueStyle()
        addGesture()
        whatSelected(seg: .pros, idx: 0)
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        // viewDidLoad()시 내용과 viewWillDisappear() 내용이 다르면 Alert Show 같으면 그냥 pop
        let alert =  UIAlertController(title: "저장하시겠습니까?", message: nil, preferredStyle: .alert)
        let yes = UIAlertAction(title: "예", style: .default) { [self] (action) in
            self.navigationController?.popViewController(animated: true)
        }
        let no = UIAlertAction(title: "아니오", style: .cancel) { [self] (action) in
            interviewQuestions = beforeInterviewData
            interviewImgs = beforeInterviewImgs
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(no)
        alert.addAction(yes)
        
        if interviewQuestions != beforeInterviewData || interviewImgs != beforeInterviewImgs {
            present(alert, animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    @IBAction func saveBtnTapped(_ sender: Any) {
        // 저장되었습니다 토스트
    }
    @IBAction func prosBtnTapped(_ sender: Any) {
        whatSelected(seg: .pros, idx: 0)
    }
    @IBAction func loveBtnTapped(_ sender: Any) {
        whatSelected(seg: .love, idx: 1)
    }
    @IBAction func tasteBtnTapped(_ sender: Any) {
        whatSelected(seg: .taste, idx: 2)
    }
    @IBAction func lifeBtnTapped(_ sender: Any) {
        whatSelected(seg: .life, idx: 3)
    }
    @IBAction func swipeAction(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .left{
            print("left")
            switch currentCategory {
            case .pros:
                whatSelected(seg: .love, idx: 1)
            case .love:
                whatSelected(seg: .taste, idx: 2)
            case .taste:
                whatSelected(seg: .life, idx: 3)
            case .life:
                return
            default:
                return
            }
        }
        if sender.direction == .right{
            print("right")
            switch currentCategory {
            case .pros:
                return
            case .love:
                whatSelected(seg: .pros, idx: 0)
            case .taste:
                whatSelected(seg: .love, idx: 1)
            case .life:
                whatSelected(seg: .taste, idx: 2)
            default:
                return
            }
        }
    }
}


extension InterviewVC {
    // MARK: - Segue Styles
    func setSegueStyle() {
        segueBtns[0].setTitle("장점", for: .normal)
        segueBtns[0].setTitleColor(.subGray2, for: .normal)
        
        segueBtns[1].setTitle("연애", for: .normal)
        segueBtns[1].setTitleColor(.subGray2, for: .normal)
        
        segueBtns[2].setTitle("호불호", for: .normal)
        segueBtns[2].setTitleColor(.subGray2, for: .normal)
        
        segueBtns[3].setTitle("라이프", for: .normal)
        segueBtns[3].setTitleColor(.subGray2, for: .normal)
    }
    
    // MARK: - 세그 좌,우 스와이프 제스쳐로 이동
    func addGesture() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(_:)))
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(_:)))
        
        swipeRight.direction = .right
        swipeLeft.direction = .left
 
        self.interviewCV.addGestureRecognizer(swipeRight)
        self.interviewCV.addGestureRecognizer(swipeLeft)
    }
    
    // MARK: - Remind Me Selected Segue
    func whatSelected(seg: InterviewCategory, idx: Int){
        if currentCategory != seg {
            currentCategory = seg
            for i in 0..<4{
                if i == idx{
                    segueIndicatiorView[i].backgroundColor = .find_Purple
                    segueBtns[i].setTitleColor(.find_Purple, for: .normal)
                }else{
                    segueIndicatiorView[i].backgroundColor = .subGray1
                    segueBtns[i].setTitleColor(.subGray2, for: .normal)
                }
            }
            interviewCV.scrollToItem(at: IndexPath(index: 0), at: .top, animated: true)
            UIView.performWithoutAnimation {
                if let collectionView = self.interviewCV {
                    collectionView.reloadSections(IndexSet(0...2))
                }
            }
        }
    }
    
    // MARK: - Set Up Notification
    func setUPNoti(){
        NotificationCenter.default.addObserver(self, selector: #selector(showPhotoSheet), name: NSNotification.Name(rawValue:"showPhotoSheet"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(changePhoto), name: NSNotification.Name(rawValue:"changePhoto"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(dataReceived), name: NSNotification.Name(rawValue:"previewImageNoti"), object: nil)
    }
    
    // 화면 터치시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // 액션시트 - 사진 추가
    @objc func showPhotoSheet() {
        /// 사진을 앞에서부터 차례대로 넣기 위해 사진 선택 인덱스 값 초기화
        receivedInt = nil
        let alert =  UIAlertController(title: "인터뷰 사진 추가", message: nil, preferredStyle: .actionSheet)
        let library =  UIAlertAction(title: "앨범에서 사진 선택", style: .default) { (action) in self.openPhotoLibrary()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(library)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    // 액션시트 - 사진 변경 및 삭제
    @objc func changePhoto() {
        let alert =  UIAlertController(title: "인터뷰 사진 변경", message: nil, preferredStyle: .actionSheet)
        let library =  UIAlertAction(title: "앨범에서 사진 선택", style: .default) { [self] (action) in openPhotoLibrary()
        }
        let deletePhoto =  UIAlertAction(title: "삭제", style: .default) { [self] (action) in
            switch currentCategory {
            case .pros:
                interviewImgs[0].images.remove(at: receivedInt!)
            case .love:
                interviewImgs[1].images.remove(at: receivedInt!)
            case .taste:
                interviewImgs[2].images.remove(at: receivedInt!)
            case .life:
                interviewImgs[3].images.remove(at: receivedInt!)
            default:
                return
            }
            if receivedInt! != 0 { receivedInt! -= 1 }
            interviewCV.reloadSections(IndexSet(1...2))
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(library)
        alert.addAction(deletePhoto)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    // NotificationCenter를 이용해 데이터 전달 받기(receivedInt)
    @objc func dataReceived(notification : NSNotification)
    {
        let receivedData = notification.object as? Int
        if receivedData != receivedInt {
            receivedInt = receivedData
            interviewCV.reloadSections(IndexSet(2...2))
        }
    }
    
    // MARK: - Open Photo Library
    func openPhotoLibrary() {
        /// 사진 접근 권한이 허용되었는지 검사
        switch PHPhotoLibrary.authorizationStatus() {
        /// 권한이 거부된 경우
        case .denied:
            print("denied")
            /// 설정창에서 권한을 재설정 하게끔 유도한다
            if let appName = Bundle.main.infoDictionary!["CFBundleName"] as? String {
                let alert = UIAlertController(title: "설정", message: "\(appName)의 사진 접근 권한이\n허용되어 있지 않습니다.\n설정에서 변경 가능합니다.", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "취소", style: .default) { (action) in
                    
                }
                let confirmAction = UIAlertAction(title: "설정", style: .default) { (action) in
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                }
                
                alert.addAction(cancelAction)
                alert.addAction(confirmAction)
                self.present(alert, animated: true, completion: nil)
            }
        /// restricted
        case .restricted:
            print("restricted")
            break
        /// 권한이 허용된 경우
        case .authorized:
            print("authorized")
            picker.sourceType = .photoLibrary
            picker.allowsEditing = true
            
            picker.modalPresentationStyle = .fullScreen
            present(picker, animated: true, completion: nil)
        /// 권한 허용을 묻기 전인 경우 (최초 1회)
        case .notDetermined:
            print("notDetermined")
            PHPhotoLibrary.requestAuthorization({ state in
                if state == .authorized {
                    DispatchQueue.main.async {
                        self.picker.sourceType = .photoLibrary
                        self.picker.allowsEditing = true
                        
                        self.picker.modalPresentationStyle = .fullScreen
                        self.present(self.picker, animated: true, completion: nil)
                    }
                } else {
                    DispatchQueue.main.async {
                        if let appName = Bundle.main.infoDictionary!["CFBundleName"] as? String {
                            let alert = UIAlertController(title: "설정", message: "\(appName)의 사진 접근 권한이\n허용되어 있지 않습니다.\n설정에서 변경 가능합니다.", preferredStyle: .alert)
                            let cancelAction = UIAlertAction(title: "취소", style: .default) { (action) in
                                
                            }
                            let confirmAction = UIAlertAction(title: "설정", style: .default) { (action) in
                                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                            }
                            
                            alert.addAction(cancelAction)
                            alert.addAction(confirmAction)
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                    //                        self.dismiss(animated: true, completion: nil)
                }
            })
        default:
            print("break")
            break
        }
    }
}

// MARK: - Protocols
extension InterviewVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // 선택된 이미지를 각 카테고리에 맞게 구조체에 아카이빙
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            
            func addImage(idx: Int) {
                if receivedInt != nil {
                    interviewImgs[idx].images[receivedInt!] = image
                } else {
                    interviewImgs[idx].images.append(image)
                }
            }
            
            /// 선택된 사진의 idx를 이용하여 사진 변경
            switch currentCategory {
            case .pros:
                addImage(idx: 0)
            case .love:
                addImage(idx: 1)
            case .taste:
                addImage(idx: 2)
            case .life:
                addImage(idx: 3)
            default:
                return
            }
        }
        interviewCV.reloadSections(IndexSet(1...2))
        dismiss(animated: true, completion: nil)
    }
}

extension InterviewVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            switch currentCategory {
            case .pros,.taste:
                return 4
            case .love,.life:
                return 5
            case .none:
                return 0
            }
        } else {
            return 1
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InterviewCVCell.idientifier, for: indexPath) as? InterviewCVCell else { return UICollectionViewCell() }
            
            /// 선택 카테고리에 따른 질문 및 답변 셋팅
            func setQandA(curCat: String, curIdx: Int){
                cell.curCategory = curCat
                cell.questionNumLabel.text = "Q.\(indexPath.row+1)"
                cell.questionTitleLabel.text = interviewQuestions[curIdx].question
                cell.answerTextField.text = interviewQuestions[curIdx].answer
            }
            
            switch currentCategory {
            case .pros:
                setQandA(curCat: "pros", curIdx: indexPath.row)
            case .love:
                setQandA(curCat: "love", curIdx: indexPath.row+4)
            case .taste:
                setQandA(curCat: "taste", curIdx: indexPath.row+9)
            case .life:
                setQandA(curCat: "life", curIdx: indexPath.row+13)
            case .none:
                return UICollectionViewCell()
            }
            return cell
            
        } else if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InterviewPhotoCVCell.identifier, for: indexPath) as? InterviewPhotoCVCell else { return UICollectionViewCell() }
            
            /// 선택 카테고리에 따른 이미지 셋팅
            func setInterviewImage(_ ctgNum: Int){
                cell.interviewImages?.forEach{
                    $0.image = nil
                }
                for (idx,img) in interviewImgs[ctgNum].images.enumerated() {
                    cell.interviewImages?[idx].image = img
                }
            }
            
            switch currentCategory {
            case .pros:
                setInterviewImage(0)
            case .love:
                setInterviewImage(1)
            case .taste:
                setInterviewImage(2)
            case .life:
                setInterviewImage(3)
            default:
                return UICollectionViewCell()
            }
            return cell
            
        } else if indexPath.section == 2 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoPreviewCVCell.identifier, for: indexPath) as? photoPreviewCVCell else { return UICollectionViewCell() }
            
            /// 선택된 인덱스 값에 따라 미리보기 이미지 전환
            func setPreviewImage(_ ctgNum: Int){
                if interviewImgs[ctgNum].images.count > 0 {
                    if receivedInt != nil {
                        cell.previewImageView.image = interviewImgs[ctgNum].images[receivedInt!]
                    } else {
                        cell.previewImageView.image = interviewImgs[ctgNum].images.last
                        receivedInt = interviewImgs[ctgNum].images.count - 1
                    }
                    /// 사진이 있으면 수정버튼 활성화
                    cell.editBtn.isHidden = false
                }else{
                    cell.previewImageView.image = nil
                    /// 사진이 없으면 수정버튼 비활성화
                    cell.editBtn.isHidden = true
                }
            }
            switch currentCategory {
            case .pros:
                setPreviewImage(0)
            case .love:
                setPreviewImage(1)
            case .taste:
                setPreviewImage(2)
            case .life:
                setPreviewImage(3)
            default:
                return UICollectionViewCell()
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    //MARK: - Cell 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            return CGSize(width: view.frame.width-32, height: 100)
        } else if indexPath.section == 1 {
            return CGSize(width: view.frame.width-32, height: 70)
        } else if indexPath.section == 2 {
            return CGSize(width: view.frame.width-32, height: collectionView.frame.width-32 )
        }
        
        return CGSize(width: 0, height: 0)
    }
    
    //MARK: - Cell간의 상하간격 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if section == 0 {
            return 16
        }else {
            return 0
        }
    }
    
    //MARK: - 마진
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        if section == 0 || section == 1{
            return UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
        } else if section == 2 {
            return UIEdgeInsets(top: 24, left: 0, bottom: 36, right: 0)
        }
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
