//
//  SplashScreen.swift
//  MoviesTestApp
//
//  Created by Macbook PRO on 08/06/2022.
//

import UIKit
import SwiftyGif

class SplashScreen: UIViewController {
    
    let logoAnimationView = LogoAnimationView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(named: "BKColor")
        view.addSubview(logoAnimationView)
        logoAnimationView.pinEdgesToSuperView()
        logoAnimationView.logoGifImageView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logoAnimationView.logoGifImageView.startAnimatingGif()
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//             your code here

            let pageView = MoviesListVC()
            pageView.modalPresentationStyle = .overCurrentContext
            self.present(pageView, animated: false, completion: nil)

        }
        
        
    }

    

}

 
extension SplashScreen: SwiftyGifDelegate {
    func gifDidStop(sender: UIImageView) {
        logoAnimationView.isHidden = true
        
//        let pageView = ThemoviesVC()
//        pageView.modalPresentationStyle = .overCurrentContext
//
//        self.present(pageView, animated: true, completion: nil)
     }
}
