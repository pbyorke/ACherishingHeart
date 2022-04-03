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
    @Binding var url: String
    @Binding var fullPath: String
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(files) { file in
                    HStack {
                        Button(action: {
                            url = file.description
                            fullPath = file.fullPath
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
        .frame(maxWidth: .infinity)
        .navigationTitle( Text("Files in the Cloud") )
        .background(Color.gray.opacity(0.2))
        .cornerRadius(20)
        .padding(.horizontal, 20)
        .padding(.bottom, 40)
        .font(.body)
        .onAppear {
            Task.init {
                self.files = await storageService.allCloudFiles()
            }
        }
        if MainView.NAMES {
            Names(name: "CloudFilesView")
        } // NAMES
    }
}

struct CloudFilesView_Previews: PreviewProvider {
    @State static var url = ""
    @State static var fullPath = ""
    static var previews: some View {
        CloudFilesView(url: $url, fullPath: $fullPath)
    }
}
