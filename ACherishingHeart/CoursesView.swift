//
//  CoursesView.swift
//  ACherishingHeart
//
//  Created by Peter Yorke on 8/28/21.
//

import SwiftUI

struct CoursesView: View {
    
    var storageService: StorageServiceProtocol = StorageService.shared
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var coursesInFolder: CoursesInFolder
    
    @State private var allCourses = [Course]()
    @State private var course = Course.new
    var selecting = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(allCourses) { course in
                    HStack {
                        if selecting {
                            Button(course.name) {
                                coursesInFolder.append(course)
                                presentationMode.wrappedValue.dismiss()
                            }
                        } else {
                            HStack {
                                PrettyLink(label: course.name, destination: CourseView(add: false, course: $course)) { self.course = course }
                            }
                        }
                        Spacer()
                    }
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
                PrettyLink(image: "plus", destination: CourseView(add: true, course: $course)) { self.course = Course.new }
            }
        }
        .onAppear {
            Task.init {
                do {
                    self.allCourses = try await storageService.listAllCourses()
                }
            }
        }
        if MainView.NAMES {
            Names(name: "CoursesView")
        } // NAMES
    }
    
}

struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView()
    }
}
