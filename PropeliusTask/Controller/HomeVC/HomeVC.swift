//
//  HomeVC.swift
//  PropeliusTask
//
//  Created by Mavani on 17/07/23.
//

import UIKit

class HomeVC: UIViewController {

    // MARK: -  Outlets
    @IBOutlet var collectionProduct : UICollectionView!
    
    @IBOutlet weak var txtSearch: UITextField!

    @IBOutlet weak var lblProductCount: UILabel!

    // MARK: - Variable Decleration
    var arrProduct = [ModelProducts]()
    var arrProductFilter = [ModelProducts]()
    var arrAllProductFilter = [ModelProducts]()

    var arrAssending = false
    var sortArray = false
    
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
    @IBAction func btnSortPressed(_ sender : UIButton) {
        self.SortPriceWise()
    }
    
    @IBAction func btnFilterPressed(_ sender : UIButton) {
        self.FilterByRating()
    }

    @IBAction func btnCartPressed(_ sender : UIButton) {
        self.gotoCartVC()
    }

}

extension HomeVC {
    
    func GetProduct() {

        if (isConnectedToNetwork()) {
            showProgress("")

            APIManager.APIGetCalling("https://fakestoreapi.com/products", success: { (response) in
                do {
                    if let assest = response as? [[String:Any]]{
                        self.arrProduct += assest.map(ModelProducts.init)
                        self.arrProductFilter = self.arrProduct
                        self.arrAllProductFilter += assest.map(ModelProducts.init)
                    }
                    self.lblProductCount.text = "\(self.arrProduct.count) Products"
                    self.collectionProduct.reloadData()
                    dismissProgress()
                }
            })

        } else {
            dismissProgress()
        }
    }

    func SortPriceWise() {
        
        if arrAssending {
            self.arrProduct = arrProduct.sorted { $0.price < $1.price }
            arrAssending = false
        } else {
            self.arrProduct = arrProduct.sorted { $0.price > $1.price }
            arrAssending = true
        }
        self.collectionProduct.reloadData()
    }
    
    func FilterByRating() {
        
        if sortArray {
            self.arrProduct = self.arrAllProductFilter
            sortArray = false
        } else {
            self.arrProduct = arrProduct.sorted { $0.rating.rate > $1.rating.rate}
            sortArray = true
        }
        self.collectionProduct.reloadData()
    }

}

extension HomeVC : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrProduct.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionProduct.dequeueReusableCell(withReuseIdentifier: "cellProduct", for: indexPath) as? cellProduct {
            let dict = arrProduct[indexPath.row]
            cell.setupCell(for: dict)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.gotoProductDetailVC(data: arrProduct[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (self.view.frame.size.width/2) - 10, height: 220)
    }
}

extension HomeVC : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtSearch.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = txtSearch.text,
           let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,with: string)
            if (updatedText.isEmpty) {
                arrProduct = arrAllProductFilter
            } else {
                arrProduct = arrProductFilter.filter { $0.desc.lowercased().range(of: updatedText.lowercased()) != nil || $0.title.lowercased().range(of: updatedText.lowercased()) != nil
                }
            }
        } else {
            arrProduct = arrAllProductFilter
        }
        self.lblProductCount.text = "\(arrProduct.count) Products Found"
        self.collectionProduct.reloadData()
        return true
    }
}
