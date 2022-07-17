//
//  TimeTravelViewController.swift
//  Deartoday
//
//  Created by 소연 on 2022/07/08.
//

import UIKit
import Photos

import Lottie
import SnapKit
import Then

final class TimeTravelViewController: UIViewController {
    
    // MARK: - Property
    
    private let dateFormatter = DateFormatter().then {
        $0.dateFormat = "yyyy.MM.dd"
    }
    
    private let yearFormatter = DateFormatter().then {
        $0.dateFormat = "yyyy"
    }
    
    private let monthFormatter = DateFormatter().then {
        $0.dateFormat = "MM"
    }
    
    private let dayFormatter = DateFormatter().then {
        $0.dateFormat = "dd"
    }
    
    private var year: String = ""
    private var month: String = ""
    private var day: String = ""
    
    var selectedImage: UIImage? = nil {
        didSet {
            timeTravelView.photoImageView.image = selectedImage
        }
    }
    
    // MARK: - UI Property
    
    private var backImageView = UIImageView().then {
        $0.image = Constant.Image.mainLeftWithg
    }
    
    private var coverView = UIView().then {
        $0.backgroundColor = UIColor(red: 50 / 255, green: 50 / 255, blue: 50 / 255, alpha: 0.8)
    }
    
    private var yearBackView = UIImageView().then {
        $0.image = Constant.Image.bgYear
    }
    
    private lazy var yearLabel = UILabel().then {
        $0.text = getYearInfo()
        $0.textColor = .lightBlue00
        $0.font = .h0
        $0.isHidden = false
    }
    
    private var yearAnimationLabel = CountDownLabel().then {
        $0.text = "0000"
        $0.textColor = .clear
        $0.font = .h0
        $0.isHidden = true
    }
    
    private var monthBackView = UIImageView().then {
        $0.image = Constant.Image.bgDate
    }
    
    private lazy var monthLabel = UILabel().then {
        $0.text = getMonthInfo()
        $0.textColor = .lightBlue00
        $0.font = .h0
        $0.isHidden = false
    }
    
    private var monthAnmationLabel = CountDownLabel().then {
        $0.text = "00"
        $0.textColor = .clear
        $0.font = .h0
        $0.isHidden = true
    }
    
    private var dayBackView = UIImageView().then {
        $0.image = Constant.Image.bgDate
    }
    
    private lazy var dayLabel = UILabel().then {
        $0.text = getDayInfo()
        $0.textColor = .lightBlue00
        $0.font = .h0
        $0.isHidden = false
    }
    
    private var dayAnimationLabel = CountDownLabel().then {
        $0.text = "00"
        $0.textColor = .clear
        $0.font = .h0
        $0.isHidden = true
    }
    
    private lazy var exitButton = UIButton().then {
        $0.setImage(Constant.Image.icExit, for: .normal)
        $0.setImage(Constant.Image.icExit, for: .highlighted)
        $0.addTarget(self, action: #selector(exitButtonDidTap), for: .touchUpInside)
    }
    
    private var guideLabel = UILabel().then {
        $0.text = """
                  테이프를 터치하여
                  돌아가고 싶은 순간을 선택해주세요
                  """
        $0.font = .p2
        $0.textColor = .glassBlue
        $0.numberOfLines = 2
        $0.addLineSpacing(spacing: 23)
    }
    
    private var timeTravelView = TimeTravelView().then {
        $0.hasPhoto = false
        $0.isUserInteractionEnabled = true
    }
    
    lazy var returnButton = DDSButton().then {
        $0.text = "과거로 돌아가기"
        $0.hasLeftIcon = true
        $0.style = .disable
        $0.addTarget(self, action: #selector(returnButtonDidTap), for: .touchUpInside)
    }
    
    private let imagePicker = UIImagePickerController()
    
    private var playerAnimationView: AnimationView = {
        let animationView = AnimationView.init(name: Constant.Lottie.timetape)
        animationView.alpha = 0
        return animationView
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        getNotification()
        setDelegate()
    }
    
    // MARK: - Custom Method
    
    private func setUI() {
        view.backgroundColor = .white
    }
    
    private func setLayout() {
        view.addSubviews([backImageView,
                          coverView,
                          playerAnimationView,
                          monthBackView,
                          yearBackView,
                          dayBackView,
                          exitButton,
                          guideLabel,
                          timeTravelView,
                          returnButton])
        
        yearBackView.addSubviews([yearLabel, yearAnimationLabel])
        monthBackView.addSubviews([monthLabel, monthAnmationLabel])
        dayBackView.addSubviews([dayLabel, dayAnimationLabel])
        
        backImageView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        coverView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        playerAnimationView.snp.makeConstraints {
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
        
        [yearLabel, yearAnimationLabel , monthLabel, monthAnmationLabel, dayLabel, dayAnimationLabel].forEach {
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
            $0.top.equalTo(yearBackView.snp.bottom).offset(56)
            $0.leading.equalToSuperview().inset(16)
        }
        
        timeTravelView.snp.makeConstraints {
            $0.top.equalTo(yearBackView.snp.bottom).offset(119)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(380)
        }
        
        returnButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(6)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(2)
        }
    }
    
    // MARK: - @objc
    
    @objc func exitButtonDidTap() {
        dismiss(animated: true)
    }
    
    @objc func returnButtonDidTap() {
        UIView.animate(withDuration: 0.6, delay: 0.3, options: .curveEaseOut) {
            self.guideLabel.alpha = 0
            self.timeTravelView.dateTextField.alpha = 0
            self.timeTravelView.titleTextField.alpha = 0
            self.returnButton.alpha = 0
        } completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 0.3, options: .curveEaseOut) {
                self.timeTravelView.alpha = 0
                self.coverView.alpha = 0
                
                self.playerAnimationView.alpha = 1
                self.playerAnimationView.play()
            } completion: { _ in
                self.setCountDownAnimation()
            }
        }
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) {
            self.timeTravelView.snp.updateConstraints {
                $0.top.equalTo(self.yearBackView.snp.bottom).offset(self.getDeviceHeight() == 812 ? 52 : 19)
            }
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) {
            self.timeTravelView.snp.updateConstraints {
                $0.top.equalTo(self.yearBackView.snp.bottom).offset(119)
            }
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func enableReturnButton(_ notification: Notification) {
        returnButton.style = .present
    }
    
    // MARK: - Custom Method
    
    private func getNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(enableReturnButton(_:)),
                                               name: NSNotification.Name("EnableReturnButton"),
                                               object: nil)
    }
    
    private func setDelegate() {
        timeTravelView.delegate = self
    }
    
    private func setCountDownAnimation() {
        [yearLabel, yearAnimationLabel, monthLabel, monthAnmationLabel, dayLabel, dayAnimationLabel].forEach {
            $0.isHidden.toggle()
        }
        
        yearAnimationLabel.config(num: year, duration: 1.2)
        yearAnimationLabel.animate(ascending: true)
        
        monthAnmationLabel.config(num: month, duration: 1.2)
        monthAnmationLabel.animate(ascending: true)
        
        dayAnimationLabel.config(num: day, duration: 1.2)
        dayAnimationLabel.animate(ascending: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.8) {
            UIView.animate(withDuration: 0.3, delay: 1.0, options: .curveEaseOut) {
                let virtualSpaceViewController = VirtualSpaceViewController()
                
                virtualSpaceViewController.modalPresentationStyle = .fullScreen
                virtualSpaceViewController.modalTransitionStyle = .crossDissolve
                
                virtualSpaceViewController.year = self.year
                virtualSpaceViewController.month = self.month
                virtualSpaceViewController.day = self.day
                
                virtualSpaceViewController.selectedImage = self.selectedImage ?? UIImage()
                
                self.present(virtualSpaceViewController, animated: true)
            }
        }
    }
    
    private func checkLibraryPermission(){
        PHPhotoLibrary.requestAuthorization( { status in
            switch status{
            case .authorized:
                print("Library: 권한 허용")
            case .denied:
                print("Library: 권한 거부")
            case .restricted, .notDetermined:
                print("Library: 선택하지 않음")
            default:
                break
            }
        })
    }
}

// MARK: - Custom Delegate

extension TimeTravelViewController: TimeTravelViewDelegate {
    func photoImageViewDidTap() {
        checkLibraryPermission()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(self.imagePicker, animated: true)
    }
}

// MARK: - UIImagePicker Delegate

extension TimeTravelViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        var newImage: UIImage? = nil
//
//        if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
//            newImage = possibleImage
//            selectedImage = possibleImage
//        } else if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            newImage = possibleImage
//            selectedImage = possibleImage
//        }
//
////        timeTravelView.photoImageView.image = newImage
//
//        let asset = info[.phAsset] as? PHAsset
//
//        let option = PHContentEditingInputRequestOptions()
//        option.canHandleAdjustmentData = { _ in true }
//
//        asset?.requestContentEditingInput(with: option, completionHandler: { (contentEditingInput, info) in
//            if let date = contentEditingInput?.creationDate {
//                self.timeTravelView.dateTextField.text = self.dateFormatter.string(from: date)
//                self.year = self.yearFormatter.string(from: date)
//                self.month = self.monthFormatter.string(from: date)
//                self.day = self.dayFormatter.string(from: date)
//                self.timeTravelView.hasPhoto = true
//            }
//        })
//
//        picker.dismiss(animated: true, completion: {
//            let cropViewController = CropViewController()
//            cropViewController.initialImage = newImage
//            cropViewController.delegate = self
//            self.present(cropViewController, animated: true)
//        })
//    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var chosenImage: UIImage?
        chosenImage = info[.originalImage] as? UIImage
                
        self.dismiss(animated: false, completion: {
            let cropViewController = CropViewController()
            cropViewController.initialImage = chosenImage
            self.present(cropViewController, animated: true)
        })
    }
}
