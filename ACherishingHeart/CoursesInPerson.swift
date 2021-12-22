//
//  CoursesInPerson.swift
//  ACherishingHeart
//
//  Created by Peter Yorke on 9/12/21.
//

import Foundation

class CoursesInPerson: ObservableObject {
    
    @Published var courses = [Course]()
    private var person: Person?
    var storageService: StorageServiceProtocol = StorageService.shared

    init() {
        courses = [Course]()
    }
    
    func setup(_ person: Person) {
        self.person = person
        initialize()
    }
    
    private func initialize() {
        guard let person = person else { return }
        Task.init {
            do {
                let courses = try await storageService.coursesInPerson(personId: person.id)
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
            if let person = person {
                let links = try await storageService.listAllCoursesInPerson(personId: person.id)
                for link in links {
                    try storageService.removeCourseToPersonLink(link)
                }
                var index = 0
                for course in courses {
                    try await storageService.createCourseToPersonLink(
                        LinkCourseToPerson(
                            id: "",
                            personId: person.id,
                            personName: "\(person.firstName) \(person.lastName)",
                            courseId: course.id,
                            courseName: course.name,
                            sequence: index
                        )
                    )
                    index += 1
                }
            }
        } catch { throw error }
    }
    
    func dump() {
        print("Courses.dump()")
        for course in courses {
            print("  \(course)")
        }
    }
    
}
