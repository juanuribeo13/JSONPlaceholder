//
//  PostsView.swift
//  JSONPlaceholder
//
//  Created by Juan Uribe on 4/17/20.
//  Copyright © 2020 Juan Uribe. All rights reserved.
//

import SwiftUI

/// View for displaying a list of posts.
struct PostsView: View {
    
    // MARK: - Properties
    
    @ObservedObject private var viewModel = PostsViewModel()
    
    // MARK: - UI
    
    var body: some View {
        NavigationView {
            List(viewModel.postItems) { PostItemView(viewModel: $0) }
                .navigationBarTitle(Text(viewModel.title), displayMode: .inline)
                .navigationBarItems(trailing:
                    Button(action: viewModel.reload) {
                        Image("refresh")
                    }
            )
        }
    }
}

struct PostsView_Previews: PreviewProvider {
    static var previews: some View {
        PostsView()
    }
}
