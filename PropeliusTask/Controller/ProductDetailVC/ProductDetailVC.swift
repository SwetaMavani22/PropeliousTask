//
//  ProductDetailVC.swift
//  PropeliusTask
//
//  Created by Mavani on 18/07/23.
//

import UIKit
import FloatRatingView

class ProductDetailVC: UIViewController {

    // MARK: -  Outlets
    @IBOutlet weak var ratingView: FloatRatingView!
    
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProductDesc: UILabel!
    @IBOutlet weak var lblProductPrice: UILabel!
    @IBOutlet weak var lblProductRateCount: UILabel!

    @IBOutlet weak var imgProduct: UIImageView!

    // MARK: - Variable Decleration
    var selectedData = ModelProducts()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.SetUp()
    }

    // MARK: - Private Method
    func SetUp() {

        self.ratingView.rating = selectedData.rating.rate
        self.lblProductName.text = selectedData.title
        self.lblProductDesc.text = selectedData.desc
        self.lblProductPrice.text = "$\(selectedData.price)"
        self.lblProductRateCount.text = "(\(selectedData.rating.count))"

        if let url = URL(string: selectedData.image){
            imgProduct.kf.setImage(with: url)
        } else {
            imgProduct.image = nil
        }
    }

    // MARK: - Button Action

    @IBAction func btnBackPressed(_ sender : UIButton) {
    
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnFavoritePressed(_ sender : UIButton) {
        
    }
    
    @IBAction func btnAddToCartPressed(_ sender : UIButton) {
        let isSave = CoreDataManager().SaveData(data: selectedData)
        if isSave {
            self.view.makeToast("Product Add To The Cart.")
        }
    }

}
