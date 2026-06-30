//
//  ServiceDTO.swift
//  MTGAPPIosRepaso
//
//  Created by Tardes on 30/6/26.
//
struct Product: Codable{
    let id: Int
    let title: String
    let description: String
    let category: String
    let price: Double
    let discountPercentage: Double
    let rating: Double
    let images: [String]
    let thumbnail: String
}

struct ProductList: Codable{
    let products: [Product]
}
