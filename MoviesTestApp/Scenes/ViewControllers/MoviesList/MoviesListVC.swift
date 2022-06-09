//
//  MoviesListVC.swift
//  MoviesTestApp
//
//  Created by Macbook PRO on 08/06/2022.
//

import UIKit
import Foundation
import ObjectMapper
import SDWebImage



class MoviesListVC: UIViewController {
    @IBOutlet weak var Moviecollection: UICollectionView!
    @IBOutlet weak var rollingImg: UIImageView!
    
    var fruits = ["apple", "banana", "orange"]
    var presenter: MoviePresenter!
    var movies = [MoviesListRS]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        rollingImg.rotate360Degrees()
        
        
        Moviecollection.dataSource = self
        Moviecollection.delegate = self
        
        Moviecollection.register(UINib(nibName: "MoviesListCell", bundle: Bundle.main), forCellWithReuseIdentifier: "MoviesListCell")
        
        self.view.backgroundColor = .black
        Moviecollection.delaysContentTouches = false
        
        self.presenter = MoviePresenter(view: self)
        presenter.retrieveNotification()
        
        Moviecollection.reloadData()
    }
}


extension MoviesListVC: UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesListCell", for: indexPath) as! MoviesListCell
        
        customCell.lblfruta.text = movies[indexPath.row].title
        
        let imageURL = URL(string: "https://image.tmdb.org/t/p/w500/" + movies[indexPath.row].poster)!
        
        customCell.PosterImg.sd_setImage(with: imageURL)
        customCell.layer.cornerRadius = 15
        customCell.backgroundColor = .white
        customCell.lblfruta.textColor = .black
        return customCell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.5, delay: 0, options: .beginFromCurrentState, animations: {
            cell?.transform = CGAffineTransform(scaleX: 0.90, y: 0.90)
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.5, delay: 0, options: .beginFromCurrentState, animations: {
            cell?.transform = .identity
        })
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
        cell.alpha = 0
        UIView.animate(withDuration: 0.6) {
            cell.alpha = 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let MovieDetails = movies[indexPath.row].taskId
        let pageView = MovieDetailsVC()
        pageView.taskId = movies[indexPath.row].taskId
        self.present(pageView, animated: true, completion: nil)
        
    }
    
}


extension MoviesListVC: MovieView {
    func moviesRetrieved(mytasks: [MoviesListRS]) {
        self.movies = mytasks
        Moviecollection.reloadData()
    }
}


extension UIView {
    func rotate360Degrees(duration: CFTimeInterval = 6) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 2)
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.duration = duration
        rotateAnimation.repeatCount=Float.infinity
        self.layer.add(rotateAnimation, forKey: nil)
    }
}



