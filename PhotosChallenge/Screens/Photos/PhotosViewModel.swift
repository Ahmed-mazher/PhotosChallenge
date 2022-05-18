//
//  PhotosViewModel.swift
//  PhotosChallenge
//
//  Created by Front Tech on 18/05/2022.
//

import Foundation
import RxSwift
import RxCocoa


class PhotosViewModel {
    
    var newsService: PhotosServiceProtocol
    var page = 1
    let flikrImages: BehaviorSubject<[PhotoModelPresentation]> = .init(value: [])
    let loading: Observable<Bool>
    var loadPageTrigger: PublishSubject<Void>
    var loadNextPageTrigger: PublishSubject<Void>
    var loadingIndicator: ActivityIndicator!
    private let error = PublishSubject<Swift.Error>()
    
    private let disposeBag = DisposeBag()
            
    init(newsService: PhotosServiceProtocol = ApiService()){
        loadingIndicator = ActivityIndicator()
        loading = loadingIndicator.asObservable()
        loadPageTrigger = PublishSubject()
        loadNextPageTrigger = PublishSubject()
        
        self.newsService = newsService
        
        let firstRequest = self.loading
            .sample(self.loadPageTrigger)
            .flatMap { [weak self] loading -> Observable<[PhotoModelPresentation]> in
                guard let self = self else { fatalError()}
                if loading {
                    return Observable.empty()
                }else {
                    self.page = 1
                    self.flikrImages.onNext([])
                    let flikrImages = self.newsService.fetchImages(page: self.page).map({ items in items })
                    let mappedFlikrImages = flikrImages.map({ items in items.map({ item  in PhotoModelPresentation(photo: item) }) })
                    return mappedFlikrImages
                        .trackActivity(self.loadingIndicator)
                }
            }
        
        let nextRequest = self.loading
            .sample(loadNextPageTrigger)
            .flatMap { [weak self] isLoading -> Observable<[PhotoModelPresentation]> in
                guard let self = self else { fatalError() }
                if isLoading {
                    return Observable.empty()
                }else {
                    self.page = self.page + 1
                    let cryptoNews = self.newsService.fetchImages(page: self.page).map({  items in items })
                    let mappedCryptoNews = cryptoNews.map({ items in items.map({ item  in PhotoModelPresentation(photo: item) }) })
                    return mappedCryptoNews
                        .trackActivity(self.loadingIndicator)
                }
            }
        
        let request = Observable.of(firstRequest, nextRequest)
            .merge()
            .share(replay: 1)
        
        let response = request
            .flatMapLatest { images -> Observable<[PhotoModelPresentation]> in
                request
                    .do(onError: { _error in
                        self.error.onNext(_error)
                    }).catch({ error -> Observable<[PhotoModelPresentation]> in
                        Observable.empty()
                    })
            }
            .share(replay: 1)
        
        Observable
            .combineLatest(request, response, flikrImages.asObservable()) { request, response, images in
                return self.page == 1 ? response : images + response
            }
            .sample(response)
            .bind(to: flikrImages)
            .disposed(by: disposeBag)
    }
}




