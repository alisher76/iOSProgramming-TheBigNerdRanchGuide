//
//  PhotoDataSource.swift
//  Photorama
//
//  Created by Alisher Abdukarimov on 5/18/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import UIKit

class PhotoDataSource: NSObject, UICollectionViewDataSource {
    
    var photos = [Photo]()
    
    func collectionView(_ collectionView: UICollectionView,
                             numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier = "PhotoCollectionViewCell"
        let cell =
            collectionView.dequeueReusableCell(withReuseIdentifier: identifier,
                                               for: indexPath) as! PhotoCollectionViewCell
        
        return cell
    }
    
    
}
