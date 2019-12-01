//
//  Session.swift
//  Movie Sessions App
//
//  Created by Abdulla Hasanov on 12/1/19.
//  Copyright © 2019 Abdulla Hasanov. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Session {
    
    let key: String
    let cineId: String
    let cinema: String
    let name: String
    let poster: String
    let time: Int64
    let ref: DatabaseReference?
    
    init(cineId: String, cinema: String, name: String, poster: String, time: Int64, key: String) {
        self.key = key
        self.cineId = cineId
        self.cinema = cinema
        self.name = name
        self.poster = poster
        self.time = time
        self.ref = nil
    }

    init(snapshot: DataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        cineId = snapshotValue["cine_id"] as! String
        cinema = snapshotValue["cinema"] as! String
        name = snapshotValue["name"] as! String
        poster = snapshotValue["poster"] as! String
        time = snapshotValue["time"] as! Int64
        ref = snapshot.ref
    }

    func toAnyObject() -> Any {
        return [
            "cine_id": cineId,
            "cinema": cinema,
            "name": name,
            "poster": poster,
            "time": time
        ]
    }
}
