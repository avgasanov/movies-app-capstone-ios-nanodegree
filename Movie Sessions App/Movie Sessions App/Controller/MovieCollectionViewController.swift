//
//  MovieCollectionViewController.swift
//  Movie Sessions App
//
//  Created by Abdulla Hasanov on 12/1/19.
//  Copyright © 2019 Abdulla Hasanov. All rights reserved.
//

import UIKit

class MovieCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate  {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var sessions: Array<Session>?
    
    let fadeView:UIView = UIView()
    let activityView = UIActivityIndicatorView(style: .whiteLarge)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initFlowLayout()
        flowLayout.prepare()
        flowLayout.invalidateLayout()
        if sessions == nil {
            showLoadingProgress()
            populateSessionsData()
        }
        
    }
    
    // https://stackoverflow.com/questions/46650183/show-activity-indicator-while-data-load-in-collectionview-swift
    func showLoadingProgress() {
        fadeView.frame = self.view.frame
        fadeView.backgroundColor = UIColor.black
        fadeView.alpha = 0.4

        self.view.addSubview(fadeView)

        self.view.addSubview(activityView)
        activityView.hidesWhenStopped = true
        activityView.center = self.view.center
        activityView.startAnimating()
    }
    
    func hideLoadingProgress() {
        self.collectionView?.alpha = 1
        self.fadeView.removeFromSuperview()
        self.activityView.stopAnimating()
    }
   
    func populateSessionsData() {
        debugPrint("starting to load")
        if sessions == nil {
            MovieClient.getSessionsData() { sessions, error in
                self.hideLoadingProgress()
                
                if let error = error {
                    self.showAlertVC(errorMessage: error, completion: nil)
                } else {
                    self.sessions = sessions
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    // Meme app lessons
    func initFlowLayout() {
        debugPrint("flow layout description: \(view.description)")
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 2.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        debugPrint("dimension: \(dimension), frame size width: \(collectionView.frame.size.width)")
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sessions?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionCell", for: indexPath) as! MovieCollectionCell
        let session = self.sessions![(indexPath as NSIndexPath).row]
        
        cell.timeLabel.text = formattedTime(time: session.time)
        cell.cinemaLabel.text = session.cinema
        cell.movieLabel.text = session.name
        cell.poster.image = UIImage(named: "poster-placeholder")
        if let task = cell.posterDownloadTask {
            task.cancel()
        }
        cell.loadingIndicator.startAnimating()
        cell.posterDownloadTask = MovieClient.getMoviePoster(posterUrlStr: session.poster) { image, error in
            if let error = error {
                self.showAlertVC(errorMessage: error, completion: nil)
            } else {
                cell.loadingIndicator.stopAnimating()
                cell.poster.image = image
            }
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let sessions = sessions {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "DetailController") as! MovieDetailViewController
            controller.movieId = sessions[indexPath.row].cineId
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func formattedTime(time: Int64) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: Date(timeIntervalSince1970: TimeInterval(time/1000)))
    }
}
