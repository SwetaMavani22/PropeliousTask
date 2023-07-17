//
//  cellProducts.swift
//  PropeliusTask
//
//  Created by Mavani on 17/07/23.
//

import Foundation
import UIKit
import Kingfisher

class cellProduct : UICollectionViewCell {
    
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProductDesc: UILabel!
    @IBOutlet weak var lblProductPrice: UILabel!
    
    @IBOutlet weak var btnFavorite: UIButton!

    @IBOutlet weak var imgProduct: UIImageView!

    
    func setupCell(for data: ModelProducts){

        self.lblProductName.text = data.title
        self.lblProductDesc.text = data.desc
        self.lblProductPrice.text = "\(data.price)"
        
        if let url = URL(string: data.image){
            imgProduct.kf.setImage(with: url)
        } else {
            imgProduct.image = nil
        }
    }

    func setupCartCell(for data: Products){

        self.lblProductName.text = data.product_name
        self.lblProductDesc.text = data.product_desc
        self.lblProductPrice.text = "\(data.product_price)"
        
        if let url = URL(string: data.product_image ?? ""){
            imgProduct.kf.setImage(with: url)
        } else {
            imgProduct.image = nil
        }
    }

}
