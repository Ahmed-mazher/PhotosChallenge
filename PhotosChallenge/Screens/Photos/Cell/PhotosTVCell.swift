//
//  PhotosTVCell.swift
//  PhotosChallenge
//
//  Created by Front Tech on 18/05/2022.
//

import Foundation
import UIKit


class PhotosTVCell: UITableViewCell {
    
    static let reusId = "PhotosTVCell"
    
    var imageImageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 16
        iv.widthAnchor.constraint(equalToConstant: 80).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 80).isActive = true
        return iv
    }()
    
    var imageTitle: UILabel = {
        let nwttl = UILabel()
        nwttl.textColor = .black
        nwttl.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        nwttl.numberOfLines = 3
        return nwttl
    }()
    
    var imageOwner: UILabel = {
        let nwttl = UILabel()
        nwttl.textColor = .systemGray
        nwttl.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        nwttl.textAlignment = .right
        return nwttl
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
        
        let labelsStackView = UIStackView(arrangedSubviews: [
            imageTitle , imageOwner
        ])
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 10
        
        let stackView = UIStackView(arrangedSubviews: [
            imageImageView, labelsStackView
        ])
        stackView.spacing = 10
        stackView.alignment = .center
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
