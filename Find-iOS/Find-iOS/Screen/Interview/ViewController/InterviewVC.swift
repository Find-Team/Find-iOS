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
        whatSelected(seg: .pros, idx: 0)
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
    @IBAction func swipeAction(_ sender: Any) {
        if swipeRecognizer.direction == .left{
            print("left")
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
        if swipeRecognizer.direction == .right{
            print("right")
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
            interviewCV.reloadSections(IndexSet(0...2))
        }
    }
    
    // MARK: - Set Up Notification
    func setUPNoti(){
        NotificationCenter.default.addObserver(self, selector: #selector(openPhotoLibrary), name: NSNotification.Name(rawValue:"openPhotoLibrary"), object: nil)
    }
    
    // 화면 터치시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
//    @objc func getValue(_ notification: Notification){
//        let getValue = notification.object as! String
//        print(getValue)
//    }
    
    // MARK: - Open Photo Library
    @objc func openPhotoLibrary() {
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
            switch currentCategory {
            case .pros:
                interviewImgs[0].images.append(image)
            case .love:
                interviewImgs[1].images.append(image)
            case .taste:
                interviewImgs[2].images.append(image)
            case .life:
                interviewImgs[3].images.append(image)
            default:
                return
            }
        }
        interviewCV.reloadSections(IndexSet(1...1))
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
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    //MARK: - Cell 크기
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
