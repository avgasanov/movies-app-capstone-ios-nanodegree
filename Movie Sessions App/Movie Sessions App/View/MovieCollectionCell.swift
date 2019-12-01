//
//  MovieCollectionCell.swift
//  Movie Sessions App
//
//  Created by Abdulla Hasanov on 12/1/19.
//  Copyright © 2019 Abdulla Hasanov. All rights reserved.
//

import UIKit
import FirebaseStorage

class MovieCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var cinemaLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var posterDownloadTask: StorageDownloadTask?
}
