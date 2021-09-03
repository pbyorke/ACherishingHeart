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
                    PrettyLink(label: course.name, spacer: true, destination: CourseView(add: false, course: $course)) { self.course = course }
                }
            }
            .padding(20)
        }
        .navigationTitle( Text("Courses") )
        .background(Color.gray.opacity(0.2))
        .cornerRadius(20)
        .padding(.horizontal, 20)
        .padding(.bottom, 40)
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
        if MainView.NAMES {
            Names(name: "CoursesView")
        } // NAMES
    }
    
}

#if DEBUG
struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView()
    }
}
#endif
