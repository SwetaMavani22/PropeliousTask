//
//  CartVC.swift
//  PropeliusTask
//
//  Created by Mavani on 18/07/23.
//

import UIKit

class CartVC: UIViewController {
    
    // MARK: -  Outlets
    @IBOutlet var collectionProduct : UICollectionView!

    // MARK: - Variable Decleration
    var arrProduct = [Products]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.SetUp()
    }

    // MARK: - Private Method
    func SetUp() {
        self.collectionProduct.register(UINib(nibName: "cellProduct", bundle: nil), forCellWithReuseIdentifier: "cellProduct")
        self.GetProduct()
    }

    
    // MARK: - Button Action
    @IBAction func btnBackPressed(_ sender : UIButton) {
    
        self.navigationController?.popViewController(animated: true)
    }
}

extension CartVC {
    
    func GetProduct() {

        CoreDataManager().FetchFavorite(complation: {(data) in
            self.arrProduct = data            
        })

    }

}

extension CartVC : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrProduct.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionProduct.dequeueReusableCell(withReuseIdentifier: "cellProduct", for: indexPath) as? cellProduct {
            let dict = arrProduct[indexPath.row]
            cell.setupCartCell(for: dict)
            return cell
        }
        return UICollectionViewCell()
    }
        
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (self.view.frame.size.width/2) - 10, height: 220)
    }
}
