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
    private let checkTimeTravelDetailProvider = MoyaProvider<CheckTimeTravelService>(plugins: [MoyaLoggingPlugin()])
    private init() { }
    
    public private(set) var checkTimeTravelData: GeneralResponse<CheckTimeTravelResponse>?
    public private(set) var checkTimeTravelDetailData: GeneralResponse<CheckTimeTravelDetailResponse>?
    
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
    
    func getTimeTravelDetail(timeTravelId: String, completion: @escaping ((GeneralResponse<CheckTimeTravelDetailResponse>?) -> ())) {
        checkTimeTravelDetailProvider.request(.checkTimeTravelDetail(timeTravelId: timeTravelId)) { result in
            switch result {
            case .success(let response):
                do {
                    self.checkTimeTravelDetailData = try response.map(GeneralResponse<CheckTimeTravelDetailResponse>?.self)
                    guard let checkTimeTravelDetailData = self.checkTimeTravelDetailData else {
                        return
                    }
                    completion(checkTimeTravelDetailData)
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
}
