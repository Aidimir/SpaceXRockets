//
//  coreData_manager.swift
//  SpaceXRockets
//
//  Created by Айдимир Магомедов on 27.03.2022.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager : NSObject{
    public static let sharedInstance = CoreDataManager()
    
    private override init() {}

    // Helper func for getting the current context.
    private func getContext() -> NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        return appDelegate.persistentContainer.viewContext
    }

    func retrieveUser() -> NSManagedObject? {
        guard let managedContext = getContext() else { return nil }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        do {
            let result = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            if result.count > 0 {
                // Assuming there will only ever be one User in the app.
                return result[0]
            } else {
                return nil
            }
        } catch let error as NSError {
            print("Retrieving user failed. \(error): \(error.userInfo)")
           return nil
        }
    }

    func saveRocket(_ rocket: RocketData) {
        print(NSStringFromClass(type(of: rocket)))
        guard let managedContext = getContext() else { return }
        guard let user = retrieveUser() else { return }
        
        var rockets: [RocketData] = []
        if let pastRockets = user.value(forKey: "rockets") as? [RocketData] {
            rockets += pastRockets
        }
        rockets.append(rocket)
        user.setValue(rockets, forKey: "rockets")
        
        do {
            print("Saving session...")
            try managedContext.save()
        } catch let error as NSError {
            print("Failed to save session data! \(error): \(error.userInfo)")
        }
}
}
