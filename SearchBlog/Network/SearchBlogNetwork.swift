//
//  SearchBlogNetwork.swift
//  SearchBlog
//
//  Created by YONGCHEOL LEE on 2021/12/15.
//

import Foundation
import RxSwift

enum SearchNetworkError: Error {
    case invalidURL
    case invalidJSON
    case networkError
    
}

class SearchBlogNetwork {
    private let session: URLSession
    let api = SearchBlogAPI()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func searchBlog(query: String) -> Single<Result<DKBlog, SearchNetworkError>> {
        guard let url = api.searchBlog(query: query).url else {
            return .just(.failure(.invalidURL))
        }
        
        let reqeust = NSMutableURLRequest(url: url)
        reqeust.httpMethod = "GET"
        reqeust.setValue("YOUR KAKAO REST API", forHTTPHeaderField: "Authorization")
        
        return session.rx.data(request: reqeust as URLRequest)
            .map { data in
                do {
                    let blogData = try JSONDecoder().decode(DKBlog.self, from: data)
                    return .success(blogData)
                } catch {
                    return .failure(.invalidJSON)
                }
            }
            .catch { _ in
                .just(.failure(.networkError))
            }
            .asSingle()
    }
}
