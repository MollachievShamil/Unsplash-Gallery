//
//  PhotoModel.swift
//  TestApp
//
//  Created by Шамиль Моллачиев on 03.02.2022.
//


import Foundation


struct PhotoModel: Codable {
    let urls: Urls?
    let created_at: String?
    let downloads: Int?
    let user: User?
}

struct Urls: Codable {
    let raw: String?
    let full: String?
    let regular: String?
    let small: String?
    let thumb: String?
    
}

struct User: Codable {
    let name: String?
    let location: String?
}
