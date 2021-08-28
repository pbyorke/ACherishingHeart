//
//  CoursesView.swift
//  ACherishingHeart
//
//  Created by Peter Yorke on 8/28/21.
//

import SwiftUI

struct CoursesView: View {
    
    var storageService: StorageServiceProtocol = StorageService.shared

    @State private var courses = [Course]()
    @State private var course = Course.new
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(courses) { course in
                    HStack {
                        PrettyLink(label: course.name, destination: CourseView(add: false, course: $course)) { self.course = course }
                        Spacer()
                    }
                }
            }
            .padding(20)
        }
        .navigationTitle( Text("Courses") )
        .font(.title2)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: CourseView(add: true, course: $course)) {
                    Image(systemName: "plus")
                }
            }
        }
        .onAppear {
            Task.init {
                do {
                    self.courses = try await storageService.listAllCourses()
                }
            }
        }
    }
    
}

#if DEBUG
struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView()
    }
}
#endif
