//
//  downloadingImages.swift
//  playground
//
//  Created by Sachin Sharma on 26/10/23.
//

import SwiftUI

// Important Topics
// Codables
// Background Threads
// Weak Self
// Combine
// Publishers and Subscribers
// FileManager
// NSCache

struct downloadingImages: View {
    
    @StateObject var vm = DownloadingImagesVM()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.dataArray) { model in
                    DownloadingImagesRow(model: model)
                }
            }
            .navigationTitle("Downloading Images")
        }
    }
}

#Preview {
    downloadingImages()
}
