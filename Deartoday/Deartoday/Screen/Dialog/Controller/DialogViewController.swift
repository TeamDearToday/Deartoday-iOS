//
//  DialogViewController.swift
//  Deartoday
//
//  Created by 소연 on 2022/07/13.
//

import UIKit

import SnapKit
import Then

final class DialogViewController: UIViewController {
    
    // MARK: - Property
    
    internal var year: String = "0000" {
        didSet {
            yearLabel.text = "\(year)"
            guideLabel.text = """
                              지금의 당신을 발견한 \(year)년도의 당신,
                              반갑게 손을 흔들며 당신을 맞이하네요.
                              한 번 인사를 건네보세요!
                              """
            guideLabel.addLineSpacing(spacing: 27)
            guideLabel.textAlignment = .center
            pastMessageView.dialogText = """
                                         안녕! 나는 \(year)년도의 너야.
                                         만나서 정말 반가워!
                                         너에게 몇 가지 궁금한 게 있는데
                                         괜찮다면 너와 잠깐 얘기하고 싶어.
                                         """
        }
    }
    
    internal var month: String = "00" {
        didSet {
            monthLabel.text = "\(month)"
        }
    }
    
    internal var day: String = "00" {
        didSet {
            dayLabel.text = "\(day)"
        }
    }
    
    internal var guideText: String = "" {
        didSet {
            guideLabel.text = guideText
            guideLabel.addLineSpacing(spacing: 30)
            guideLabel.textAlignment = .center
        }
    }
    
    internal var photoImage: UIImage? = nil {
        didSet {
            photoImageView.image = photoImage
        }
    }
    
    internal var timeTravelTitle: String? = nil
    
    private var canSendMessage: Bool = false {
        didSet {
            sendButton.isUserInteractionEnabled = canSendMessage ? true : false
        }
    }
    
    private var isTextViewEditing: Bool = false
    
    private var questions = [String]()
    private var lastMessage = [String]()
    private var answers: [String] = ["", "", "", "", "", "", ""]
    
    private var count: Int = 0
    
    private let dateFormatter = DateFormatter().then {
        $0.dateFormat = "yyyy.MM.dd"
    }
    
    // MARK: - UI Property
    
    private var backgroundImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = Constant.Image.convoBg
    }
    
    private var yearBackView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = Constant.Image.bgYearYellow
    }
    
    private var yearLabel = UILabel()
    
    private var monthBackView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = Constant.Image.bgMonthYellow
    }
    
    private var monthLabel = UILabel()
    
    private var dayBackView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = Constant.Image.bgMonthYellow
    }
    
    private var dayLabel = UILabel()
    
    private var exitButton = UIButton().then {
        $0.setTitle("", for: .normal)
        $0.setImage(Constant.Image.icExit, for: .normal)
        $0.setImage(Constant.Image.icExit, for: .highlighted)
        $0.tintColor = .yellow02
    }
    
    private var guideLabel = UILabel().then {
        $0.textColor = .lightGray00
        $0.font = .p3
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.alpha = 0
    }
    
    private var pastMessageView = DialogMessageView().then {
        $0.dialogType = .past
        $0.alpha = 0
    }
    
    private var presentMessageView = DialogMessageView().then {
        $0.dialogType = .present
        $0.alpha = 0
    }
    
    private lazy var nextButton = DDSButton().then {
        $0.text = "안녕!"
        $0.hasLeftIcon = false
        $0.style = .present
        $0.addTarget(self, action: #selector(nextButtonDidTap), for: .touchUpInside)
        $0.alpha = 0
    }
    
    private var photoImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.alpha = 0
        $0.makeRound(radius: 21)
    }
    
    private lazy var answerTextView = UITextView().then {
        $0.text = "답장을 입력해주세요."
        $0.textColor = .white
        $0.font = .p7
        $0.isHidden = true
        $0.backgroundColor = .clear
        $0.isScrollEnabled = false
    }
    
    private var underLineView = UIView().then {
        $0.backgroundColor = .blue02
        $0.isHidden = true
    }
    
    private lazy var sendButton = UIButton().then {
        $0.setTitle("보내기", for: .normal)
        $0.setTitleColor(.gray01, for: .disabled)
        $0.setTitleColor(.blue02, for: .normal)
        $0.setTitleColor(.blue02, for: .highlighted)
        $0.isHidden = true
        $0.addTarget(self, action: #selector(sendButtonDidTap), for: .touchUpInside)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
    
    // MARK: - @objc
    
    @objc func exitButtonDidTap() {
        dismiss(animated: true)
    }
    
    @objc func nextButtonDidTap(_ sender: DDSButton) {
        if sender.text == "안녕!" {
            hideNarrationLabel(guideLabel) { }
            hideButton(nextButton) {
                self.guideText = "당신에게 궁금한게 많은지 이것저것 질문을 합니다."
                self.showPastView(self.pastMessageView) {
                    self.guideText = ""
                    self.nextButton.text = "응, 좋아!"
                    self.showButton(self.nextButton) { }
                }
            }
        } else if sender.text == "응, 좋아!"{
            hidePastView(self.pastMessageView) { }
            hideButton(self.nextButton) {
                self.pastMessageView.dialogText = """
                                                  고마워!
                                                  아하, 너는 이때로 가장 돌아가고 싶었구나.
                                                  """
                
                self.setDialogMessageViewHeight()
                
                self.showView(self.photoImageView)
                self.showPastView(self.pastMessageView) {
                    self.hidePastView(self.pastMessageView, delay: 1.2, duration: 1.0) {
                        self.setDialogAnimation()
                    }
                }
            }
        } else {
            TimeTravelAPI.shared.postAnswers(dialog: TimeTravelAnswerRequest(title: timeTravelTitle ?? "",
                                                                             year: Int(year) ?? 0,
                                                                             month: Int(month) ?? 0,
                                                                             day: Int(day) ?? 0,
                                                                             currentDate: "\(year).\(month).\(day)",
                                                                             questions: questions,
                                                                             answers: answers),
                                             image: photoImage ?? UIImage()) { answerData, err in
                guard let answerData = answerData else {
                    return
                }
                print(answerData.message)
            }
            
            view.window?.rootViewController?.dismiss(animated: true)
        }
    }
    
    @objc func sendButtonDidTap() {
        if let text = answerTextView.text {
            presentMessageView.dialogText = text
            answers[count] = text
        }
        
        setDialogMessageViewHeight()
        
        answerTextView.text = ""
        sendButton.isEnabled = false
        
        count += 1
        switch count {
        case 0, 1, 2, 3, 4, 5:
            hidePastView(pastMessageView) {
                self.showPresentView(self.presentMessageView) {
                    self.sendButton.isEnabled = false
                    self.hidePresentView(self.presentMessageView) {
                        self.pastMessageView.dialogText = self.questions[self.count]
                        self.setDialogMessageViewHeight()
                        
                        self.showPastView(self.pastMessageView) {
                            self.sendButton.isEnabled = true
                        }
                    }
                }
            }
        case 6:
            hidePastView(pastMessageView) {
                self.showPresentView(self.presentMessageView) {
                    self.hidePresentView(self.presentMessageView) {
                        self.guideText = "마지막으로,\n과거의 당신에게 꼭 해주고 싶은 말을 남기세요."
                        self.guideLabel.snp.updateConstraints {
                            $0.top.equalTo(self.view.safeAreaLayoutGuide).inset(300)
                        }
                        
                        self.showNarrationLabel(self.guideLabel) {
                            self.presentMessageView.dialogText = self.answerTextView.text
                            self.setDialogMessageViewHeight()
                            self.sendButton.isEnabled = true
                        }
                    }
                }
            }
        default:
            hideNarrationLabel(guideLabel) {
                self.showPresentView(self.presentMessageView) {
                    self.hidePastView(self.photoImageView, delay: 1.0 , duration: 1.0) { }
                    UIView.animate(withDuration: 1.0, delay: 0.7, options: .curveEaseOut) {
                        self.presentMessageView.transform = CGAffineTransform(translationX: 0, y: -154)
                        self.presentMessageView.alpha = 0
                    } completion: { _ in
                        [self.answerTextView, self.underLineView, self.sendButton].forEach {
                            $0.isHidden = true
                        }
                        self.answerTextView.resignFirstResponder()
                        
                        self.pastMessageView.dialogText = "소중한 말 남겨줘서 정말 고마워."
                        self.setDialogMessageViewHeight()
                        
                        self.pastMessageView.snp.updateConstraints {
                            $0.top.equalTo(self.view.safeAreaLayoutGuide).inset(228)
                        }
                        
                        self.showPastView(self.pastMessageView) {
                            self.hidePastView(self.pastMessageView, delay: 1.2, duration: 1.0) {
                                self.pastMessageView.dialogText = self.lastMessage[0]
                                self.setDialogMessageViewHeight(topConstant: 228)
                                
                                self.showPastView(self.pastMessageView) {
                                    self.hidePastView(self.pastMessageView, delay: 1.2, duration: 1.0) {
                                        self.pastMessageView.dialogText = self.lastMessage[1]
                                        self.setDialogMessageViewHeight(topConstant: 228)
                                        
                                        self.showPastView(self.pastMessageView) {
                                            self.nextButton.text = "다시 오늘을 살아가기"
                                            self.nextButton.snp.updateConstraints {
                                                $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(2)
                                                $0.centerX.equalToSuperview()
                                                $0.width.equalTo(363)
                                            }
                                            self.showButton(self.nextButton) { }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Custom Method
    
    private func setUI() {
        setDateLabel()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.setLabelAnimation()
        }
        
        setTextView()
        getQuestion()
    }
    
    private func setLayout() {
        view.addSubviews([backgroundImageView,
                          yearBackView,
                          monthBackView,
                          dayBackView,
                          exitButton,
                          guideLabel,
                          nextButton,
                          pastMessageView,
                          presentMessageView,
                          photoImageView,
                          sendButton,
                          underLineView,
                          answerTextView])
        
        yearBackView.addSubview(yearLabel)
        monthBackView.addSubview(monthLabel)
        dayBackView.addSubview(dayLabel)
        
        backgroundImageView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        yearBackView.snp.makeConstraints {
            $0.width.equalTo(114)
            $0.height.equalTo(56)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(8)
            $0.leading.equalToSuperview().inset(6)
        }
        
        monthBackView.snp.makeConstraints {
            $0.width.equalTo(73)
            $0.height.equalTo(56)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(8)
            $0.leading.equalToSuperview().inset(106)
        }
        
        dayBackView.snp.makeConstraints {
            $0.width.equalTo(73)
            $0.height.equalTo(56)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(8)
            $0.leading.equalToSuperview().inset(165)
        }
        
        [yearLabel, monthLabel, dayLabel].forEach {
            $0.snp.makeConstraints {
                $0.centerX.centerY.equalToSuperview()
            }
        }
        
        exitButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(14)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.height.equalTo(44)
        }
        
        guideLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(324)
            $0.centerX.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(150)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(240)
        }
        
        pastMessageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(228)
            $0.width.equalTo(343)
            $0.height.equalTo(115)
            $0.centerX.equalToSuperview()
        }
        
        presentMessageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(228)
            $0.width.equalTo(343)
            $0.height.equalTo(115)
            $0.centerX.equalToSuperview()
        }
        
        photoImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(83)
            $0.width.equalTo(343)
            $0.height.equalTo(191)
            $0.centerX.equalToSuperview()
        }
        
        underLineView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.keyboardLayoutGuide.snp.top).inset(-26)
            $0.height.equalTo(1)
        }
        
        sendButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(underLineView.snp.top).offset(-9)
            $0.height.equalTo(27)
        }
        
        answerTextView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(75)
            $0.bottom.equalTo(underLineView.snp.top).offset(-12)
            $0.height.equalTo(21)
        }
    }
    
    private func setDateLabel() {
        [yearLabel, monthLabel, dayLabel].forEach {
            $0.textColor = .gray00
            $0.font = .h0
        }
    }
    
    private func setLabelAnimation() {
        showNarrationLabel(guideLabel) {
            self.showButton(self.nextButton) { }
        }
    }
    
    private func setDialogAnimation() {
        pastMessageView.dialogText = questions[count]
        setDialogMessageViewHeight()
        
        showPastView(self.pastMessageView) {
            [self.answerTextView, self.underLineView, self.sendButton].forEach {
                $0.isHidden = false
            }
            self.answerTextView.becomeFirstResponder()
        }
    }
    
    private func setTextView() {
        answerTextView.delegate = self
    }
    
    private func setDialogMessageViewHeight(topConstant: Double = 290) {
        [pastMessageView, presentMessageView].forEach {
            let height = $0.dialogLabel.intrinsicContentSize.height + 30
            
            $0.snp.updateConstraints {
                $0.top.equalTo(self.view.safeAreaLayoutGuide).inset(topConstant)
                $0.height.equalTo(height)
            }
        }
    }
}

// MARK: - UITextView Delegate

extension DialogViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        answerTextView.text = (answerTextView.text == "답장을 입력해주세요.") ? "" : "답장을 입력해주세요."
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        let size = CGSize(width: answerTextView.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        if estimatedSize.height >= 50 {
            textView.isScrollEnabled = true
            
            textView.constraints.forEach { (constraint) in
                if constraint.firstAttribute == .height {
                    constraint.constant = 50
                }
            }
        } else {
            textView.isScrollEnabled = false
            
            textView.constraints.forEach { (constraint) in
                if constraint.firstAttribute == .height {
                    constraint.constant = estimatedSize.height
                }
            }
        }
    }
}

// MARK: - Network

extension DialogViewController {
    private func getQuestion() {
        TimeTravelAPI.shared.getQuestion { questionData, err in
            guard let questionData = questionData else { return }
            self.questions = questionData.data?.questions ?? [""]
            self.lastMessage = questionData.data?.lastMessage ?? [""]
        }
    }
}
