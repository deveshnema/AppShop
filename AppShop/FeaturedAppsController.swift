//
//  ViewController.swift
//  AppShop
//
//  Created by Devesh Nema on 5/23/18.
//  Copyright © 2018 Devesh Nema. All rights reserved.
//

import UIKit

private let cellid = "cellid"
private let largecellid = "largecellid"
private let headerid = "headerid"

class FeaturedAppsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var featuredApps: FeaturedApps? {
        didSet {
            DispatchQueue.main.async(execute: { () -> Void in
                self.collectionView?.reloadData()
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Featured Apps"
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: cellid)
        collectionView?.register(LargeCategoryCell.self, forCellWithReuseIdentifier: largecellid)
        collectionView?.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerid)
        loadJsonData()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = featuredApps?.categories?.count {
            return count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let celltype = featuredApps?.categories?[indexPath.item].type, celltype == "large" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: largecellid, for: indexPath) as! LargeCategoryCell
            cell.appCategory = featuredApps?.categories?[indexPath.item]
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath) as! CategoryCell
        cell.appCategory = featuredApps?.categories?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 2 {
            return CGSize(width: view.frame.width, height: 160)
        }
        return CGSize(width: view.frame.width, height: 230)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerid, for: indexPath) as! HeaderCell
        header.appCategory = featuredApps?.bannerCategory
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
    
    func loadJsonData() {
        let jsonurl = "https://api.letsbuildthatapp.com/appstore/featured"
        guard let url = URL(string: jsonurl) else {return}
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            guard let data = data else { return }
            if let error = error {
                print(error)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                self.featuredApps = try decoder.decode(FeaturedApps.self, from: data)
            } catch let err {
                print(err)
            }
        }) .resume()
    }
    
    
}

























