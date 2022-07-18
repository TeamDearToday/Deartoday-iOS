//
//  TimeTravelService.swift
//  Deartoday
//
//  Created by 소연 on 2022/07/17.
//

import Moya

enum TimeTravelService {
    case oldMedia(year: Int)
    case question
    case answer(answer: TimeTravelAnswerRequest)
}

extension TimeTravelService: BaseTargetType {
    var path: String {
        switch self {
        case .oldMedia:
            return URLConstant.oldMedia
        case .question:
            return URLConstant.question
        case .answer:
            return URLConstant.answer
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .oldMedia, .question:
            return .get
        case .answer:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .oldMedia(let year):
            return .requestParameters(
                parameters: ["year": year],
                encoding: URLEncoding.queryString)
        case .question:
            return .requestPlain
        case .answer(let answer):
            var multiPartFormData: [MultipartFormData] = []
            
            let title = answer.title.data(using: .utf8) ?? Data()
            multiPartFormData.append(MultipartFormData(provider: .data(title), name: "title"))
            
            // UIImage -> jpegImageData
//            let imageData = answer.image.jpegData(compressionQuality: 1.0)
//            let image = MultipartFormData(provider: .data(imageData ?? Data()), name: "image", fileName: "\(title).jpg", mimeType: "image/jpeg")
            if let image = answer.image {
                let image = MultipartFormData(
                    provider: .data(image), name: "image", fileName: "\(answer.title).jpg", mimeType: "image/jpg")
                multiPartFormData.append(image)
            }
            
            let year = String(answer.year).data(using: .utf8) ?? Data()
            let month = String(answer.month).data(using: .utf8) ?? Data()
            let day = String(answer.day).data(using: .utf8) ?? Data()
            
            let currentDate = answer.currentDate.data(using: .utf8) ?? Data()
            
            multiPartFormData.append(MultipartFormData(provider: .data(year), name: "year"))
            multiPartFormData.append(MultipartFormData(provider: .data(month), name: "month"))
            multiPartFormData.append(MultipartFormData(provider: .data(day), name: "day"))
            multiPartFormData.append(MultipartFormData(provider: .data(currentDate), name: "currentDate"))
            
            let questions = answer.questions
            let answers = answer.answers
            
//            var questionsData : [Data] = []
//            var answersData : [Data] = []
            
            for question in questions {
                let questionData = question.data(using: .utf8) ?? Data()
                multiPartFormData.append(MultipartFormData(provider: .data(questionData), name: "questions"))
//                questionsData.append(questionData)
            }
            
            for answer in answers {
                let answerData = answer.data(using: .utf8) ?? Data()
                multiPartFormData.append(MultipartFormData(provider: .data(answerData), name: "answers"))
//                answersData.append(answerData)
            }
           
//            multiPartFormData.append(MultipartFormData(provider: .data(questions), name: "questions"))
            
            return .uploadMultipart(multiPartFormData)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "multipart/form-data",
                "Authorization": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiNjJkNTAyMWEyNDEzM2E4OTU3M2YzODM3In0sImlhdCI6MTY1ODEzNzc5MywiZXhwIjoxNjU4MTQxMzkzfQ.QnA-RGbY3GNHR6rggla6a5tlFolh-bBjbNgtDXzW6Tk"]
    }
}

