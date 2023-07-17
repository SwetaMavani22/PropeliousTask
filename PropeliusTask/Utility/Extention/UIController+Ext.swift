//
//  UIController+Ext.swift
//  mExpense
//
//  Created by user1 on 26/10/21.
//

import Foundation
import UIKit
import CoreData

extension UIViewController {
    
     func gotoProductDetailVC(data :  ModelProducts) {
        let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: ProductDetailVC.self)
        vc.selectedData = data
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoCartVC() {
       let vc = UIStoryboard.instantiateViewController(storyborad: .main, withViewClass: CartVC.self)
       self.navigationController?.pushViewController(vc, animated: true)
   }

}
