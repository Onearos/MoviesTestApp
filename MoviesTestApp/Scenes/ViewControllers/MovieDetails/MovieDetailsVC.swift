//
//  MovieDetailsVC.swift
//  MoviesTestApp
//
//  Created by Macbook PRO on 08/06/2022.
//

import UIKit
import Foundation
import ObjectMapper
import SDWebImage


import SwiftyStarRatingView


class MovieDetailsVC: UIViewController {
    
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var MovieTitle: UILabel!
    @IBOutlet weak var MoviePoster: UIImageView!
    @IBOutlet weak var MovieRealease: UILabel!
    @IBOutlet weak var MovieDescription: UILabel!
    
    
    var presenterr: MoviePresenter!
    var taskId: Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.presenterr = MoviePresenter(viewdetails: self)
        presenterr.retrieveNotificationRecap(taskId: taskId)
        
        
    }
}

extension MovieDetailsVC: MovieDetailsView {
    func moviedetailsRetrieved(title: String,overview: String,releasedate: String, poster: String, rating : NSNumber) {
        
        
        self.MovieTitle.text = title
        self.MovieRealease.text = releasedate
        self.MovieDescription.text = overview
        self.ratingLbl.text = rating.stringValue
        
        
//        Display The poster
        
        let imageURL = URL(string: "https://image.tmdb.org/t/p/w500/" + poster)!
        self.MoviePoster.sd_setImage(with: imageURL)
        
        
        
        //        Display The Rating view
        
        let starRatingView = SwiftyStarRatingView()
        starRatingView.frame =  ratingView.bounds
        starRatingView.allowsHalfStars = true
        starRatingView.maximumValue = 5
        starRatingView.minimumValue = 0
        starRatingView.value = CGFloat(Int(Int(truncating: rating) / 2))
        starRatingView.tintColor = UIColor.yellow
        starRatingView.backgroundColor = .clear
        
        ratingView.addSubview(starRatingView)
        ratingView.backgroundColor = .clear
    }
    
    
    
    
}

