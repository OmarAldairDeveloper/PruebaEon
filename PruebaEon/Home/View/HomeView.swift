//
//  ContentView.swift
//  PruebaEon
//
//  Created by Omar Aldair on 19/05/24.
//

import SwiftUI

struct HomeView: View {
    @State var showSideBar = false
    @StateObject var homeViewModel = HomeViewModel()
    @State var selectedMenu: Menu = .home
    @State var currentCategory = ""
    @State var currentMealId = ""
    @State var currentMealName = ""
    @State var goToMealDetail = false
    var body: some View {
        NavigationView {
            ZStack(alignment: .leading) {
                VStack {
                    ZStack {
                        HStack {
                            Spacer()
                            
                            Text(getTitle())
                                .font(.system(size: 14, weight: .bold))

                            Spacer()
                        }
                        .padding(.top, 54)
                        .padding(.leading)
                        .padding(.bottom, 8)
                        
                        HStack {
                            Button {
                                withAnimation(.spring) {
                                    if selectedMenu == .reduceMeals {
                                        selectedMenu = .categories
                                    } else {
                                        showSideBar = true
                                    }
                                 
                                }
                            } label: {
                                Image(systemName: selectedMenu == .reduceMeals ? "arrow.backward" : "line.3.horizontal")
                                    .font(.system(size: 20))
                                    .foregroundColor(Color.black)
                                
                            }

                            Spacer()
                        }
                        .padding(.top, 54)
                        .padding(.leading)
                        .padding(.bottom, 8)
                    }

                    if selectedMenu == .home {
                        ScrollView(showsIndicators: false) {
                            ForEach(0..<homeViewModel.randomMeals.count, id: \.self) { idx in
                                MealItem(meal: homeViewModel.randomMeals[idx])
                            }
                        }
                    } else if selectedMenu == .categories {
                        ScrollView(showsIndicators: false) {
                            ForEach(0..<homeViewModel.categories.count, id: \.self) { idx in
                                CategoryItem(category: homeViewModel.categories[idx], onSelected: { category in
                                    selectedMenu = .reduceMeals
                                    currentCategory = category
                                    homeViewModel.getMealsFor(category: category)
                                })
                            }
                        }
                    } else {
                        ScrollView(showsIndicators: false) {
                            ForEach(0..<homeViewModel.reduceMeals.count, id: \.self) { idx in
                                ReduceMealItem(meal: homeViewModel.reduceMeals[idx], onClick: { id, name in
                                    // Go to detail
                                    currentMealId = id
                                    currentMealName = name
                                    goToMealDetail = true
                                })
                                .id(idx)
                            }
                        }
                    }
                    
                    
                    Spacer()
                    
                }
                
                SideBar(showView: $showSideBar, selectedMenu: $selectedMenu, onSelect: {
                    if selectedMenu == .home {
                        homeViewModel.counter = 0
                        homeViewModel.randomMeals.removeAll()
                        homeViewModel.getRandomMeals()
                    } else {
                        homeViewModel.getCategories()
                    }
                })
                .offset(x: showSideBar ? 0 : -(screen.width * 0.7))
                
                NavigationLink(destination: MealDetailView(id: currentMealId, name: currentMealName), isActive: $goToMealDetail) {}
                .frame(width: 0, height: 0)
            }
            .edgesIgnoringSafeArea(.all)
        }
        .navigationBarBackButtonHidden()
    }
    
    func getTitle() -> String {
        switch selectedMenu {
        case .home:
            return "3 alimentos random"
        case .categories:
            return "Categorías"
        case .reduceMeals:
            return "Platillos para \(currentCategory)"
        }
    }
}

#Preview {
    HomeView()
}

enum Menu {
    case home
    case categories
    case reduceMeals
}
