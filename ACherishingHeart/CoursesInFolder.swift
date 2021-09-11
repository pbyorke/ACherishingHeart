//
//  CoursesInFolder.swift
//  ACherishingHeart
//
//  Created by Peter Yorke on 8/28/21.
//

import Foundation

class CoursesInFolder: ObservableObject {
    
    @Published var courses = [Course]()
    private var folder: Folder?
    var storageService: StorageServiceProtocol = StorageService.shared

    init() {
        courses = [Course]()
    }
    
    func setup(_ folder: Folder) {
        self.folder = folder
        initialize()
    }
    
    private func initialize() {
        guard let folder = folder else { return }
        Task.init {
            do {
                let courses = try await storageService.coursesInFolder(folderId: folder.id)
                DispatchQueue.main.async {
                    self.courses = courses
                }
            } catch { }
        }
    }
    
    func append(_ course: Course) {
        courses.append(course)
    }
    
    subscript(index: Int) -> Course {
        get { return courses[index] }
        set(newValue) { courses[index] = newValue }
    }

    func delete(course: Course) {
        if let index = courses.firstIndex(of: course) {
            courses.remove(at: index)
        }
    }
    
    func up(course: Course) {
        if let index = courses.firstIndex(of: course) {
            if index > 0 {
                courses.remove(at: index)
                courses.insert(course, at: index - 1)
            }
        }
    }
    
    func down(course: Course) {
        if let index = courses.firstIndex(of: course) {
            if index < courses.count - 1 {
                courses.remove(at: index)
                courses.insert(course, at: index + 1)
            }
        }
    }

    func rewrite() async throws {
        do {
            if let folder = folder {
                let coursesInFolder = try await storageService.listAllCoursesInFolder(folderId: "\(folder.id)")
                for courseInFolder in coursesInFolder {
                    try storageService.removeFolderToCourse(courseInFolder)
                }
                var index = 0
                for course in courses {
                    try await storageService.createCourseToFolderLink(LinkCourseToFolder(
                        id: "",
                        folderId: folder.id,
                        folderName: folder.name,
                        courseId: course.id,
                        courseName: course.name,
                        sequence: index
                    ))
                    index += 1
                }
            }
        } catch { throw error }
    }

    func dump() {
        print("* * *  Courses.dump()")
        for course in courses {
            print("  * * *  \(course)")
        }
    }
    
}
