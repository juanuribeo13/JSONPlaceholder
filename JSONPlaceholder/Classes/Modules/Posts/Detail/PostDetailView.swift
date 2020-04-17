//
//  PostDetailView.swift
//  JSONPlaceholder
//
//  Created by Juan Uribe on 4/17/20.
//  Copyright © 2020 Juan Uribe. All rights reserved.
//

import SwiftUI

struct PostDetailView: View {
    
    // MARK: - Properties
    
    @ObservedObject private var viewModel: PostDetailViewModel
    
    // MARK: - Initializers
    
    init(viewModel: PostDetailViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - UI
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Description
            Text(viewModel.descriptionCaption)
                .font(Font.system(.headline))
                .padding(.bottom)
            Text(viewModel.description)
            
            // User
            Text(viewModel.userCaption)
                .font(Font.system(.headline))
                .padding(.vertical)
            Text(viewModel.userName)
            Text(viewModel.userEmail)
            Text(viewModel.userPhone)
            Text(viewModel.userWebsite)
            
            Spacer()
        }
        .padding(.all)
        .navigationBarTitle(viewModel.title)
        .navigationBarItems(trailing: favoriteButton)
        .onAppear(perform: viewModel.onAppear)
    }
    
    private var favoriteButton: some View {
        Button(action: viewModel.swapFavorite) {
            viewModel.isFavorite ? Image("star") : Image("starOutline")
        }
    }
}
