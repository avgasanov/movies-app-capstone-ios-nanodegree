//
//  MovieClient.swift
//  Movie Sessions App
//
//  Created by Abdulla Hasanov on 12/1/19.
//  Copyright © 2019 Abdulla Hasanov. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

class MovieClient {
    
    static var ref: DatabaseReference!
    static var storage: Storage!
    
    class func initDatabase() {
        let database = Database.database()
        database.isPersistenceEnabled = true
        ref = database.reference()
        storage = Storage.storage()
    }
    
    
    class func getSessionsData(completion: @escaping (Array<Session>?, String?) -> Void) {
        guard let ref = ref else {
            completion(nil, "database is not initialized")
            debugPrint("database is not initialized")
            return
        }
        ref.child(Constants.sessions.rawValue).observeSingleEvent(of: .value, with: { snapshot in
            var sessions: Array<Session> = []
            for child in snapshot.children {
                let session = Session(snapshot: child as! DataSnapshot)
                sessions.append(session)
            }
            DispatchQueue.main.async {
                completion(sessions, nil)
            }
        }) { error in
            debugPrint("my error: \(error)")
            DispatchQueue.main.async {
                completion(nil, error.localizedDescription)
            }
        }
        
    }
    
    class func getMovieDetail(movieId: String, completion: @escaping (Movie?, String?) -> Void) {
        guard let ref = ref else {
            completion(nil, "database is not initialized")
            debugPrint("database is not initialized")
            return
        }
        ref.child(Constants.movies.rawValue).child(movieId).observeSingleEvent(of: .value) { snapshot in
            let movie = Movie(snapshot: snapshot)
            DispatchQueue.main.async {
                completion(movie, nil)
            }
        }
    }
    
    class func getMoviePoster(posterUrlStr: String, completion: @escaping (UIImage?, String?) -> Void) -> StorageDownloadTask?{
        guard let storage = storage else {
            completion(nil, "database is not initialized")
            debugPrint("database is not initialized")
            return nil
        }
        let gsReference = storage.reference(forURL: posterUrlStr)
        return gsReference.getData(maxSize: 10 * 1024 * 1024) { data, error in
            if let error = error {
                if error.localizedDescription == "User cancelled the upload/download." {
                    return
                }
                DispatchQueue.main.async {
                    completion(nil, error.localizedDescription)
                }
                debugPrint("Error downloading image: \(error.localizedDescription)")
            } else {
                let image = UIImage(data: data!)
                DispatchQueue.main.async {
                    completion(image, nil)
                }
            }
        }
    }
}
