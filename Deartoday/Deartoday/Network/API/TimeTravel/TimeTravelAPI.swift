//
//  TimeTravelAPI.swift
//  Deartoday
//
//  Created by 소연 on 2022/07/17.
//

import Moya

final class TimeTravelAPI {
    static let shared: TimeTravelAPI = TimeTravelAPI()
    private let oldMediaProvider = MoyaProvider<TimeTravelService>(plugins: [MoyaLoggingPlugin()])
    private init() { }
    
    public private(set) var oldMediaData: GeneralResponse<TimeTravelResponse>?
    
    // MARK: - GET
    
    public func getOldMedia(year: Int,
                            completion: @escaping ((GeneralResponse<TimeTravelResponse>?, Int?) -> ())) {
        oldMediaProvider.request(.oldMedia(year: year)) { result in
            switch result {
            case .success(let response):
                do {
                    self.oldMediaData = try response.map(GeneralResponse<TimeTravelResponse>?.self)
                    guard let oldMediaData = self.oldMediaData else { return }
                    completion(oldMediaData, nil)
                    
                } catch(let err) {
                    print(err.localizedDescription, 500)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil, 500)
            }
        }
    }
}
