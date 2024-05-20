//
//  SideBar.swift
//  PruebaEon
//
//  Created by Omar Aldair on 19/05/24.
//

import SwiftUI
let screen = UIScreen.main.bounds
struct SideBar: View {
    @Binding var showView: Bool
    @Binding var selectedMenu: Menu
    var onSelect: () -> Void
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Button {
                    withAnimation(.spring) {
                        showView = false
                    }
                   
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 20))
                        .foregroundColor(Color.white)
                }

            }
            .padding(.top, 54)
            .padding(.trailing)
            
            Button {
                withAnimation(.spring) {
                    showView = false
                }
                selectedMenu = .home
                onSelect()
            } label: {
                HStack {
                    if selectedMenu == .home {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 12, height: 12)
                    }
                    Text("Home")
                        .foregroundStyle(.white)
                    
                    Spacer()
                }
                .padding(.leading)
                
            }
            .padding(.bottom)
            .padding(.top, 30)
            
            Button {
                withAnimation(.spring) {
                    showView = false
                }
                selectedMenu = .categories
                onSelect()
            } label: {
                HStack {
                    if selectedMenu == .categories {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 12, height: 12)
                    }
                    Text("Categorías")
                        .foregroundStyle(.white)
                    
                    Spacer()
                }
                .padding(.leading)
               
            }

            Spacer()
            
            
        }
        .frame(width: screen.width * 0.7, height: screen.height)
        .background(Color.black)
    }
}

#Preview {
    SideBar(showView: .constant(false), selectedMenu: .constant(.home), onSelect: {})
}
