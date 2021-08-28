//
//  CoursesInFolder.swift
//  CoursesInFolder
//
//  Created by Peter Yorke on 8/28/21.
//

import SwiftUI

struct CoursesInFolderView: View {
    
    var storageService: StorageServiceProtocol = StorageService.shared

    @Binding var folder: Folder
    @State private var courses = [Course]()
    
    var body: some View {
        VStack {
            ZStack {
                Text("Courses in this Folder").font(.title)
                HStack {
                    Spacer()
                    PrettyLink(image: "plus", destination: AddCoursesView(folder: $folder)) { }
                }
            }
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(courses) { course in
                        HStack {
                            Text("\(course.name)")
                        }
                    }
                }
            }
        }
        .padding(20)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(20)
        .font(.body)
        .task {
            do {
                let array = try await storageService.coursesInFolder(folderId: folder.id)
                DispatchQueue.main.async {
                    self.courses = array
                }
            } catch { }
        }
    }
    
}

#if DEBUG
struct CoursesInFolderView_Previews: PreviewProvider {
    @State static var folder = Folder.new
    static var previews: some View {
        CoursesInFolderView(folder: $folder)
    }
}
#endif
