//
//  AddCoursesView.swift
//  ACherishingHeart
//
//  Created by Peter Yorke on 8/28/21.
//

import SwiftUI

struct AddCoursesView: View {
    
    @Binding var folder: Folder
    
    var body: some View {
        VStack {
            Text("Add Courses")
            if MainView.NAMES {
                Names(name: "AddCoursesView")
            } // NAMES
        }
    }
}

struct AddCoursesView_Previews: PreviewProvider {
    @State static var folder = Folder.new
    static var previews: some View {
        AddCoursesView(folder: $folder)
    }
}
