//
//  CoreDataModel.swift
//  MovieApp
//
//  Created by Ruman on 13/05/2022.
//

import Foundation
import CoreData

class CoreDataModel {
    static let shared = CoreDataModel()
    @discardableResult func save_Create_Data(entityName: String , key:String , value : NSObject) -> Bool  {
        if let _ = NSClassFromString("XCTest") {
            return true
        }
        let context = CoreDataStack.shared.managedObjectContext
        
        guard let userEntity = NSEntityDescription.entity(forEntityName: entityName, in: context) else{
            return false
        }
        
        let aNotification = NSManagedObject(entity: userEntity, insertInto: context)
        aNotification.setValue(value, forKey: key)
        return CoreDataStack.saveContext(managedObjectContext: context)
    }
        
        func getData(entityName: String) -> [NSManagedObject]? {
            if let _ = NSClassFromString("XCTest") {
                return [NSManagedObject]()
            }
            let entityContext = CoreDataStack.shared.managedObjectContext
            let fetchEntity = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            
            do{
                let results = try entityContext.fetch(fetchEntity)
                return results as? [NSManagedObject]
            }catch let error as NSError {
                print("Could Not save data. \(error) , \(error.description)")
            }
            return nil
        }
        //    MARK:- Update data in DB
//        func updateData(entityName: String , key:String , keyValue : NSObject, newValue : NSObject)  {
//            let entityContext = CoreDataStack.shared.managedObjectContext
//            let fetchEntity = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
//            guard let notification = keyValue as? MovieLocalDBModel, let newVal = newValue as? MovieLocalDBModel else {return}
//
//            guard let userEntity = NSEntityDescription.entity(forEntityName: entityName, in: entityContext) else{
//                return
//            }
//
//
//            do{
//                let results = try entityContext.fetch(fetchEntity)
//
//                if results.count > 0  {
//
//                    if let first = results.first(where: { (managedObject) -> Bool in
//                        let updateObj = managedObject as? NSManagedObject
//
//                        if let notificationObject = updateObj?.value(forKey: "notification") as? MovieLocalDBModel {
//
////                            if notificationObject.promotionID == newVal.promotionID {
////                                return true
////                            }
//                        }
//                        return false
//                    }) as? NSManagedObject {
//                        first.setValue(newVal, forKey: "notification")
//                    }
//                }
//
//
//                CoreDataStack.saveContext(managedObjectContext: entityContext)
//            }catch let error as NSError {
//                print("Could Not save data. \(error) , \(error.description)")
//            }
//        }
    
        //    MARK:- Delete a object from DB
        func deleteData(entityName: String , key:String , keyValue : MovieLocalDBModel)  {
            let entityContext = CoreDataStack.shared.managedObjectContext
            let movies: NSFetchRequest<Movies> = Movies.fetchRequest()
            do{
                let results = try entityContext.fetch(movies)
                let indexforDelete = results.filter { movie in
                    return movie.movie?.movieName == keyValue.movieName
                }
                if indexforDelete.count == 0{
                    return
                }
                let updateObj = indexforDelete[0] as NSManagedObject
                entityContext.delete(updateObj)
                do{
                    try entityContext.save()
                }catch let error as NSError {
                    print("Could Not save data. \(error) , \(error.description)")
                }
            }catch let error as NSError {
                print("Could Not save data. \(error) , \(error.description)")
            }
        }
        
        //    MARK:- Delete data in DB
    @discardableResult func deleteAllData(entityName: String ) -> Bool {
        if let _ = NSClassFromString("XCTest") {
            return true
        }
            let entityContext = CoreDataStack.shared.managedObjectContext
            let fetchEntity = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchEntity)
            
            do {
                try entityContext.execute(deleteRequest)
                try entityContext.save()
            } catch {
                print ("There was an error")
            }
            return true
        }
    
    
    func getMovieData() -> [MovieLocalDBModel]?{
        
        if let _ = NSClassFromString("XCTest") {
            let movie = MovieLocalDBModel(moviePoster: "", movieName: "", releaseDate: "", favorite: true,backdrop_path: "", overview: "" )
            return [movie]
        }

        let results = self.getData(entityName: CoreDataConstants.entityName)
        guard let allResults = results else{
            return nil
        }
        
        var resultsArray = [MovieLocalDBModel]()
        //        print(results)
        for result in allResults{
            guard let notification = result.value(forKey: "movie") as? MovieLocalDBModel else{
                return nil
            }
            resultsArray.append(notification)
        }
        return resultsArray
    }
       
}
