//
//  CloudFileView.swift
//  ACherishingHeart
//
//  Created by Pete Yorke on 8/26/21.
//

import SwiftUI

struct CloudFileView: View {

    @Binding var file: CloudFile
    
    var body: some View {
        VStack(spacing: 16) {
            VStack(spacing: 16) {
                TitledText(title: "ID", text: file.id)
                TitledText(title: "Full path", text: file.fullPath)
                TitledText(title: "Bucket", text: file.bucket)
                TitledText(title: "Name", text: file.name)
                TitledText(title: "Description", text: file.description)
            }
            .padding()
            .font(.title2)
            .navigationTitle( Text("File in the Cloud") )
        }
    }
}

#if DEBUG
struct CloudFIleView_Previews: PreviewProvider {
    @State static var file = CloudFile.new
    static var previews: some View {
        CloudFileView(file: $file)
    }
}
#endif
