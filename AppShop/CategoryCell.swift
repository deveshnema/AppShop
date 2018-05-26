//
//  CategoryCell.swift
//  AppShop
//
//  Created by Devesh Nema on 5/23/18.
//  Copyright © 2018 Devesh Nema. All rights reserved.
//

import UIKit

private let appcellid = "appcellid"

class CategoryCell : UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var appCategory: AppCategory? {
        didSet {
            if let name = appCategory?.name {
                categoryLabel.text = name
            }
            appsCollectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = appCategory?.apps?.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: appcellid, for: indexPath) as! AppCell
        cell.app = appCategory?.apps?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: frame.height - 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
    
    let categoryLabel : UILabel = {
        let label = UILabel()
        label.text = "Best New Apps"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let appsCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let dividerLineView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setupViews() {
        backgroundColor = UIColor.clear
        addSubview(categoryLabel)
        addSubview(appsCollectionView)
        addSubview(dividerLineView)
        
        appsCollectionView.delegate = self
        appsCollectionView.dataSource = self
        appsCollectionView.register(AppCell.self, forCellWithReuseIdentifier: appcellid)
        
        
        categoryLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        categoryLabel.bottomAnchor.constraint(equalTo: appsCollectionView.topAnchor).isActive = true
        categoryLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 14).isActive = true
        categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        appsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        appsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        dividerLineView.topAnchor.constraint(equalTo: appsCollectionView.bottomAnchor).isActive = true
        dividerLineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        dividerLineView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        dividerLineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 14).isActive = true
        dividerLineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
}

class AppCell : UICollectionViewCell {
    var app: App? {
        didSet {
            if let name = app?.Name {
                nameLabel.text = name
            }
            if let imageName = app?.ImageName {
                imageView.image = UIImage(named: imageName)
            }
            if let price = app?.Price {
                priceLabel.text = "$ \(price)"
            }
            if let category = app?.Category {
                categoryLabel.text = category
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "app1")
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 16
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.text = "Workspace Buddy Pro II"
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let categoryLabel : UILabel = {
        let label = UILabel()
        label.text = "Productivity"
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.darkGray
        return label
    }()
    
    let priceLabel : UILabel = {
        let label = UILabel()
        label.text = "$4.99"
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.darkGray
        return label
    }()
    
    func setupViews() {
        backgroundColor = UIColor.white
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(categoryLabel)
        addSubview(priceLabel)
        
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 2).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        categoryLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2).isActive = true
        categoryLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        categoryLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
        categoryLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        priceLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 2).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
}



class LargeCategoryCell : CategoryCell {
    private let largeAppCellid = "largeAppCellid"
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: frame.height - 40)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: largeAppCellid, for: indexPath) as! LargeAppCell
        cell.app = appCategory?.apps?[indexPath.item]
        return cell
    }
    
    override func setupViews() {
        super.setupViews()
        appsCollectionView.register(LargeAppCell.self, forCellWithReuseIdentifier: largeAppCellid)
    }
}


class LargeAppCell : AppCell {
    override func setupViews() {
        addSubview(imageView)
        
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -14).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
}



class HeaderCell : CategoryCell {
    private let bannerCellid = "bannerCellid"
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width/2 + 50, height: frame.height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bannerCellid, for: indexPath) as! BannerCell
        cell.app = appCategory?.apps?[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    override func setupViews() {
        appsCollectionView.register(BannerCell.self, forCellWithReuseIdentifier: bannerCellid)
        appsCollectionView.delegate = self
        appsCollectionView.dataSource = self
        
        addSubview(appsCollectionView)
        appsCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        appsCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        appsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        appsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
}

class BannerCell : AppCell {
    override func setupViews() {
        addSubview(imageView)
        imageView.layer.cornerRadius = 0
        imageView.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        imageView.layer.borderWidth = 0.5
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
}


















