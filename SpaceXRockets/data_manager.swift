//
//  data_manager.swift
//  SpaceXRockets
//
//  Created by Айдимир Магомедов on 27.03.2022.
//

import Foundation
import CoreData
import UIKit

class DataManager : NSObject{
    func saveRocketsToCoreData(rockets : [RocketData]){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "RocketsData", in: context) else {return}
        let object = RocketsData(entity: entity, insertInto: context)
       // object.rockets = rockets
        do{
            print("Did save to core data")
            try context.save()
        }
        catch let error as NSError{
            print("Didn't save to core data")
            print(error.localizedDescription)
        }
    }
    func retrieveRockets() -> [RocketsData]? {
        let appDelegate =  UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest : NSFetchRequest<RocketsData> = RocketsData.fetchRequest()
        var rockets : [RocketsData]? = nil
        do {
            rockets = try context.fetch(fetchRequest)
            return rockets
        }
        catch {
            return nil
        }
    }
    func resetCoreData(){
        let appDelegate =  UIApplication.shared.delegate as! AppDelegate
        let storeContainer = appDelegate.persistentContainer.persistentStoreCoordinator

        // Delete each existing persistent store
        for store in storeContainer.persistentStores {
            do{
            try storeContainer.destroyPersistentStore(
                at: store.url!,
                ofType: store.type,
                options: nil
            )
                
            }
            catch{
                print("didn't reset core data")
            }
        }

        // Re-create the persistent container
        appDelegate.persistentContainer = NSPersistentContainer(
            name: "data_model" // the name of
            // a .xcdatamodeld file
        )

        // Calling loadPersistentStores will re-create the
        // persistent stores
        appDelegate.persistentContainer.loadPersistentStores {
            (store, error) in
            // Handle errors
        }
    }
}
