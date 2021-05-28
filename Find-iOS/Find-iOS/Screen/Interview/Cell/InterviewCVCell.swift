//
//  InterviewCVCell.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/17.
//

import UIKit
import Photos

class InterviewCVCell: UICollectionViewCell {
    static let identifier = "InterviewCVCell"
    
    let picker = UIImagePickerController()
    var currentCategory: InterviewCategory?
    var receivedInt : Int? // 선택된 이미지의 인덱스 값 - preview View에서 사용하기 위함
    
    @IBOutlet weak var innerInterviewCV: UICollectionView! {
        didSet {
            innerInterviewCV.delegate = self
            innerInterviewCV.dataSource = self
            innerInterviewCV.register(InterviewQestionCVCell.nib(), forCellWithReuseIdentifier: InterviewQestionCVCell.idientifier)
            innerInterviewCV.register(InterviewPhotoCVCell.nib(), forCellWithReuseIdentifier: InterviewPhotoCVCell.identifier)
            innerInterviewCV.register(photoPreviewCVCell.nib(), forCellWithReuseIdentifier: photoPreviewCVCell.identifier)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUPNoti()
        picker.delegate = self
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "InterviewCVCell", bundle: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}


extension InterviewCVCell {
    // MARK: - Set Up Notification
    func setUPNoti(){
        NotificationCenter.default.addObserver(self, selector: #selector(changeSegue), name: NSNotification.Name(rawValue:"changeSegue"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(scrollToTextField), name: NSNotification.Name(rawValue:"scrollToTextField"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showPhotoSheet), name: NSNotification.Name(rawValue:"showPhotoSheet"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(changePhoto), name: NSNotification.Name(rawValue:"changePhoto"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(dataReceived), name: NSNotification.Name(rawValue:"previewImageNoti"), object: nil)
    }
    
    // InterviewVC에서 세그 변경 감지
    @objc func changeSegue(notification: NSNotification) {
        let changeData = notification.object as? InterviewCategory
        currentCategory = changeData
        innerInterviewCV.reloadSections(IndexSet(0...2))
    }
    
    // 인터뷰 답변 입력시 해당 위치로 스크롤 이동
    @objc func scrollToTextField(notification: NSNotification) {
        guard let idx = notification.object as? Int else { return }
        innerInterviewCV.scrollToItem(at: IndexPath(row: idx, section: 0), at: .top, animated: true)
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
        self.parentViewController?.present(alert, animated: true, completion: nil)
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
            innerInterviewCV.reloadSections(IndexSet(1...2))
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(library)
        alert.addAction(deletePhoto)
        alert.addAction(cancel)
        self.parentViewController?.present(alert, animated: true, completion: nil)
    }
    
    // NotificationCenter를 이용해 데이터 전달 받기(receivedInt)
    @objc func dataReceived(notification : NSNotification)
    {
        let receivedData = notification.object as? Int
        if receivedData != receivedInt {
            receivedInt = receivedData
            innerInterviewCV.reloadSections(IndexSet(2...2))
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
                self.parentViewController?.present(alert, animated: true, completion: nil)
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
            self.parentViewController?.present(self.picker, animated: true, completion: nil)
        /// 권한 허용을 묻기 전인 경우 (최초 1회)
        case .notDetermined:
            print("notDetermined")
            PHPhotoLibrary.requestAuthorization({ state in
                if state == .authorized {
                    DispatchQueue.main.async {
                        self.picker.sourceType = .photoLibrary
                        self.picker.allowsEditing = true
                        
                        self.picker.modalPresentationStyle = .fullScreen
                        self.parentViewController?.present(self.picker, animated: true, completion: nil)
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
                            self.parentViewController?.present(alert, animated: true, completion: nil)
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
extension InterviewCVCell: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
        innerInterviewCV.reloadSections(IndexSet(1...2))
        self.parentViewController?.dismiss(animated: true, completion: nil)
    }
}

extension InterviewCVCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InterviewQestionCVCell.idientifier, for: indexPath) as? InterviewQestionCVCell else { return UICollectionViewCell() }
            /// 선택 카테고리에 따른 질문 및 답변 셋팅
            func setQandA(curCat: String, curIdx: Int){
                cell.idxRow = indexPath.row
                cell.curCategory = curCat
                cell.questionNumLabel.text = "Q.\(indexPath.row+1)"
                cell.questionTitleLabel.text = interviewQuestions[curIdx].question
                cell.answerTextView.text = interviewQuestions[curIdx].answer
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            innerInterviewCV.scrollToItem(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    // MARK: - Cell 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            return CGSize(width: collectionView.frame.width-32, height: 100)
        } else if indexPath.section == 1 {
            return CGSize(width: collectionView.frame.width-32, height: 70)
        } else if indexPath.section == 2 {
            return CGSize(width: collectionView.frame.width-32, height: collectionView.frame.width-32 )
        }
        
        return CGSize(width: 0, height: 0)
    }
    
    // MARK: - Cell간의 상하간격 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if section == 0 {
            return 16
        }else {
            return 0
        }
    }
    
    // MARK: - 마진
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
