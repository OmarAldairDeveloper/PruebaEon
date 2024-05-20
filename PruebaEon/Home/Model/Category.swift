//
//  Category.swift
//  PruebaEon
//
//  Created by Omar Aldair on 19/05/24.
//

import Foundation

struct CategoryResponse: Decodable {
    let categories: [Category]
}

struct Category: Decodable {
    let idCategory: String
    let strCategory: String
    let strCategoryThumb: String
    let strCategoryDescription: String
}

enum ServiceError: Error {
    case invalidURL
    case noData
}
