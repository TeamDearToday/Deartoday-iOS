//
//  LoginAPI.swift
//  Deartoday
//
//  Created by 황찬미 on 2022/07/18.
//

import Moya

final class LoginAPI {
    static let shared: LoginAPI = LoginAPI()
    private let loginProvider = MoyaProvider<LoginService>(plugins: [MoyaLoggingPlugin()])
    private init() { }
    
    public private(set) var loginData: GeneralResponse<LoginResponse>?
    
    // MARK: - Post
    
    func login(social: String, socialToken: String, FCMToken: String, completion: @escaping ((GeneralResponse<LoginResponse>?, Error?) -> ())) {
        loginProvider.request(.login(social: social, socialToken: socialToken, FCMToken: FCMToken)) { [weak self] response in
            switch response {
            case .success(let result):
                do {
                    self?.loginData = try result.map(GeneralResponse<LoginResponse>?.self)
                    guard let loginData = self?.loginData else { return }
                    completion(loginData, nil)
                } catch(let err) {
                    print(err.localizedDescription)
                    completion(nil, err)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil, err)
            }
        }
    }
}
