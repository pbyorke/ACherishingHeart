////
////  SignInViewModel.swift
////  ACherishingHeart
////
////  Created by Pete Yorke on 7/29/21.
////
//
//import Foundation
////import Combine
//
//enum SignInState {
//    case successful
//    case failed(error: Error)
//    case na
//}
//
//protocol SignInViewModelProtocol {
//    func signin() async throws
////    var service: LoginService { get }
////    var state: LoginState { get }
//    var credentials: SignInCredentials { get }
////    init(service: LoginService)
//}
//
//final class SignInViewModel: ObservableObject, SignInViewModelProtocol {
//    
//    @Published var state: SignInState = .na
//    @Published var credentials: SignInCredentials = SignInCredentials.new
//    
////    private var subscriptions = Set<AnyCancellable>()
//    
//    let service: SignInService
//    
//    init(service: SignInService) {
//        self.service = service
//    }
//    
//    func signin() async throws {
////        service
////            .login(with: credentials)
////            .sink { res in
////                switch res {
////                case .failure(let err) : self.state = .failed(error: err)
////                default: break
////                }
////            } receiveValue: { [weak self] in
////                self?.state = .successful
////            }
////            .store(in: &subscriptions)
//        do {
//            try await service
//                .signin(with: credentials)
//        } catch {
//            throw error
//        }
//    }
//    
//}
