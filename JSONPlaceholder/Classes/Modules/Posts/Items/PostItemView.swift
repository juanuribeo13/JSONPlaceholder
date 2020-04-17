//
//  PostItemView.swift
//  JSONPlaceholder
//
//  Created by Juan Uribe on 4/17/20.
//  Copyright © 2020 Juan Uribe. All rights reserved.
//

import SwiftUI

/// View for displaying a post
struct PostItemView: View {
    
    // MARK: - Properties
    
    @ObservedObject private var viewModel: PostItemViewModel
    
    // MARK: - Initializers
    
    init(viewModel: PostItemViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - UI
    
    var body: some View {
        HStack(alignment: .center) {
            NavigationLink(
                destination: PostDetailView(viewModel: viewModel.makeDetailVM()),
                isActive: $viewModel.navigate,
                label: { EmptyView() })
                .frame(width: 0, height: 0)
            indicatorView
                .frame(width: 25)
            Text(viewModel.title)
        }
        .onTapGesture(perform: viewModel.selected)
    }
    
    var indicatorView: some View {
        HStack {
            Spacer()
            if !viewModel.isRead {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 10)
            } else if viewModel.isFavorite {
                Image("star").colorMultiply(.yellow)
            }
            Spacer()
        }
    }
}
