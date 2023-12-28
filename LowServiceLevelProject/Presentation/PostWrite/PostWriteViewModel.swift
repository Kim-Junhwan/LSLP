//
//  PostWriteViewModel.swift
//  LowServiceLevelProject
//
//  Created by JunHwan Kim on 2023/12/20.
//

import Foundation

final class PostWriteViewModel: ObservableObject {
    @Published var content: String = ""
    @Published var imageList: [Data] = []
    @Published var currentError: Error?
}
