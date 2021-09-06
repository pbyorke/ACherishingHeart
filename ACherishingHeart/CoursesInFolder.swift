//
//  CoursesInFolder.swift
//  ACherishingHeart
//
//  Created by Peter Yorke on 8/28/21.
//

import SwiftUI

struct CoursesInFolderView: View {
    
    var storageService: StorageServiceProtocol = StorageService.shared

    @Binding var courses: [Course]
    @State private var selectedCourse = Course.new
    
    var body: some View {
        VStack {
            if MainView.NAMES {
                Text("CoursesInFolderView")
            } // NAMES
            ZStack {
                Text("Courses in this Folder").font(.title)
                HStack {
                    Spacer()
//                    PrettyLink(image: "plus", destination: CoursesView(selecting: true, selectedCourse: $selectedCourse)) { }
                }
            }
            List(courses, id: \.id) { course in
                Text("\(course.name)")
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Swipe(symbol: "minus.square.fill", color: .red) { delete(course: course) }
                        Swipe(symbol: "arrow.down.square.fill", color: .green) { moveDown(course: course) }
                        Swipe(symbol: "arrow.up.square.fill", color: .green) { moveUp(course: course) }
                    }
            }
        }
        .padding(20)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(20)
        .font(.body)
    }
    
    private func delete(course: Course) {
        print("* * *  delete")
    }
    
    private func  moveUp(course: Course) {
        print("* * *  up")
    }
    
    private func  moveDown(course: Course) {
        print("* * *  down")
    }
    
}

#if DEBUG
struct CoursesInFolderView_Previews: PreviewProvider {
    @State static var courses = [Course]()
    static var previews: some View {
        CoursesInFolderView(courses: $courses)
    }
}
#endif
