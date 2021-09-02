//
//  CloudFilesView.swift
//  ACherishingHeart
//
//  Created by Pete Yorke on 8/26/21.
//

import SwiftUI

struct CloudFilesView: View {
    
    @Environment(\.presentationMode) var presentationMode
    var storageService: StorageServiceProtocol = StorageService.shared

    @State private var files = [CloudFile]()
    @State private var file = CloudFile.new
    @Binding var bucket: String
    
    var body: some View {
        VStack {
            VStack {
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(files) { file in
                            HStack {
                                Button(action: {
                                    bucket = file.bucket
                                    presentationMode.wrappedValue.dismiss()
                                }, label: {
                                    Text("\(file.name)")
                                })
                                Spacer()
                            }
                        }
                    }
                    .padding(20)
                }
            }
            .navigationTitle( Text("Files in the Cloud") )
            .background(Color.gray.opacity(0.2))
            .cornerRadius(20)
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
            .font(.body)
            if MainView.NAMES {
                Names(name: "CloudFilesView")
            } // NAMES
        }
        .onAppear {
            Task.init {
                self.files = await storageService.allCloudFiles()
            }
        }
    }
}

#if DEBUG
struct CloudFilesView_Previews: PreviewProvider {
    @State static var bucket = ""
    static var previews: some View {
        CloudFilesView(bucket: $bucket)
    }
}
#endif
