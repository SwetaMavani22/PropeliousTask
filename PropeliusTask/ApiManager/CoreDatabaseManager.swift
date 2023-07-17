//
//  CoreDatabaseManager.swift
//  InterviewTask
//
//  Created by Mavani on 12/10/22.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    func SaveData(data : ModelProducts) -> Bool{
        
        let selectedPhotos = data
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Products",in: context!)!
        let product = NSManagedObject(entity: entity,insertInto: context)
        
        product.setValue("\(selectedPhotos.id)", forKey: "product_id")
        product.setValue(selectedPhotos.title, forKey: "product_name")
        product.setValue(selectedPhotos.image, forKey: "product_image")
        product.setValue(selectedPhotos.desc, forKey: "product_desc")
        product.setValue(selectedPhotos.price, forKey: "product_price")
        do {
            try context?.save()
            return true
        } catch {
            return false
        }
    }
    
    func FetchFavorite(complation : @escaping ([Products]) -> ()) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Products>(entityName: "Products")
        do {
            complation(try context.fetch(fetchRequest))
        } catch {
            print("Cannot fetch")
        }
    }
    
    
    func deletePhotos(data : Products) -> Bool {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        
        context?.delete(data)
        do {
            try  context?.save()
            return true
        } catch {
            return false
        }
    }


}
