//
//  PostsViewModel.swift
//  JSONPlaceholder
//
//  Created by Juan Uribe on 4/17/20.
//  Copyright © 2020 Juan Uribe. All rights reserved.
//

import Foundation
import Combine

/// View model for a list of posts.
final class PostsViewModel: ObservableObject {
    
    // MARK: - Properties
    
    private let networkProvider: PostsNetworkProvider
    private var disposeBag = Set<AnyCancellable>()
    @Published private var posts = [Post]()
    private var readPosts: CurrentValueSubject<Set<Post>, Never>
    private var favoritePosts: CurrentValueSubject<Set<Post>, Never>
    
    /// The title for the view.
    let title: String = "Posts"
    /// The post items to display.
    @Published private(set) var postItems: [PostItemViewModel] = []
    
    // MARK: - Initializers
    
    init(networkProvider: PostsNetworkProvider = PostsNetworkProvider()) {
        self.networkProvider = networkProvider
        readPosts = CurrentValueSubject(Set())
        favoritePosts = CurrentValueSubject(Set())
        
        bind()
        loadPosts()
    }
    
    // MARK: - Public Functions
    
    func reload() {
        loadPosts()
    }
    
    // MARK: - Private Functions
    
    private func bind() {
        $posts.eraseToAnyPublisher()
            .receive(on: DispatchQueue.global())
            .map { [weak self] posts in
                guard let strongSelf = self else {
                    return []
                }
                return posts.map {
                    return PostItemViewModel(
                        post: $0,
                        readPosts: strongSelf.readPosts,
                        favoritePosts: strongSelf.favoritePosts)
                }
        }
        .replaceError(with: [])
        .receive(on: DispatchQueue.main)
        .assign(to: \.postItems, on: self)
        .store(in: &disposeBag)
    }
    
    private func loadPosts() {
        networkProvider.getAllPosts()
            .replaceError(with: [])
            .receive(on: RunLoop.main)
            .assign(to: \.posts, on: self)
            .store(in: &disposeBag)
    }
}
