//
//  MainAPI.swift
//  Deartoday
//
//  Created by 이경민 on 2022/07/18.
//

import Moya

final class MainAPI {
    static let shared: MainAPI = MainAPI()
    private let mainProvider = MoyaProvider<MainService>(plugins: [MoyaLoggingPlugin()])
    private init() { }
    
    public private(set) var mainData: GeneralResponse<MainResponse>?
    
    // MARK: - GET
    
    func getMain(completion: @escaping (GeneralResponse<MainResponse>?) -> ()) {
        mainProvider.request(.main) { result in
            switch result {
            case .success(let response):
                do {
                    self.mainData = try response.map(GeneralResponse<MainResponse>?.self)
                    guard let mainData = self.mainData else { return }
                    completion(mainData)
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
