//
//  PhotoStore.swift
//  Photorama
//
//  Created by Alisher Abdukarimov on 5/17/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import Foundation
import UIKit
import CoreData

enum TagsResult {
    case success([NSManagedObject])
    case failure(Error)
}


enum ImageResult {
    case success(UIImage)
    case failure(Error)
    
}

enum PhotoError: Error {
   case imageCreationError
}
enum PhotosResult {
    case success ([Photo])
    case failure(Error)
}
class PhotoStore {
    
    let imageStore = ImageStore()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Photorama")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error setting up CoreData: \(error)")
            }
        }
        return container
    }()
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    func fetchInterestingPhotosURL(completion: @escaping (PhotosResult) -> Void) {
        let url = FlickrAPI.interestingPhotosURL
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {
            (optionalData, optionalResponce, optionalError) -> Void in
            
            self.processPhotosRequest(data: optionalData, error: optionalError) {
                (result) in
                OperationQueue.main.addOperation {
                    completion(result)
                }
            }
       }
        task.resume()
    }
    
    private func processPhotosRequest(data: Data?, error: Error?, completion: @escaping (PhotosResult) -> Void) {
        guard let jsonData = data else {
            completion(.failure(error!))
            return
        }
        
        self.persistentContainer.performBackgroundTask {
            (context) in
            let result = FlickrAPI.photos(fromJSON: jsonData, into: context)
            
            do {
            try context.save()
            }catch{
                print("error saving CD \(error)")
                completion(.failure(error))
                return
            }
            
            switch result {
            case let .success(photos):
                let photoIDs = photos.map { return $0.objectID }
                let viewContext = self.persistentContainer.viewContext
                let viewContextPhotos = photoIDs.map { return viewContext.object(with: $0) } as! [Photo]
                completion(.success(viewContextPhotos))
            case .failure(_):
                completion(result)
            }

        }
    }
    
    private func processImageRequest(data: Data?, error: Error?) -> ImageResult {
        guard
           let imageData = data,
            let image = UIImage(data: imageData) else {
                if data == nil {
                    return .failure(error!)
                }else{
                    return .failure(PhotoError.imageCreationError)
                }
        }
        return .success(image)
        
    }
    
    func fetchImage(for photo: Photo, completion: @escaping (ImageResult) -> Void) {
        
        guard let photoKey = photo.photoID else {
            preconditionFailure("Photo expected to have a photoID")
        }
        if let image = imageStore.image(forKey: photoKey) {
            OperationQueue.main.addOperation {
                completion(.success(image))
            }
            return
        }
        guard let photoURL = photo.remoteURL else {
            preconditionFailure("Photo expected to have a remoteURL")
        }
        let request = URLRequest(url: photoURL as URL)
        let task = session.dataTask(with: request) {
            (data,responce,error) -> Void in
            let result = self.processImageRequest(data: data, error: error)
            if case let .success(image) = result {
                self.imageStore.setImage(image, forKey: photoKey)
            }
            OperationQueue.main.addOperation {
            completion(result)
            }
        }
        task.resume()
    }
    
    func fetchAllPhotos(completion: @escaping (PhotosResult) -> Void) {
        let fetchRequest: NSFetchRequest<Photo> = Photo.fetchRequest()
        let sortByDateTaken = NSSortDescriptor(key: #keyPath(Photo.dateTaken), ascending: true)
        fetchRequest.sortDescriptors = [sortByDateTaken]
        
        let viewContext = persistentContainer.viewContext
        viewContext.perform {
            do {
                let allPhotos = try viewContext.fetch(fetchRequest)
                completion(.success(allPhotos))
            }catch{
             completion(.failure(error))
            }
        }
    }
    
    
    func fetchAllTags(completion: @escaping (TagsResult) -> Void) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Tag")
        let sortByName = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortByName]
        
        let viewContext = persistentContainer.viewContext
        viewContext.perform {
            do {
                let allTags = try fetchRequest.execute()
                completion(.success(allTags as! [Photo]))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
