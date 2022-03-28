//
//  MockNetworkClient.swift
//  Homework-5.2
//
//  Created by Мария Коханчик on 28.03.2022.
//

import Foundation

final class MockNetworkClient<R>: NetworkClient {

    enum MockNetworkClientError: Error { case stubError
    }

    typealias Response = R
    typealias Completion = (Response?, Error?) -> ()

    var stubError: Bool = false
    var stubResponse: R?

    func networkRequest<P: Codable>(params: P, completion: @escaping Completion) {
        if stubError {
            completion(nil, MockNetworkClientError.stubError)
        } else {
            completion(stubResponse, nil)
        }
    }

}
