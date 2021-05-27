//
//  YourProfileVC.swift
//  Find-iOS
//


import UIKit

//enum InterviewCategory {
//    case pros, love, taste, life
//}
enum ProfileCategory {
    case pros, love, taste, life
}

class YourProfileVC: UIViewController {
    
    var currentCategory: ProfileCategory = .pros

    @IBOutlet weak var fulllScrollView: UIScrollView!
    @IBOutlet weak var imageScrollView: UIScrollView!
    @IBOutlet weak var imagePageControl: UIPageControl!
    @IBOutlet weak var starBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var criteriaView: UIView!
    @IBOutlet weak var criteriaLabel: UILabel!
    @IBOutlet weak var informationView: UIView!
    @IBOutlet weak var introductionView: UIView!
    @IBOutlet weak var introductionContentView: UIView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var informationLabel1: UILabel!
    @IBOutlet weak var informationLabel2: UILabel!
    @IBOutlet weak var interviewView: UIView!
    @IBOutlet weak var segueBtnStackView: UIStackView!
    @IBOutlet weak var segueProsBtn: UIButton!
    @IBOutlet weak var segueLoveBtn: UIButton!
    @IBOutlet weak var segueTasteBtn: UIButton!
    @IBOutlet weak var segueLifeBtn: UIButton!
    @IBOutlet var segueIndicator: [UIView]!
    @IBOutlet weak var segueInterviewCollectionView: UICollectionView!
    @IBOutlet weak var floatingLikeBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setButton()
        setSegueStyle()
        prosSelected()
        
        segueInterviewCollectionView.dataSource = self
        segueInterviewCollectionView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    // MARK: - IBAction

    @IBAction func backBtnClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func starBtnClicked(_ sender: Any) {
        if self.starBtn.isSelected == false {
            self.starBtn.isSelected = true
            self.starBtn.setImage(UIImage(named: "btnFoundStarMint"), for: .normal)
            showToast(message: "상대를 찜했습니다")
        }
        else {
            self.starBtn.isSelected = false
            self.starBtn.setImage(UIImage(named: "btnFoundStarMintLine"), for: .normal)
            showToast(message: "찜을 취소했습니다")
        }
    }
    
    @IBAction func prosBtnClicked(_ sender: Any) {
        prosSelected()
        segueInterviewCollectionView.reloadData()
    }
    
    @IBAction func loveBtnClicked(_ sender: Any) {
        loveSelected()
        segueInterviewCollectionView.reloadData()
    }
    
    @IBAction func tasteBtnClicked(_ sender: Any) {
        tasteSelected()
        segueInterviewCollectionView.reloadData()
    }
    
    @IBAction func lifeBtnClicked(_ sender: Any) {
        lifeSelected()
        segueInterviewCollectionView.reloadData()
    }
    
    @IBAction func floatingLikeBtnClicked(_ sender: Any) {
        floatingLikeBtn.setTitle("호감 보냄", for: .normal)
        floatingLikeBtn.isEnabled = false
    }
}

extension YourProfileVC {
    func setView() {
        introductionContentView.makeRounded(cornerRadius: 10)
    }
    
    func setButton() {
        floatingLikeBtn.backgroundColor = .find_DarkPurple
        floatingLikeBtn.makeRounded(cornerRadius: 10)
        floatingLikeBtn.setTitle("호감 보내기", for: .normal)
        floatingLikeBtn.setTitleColor(.white, for: .normal)
        floatingLikeBtn.titleLabel?.font = .spoqaMedium(size: 16)
    }
    
    func showToast(message : String, font: UIFont = UIFont.spoqaRegular(size: 14)) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 145, height: 35))
        toastLabel.backgroundColor = UIColor.find_DarkPurple.withAlphaComponent(0.5)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 15;
        toastLabel.clipsToBounds = true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: { toastLabel.alpha = 0.0 }, completion: {(isCompleted) in toastLabel.removeFromSuperview() })
    }
    
    func setSegueStyle() {
        segueProsBtn.setTitle("장점", for: .normal)
        segueProsBtn.setTitleColor(.subGray2, for: .normal)
        segueProsBtn.titleLabel?.font = .spoqaRegular(size: 14)
        
        segueLoveBtn.setTitle("연애", for: .normal)
        segueLoveBtn.setTitleColor(.subGray2, for: .normal)
        segueLoveBtn.titleLabel?.font = .spoqaRegular(size: 14)
        
        segueTasteBtn.setTitle("호불호", for: .normal)
        segueTasteBtn.setTitleColor(.subGray2, for: .normal)
        segueTasteBtn.titleLabel?.font = .spoqaRegular(size: 14)
        
        segueLifeBtn.setTitle("라이프", for: .normal)
        segueLifeBtn.setTitleColor(.subGray2, for: .normal)
        segueLifeBtn.titleLabel?.font = .spoqaRegular(size: 14)
        
        if segueIndicator.count == 4 {
            print("찍히나요?")
            segueIndicator[0].backgroundColor = .subGray1
            segueIndicator[1].backgroundColor = .subGray1
            segueIndicator[2].backgroundColor = .subGray1
            segueIndicator[3].backgroundColor = .subGray1
        }

    }
    
    func prosSelected() {
        currentCategory = .pros
        self.segueInterviewCollectionView.scrollToItem(at: NSIndexPath(item: 0, section: 0) as IndexPath, at: .left, animated: true)
        
        if segueIndicator.count == 4 {
            segueIndicator[0].backgroundColor = .find_Purple
            segueIndicator[1].backgroundColor = .subGray1
            segueIndicator[2].backgroundColor = .subGray1
            segueIndicator[3].backgroundColor = .subGray1
        }
        
        segueProsBtn.setTitle("장점", for: .normal)
        segueProsBtn.setTitleColor(.find_Purple, for: .normal)
        segueProsBtn.titleLabel?.font = .spoqaRegular(size: 14)
        
        segueLoveBtn.setTitleColor(.subGray2, for: .normal)
        segueTasteBtn.setTitleColor(.subGray2, for: .normal)
        segueLifeBtn.setTitleColor(.subGray2, for: .normal)
    }
    
    func loveSelected() {
        currentCategory = .love
        self.segueInterviewCollectionView.scrollToItem(at: NSIndexPath(item: 1, section: 0) as IndexPath, at: .left, animated: true)
        
        if segueIndicator.count == 4 {
            segueIndicator[0].backgroundColor = .subGray1
            segueIndicator[1].backgroundColor = .find_Purple
            segueIndicator[2].backgroundColor = .subGray1
            segueIndicator[3].backgroundColor = .subGray1
        }
        
        segueLoveBtn.setTitle("연애", for: .normal)
        segueLoveBtn.setTitleColor(.find_Purple, for: .normal)
        segueLoveBtn.titleLabel?.font = .spoqaRegular(size: 14)
        
        segueProsBtn.setTitleColor(.subGray2, for: .normal)
        segueTasteBtn.setTitleColor(.subGray2, for: .normal)
        segueLifeBtn.setTitleColor(.subGray2, for: .normal)
    }
    
    func tasteSelected() {
        currentCategory = .taste
        self.segueInterviewCollectionView.scrollToItem(at: NSIndexPath(item: 2, section: 0) as IndexPath, at: .left, animated: true)
        
        if segueIndicator.count == 4 {
            segueIndicator[0].backgroundColor = .subGray1
            segueIndicator[1].backgroundColor = .subGray1
            segueIndicator[2].backgroundColor = .find_Purple
            segueIndicator[3].backgroundColor = .subGray1
        }
        
        segueTasteBtn.setTitle("호불호", for: .normal)
        segueTasteBtn.setTitleColor(.find_Purple, for: .normal)
        segueTasteBtn.titleLabel?.font = .spoqaRegular(size: 14)
        
        segueProsBtn.setTitleColor(.subGray2, for: .normal)
        segueLoveBtn.setTitleColor(.subGray2, for: .normal)
        segueLifeBtn.setTitleColor(.subGray2, for: .normal)
    }
    
    func lifeSelected() {
        currentCategory = .life
        self.segueInterviewCollectionView.scrollToItem(at: NSIndexPath(item: 3, section: 0) as IndexPath, at: .left, animated: true)
        
        if segueIndicator.count == 4 {
            segueIndicator[0].backgroundColor = .subGray1
            segueIndicator[1].backgroundColor = .subGray1
            segueIndicator[2].backgroundColor = .subGray1
            segueIndicator[3].backgroundColor = .find_Purple
        }
        
        segueLifeBtn.setTitle("라이프", for: .normal)
        segueLifeBtn.setTitleColor(.find_Purple, for: .normal)
        segueLifeBtn.titleLabel?.font = .spoqaRegular(size: 14)
        
        segueProsBtn.setTitleColor(.subGray2, for: .normal)
        segueLoveBtn.setTitleColor(.subGray2, for: .normal)
        segueTasteBtn.setTitleColor(.subGray2, for: .normal)
    }
}

extension YourProfileVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SegueInterviewCVC.identifier, for: indexPath) as? SegueInterviewCVC else { return UICollectionViewCell() }
        cell.currentCategory = currentCategory
        return cell
    }
}

extension YourProfileVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
        switch currentIndex {
        case 0:
            prosSelected()
        case 1:
            loveSelected()
        case 2:
            tasteSelected()
        case 3:
            lifeSelected()
        default:
            break
        }
        segueInterviewCollectionView.reloadData()
    }

}
