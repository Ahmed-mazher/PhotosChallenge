//
//  AdBannerTVCell.swift
//  PhotosChallenge
//
//  Created by Front Tech on 19/05/2022.
//

import Foundation
import UIKit


class AdBannerTVCell: UITableViewCell {
    
    static let reusId = "AdBannerTVCell"
    
    var bannerImage: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 16
        iv.image = UIImage(named: "banner image")
        return iv
    }()
    
   
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        backgroundColor = .white
    }
    
    private func configure(){
        addSubview(bannerImage)
        bannerImage.translatesAutoresizingMaskIntoConstraints = false
        bannerImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
        bannerImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        bannerImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        bannerImage.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
