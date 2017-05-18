//
//  PhotosViewController.swift
//  Photorama
//
//  Created by Alisher Abdukarimov on 5/17/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    var store: PhotoStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.fetchInterestingPhotosURL {
            (photoResult) -> Void in
            
            switch photoResult {
            case let .success(photos):
                
                print("Successfully found \(photos.count) photos.")
                if let firstPhoto = photos.first {
                    self.updateImageView(for: firstPhoto)
                }
            case let .failure(error):
                print("Error fetching interesting photos: \(error)")
            }
        }
    }
    
    
    func updateImageView(for photo: Photo) {
        
            self.store.fetchImage(for: photo) { (imageResult) -> Void in
                switch imageResult {
                case let .success(image):
                    self.imageView.image = image
                case let .failure(error):
                    print("Error downloading image: \(error)")
                
        }
        }
    }
    
}
