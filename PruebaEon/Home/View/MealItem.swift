//
//  MealItem.swift
//  PruebaEon
//
//  Created by Omar Aldair on 19/05/24.
//

import SwiftUI

struct MealItem: View {
    let meal: Meal
    
    var body: some View {
        VStack {
            Text(meal.strMeal)
                .font(.headline)
                .padding(.vertical, 12)
            
            if let url = URL(string: meal.strMealThumb) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 200)
                        .cornerRadius(8)
                        .clipped()
                        
                } placeholder: {
                    ProgressView()
                }
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 200)
                    .cornerRadius(8)
                    .clipped()
                
            }
        }
        .padding()
        .frame(width: screen.width * 0.8)
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

struct ReduceMealItem: View {
    let meal: ReduceMeal
    var onClick: (String, String) -> Void
    
    var body: some View {
        VStack {
            Text(meal.strMeal)
                .font(.headline)
                .padding(.vertical, 12)
            
            if let url = URL(string: meal.strMealThumb) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 200)
                        .cornerRadius(8)
                        .clipped()
                        
                } placeholder: {
                    ProgressView()
                }
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 200)
                    .cornerRadius(8)
                    .clipped()
                
            }
        }
        .padding()
        .frame(width: screen.width * 0.8)
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .onTapGesture {
            onClick(meal.idMeal, meal.strMeal)
        }
    }
}

