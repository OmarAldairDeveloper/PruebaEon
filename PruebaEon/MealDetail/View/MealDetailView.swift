//
//  MealDetail.swift
//  PruebaEon
//
//  Created by Omar Aldair on 20/05/24.
//

import SwiftUI

struct MealDetailView: View {
    @Environment(\.presentationMode) var navigation
    let id: String
    let name: String
    @State var isLoading = false
    @State var mealDetail = Meal(idMeal: "", strMeal: "", strDrinkAlternate: nil, strCategory: "", strArea: "", strInstructions: "", strMealThumb: "", strTags: nil, strYoutube: "", strIngredient1: nil, strIngredient2: nil, strIngredient3: nil, strIngredient4: nil, strIngredient5: nil, strIngredient6: nil, strIngredient7: nil, strIngredient8: nil, strIngredient9: nil, strIngredient10: nil, strIngredient11: nil, strIngredient12: nil, strIngredient13: nil, strIngredient14: nil, strIngredient15: nil, strIngredient16: nil, strIngredient17: nil, strIngredient18: nil, strIngredient19: nil, strIngredient20: nil, strMeasure1: nil, strMeasure2: nil, strMeasure3: nil, strMeasure4: nil, strMeasure5: nil, strMeasure6: nil, strMeasure7: nil, strMeasure8: nil, strMeasure9: nil, strMeasure10: nil, strMeasure11: nil, strMeasure12: nil, strMeasure13: nil, strMeasure14: nil, strMeasure15: nil, strMeasure16: nil, strMeasure17: nil, strMeasure18: nil, strMeasure19: nil, strMeasure20: nil, strSource: nil, strImageSource: nil, strCreativeCommonsConfirmed: nil, dateModified: nil)

    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Spacer()
                    
                    Text(name)
                        .font(.system(size: 14, weight: .bold))

                    Spacer()
                }
                .padding(.top, 54)
                .padding(.leading)
                .padding(.bottom, 8)
                
                HStack {
                    Button {
                        withAnimation(.spring) {
                            navigation.wrappedValue.dismiss()
                        }
                    } label: {
                        Image(systemName: "arrow.backward")
                            .font(.system(size: 20))
                            .foregroundColor(Color.black)
                        
                    }

                    Spacer()
                }
                .padding(.top, 54)
                .padding(.leading)
                .padding(.bottom, 8)
            }
            
            if !isLoading {
                ScrollView {
                  
                        VStack(alignment: .leading, spacing: 16) {
                 
                            if let url = URL(string: mealDetail.strMealThumb) {
                                AsyncImage(url: url) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxWidth: .infinity)
                                } placeholder: {
                                    ProgressView()
                                }
                            }

                            Text(mealDetail.strMeal)
                                .font(.title)
                                .fontWeight(.bold)
                                .padding(.horizontal)

                            Text("Category: \(mealDetail.strCategory)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .padding(.horizontal)

                            Text(mealDetail.strInstructions)
                                .font(.body)
                                .padding(.horizontal)

                            Text("Ingredients:")
                                .font(.headline)
                                .padding([.top, .horizontal])

                            VStack(alignment: .leading, spacing: 8) {
                                let ingredients = mealDetail.getIngredients()
                                let measures = mealDetail.getMeasures()
                                
                                ForEach(0..<ingredients.count, id: \.self) { index in
                                    if index < measures.count {
                                        Text("• \(ingredients[index]) - \(measures[index])")
                                            .font(.body)
                                            .padding(.horizontal)
                                    } else {
                                        Text("• \(ingredients[index])")
                                            .font(.body)
                                            .padding(.horizontal)
                                    }
                                }
                            }
                            .padding(.bottom)
                        }
                    
                    
                }
            }
           
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            isLoading = true
            ServiceManager.shared.fetchMealDetails(by: id) { result in
                switch result {
                case .success(let mealResponse):
                    self.mealDetail = mealResponse.meals[0]
                    self.isLoading = false
                 case .failure(_):
                    self.isLoading = false
                    break
                 }
            }
        }
        .navigationBarBackButtonHidden()
    }
}
