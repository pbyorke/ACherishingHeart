//
//  CoursesInFolderView.swift
//  ACherishingHeart
//
//  Created by Peter Yorke on 9/6/21.
//

import SwiftUI

struct CoursesInFolderView: View {

    @EnvironmentObject var coursesInFolder: CoursesInFolder

    var body: some View {
        VStack {
            if MainView.NAMES {
                Text("CoursesInFolderView").foregroundColor(.cyan)
            } // NAMES
            ZStack {
                Text("Courses in this Folder")
                    .font(.title)
                HStack {
                    Spacer()
                    PrettyLink(image: "plus", destination: CoursesView(selecting: true)) { }
                }
            }
            List(coursesInFolder.courses, id: \.id) { course in
                Text("\(course.name)")
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Swipe(symbol: "minus.square.fill", color: .red) { coursesInFolder.delete(course: course) }
                        Swipe(symbol: "arrow.down.square.fill", color: .green) { coursesInFolder.down(course: course) }
                        Swipe(symbol: "arrow.up.square.fill", color: .green) { coursesInFolder.up(course: course) }
                    }
            }
        }
        .padding(20)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(20)
        .font(.body)
    }
    
}

#if DEBUG
struct CoursesInFolderView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesInFolderView()
    }
}
#endif
