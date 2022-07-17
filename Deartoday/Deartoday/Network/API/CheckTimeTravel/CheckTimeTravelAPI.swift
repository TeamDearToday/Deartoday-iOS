//
//  CheckTimeTravelAPI.swift
//  Deartoday
//
//  Created by 이경민 on 2022/07/18.
//

import Moya

final class CheckTimeTravelAPI {
    static let shared: CheckTimeTravelAPI = CheckTimeTravelAPI()
    private let checkTimeTravelProvider = MoyaProvider<CheckTimeTravelService>(plugins: [MoyaLoggingPlugin()])
    private init() { }
    
    public private(set) var checkTimeTravelData: GeneralResponse<CheckTimeTravelResponse>?
    
    // MARK: - GET
    
    func getCheckTimeTravel(completion: @escaping (GeneralResponse<CheckTimeTravelResponse>?) -> ()) {
        checkTimeTravelProvider.request(.checkTimeTravel) { result in
            switch result {
            case .success(let response):
                do {
                    self.checkTimeTravelData = try response.map(GeneralResponse<CheckTimeTravelResponse>?.self)
                    guard let checkTimeTravelData = self.checkTimeTravelData else {
                        return
                    }
                    completion(checkTimeTravelData)
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
