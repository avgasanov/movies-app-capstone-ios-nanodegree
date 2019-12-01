//
//  Movie.swift
//  Movie Sessions App
//
//  Created by Abdulla Hasanov on 12/1/19.
//  Copyright © 2019 Abdulla Hasanov. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Movie {
    
    let key: String
    let description: String
    let name: String
    let rating: Int
    let trailer: String
    let ref: DatabaseReference?
    
    init(description: String, name: String, rating: Int, trailer: String, key: String) {
        self.key = key
        self.description = description
        self.name = name
        self.rating = rating
        self.trailer = trailer
        self.ref = nil
    }

    init(snapshot: DataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["name"] as! String
        rating = snapshotValue["rating"] as! Int
        description = snapshotValue["description"] as! String
        trailer = snapshotValue["trailer"] as! String
        ref = snapshot.ref
    }

    func toAnyObject() -> Any {
        return [
            "name": name,
            "description": description,
            "trailer": trailer,
            "rating": rating
        ]
    }
}
