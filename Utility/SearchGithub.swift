//
//  SearchGithub.swift
//  gitsearch (iOS)
//
//  Created by 楊勇 on R 4/02/18.
//

import Foundation
class GithubSearch{
    public struct Model: Codable, Identifiable{
        let full_name: String
        let id: Int
        let node_id: String
        let name: String
        let stargazers_count: Int
        let url: String
    }
    public struct Response: Codable {
        let total_count: Int
        let incomplete_results:Bool
        let items: [Model];
    }
    static func search(term: String, completion: @escaping (Result<Response, Error>) -> ()) {
        if let searchURL = URL(string: "https://api.github.com/search/repositories?q=\(term)") {
            let task = URLSession.shared.dataTask(with: searchURL) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                } else if (response as? HTTPURLResponse)?.statusCode == 403 {
                    completion(.failure(NSError(domain: "GithubSearch", code: -1, userInfo: ["NSErrorLocalizedDescription":"403 Forbidden"])))
                } else if (response as? HTTPURLResponse)?.statusCode == 404 {
                    completion(.failure(NSError(domain: "GithubSearch", code: -1, userInfo: ["NSErrorLocalizedDescription":"Not found"])))
                } else if (response as? HTTPURLResponse)?.statusCode == 422 {
                    completion(.failure(NSError(domain: "GithubSearch", code: -1, userInfo: ["NSErrorLocalizedDescription":"Unprocessable Entity"])))
                } else {
                    guard let data = data else {
                        completion(.failure(NSError(domain: "GithubSearch", code: -2, userInfo: ["NSErrorLocalizedDescription":"Can't load data"])))
                        return
                    }
                    do {
                        let response = try JSONDecoder().decode(Response.self, from: data)
                        completion(.success(response))
                    } catch(let error) {
                        completion(.failure(error))
                    }
                }
            }
            task.resume()
        }
    }
}
