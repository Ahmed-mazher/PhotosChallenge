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
        let photosTableView = UITableView()
        photosTableView.rowHeight = 100
        photosTableView.backgroundColor = .white
        photosTableView.separatorColor = UIColor.systemGray4.withAlphaComponent(0.2)
        photosTableView.register(PhotosTVCell.self, forCellReuseIdentifier: PhotosTVCell.reusId)
        photosTableView.register(AdBannerTVCell.self, forCellReuseIdentifier: AdBannerTVCell.reusId)
        return photosTableView
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
        
        viewModel.flikrImages.bind(to: imagesTableView.rx.items) { [weak self] tableView, row, item in
            
            let indexPath = IndexPath(row: row, section: 0)
            let index = indexPath.row + 1
            if index % 6 == 0 {
                
                let cell = self?.imagesTableView.dequeueReusableCell(withIdentifier: AdBannerTVCell.reusId, for: indexPath) as! AdBannerTVCell
                // Configure the cell
                
                return cell
            }else {
                let cell = self?.imagesTableView.dequeueReusableCell(withIdentifier: PhotosTVCell.reusId, for: indexPath) as! PhotosTVCell
                // Configure the cell
                cell.imageTitleLabel.text = item.title
                cell.imageOwnerLabel.text = "Owner: \(item.owner ?? "")"
                cell.imageImageView.setImage(imageUrl:"http://farm\(item.farm ?? 66).static.flickr.com/\(item.server ?? "")/\(item.id ?? "")_\(item.secret ?? "").jpg")
                return cell
            }
            
            
        }.disposed(by: disposeBag)
        
        
        imagesTableView.rx.modelSelected(PhotoModelPresentation.self)
            .subscribe(onNext: { [weak self] item in
                guard let self = self else { return }
                let index = (self.imagesTableView.indexPathForSelectedRow?.row ?? 0) + 1
                if index % 6 == 0 {
                    //action for ad banner image
                }else{
                    if let showVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PhotoShowViewController") as? PhotoShowViewController {
                        showVC.setupUI(item: item)
                        self.present(showVC, animated: true)
                    }
                }
                
            }).disposed(by: disposeBag)
        
        imagesTableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        imagesTableView.rx.reachedBottom
            .bind(to: viewModel.loadNextPageTrigger)
            .disposed(by: disposeBag)
    }
}

