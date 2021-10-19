//
//  AppDelegate.swift
//  GuideBookApp
//
//  Created by Irish on 10/8/21.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Preload data if needed
        preloadData()
        
        return true
    }
    
    //MARK: - Preload Data
    private func preloadData() {
        
        let defaults = UserDefaults.standard
        
        // Reference to core Data Context
        let context = persistentContainer.viewContext
        
        // Check if this is the first launch
        if defaults.bool(forKey: Constants.PRELOAD_DATA) == false {
            
            // If so, then parse the json file into Core Data
            
            // Get a path to the local JSON file
            let path = Bundle.main.path(forResource: "PreloadedData", ofType: "json")
            
            guard path != nil else {
                
                print("Couldn't get path to url")
                return
            }
            
            // Create url from path
            let url = URL(fileURLWithPath: path!)
            
            // Get the data
            do {
                
                let data = try  Data(contentsOf: url)
                
                // Try turning the data into json object
                let jsonArray = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [[String:Any]]
                
                // Loop through the json objects
                
                for d in jsonArray {
                    
                    // Create a place object and populate properties
                    let p = Place(context: context)
                    p.name = d["name"] as? String
                    p.imagename = d["imagename"] as? String
                    p.address = d["address"] as? String
                    p.summary = d["summary"] as? String
                    p.lat = d["lat"] as! Double
                    p.long = d["long"] as! Double
                    
                }
            } catch {
                
            }
            
            // Save Data
            self.saveContext()
            
            // Set the preload data flag to true
            defaults.set(true, forKey: Constants.PRELOAD_DATA)
        }
        
        
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "GuideBookApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

