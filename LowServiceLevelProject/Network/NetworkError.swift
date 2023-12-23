//
//  NetworkError.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/23.
//

import Foundation

struct NetworkError: Error {
    let title: String
    let description: String
    let originError: Error
}
