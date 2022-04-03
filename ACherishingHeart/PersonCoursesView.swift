//
//  PersonCoursesView.swift
//  ACherishingHeart
//
//  Created by Pete Yorke on 9/17/21.
//

import SwiftUI

struct PersonCoursesView: View {

    @EnvironmentObject var coursesInPerson: CoursesInPerson

    var body: some View {
        VStack {
            ZStack {
                Text("Courses")
                    .font(.title)
                HStack {
                    Spacer()
                    PrettyLink(image: "plus", destination: CoursesView(selecting: true)) { }
                }
            }
            List(coursesInPerson.courses, id: \.id) { course in
                Text("\(course.name)")
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Swipe(symbol: "minus.square.fill", color: .red) { coursesInPerson.delete(course: course) }
                        Swipe(symbol: "arrow.down.square.fill", color: .green) { coursesInPerson.down(course: course) }
                        Swipe(symbol: "arrow.up.square.fill", color: .green) { coursesInPerson.up(course: course) }
                    }
            }
            if MainView.NAMES {
                Text("PersonCoursesView").foregroundColor(.cyan)
            } // NAMES
        }
        .padding(20)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(20)
        .font(.body)
    }
    
}

struct PersonCoursesView_Previews: PreviewProvider {
    static var previews: some View {
        PersonCoursesView()
    }
}
