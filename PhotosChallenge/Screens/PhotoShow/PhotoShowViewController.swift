//
//  PhotoShowViewController.swift
//  PhotosChallenge
//
//  Created by Front Tech on 18/05/2022.
//

import UIKit

class PhotoShowViewController: UIViewController {

    var imageImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureImageView()
    }
    
    func setupUI(item: PhotoModelPresentation) {        
        imageImageView.setImage(imageUrl: "http://farm\(item.farm ?? 66).static.flickr.com/\(item.server ?? "")/\(item.id ?? "")_\(item.secret ?? "").jpg")
    }
    
    func configureImageView() {
        view.addSubview(imageImageView)
        imageImageView.frame = view.bounds
    }
    
}


