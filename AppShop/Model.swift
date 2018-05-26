//
//  Model.swift
//  AppShop
//
//  Created by Devesh Nema on 5/25/18.
//  Copyright © 2018 Devesh Nema. All rights reserved.
//

import Foundation

struct App : Decodable {
    var Id: Int?
    var Name: String?
    var Category: String?
    var Price: Double?
    var ImageName: String?
}


struct AppCategory : Decodable {
    var name: String?
    var apps: [App]?
    var type: String?
}

struct FeaturedApps: Decodable {
    var bannerCategory: AppCategory?
    var categories: [AppCategory]?
}
