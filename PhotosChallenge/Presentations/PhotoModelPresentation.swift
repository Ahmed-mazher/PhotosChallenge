//
//  PhotoModelPresentation.swift
//  PhotosChallenge
//
//  Created by Front Tech on 18/05/2022.
//

import Foundation


final class PhotoModelPresentation : NSObject {
    let id : String?
    let owner : String?
    let secret : String?
    let server : String?
    let farm : Int?
    let title : String?
    let ispublic : Int?
    let isfriend : Int?
    let isfamily : Int?

    init(id: String?, owner: String?, secret: String?, server: String?, farm: Int?, title: String?, ispublic: Int?, isfriend: Int?, isfamily: Int?){
        self.id = id
        self.owner = owner
        self.secret = secret
        self.server = server
        self.farm = farm
        self.title = title
        self.ispublic = ispublic
        self.isfriend = isfriend
        self.isfamily = isfamily
    }

    convenience init(photo: Photo) {
        self.init(id: photo.id, owner: photo.owner, secret: photo.secret, server: photo.server, farm: photo.farm, title: photo.title, ispublic: photo.ispublic, isfriend: photo.isfriend, isfamily: photo.isfamily)
    }

    override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? PhotoModelPresentation else { return false }
        return self.id == other.id && self.owner == other.owner && self.secret == other.secret && self.server == other.server && self.farm == other.farm && self.title == other.title && self.ispublic == other.ispublic && self.isfriend == other.isfriend && self.isfamily == other.isfamily
    }
}

//final class PhotoModelPresentation : NSObject {
//    let photos : Photos
//    let stat : String
//
//    init(photos: Photos, stat: String){
//        self.photos = photos
//        self.stat = stat
//
//    }
//
//    convenience init(photoModel: PhotosModel) {
//        self.init(photos: photoModel.photos, stat: photoModel.stat)
//    }
//
//    override func isEqual(_ object: Any?) -> Bool {
//        guard let other = object as? PhotoModelPresentation else { return false }
//        return self.photos == other.photos && self.stat == other.stat
//    }
//}
