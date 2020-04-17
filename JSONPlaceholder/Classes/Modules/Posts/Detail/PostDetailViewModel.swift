//
//  PostDetailViewModel.swift
//  JSONPlaceholder
//
//  Created by Juan Uribe on 4/17/20.
//  Copyright © 2020 Juan Uribe. All rights reserved.
//

import Foundation
import Combine

final class PostDetailViewModel: ObservableObject {
    
    private struct Constant {
        static let userName = "Name:"
        static let userEmail = "Email:"
        static let userPhone = "Phone:"
        static let userWebsite = "Website:"
    }
    
    // MARK: - Properties
    
    private let post: Post
    private let userNetworkProvider: UserNetworkProvider
    private var favoritePosts: CurrentValueSubject<Set<Post>, Never>
    private var disposeBag = Set<AnyCancellable>()
    
    /// The title for the view.
    let title: String = "Post"
    /// Whether this item is a favorite.
    @Published private(set) var isFavorite: Bool = false
    /// The caption for the description section
    let descriptionCaption: String = "Description"
    /// The post description
    var description: String { post.body }
    /// The caption for the user section
    let userCaption: String = "User"
    /// The user name
    @Published private(set) var userName: String = Constant.userName
    /// The user email
    @Published private(set) var userEmail: String = Constant.userEmail
    /// The user phone number
    @Published private(set) var userPhone: String = Constant.userPhone
    /// The user website
    @Published private(set) var userWebsite: String = Constant.userWebsite
    
    // MARK: - Initializers
    
    init(post: Post,
         userNetworkProvider: UserNetworkProvider = UserNetworkProvider(),
         favoritePosts: CurrentValueSubject<Set<Post>, Never>) {
        self.post = post
        self.userNetworkProvider = userNetworkProvider
        self.favoritePosts = favoritePosts
        
        bind()
    }
    
    // MARK: - Public Functions
    
    func onAppear() {
        loadUser()
    }
    
    func swapFavorite() {
        var favorites = favoritePosts.value
        if isFavorite {
            favorites.remove(post)
        } else {
            favorites.insert(post)
        }
        favoritePosts.send(favorites)
    }
    
    // MARK: - Private Functions
    
    private func bind() {
        favoritePosts.eraseToAnyPublisher()
            .map { $0.contains(self.post) }
            .assign(to: \.isFavorite, on: self)
            .store(in: &disposeBag)
    }
    
    private func loadUser() {
        userNetworkProvider.getUser(id: post.userId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            }, receiveValue: { [weak self] (user) in
                self?.update(user: user)
            })
            .store(in: &disposeBag)
    }
    
    private func update(user: User) {
        userName = "\(Constant.userName) \(user.name)"
        userEmail = "\(Constant.userEmail) \(user.email)"
        userPhone = "\(Constant.userPhone) \(user.phone)"
        userWebsite = "\(Constant.userWebsite) \(user.website)"
    }
}
