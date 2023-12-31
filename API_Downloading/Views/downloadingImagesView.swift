//
//  downloadingImagesView.swift
//  API_Downloading
//
//  Created by Sachin Sharma on 01/11/23.
//

import SwiftUI

struct DownloadingImageView: View {
    
    @StateObject var loader: ImageLoadingVM
    
    init(url: String, key: String) {
        _loader = StateObject(wrappedValue: ImageLoadingVM(url: url, key: key))
    }
    
    var body: some View {
        ZStack {
            if loader.isLoading {
                ProgressView()
            } else if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .clipShape(Circle())
                    
            }
        }
    }
}

#Preview {
    DownloadingImageView(url: "https://via.placeholder.com/600/92c952", key: "1")
        .frame(width: 75, height: 75)
}
