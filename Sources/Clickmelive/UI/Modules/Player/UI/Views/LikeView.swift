//
//  LikeView.swift
//  ClickmeliveUI
//
//  Created by Can on 4.03.2024.
//

import UIKit

extension LikeView {
    // MARK: - Video
    func configure(with viewModel: VideoViewModel) {
        lblLikeCount.text = viewModel.totalLikeCount
    }
    
    // MARK: - Video Interaction
    func updateLikeStatus(with like: Bool, withAnimation: Bool) {
        self.like = like
        ivLike.image = .appImage(like ? .iconLiked: .iconLike)
        if withAnimation { animateLikeIcon() }
    }
}

extension LikeView {
    // MARK: - Live Event
    func configure(with viewModel: LiveEventViewModel) {
        lblLikeCount.text = viewModel.totalLikeCount
    }
    
    // MARK: - Live Event Interaction
    func configure(with viewModel: LiveEventUserInteractionViewModel, initialCall: Bool) {
        self.like = viewModel.like
        ivLike.image = .appImage(viewModel.like ? .iconLiked: .iconLike)
        if !initialCall { animateLikeIcon() }
    }
}

extension LikeView {
    private func registerActions() {
        let likeGesture = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        ivLike.addGestureRecognizer(likeGesture)
    }
    
    @objc private func likeTapped() {
        onLikeTapped?(like)
    }
}

extension LikeView {
    func animateLikeIcon() {
        guard like else { return }
        
        ivLike.transform = CGAffineTransform(scaleX: 1, y: 1)
        
        UIView.animateKeyframes(withDuration: 0.25, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                self.ivLike.transform = CGAffineTransform(scaleX: 1.525, y: 1.525)
            }
       
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                self.ivLike.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }, completion: nil)
    }
}

class LikeView: _View {
    
    var onLikeTapped: ((_ like: Bool) -> Void)?
    
    private var like: Bool = false
    
    // MARK: - Views
    private(set) lazy var contentStackView: UIStackView = {
        let view = UIStackView()
        return view
    }()
    
    private(set) lazy var likeImageContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    private(set) lazy var ivLike: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    private(set) lazy var lblLikeCount: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override func setUp() {
        super.setUp()
        
        registerActions()
        ivLike.isUserInteractionEnabled = true
    }
    
    override func setUpAppearance() {
        super.setUpAppearance()
        layer.cornerRadius = 8
       
        contentStackView.axis = .vertical
        contentStackView.spacing = 3
        contentStackView.distribution = .fill
        
        lblLikeCount.font = .appFont(.bold, size: 12)
        lblLikeCount.textColor = .appColor(.appPrimaryText)
        lblLikeCount.textAlignment = .center
    }
    
    override func setUpLayout() {
        super.setUpLayout()
      
        likeImageContainer.addSubview(ivLike)
        
        [likeImageContainer, lblLikeCount].forEach {
            contentStackView.addArrangedSubview($0)
        }
        
        addSubview(contentStackView)
        
        contentStackView.fillSuperview()
        
        ivLike.anchor(top: likeImageContainer.topAnchor, bottom: likeImageContainer.bottomAnchor, widthConstant: 40, heightConstant: 35)
        ivLike.anchorCenterXToSuperview()
        
        lblLikeCount.constrainHeight(15)
        lblLikeCount.widthAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
    }
    
    override func updateContent() {
        super.updateContent()
        ivLike.image = .appImage(.iconLike)
    }
}
