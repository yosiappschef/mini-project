//
//  HomeModel.swift
//  sampleCRUD
//
//  Created by apcmbp23 on 01/11/23.
//

import Foundation

struct BannerModel {
    let image: String
}

var bannerMokup = [
    BannerModel(image: "image_banner"),
    BannerModel(image: "image_banner"),
    BannerModel(image: "image_banner"),
    BannerModel(image: "image_banner"),
    BannerModel(image: "image_banner"),
    BannerModel(image: "image_banner"),
    BannerModel(image: "image_banner"),
    BannerModel(image: "image_banner"),
    BannerModel(image: "image_banner")
]

var banner = [
    BannerModel(image: "image_banner"),
    BannerModel(image: "image_banner"),
]

enum Banner {
    struct Request {
        var page: Int
    }
}
