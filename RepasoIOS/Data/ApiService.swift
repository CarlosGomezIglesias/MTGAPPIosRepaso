//
//  ApiService.swift
//  MTGAPPIosRepaso
//
//  Created by Tardes on 30/6/26.
//
import Foundation



class ApiService {
    
    static let BASE_URL = "https://dummyjson.com/products"
    
    static func searchProductByCategory(_ query: String) async -> [Product] {
        guard let url = URL(string: "\(BASE_URL)/category/q=\(query)") else {
            print ("Invalid URL")
            return []
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            return try JSONDecoder().decode(ProductList.self, from: data).products
        }catch {
            print("Invalid data")
            return []
        }
    }
    
    static func getProductById(_ id: Int) async -> Product? {
        guard let url = URL(string: "\(BASE_URL)/\(id)") else {
            print ("Invalid URL")
            return nil
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            return try JSONDecoder().decode(Product.self, from: data)
        }catch {
            print("Invalid data")
            return nil
        }
    }
    
    static func getProductList() async -> [Product] {//limit=0 devuelve todas las recetas, lo suyo es hacerlo paginado
        guard let url = URL(string: "\(BASE_URL)?limit=0") else {
            print ("Invalid URL")
            return []
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            return try JSONDecoder().decode(ProductList.self, from: data).products
        }catch {
            print(error.localizedDescription)
            print("Invalid data")
            return []
        }
    }
    
    
}

