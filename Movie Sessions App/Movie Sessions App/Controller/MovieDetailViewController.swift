//
//  MovieDetailViewController.swift
//  Movie Sessions App
//
//  Created by Abdulla Hasanov on 12/1/19.
//  Copyright © 2019 Abdulla Hasanov. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class MovieDetailViewController: UIViewController, YTPlayerViewDelegate {
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var youtube: YTPlayerView!
    @IBOutlet weak var desc: UILabel!
    var movieId: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        youtube.delegate = self
        indicator.startAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MovieClient.getMovieDetail(movieId: movieId) { movie, error in
            if let error = error {
                self.showAlertVC(errorMessage: error) { action in self.navigationController?.popToRootViewController(animated: true)
                }
            } else {
                if let trailer = movie?.trailer {
                    self.youtube.load(withVideoId: trailer)
                }
                self.desc.text = movie?.description
            }
        }
    }
    
    func playerView(_ playerView: YTPlayerView, receivedError error: YTPlayerError) {
        showAlertVC(errorMessage: "Youtube player error") { action in
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        indicator.stopAnimating()
    }
}
