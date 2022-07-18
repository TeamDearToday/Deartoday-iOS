//
//  TimeTravelAPI.swift
//  Deartoday
//
//  Created by 소연 on 2022/07/17.
//

import Moya

final class TimeTravelAPI {
    static let shared: TimeTravelAPI = TimeTravelAPI()
    private let timeTravelProvider = MoyaProvider<TimeTravelService>(plugins: [MoyaLoggingPlugin()])
    private init() { }
    
    public private(set) var oldMediaData: GeneralResponse<TimeTravelResponse>?
    public private(set) var questionData: GeneralResponse<TimeTravelQuestionResponse>?
    public private(set) var dialogData: GeneralResponse<TimeTravelAnswerResponse>?
 
    // MARK: - GET
    
    public func getOldMedia(year: Int,
                            completion: @escaping ((GeneralResponse<TimeTravelResponse>?, Int?) -> ())) {
        timeTravelProvider.request(.oldMedia(year: year)) { result in
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
    
    public func getQuestion(completion: @escaping ((GeneralResponse<TimeTravelQuestionResponse>?, Int?) -> ())) {
        timeTravelProvider.request(.question) { result in
            switch result {
            case .success(let response):
                do {
                    self.questionData = try response.map(GeneralResponse<TimeTravelQuestionResponse>?.self)
                    guard let questionData = self.questionData else { return }
                    completion(questionData, nil)
                    
                } catch(let err) {
                    print(err.localizedDescription, 500)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil, 500)
            }
        }
    }
    
    public func postAnswers(dialog: TimeTravelAnswerRequest, completion: @escaping ((GeneralResponse<TimeTravelAnswerResponse>?, Int?) -> ())) {
        timeTravelProvider.request(.dialog(dialog: dialog)) { result in
            switch result {
            case .success(let response):
                do {
                    self.dialogData = try response.map(GeneralResponse<TimeTravelAnswerResponse>?.self)
                    guard let dialogData = self.dialogData else { return }
                    completion(dialogData, nil)
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
