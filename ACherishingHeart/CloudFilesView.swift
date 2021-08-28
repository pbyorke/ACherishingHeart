//
//  CloudFilesView.swift
//  ACherishingHeart
//
//  Created by Pete Yorke on 8/26/21.
//

import SwiftUI

struct CloudFilesView: View {
    
    var storageService: StorageServiceProtocol = StorageService.shared

    @State private var files = [CloudFile]()
    @State private var file = CloudFile.new
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(files) { file in
                    HStack {
                        PrettyLink(label: file.name, destination: CloudFileView(file: $file)) { self.file = file }
                        Spacer()
                    }
                }
            }
            .padding(20)
        }
        .navigationTitle( Text("Files in the Cloud") )
        .font(.title2)
        .onAppear {
            Task.init {
                self.files = await storageService.allCloudFiles()
            }
        }
    }
}

#if DEBUG
struct CloudFilesView_Previews: PreviewProvider {
    static var previews: some View {
        CloudFilesView()
    }
}
#endif
