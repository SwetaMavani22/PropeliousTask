//
//  ModelPhotos.swift
//  InterviewTask
//
//  Created by Mavani on 11/10/22.
//

import Foundation
import SwiftUI

class ModelProducts : NSObject{

    var id = 0
    var title = ""
    var desc = ""
    var category = ""
    var image = ""
    var price = 0.0
    var rating = ModelRating()

    override init() {
        super.init()
    }

    init(dic:[String:Any]) {

        id = dic["id"] as? Int ?? 0
        title = dic["title"] as? String ?? ""
        desc = dic["description"] as? String ?? ""
        category = dic["category"] as? String ?? ""
        image = dic["image"] as? String ?? ""
        price = dic["price"] as? Double ?? 0.0
        rating = ModelRating.init(dic: dic["rating"] as? [String:Any] ?? ["":""])
    }
}

class ModelRating : NSObject{
    
    var rate = 0.0
    var count = 0

    override init() {
        super.init()
    }

    init(dic:[String:Any]) {

        rate = dic["rate"] as? Double ?? 0.0
        count = dic["count"] as? Int ?? 0
    }
}
