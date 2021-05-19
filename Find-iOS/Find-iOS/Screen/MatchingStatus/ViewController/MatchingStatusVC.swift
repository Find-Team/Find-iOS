//
//  MatchingStatusVC.swift
//  Find-iOS
//
//  Created by 이원석 on 2021/05/19.
//

import UIKit

enum MatchingCategory {
    case feelings, dibs
}

class MatchingStatusVC: UIViewController {
    var curCategory: MatchingCategory?
    
    @IBOutlet var segIndicators: [UIView]!
    @IBOutlet weak var matchingCV: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension MatchingStatusVC {
    
}

extension MatchingStatusVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    }
    
    
}
