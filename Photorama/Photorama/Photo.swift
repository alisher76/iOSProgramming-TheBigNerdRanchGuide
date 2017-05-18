//
//  Photo.swift
//  Photorama
//
//  Created by Alisher Abdukarimov on 5/17/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import Foundation
class Photo {
    
    let title: String
    let remoteURL: URL
    let photoID: String
    let dateTaken: Date
    
    
    init(title: String, photoID: String, remoteURL: URL, dateTaken: Date) {
        self.dateTaken = dateTaken
        self.photoID = photoID
        self.remoteURL = remoteURL
        self.title = title
        
    }
    
    
}

extension Photo: Equatable {

    static func ==(lhs: Photo, rhs: Photo) -> Bool {
        return lhs.photoID == rhs.photoID
    }
    
}
