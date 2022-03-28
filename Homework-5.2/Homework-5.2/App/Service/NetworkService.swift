//
//  NetworkService.swift
//  Homework-5.2
//
//  Created by Мария Коханчик on 28.03.2022.
//

import Foundation

struct ItemRequestParams: Codable {
    let index: Int
}

struct Item {}

protocol NetworkClient {
    
    associatedtype Response
    typealias Completion = (Response?, Error?) -> ()
    func networkRequest<P: Codable>(params: P, completion: @escaping Completion)
    
}

final class ItemNetworkClient: NetworkClient {

    typealias Response = Item
    func networkRequest<P: Codable>(params: P, completion: @escaping Completion) {
        // здесь происходит реальный сетевой запрос
    }
    
}

final class NetworkService<C: NetworkClient> {

    enum ServiceError: Error { case badResponse
    }

    typealias Completion = (Item?, Error?) -> ()
    typealias Parameters = [String: Int]

    private let client: C

    init(client: C) {
        self.client = client
    }

    func fetchItem(at index: Int, completion: @escaping Completion) {
        let params = ItemRequestParams(index: index)
        client.networkRequest(params: params) { (response, error) in
            if let error = error {
                completion(nil, error)
            } else if let item = response as? Item {
                completion(item, nil)
            } else {
                completion(nil, ServiceError.badResponse)
            }
        }
    }
    
}
