//
//  DownloadingImagesVM.swift
//  playground
//
//  Created by Sachin Sharma on 26/10/23.
//

import Foundation
import SwiftUI
import Combine

class DownloadingImagesVM: ObservableObject {
    
    @Published var dataArray: [PhotoModel] = []
    
    
    let dataService = PhotoModelDataService.instance
    var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$photoModel
            .sink { [weak self] returenedPhotoModel in
                self?.dataArray = returenedPhotoModel
            }
            .store(in: &cancellables)
    }
    
    
}
