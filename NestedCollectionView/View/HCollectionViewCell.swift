//
//  HCollectionView+Cell.swift
//  NestedCollectionView
//
//  Created by Mike Saradeth on 3/31/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import UIKit

class HCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "HCollectionViewCell"
    let isFavoriteImage = UIImage(named: "MyFavorite")
    let notFavoriteImage = UIImage(named: "NotMyFavorite")
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var favImageView: UIImageView!
    @IBOutlet weak var favContentView: UIView!
    var item: Cat!

    func configure(item: Cat) {
        self.item = item
        addTapGestureRecognizer(view: favContentView)
        
        // Set cat and favorite images
        favImageView.image = (Cache.isFavorite[item.id] ?? false) ? isFavoriteImage : notFavoriteImage
        if let image = Cache.image[item.id] {
            imageView.image = image
        }else {
            DispatchQueue.global().async {
                guard let imageURL = URL(string: item.url),
                    let imageData = try? Data(contentsOf: imageURL),
                    let image =  UIImage(data: imageData) else { return }
                Cache.image[item.id] = image
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }

    private func addTapGestureRecognizer(view: UIView) {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tabPressed(_:)))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    // Toggle favorite
    @IBAction func tabPressed(_ sender: UITapGestureRecognizer) {
        Cache.isFavorite[item.id] = !(Cache.isFavorite[item.id] ?? false)
        favImageView.image = (Cache.isFavorite[item.id] ?? false) ? isFavoriteImage : notFavoriteImage
    }
    
    deinit {
        print("deinit - HCollectionViewCell")
    }
}

