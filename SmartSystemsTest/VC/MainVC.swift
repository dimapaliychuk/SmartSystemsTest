//
//  MainVC.swift
//  SmartSystemsTest
//
//  Created by Dima Paliychuk on 5/4/18.
//  Copyright © 2018 Dima Paliychuk. All rights reserved.
//

import UIKit
import GiphyCoreSDK
import SwiftyGif

class MainVC: UIViewController {

    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var imageCollectionView: UICollectionView!
    
    private var media = [GPHMedia]()
    private let refreshControl = UIRefreshControl()
    
    //MARK: life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    //MARK: private
    
    private func setupUI() {
        searchTextField.placeholder = "enter_text".localized
        searchButton.setTitle("search".localized, for: .normal)
        
        imageCollectionView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refreshControl.attributedTitle = NSAttributedString(string: "fetching_data".localized)
    }
    
    
    //MARK: actions

    @IBAction private func searchButtonAction(_ sender: Any) {
        fetchData()
    }
    
    @objc private func refreshData(_ sender: Any) {
        fetchData()
    }
    
    private func fetchData() {
        guard let tag = searchTextField.text else {
            return
        }
        GPHManager.shared.getImagesBy(tag: tag) { [weak self] (result, error) in
            DispatchQueue.main.async {
                guard let media = result?.data else {
                    return
                }
                self?.media = media
                self?.imageCollectionView.reloadData()
                self?.refreshControl.endRefreshing()
            }
        }
    }
}


//UICollectionView

extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return media.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath as IndexPath) as! ImageCollectionViewCell
        
        if let strUrl = media[indexPath.item].images?.original?.gifUrl,
            let url = URL(string: strUrl) {
            cell.imageView.setGifFromURL(url)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        DescriptionVC.show(from: self, media: media[indexPath.item])
    }
}
