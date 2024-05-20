//
//  CategoryItem.swift
//  PruebaEon
//
//  Created by Omar Aldair on 19/05/24.
//

import SwiftUI

struct CategoryItem: View {
    let category: Category
    var onSelected: (String) -> Void
    
    var body: some View {
        HStack {
            if let url = URL(string: category.strCategoryThumb) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 60)
                        .cornerRadius(8)
                        .clipped()
                        
                } placeholder: {
                    ProgressView()
                }
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 60)
                    .cornerRadius(8)
                    .clipped()
                
            }
            
            VStack {
                Text(category.strCategory)
                    .font(.headline)
                
                Text(category.strCategoryDescription)
                    .font(.subheadline)
            }
           
            
        }
        .padding()
        .frame(width: screen.width * 0.9)
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .onTapGesture {
            onSelected(category.strCategory)
        }
    }
}

