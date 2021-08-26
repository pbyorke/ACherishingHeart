//
//  CloudFilesView.swift
//  ACherishingHeart
//
//  Created by Pete Yorke on 8/26/21.
//

import SwiftUI

struct CloudFilesView: View {
    
    @EnvironmentObject var storageService: StorageService
    
    @State private var files = [CloudFile]()
    
    var body: some View {
        HStack {
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(files) { file in
                        PrettyLink(label: file.name, destination: CloudFileView()) { }
                    }
                }
            }
        }
        .padding()
        .font(.title2)
        .navigationTitle( Text("Files in the Cloud") )
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
