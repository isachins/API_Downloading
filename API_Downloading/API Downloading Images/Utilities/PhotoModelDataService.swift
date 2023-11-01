//
//  PhotoModelDataService.swift
//  playground
//
//  Created by Sachin Sharma on 26/10/23.
//

import Foundation
import Combine

class PhotoModelDataService {
    
    static let instance = PhotoModelDataService() // Singleton
    
    @Published var photoModel: [PhotoModel] = []
    var cancellables = Set<AnyCancellable>()
    
    private init() {
        downloadData()
    }
    
    
    func downloadData() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else { return }

        // use of combine for data download
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PhotoModel].self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case.finished:
                    break
                case.failure(let error):
                    print("Error Downloading Data: \(error)")
                }
            } receiveValue: { [weak self] returnedPhotoModel in
                self?.photoModel = returnedPhotoModel
            }
            .store(in: &cancellables)
    }
    
    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let responce = output.response as? HTTPURLResponse,
                responce.statusCode >= 200 && responce.statusCode <= 300 else {
                throw URLError(.badServerResponse)
          }
          return output.data
    }
}
