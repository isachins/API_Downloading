//
//  ImageLoadingVM.swift
//  API_Downloading
//
//  Created by Sachin Sharma on 01/11/23.
//

import Foundation
import SwiftUI
import Combine

class ImageLoadingVM: ObservableObject {
 
    @Published var image: UIImage? = nil
    @Published var isLoading = false
    var cancellables = Set<AnyCancellable>()
    
    // For storing in cache memory or RAM
    let manager = PhotoModelCacheManager.instance
    
    // For storing in Filemanager or in ROM
    // let manager = PhotoModelCacheManager.instance
    
    let urlString: String
    let imageKey: String
    
    init(url: String, key: String) {
        urlString = url
        imageKey = key
        getImage()
    }
    
    func getImage() {
        if let savedImage = manager.get(key: imageKey) {
            image = savedImage
            print("Getting saved image")
        } else {
            downloadImage()
            print("Downloading image now")
        }
    }
    
    func downloadImage() {
        print("Downloading Image Now!")
        isLoading = true
        guard let url = URL(string: urlString) else {
            isLoading = false
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map{UIImage(data: $0.data)}
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                guard
                    let self = self,
                    let image = returnedImage else { return }
                
                self.image = image
                self.manager.add(key: self.imageKey, value: image)
            }
            .store(in: &cancellables)
    }
    
    
    
}

