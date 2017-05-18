//
//  PhotoStore.swift
//  Photorama
//
//  Created by Alisher Abdukarimov on 5/17/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import Foundation
import UIKit


enum ImageResult {
    case success(UIImage)
    case failure(Error)
    
}

enum PhotoError: Error {
   case imageCreationError
}
enum PhotoResult {
    case success ([Photo])
    case failure(Error)
}
class PhotoStore {
    
    let imageStore = ImageStore()
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    func fetchInterestingPhotosURL(completion: @escaping (PhotoResult) -> Void) {
        let url = FlickrAPI.interestingPhotosURL
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {
            (optionalData, optionalResponce, optionalError) -> Void in
            let result = self.processPhotosRequest(data: optionalData, error: optionalError)
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
    
    private func processPhotosRequest(data: Data?, error: Error?) -> PhotoResult {
        guard let jsonData = data else {
            return .failure(error!)
        }
        
        return FlickrAPI.photos(fromJSON: jsonData)
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
        
        let photoKey = photo.photoID
        if let image = imageStore.image(forKey: photoKey) {
            OperationQueue.main.addOperation {
                completion(.success(image))
            }
            return
        }
        let photoURL = photo.remoteURL
        let request = URLRequest(url: photoURL)
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
    
    
}
