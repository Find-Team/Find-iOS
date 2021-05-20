//
//  FindFoundVC.swift
//  Find-iOS
//
//  Created by 장서현 on 2021/05/20.
//

import UIKit

enum Category {
    case find, found
}

class FindFoundVC: UIViewController {
    
    var currentCategory: Category = .find
    
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
        
        // Do any additional setup after loading the view.
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
        segueFindBtn.setTitle("find", for: .normal)
        segueFindBtn.setTitleColor(.gray , for: .normal)
        segueFindBtn.titleLabel?.font = .systemFont(ofSize: 14)
        
        segueFindBtn.setTitle("found", for: .normal)
        segueFindBtn.setTitleColor(.gray , for: .normal)
        segueFindBtn.titleLabel?.font = .systemFont(ofSize: 14)
    }
    
    func findSelected() {
        currentCategory = .find
        self.myCollectionView.scrollToItem(at: NSIndexPath(item: 0, section: 0) as IndexPath, at: .left, animated: true)
        
        if segueIndicatorView.count == 2 {
            segueIndicatorView[0].backgroundColor = .purple
            segueIndicatorView[1].backgroundColor = .gray
        }
        
        segueFindBtn.setTitle("find", for: .normal)
        segueFindBtn.setTitleColor(.purple, for: .normal)
        segueFindBtn.titleLabel?.font = .systemFont(ofSize: 14)
        
        segueFoundBtn.setTitleColor(.gray, for: .normal)
    }
    
    func foundSelected() {
        currentCategory = .found
        self.myCollectionView.scrollToItem(at: NSIndexPath(item: 1, section: 0) as IndexPath, at: .left, animated: true)
        
        if segueIndicatorView.count == 2 {
            segueIndicatorView[0].backgroundColor = .gray
            segueIndicatorView[1].backgroundColor = .purple
        }
        
        segueFoundBtn.setTitle("found", for: .normal)
        segueFoundBtn.setTitleColor(.purple, for: .normal)
        segueFoundBtn.titleLabel?.font = .systemFont(ofSize: 14)
        
        segueFindBtn.setTitleColor(.gray, for: .normal)
    }
}

// MARK: - Protocol

extension FindFoundVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
}

extension FindFoundVC: UICollectionViewDelegateFlowLayout {
    
}
