//
//  ViewController.swift
//  PhotosChallenge
//
//  Created by Front Tech on 18/05/2022.
//


import Foundation
import UIKit
import RxSwift
import RxCocoa


class PhotosViewController: UIViewController, UIScrollViewDelegate {
    
    var imagesTableView: UITableView = {
        let cryptTableView = UITableView()
        cryptTableView.rowHeight = 100
        cryptTableView.backgroundColor = .white
        cryptTableView.separatorColor = UIColor.systemGray4.withAlphaComponent(0.2)
        cryptTableView.register(PhotosTVCell.self, forCellReuseIdentifier: PhotosTVCell.reusId)
        return cryptTableView
    }()
    
    let activityIndicatorview = UIActivityIndicatorView()
    let viewModel = PhotosViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Fliker Photos"
        self.view.backgroundColor = .white
        configureTableView()
        setupBinding()
    }
    
    func configureTableView() {
        view.addSubview(imagesTableView)
        imagesTableView.frame = view.bounds
    }
    
    func setupBinding(){
        viewModel.loading.asObservable()
            .observe(on: MainScheduler.instance)
            .bind(to: activityIndicatorview.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel.loadPageTrigger.onNext(())
        
        viewModel.flikrImages.bind(to: imagesTableView.rx.items(cellIdentifier: PhotosTVCell.reusId, cellType: PhotosTVCell.self)) { index, item, cell in
            cell.imageTitle.text = item.title
            cell.imageOwner.text = "Owner: \(item.owner ?? "")"
            cell.imageImageView.setImage(imageUrl:"http://farm\(item.farm ?? 66).static.flickr.com/\(item.server ?? "")/\(item.id ?? "")_\(item.secret ?? "").jpg")
        }.disposed(by: disposeBag)
        
        
        imagesTableView.rx.modelSelected(PhotoModelPresentation.self)
            .subscribe(onNext: { [weak self] item in
                guard let self = self else { return }
                if let showVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PhotoShowViewController") as? PhotoShowViewController {
                    showVC.setupUI(item: item)
                   self.present(showVC, animated: true)
                }
            }).disposed(by: disposeBag)
        
        imagesTableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        imagesTableView.rx.reachedBottom
            .bind(to: viewModel.loadNextPageTrigger)
            .disposed(by: disposeBag)
    }
}

