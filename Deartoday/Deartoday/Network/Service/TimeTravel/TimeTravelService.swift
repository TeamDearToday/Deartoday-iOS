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
    case dialog(dialog: TimeTravelAnswerRequest, image: UIImage)
}

extension TimeTravelService: BaseTargetType {
    var path: String {
        switch self {
        case .oldMedia:
            return URLConstant.oldMedia
        case .question:
            return URLConstant.question
        case .dialog:
            return URLConstant.dialog
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .oldMedia, .question:
            return .get
        case .dialog:
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
        case .dialog(let dialog, let image):
            var multiPartFormData: [MultipartFormData] = []
            
            let title = dialog.title.data(using: .utf8) ?? Data()
            multiPartFormData.append(MultipartFormData(provider: .data(title), name: "title"))
            
            let year = String(dialog.year).data(using: .utf8) ?? Data()
            let month = String(dialog.month).data(using: .utf8) ?? Data()
            let day = String(dialog.day).data(using: .utf8) ?? Data()
            
            // UIImage -> jpegImageData
            let imageData = image.jpegData(compressionQuality: 1.0)
            let image = MultipartFormData(provider: .data(imageData ?? Data()), name: "image", fileName: "image.jpg", mimeType: "image/jpeg")
            multiPartFormData.append(image)
            
            let writtenDate = dialog.writtenDate.data(using: .utf8) ?? Data()
            
            multiPartFormData.append(MultipartFormData(provider: .data(year), name: "year"))
            multiPartFormData.append(MultipartFormData(provider: .data(month), name: "month"))
            multiPartFormData.append(MultipartFormData(provider: .data(day), name: "day"))
            multiPartFormData.append(MultipartFormData(provider: .data(writtenDate), name: "writtenDate"))
            
            let questions = dialog.questions
            let answers = dialog.answers
            
            for index in questions.indices {
                let questionData = questions[index].data(using: .utf8) ?? Data()
                multiPartFormData.append(MultipartFormData(provider: .data(questionData), name: "questions[\(index)]"))
            }
            for index in answers.indices {
                let answerData = answers[index].data(using: .utf8) ?? Data()
                multiPartFormData.append(MultipartFormData(provider: .data(answerData), name: "answers[\(index)]"))
            }
            
            return .uploadMultipart(multiPartFormData)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "multipart/form-data",
                "Authorization": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiNjJjZTgwZDk2ZDZlMjJlOGMzNjFhNDVkIn0sImlhdCI6MTY1ODM0MDk0MCwiZXhwIjoxNjU5NTUwNTQwfQ.0iexVmi8OeJIjq2KwEpq3RclhsK6qvNuS5VCrVcXl_o"]
    }
}

