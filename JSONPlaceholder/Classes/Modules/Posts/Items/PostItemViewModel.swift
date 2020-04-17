//
//  PostItemViewModel.swift
//  JSONPlaceholder
//
//  Created by Juan Uribe on 4/17/20.
//  Copyright © 2020 Juan Uribe. All rights reserved.
//

import Foundation
import Combine

/// View model for a post.
final class PostItemViewModel: ObservableObject, Identifiable {
    
    // MARK: - Properties
    
    private let post: Post
    private var readPosts: CurrentValueSubject<Set<Post>, Never>
    private var favoritePosts: CurrentValueSubject<Set<Post>, Never>
    private var disposeBag = Set<AnyCancellable>()
    
    /// Used for navigating to the post details.
    @Published var navigate: Bool = false
    /// The title of the post.
    var title: String { post.title }
    /// Whether the post has been read.
    @Published private(set) var isRead: Bool = false
    /// Whether this item is a favorite.
    @Published private(set) var isFavorite: Bool = false
    
    // MARK: - Initializers
    
    init(post: Post,
         readPosts: CurrentValueSubject<Set<Post>, Never>,
         favoritePosts: CurrentValueSubject<Set<Post>, Never>) {
        self.post = post
        self.readPosts = readPosts
        self.favoritePosts = favoritePosts
        
        bind()
    }
    
    // MARK: - Public Functions
    
    func selected() {
        navigate = true
        var posts = readPosts.value
        posts.insert(post)
        readPosts.send(posts)
    }
    
    func makeDetailVM() -> PostDetailViewModel {
        return PostDetailViewModel(post: post,
                                   favoritePosts: favoritePosts)
    }
    
    // MARK: - Private Functions
    
    private func bind() {
        readPosts.eraseToAnyPublisher()
            .map { $0.contains(self.post) }
            .assign(to: \.isRead, on: self)
            .store(in: &disposeBag)
        
        favoritePosts.eraseToAnyPublisher()
            .map { $0.contains(self.post) }
            .assign(to: \.isFavorite, on: self)
            .store(in: &disposeBag)
    }
}
