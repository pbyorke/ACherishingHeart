//
//  CourseView.swift
//  ACherishingHeart
//
//  Created by Peter Yorke on 8/28/21.
//

import SwiftUI

struct CourseView: View {
    
    @Environment(\.presentationMode) var presentationMode
    var storageService: StorageServiceProtocol = StorageService.shared

    var add: Bool
//    = false
    @Binding var course: Course
    
    var body: some View {
        VStack {
            VStack(spacing: 16) {
                InputTextFieldView(
                    text: $course.name,
                    placeholder: "Name",
                    keyboardType: .default,
                    sfSymbol: nil
                )
                InputTextFieldView(
                    text: $course.description,
                    placeholder: "Description",
                    keyboardType: .default,
                    sfSymbol: nil
                )
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: update) {
                        if add {
                            Image(systemName: "plus")
                        } else {
                            Image(systemName: "square.and.arrow.down")
                        }
                    }
                }
            }
            .padding(.horizontal, 15)
            .navigationTitle("Course")
            if MainView.NAMES {
                Names(name: "CourseView")
            } // NAMES
        }
    }
    
    private func update() {
        Task.init {
            do {
                if add {
                    try await storageService.createCourse(course)
                } else {
                    try storageService.updateCourse(course)
                }
            } catch { }
        }
        presentationMode.wrappedValue.dismiss()
    }
    
}

struct COurseView_Previews: PreviewProvider {
    @State static var course = Course.new
    static var previews: some View {
        CourseView(add: false, course: $course)
            .preview(with: "Add or update a Course")
    }
}
