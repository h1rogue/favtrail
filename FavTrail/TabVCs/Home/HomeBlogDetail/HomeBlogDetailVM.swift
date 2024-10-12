//
//  HomeBlogDetailVM.swift
//  FavTrail
//
//  Created by Hirakjyoti Borah on 29/09/22.
//

import Foundation

protocol HomeBlogDetailVMDelegate: AnyObject {
    func refreshTable()
}
 
class HomeBlogDetailVM {
    weak var delegate: HomeBlogDetailVMDelegate?
    private var blogId: String
    
    init(blogId: String) {
        self.blogId = blogId
    }
    
    var blogDetailModel: BlogDetailModel? {
        didSet {
            delegate?.refreshTable()
        }
    }
    
    func numberOfRowsInSection(_ section: Int = 0) -> Int {
        return blogDetailModel?.blogData.blogList.count ?? 0
    }
    
    func cellForRowAtIndexPath(indexPathRow: Int) -> BlogDetailElement? {
        return blogDetailModel?.blogData.blogList[indexPathRow]
    }
    
    func fetchBlogDetail() {
        //MARK: todo -> queryItems: ["blog_id": blogId] (API not ready till now so workaround)
//        let apiEndPoint = NetworkAPiEndPointBuilder.home(api: .blogDetailApi, queryItems: nil).build()
//
//        guard let request: URLRequest = HttpNetworkLayer.createRequest(apiEndPoint: apiEndPoint) else {
//            return //TODO: implment this later
//        }
        
        let apiEndpoint = "http://43.207.154.89/apis/blog-data/1"
        let url = URL(string: apiEndpoint)!
        let request = URLRequest(url: url)
        
        HttpNetworkLayer().request(request: request, responseType: BlogDetailModel.self) { result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self.blogDetailModel = model
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension HomeBlogDetailVM {
    
    struct BlogDetailModel: Codable {
       // let blogId: String
        let statsInfo: StatsModel
        let blogData: BlogDetailData
    }
    
    struct BlogDetailData: Codable {
        let blogList: [BlogDetailElement]
    }
    
    enum BlogDetailDataType: String, Codable {
        case image
        case text
    }
    
    struct BlogDetailElement: Codable {
        let dataType: BlogDetailDataType
        let data: String
        
        enum CodingKeys: String, CodingKey {
            case dataType, image, text
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.dataType = try container.decode(BlogDetailDataType.self, forKey: .dataType)
            
            switch dataType {
            case .image:
                self.data = try container.decode(String.self, forKey: .image)
            case .text:
                self.data = try container.decode(String.self, forKey: .text)
            }
        }
        
        func encode(to encoder: Encoder) throws {
            
        }
    }
}
