//
//  CheckMessageAPI.swift
//  Deartoday
//
//  Created by 이경민 on 2022/07/18.
//

import Moya

final class CheckMessageAPI {
    static let shared: CheckMessageAPI = CheckMessageAPI()
    private let checkMessageProvider = MoyaProvider<CheckMessageService>(plugins: [MoyaLoggingPlugin()])
    private init() { }
    
    public private(set) var checkMessageData: GeneralResponse<CheckMessageResponse>?
    
    // MARK: - GET
    
    func getCheckMessage(completion: @escaping (GeneralResponse<CheckMessageResponse>?) -> ()) {
        checkMessageProvider.request(.checkMessage) { result in
            switch result {
            case .success(let response):
                do {
                    self.checkMessageData = try response.map(GeneralResponse<CheckMessageResponse>?.self)
                    guard let checkMessageData = self.checkMessageData else { return }
                    completion(checkMessageData)
                } catch(let err) {
                    print(err.localizedDescription, 500)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
}
