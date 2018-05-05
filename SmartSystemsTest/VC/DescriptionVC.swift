//
//  DescriptionVC.swift
//  SmartSystemsTest
//
//  Created by Dima Paliychuk on 5/5/18.
//  Copyright © 2018 Dima Paliychuk. All rights reserved.
//

import Foundation
import UIKit
import GiphyCoreSDK
import SwiftyGif


class DescriptionVC: UIViewController {
    
    @IBOutlet private weak var userAvatarImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var sourseLabel: UILabel!
    @IBOutlet private weak var tagsLabel: UILabel!
    @IBOutlet private weak var backButton: UIButton!
    
    private var media: GPHMedia!
    
    
    //MARK: life cycle
    
    class func show(from: UIViewController, media: GPHMedia) {
        let vc = UIStoryboard.main.instantiateViewController(
            withIdentifier: Constants.VcId.descriptionVC
        ) as! DescriptionVC
        
        vc.modalTransitionStyle = .flipHorizontal
        vc.media = media
        
        from.present(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    //MARK: private
    
    private func setupUI() {
        backButton.setTitle("back".localized, for: .normal)
        if let strUrl = media.user?.avatarUrl,
            let url = URL(string: strUrl) {
            userAvatarImageView.setGifFromURL(url)
        }
        userNameLabel.text = media.user?.name ?? "-"
        let sourse = media.source ?? "-"
        sourseLabel.text = "sourse".localized + " :\n" + sourse
        var allTags = "-"
        if let tags = media.tags {
            allTags = ""
            for tag in tags {
                allTags += tag + "\n"
            }
        }
        tagsLabel.text = "tags".localized + " :\n" + allTags
    }
    
    
    //MARK: actions
    
    @IBAction private func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
