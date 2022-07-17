//
//  CropViewController.swift
//  Deartoday
//
//  Created by 소연 on 2022/07/17.
//

import UIKit

final class CropViewController: UIViewController {
    
    // MARK: - Property
    
    var initialImage: UIImage? = nil {
        didSet {
            cropImageView.image = initialImage
            cropImageView.contentMode = .scaleAspectFit
        }
    }
    
    // MARK: - UI Property
    
    private var containerView = UIView().then {
        $0.backgroundColor = .white
        $0.makeRound(radius: 8)
    }
    
    private var scrollView = UIScrollView().then {
        $0.backgroundColor = .gray
        $0.decelerationRate = .fast
        $0.isScrollEnabled = true
        $0.makeRound(radius: 8)
    }
    
    private var cropImageView = UIImageView().then {
        $0.makeRound(radius: 8)
    }
    
    private var bottomView = UIView().then {
        $0.backgroundColor = .gray00
    }
    
    private lazy var useButton = UIButton().then {
        $0.setTitle("선택", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.setTitleColor(.white, for: .highlighted)
        $0.addTarget(self, action: #selector(useButtonDidTap), for: .touchUpInside)
    }
    
    private lazy var cancelButton = UIButton().then {
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.setTitleColor(.white, for: .highlighted)
        $0.addTarget(self, action: #selector(cancelButtonDidTap), for: .touchUpInside)
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setScrollView()
    }
    
    // MARK: - @objc
    
    @objc func useButtonDidTap() {
        guard let presentingViewController = self.presentingViewController as? TimeTravelViewController else { return }
        dismiss(animated: true, completion: nil)
    }
    
    @objc func cancelButtonDidTap() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Custom Method
    
    private func setUI() {
        view.backgroundColor = .black
    }
    
    private func setLayout() {
        view.addSubviews([containerView, bottomView])
        bottomView.addSubviews([cancelButton, useButton])
        
        containerView.addSubview(scrollView)
        scrollView.addSubview(cropImageView)
        
        containerView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(274)
            $0.height.equalTo(154)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        cropImageView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        bottomView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
        
        cancelButton.snp.makeConstraints {
            $0.leading.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        useButton.snp.makeConstraints {
            $0.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
    }
    
    private func setScrollView() {
        scrollView.delegate = self
        scrollView.minimumZoomScale = -10.0
        scrollView.maximumZoomScale = 4.0
    }
}

// MARK: - UIScrollView Delegate

extension CropViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return cropImageView
    }
}
