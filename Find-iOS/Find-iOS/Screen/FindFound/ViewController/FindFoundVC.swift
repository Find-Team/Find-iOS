//
//  FindFoundVC.swift
//  Find-iOS
//
//  Created by 장서현 on 2021/05/20.
//

import UIKit

//enum Category {
//    case find, found
//}

enum FindFoundCategory {
    case find, found
}

class FindFoundVC: UIViewController {
    
    var currentCategory: FindFoundCategory = .find
    var findCheckIndex: Int = 0
    
    // MARK: - IBOutlet

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var segueBtnStackView: UIStackView!
    @IBOutlet weak var segueFindBtn: UIButton!
    @IBOutlet weak var segueFoundBtn: UIButton!
    @IBOutlet weak var segueIndicatorStackView: UIStackView!
    @IBOutlet var segueIndicatorView: [UIView]!
    @IBOutlet weak var myCollectionView: UICollectionView!

    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSegueStyle()
        switch findCheckIndex {
            case 0: findSelected()
            case 1:
                foundSelected()
//                myCollectionView.reloadData()
            default: findSelected()
        }
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        print(findCheckIndex)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myCollectionView.reloadData()
    }

    // MARK: - IBAction
    
    @IBAction func findBtnClicked(_ sender: Any) {
        findSelected()
    }
    
    @IBAction func foundBtnClicked(_ sender: Any) {
        foundSelected()
    }
}

// MARK: - extension func

extension FindFoundVC {
    func setSegueStyle() {
        print("setsegueStyle")
        segueFindBtn.setTitle("FIND", for: .normal)
        segueFindBtn.setTitleColor(.find_DarkPurple , for: .normal)
        segueFindBtn.titleLabel?.font = .spoqaRegular(size: 14)
        
        segueFoundBtn.setTitle("FOUND", for: .normal)
        segueFoundBtn.setTitleColor(.subGray1 , for: .normal)
        segueFoundBtn.titleLabel?.font = .spoqaRegular(size: 14)
    }
    
    func findSelected() {
        print("findselected")
        currentCategory = .find
        self.tabBarController?.tabBar.isHidden = false
        self.myCollectionView.scrollToItem(at: NSIndexPath(item: 0, section: 0) as IndexPath, at: .left, animated: true)
        if segueIndicatorView.count == 2 {
            segueIndicatorView[0].backgroundColor = .find_DarkPurple
            segueIndicatorView[1].backgroundColor = .subGray1
        }
        
        segueFindBtn.setTitle("FIND", for: .normal)
        segueFindBtn.setTitleColor(.find_DarkPurple, for: .normal)
        segueFindBtn.titleLabel?.font = .spoqaRegular(size: 14)
        segueFoundBtn.setTitleColor(.subGray1, for: .normal)
    }
    
    func foundSelected() {
        print("foundSelected")
        currentCategory = .found
        self.tabBarController?.tabBar.isHidden = true
        self.myCollectionView.scrollToItem(at: NSIndexPath(item: 1, section: 0) as IndexPath, at: .left, animated: true)
        
        if segueIndicatorView.count == 2 {
            segueIndicatorView[0].backgroundColor = .subGray1
            segueIndicatorView[1].backgroundColor = .find_DarkPurple
        }
        
        segueFoundBtn.setTitle("FOUND", for: .normal)
        segueFoundBtn.setTitleColor(.find_DarkPurple, for: .normal)
        segueFoundBtn.titleLabel?.font = .spoqaRegular(size: 14)
        
        segueFindBtn.setTitleColor(.subGray1, for: .normal)
    }
}

// MARK: - Protocol

extension FindFoundVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FindFoundSegueCVC.identifier, for: indexPath) as? FindFoundSegueCVC else { return UICollectionViewCell() }
        
        let findView = FindView(frame: cell.myFindView.frame)
        let foundView = FoundView(frame: cell.myFoundView.frame)
        
        if indexPath.row == 0 {
            cell.currentCategory = currentCategory
            cell.myFindView.addSubview(findView)
            cell.myFoundView.isHidden = true
            cell.myFindView.isHidden = false
            foundView.removeFromSuperview()
            return cell
        } else if indexPath.row == 1 {
            cell.currentCategory = currentCategory
            cell.myFoundView.addSubview(foundView)
            cell.myFindView.isHidden = true
            cell.myFoundView.isHidden = false
            findView.removeFromSuperview()
            return cell
        }
        return UICollectionViewCell()
    }
}

extension FindFoundVC: UICollectionViewDelegateFlowLayout {
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
            findSelected()
            print("case0")
        case 1:
            foundSelected()
            print("case1")
            
        default:
            break
        }
    }
}
