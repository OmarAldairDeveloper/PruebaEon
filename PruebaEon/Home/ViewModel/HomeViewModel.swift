//
//  HomeViewModel.swift
//  PruebaEon
//
//  Created by Omar Aldair on 19/05/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var randomMeals = [Meal]()
    @Published var reduceMeals = [ReduceMeal]()
    @Published var categories = [Category]()
    @Published var counter = 0
    @Published var isLoading = false
    
    init() {
        getRandomMeals()
    }
    
    func getRandomMeals() {
        ServiceManager.shared.fetchRandomMeal { result in
            switch result {
             case .success(let mealResponse):
                DispatchQueue.main.async {
                    self.randomMeals.append(mealResponse.meals[0])
                    self.counter += 1
                    if self.counter < 3 {
                        self.getRandomMeals()
                    }
                }
             case .failure(_):
                break
             }
        }
    }
    
    func getMealsFor(category: String) {
        self.randomMeals.removeAll()
        ServiceManager.shared.fetchMealsFor(category: category) { result in
            switch result {
             case .success(let mealResponse):
                DispatchQueue.main.async {
                    self.reduceMeals = mealResponse.meals
                }
             case .failure(_):
                break
             }
        }
    }
    
    func getCategories() {
        self.categories.removeAll()
        ServiceManager.shared.fetchCategories { result in
            switch result {
             case .success(let categoriesResponse):
                DispatchQueue.main.async {
                    self.categories = categoriesResponse.categories
                }
             case .failure(_):
                break
             }
        }
    }
}
