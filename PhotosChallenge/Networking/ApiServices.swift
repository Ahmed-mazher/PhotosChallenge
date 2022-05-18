//
//  ApiServices.swift
//  PhotosChallenge
//
//  Created by Front Tech on 18/05/2022.
//

import Foundation
import RxSwift
import Alamofire


protocol PhotosServiceProtocol {
    func fetchImages(page: Int) -> Observable<[Photo]>
}


class ApiService: PhotosServiceProtocol {
    
    func fetchImages(page: Int) -> Observable<[Photo]> {
        return request(url: URL(string: "https://www.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=50&text=Color&page=\(page)&per_page=20&api_key=d17378e37e555ebef55ab86c4180e8dc")!)
    }
    
   
    
    func request(url: URL) -> Observable<[Photo]> {
        return Observable.create { observer -> Disposable in
            AF.request(url).responseData { (response) in
                switch response.result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .iso8601
                        let response = try decoder.decode(PhotosModel.self, from: data)
                        observer.onNext((response.photos?.photo!)!)
                        observer.onCompleted()
                    } catch {
                        observer.onError(error)
                    }
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create {
                
            }
        }
    }
}
