//
//  CommentFullScreenViewModel.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 26/04/23.
//

import Foundation

protocol CommentFullScreenVMDelegate: AnyObject {
    func refreshCollectionView()
}

class CommentFullScreenViewModel {
    weak var delegate: CommentFullScreenVMDelegate?
    private var blogId: String
    var commentFullScreenModel: CommentFullScreenModel? {
        didSet {
            delegate?.refreshCollectionView()
        }
    }
    
    init(blogID: String, delegate: CommentFullScreenVMDelegate) {
        self.blogId = blogID
        self.delegate = delegate
    }
    
    func viewDidLoad() {
        fetchBlogDetail()
    }
    
    private func fetchBlogDetail() {
        
        //TODO: change api END POINT
        let apiEndpoint = "https://demo7653918.mockable.io/comments"
        let url = URL(string: apiEndpoint)!
        let request = URLRequest(url: url)
        
        HttpNetworkLayer().request(request: request, responseType: CommentFullScreenModel.self) { result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self.commentFullScreenModel = model
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getNumberOfItemsInSection() -> Int {
        return commentFullScreenModel?.feed.objects.count ?? 0
    }
    
    func getCellModelForItem(at indexPath: IndexPath) -> CommentModel? {
        return commentFullScreenModel?.feed.objects[indexPath.row]
    }
}

extension CommentFullScreenViewModel {
    
    struct CommentFullScreenModel: Codable {
        let meta: MetaData?
        let feed: CommentFeed
    }
    
    struct CommentFeed: Codable {
        let objects: [CommentModel]
    }
    
    struct CommentModel: Codable {
        let userName: String
        let userComment: String
        let userImage: String
        let likes: Int?
    }
    
    struct MetaData: Codable {
        let bgColor: String
    }
}
