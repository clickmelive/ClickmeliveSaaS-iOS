//
//  PlayerViewController.swift
//  ClickmeliveUI
//
//  Created by Can on 4.03.2024.
//

import UIKit

protocol PlayerViewControllerOutput {
    func itemsTapped()
    func likeTapped(like: Bool)
    func messageSendTapped(message: String)
    func minimizeTapped()
    func closePipTapped()
}

final class PlayerViewController: UIViewController {
    
    lazy var playerVCView = Components.default.playerVCView.init()
    
    deinit {
        print("deinit PlayerViewController")
    }
    
    var output: PlayerViewControllerOutput?
    var viewTapGesture: UITapGestureRecognizer?
    var onShouldUpdateLiveEventViewerCount: (() -> Void)?
    
    private var liveEventViewerCountTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerActions()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        playerVCView.playerView.setUpDisplayLink()
        observeKeyboardNotifications()
        registerAppLifecycleNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        NotificationCenter.default.removeObserver(self)
        stopLiveEventViewerCountTimer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        playerVCView.playerView.tearDownDisplayLink()
        playerVCView.playerView.pauseLivePlayback()
        playerVCView.playerView.pauseVideoPlayback()
        removeKeyboardNotifications()
    }
    
    override func loadView() {
        view = playerVCView
    }
}

extension PlayerViewController {
    func updateLikeStatus(with like: Bool, withAnimation: Bool) {
        playerVCView.updateLikeStatus(with: like, withAnimation: withAnimation)
    }
}

// MARK: - Video management
extension PlayerViewController {
    func setVideoDetail(with viewModel: VideoViewModel, imageLoader: ImageLoader) {
        playerVCView.configure(with: viewModel, imageLoader: imageLoader)
    }
    
    func updateStats(with viewModel: VideoViewModel) {
        playerVCView.updateStats(with: viewModel)
    }
}

// MARK: - Live Event Management
extension PlayerViewController {
    func setLiveEventDetail(with viewModel: LiveEventViewModel, imageLoader: ImageLoader) {
        playerVCView.configure(with: viewModel, imageLoader: imageLoader)
    }
    
    func updateStats(with viewModel: LiveEventViewModel) {
        playerVCView.updateStats(with: viewModel)
    }
}

extension PlayerViewController {
    func updateLiveEventViewerCount(with viewModel: LiveEventViewerViewModel) {
        playerVCView.updateLiveEventViewerCount(with: viewModel)
    }
}

extension PlayerViewController {
    private func startLiveEventViewerCountTimer() {
        onShouldUpdateLiveEventViewerCount?()
        
        liveEventViewerCountTimer?.invalidate()
        liveEventViewerCountTimer = Timer.scheduledTimer(timeInterval: Double.random(in: 5...8), target: self, selector: #selector(shouldUpdateLiveEventViewerCount), userInfo: nil, repeats: true)
    }
    
    private func stopLiveEventViewerCountTimer() {
        liveEventViewerCountTimer?.invalidate()
        liveEventViewerCountTimer = nil
    }
    
    @objc private func shouldUpdateLiveEventViewerCount() {
        onShouldUpdateLiveEventViewerCount?()
    }
}

extension PlayerViewController {
    private func registerAppLifecycleNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(appDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appWillResignActive), name: UIApplication.willResignActiveNotification, object: nil)
    }

    @objc private func appDidBecomeActive() {
        if playerVCView.playerView.isStreaming {
            startLiveEventViewerCountTimer()
        }
    }

    @objc private func appWillResignActive() {
        if playerVCView.playerView.isStreaming {
            stopLiveEventViewerCountTimer()
        }
    }
}

extension PlayerViewController {
    func display(chatMessages: [CollectionCellController]) {
        playerVCView.chatView.display(chatMessages: chatMessages)
    }
    
    private func setupCollectionView() {
        playerVCView.chatView.chatList.register(ChatCell.self, forCellWithReuseIdentifier: ChatCell.reuseId)
    }
}

// MARK: - Actions
extension PlayerViewController {
    private func registerActions() {
        let itemsGesture = UITapGestureRecognizer(target: self, action: #selector(itemsTapped))
        playerVCView.itemsView.addGestureRecognizer(itemsGesture)
        
        playerVCView.likeView.onLikeTapped = output?.likeTapped
        
        let composeGesture = UITapGestureRecognizer(target: self, action: #selector(composeTapped))
        playerVCView.composerView.composerContainer.addGestureRecognizer(composeGesture)
        
        viewTapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        if let tapGesture = viewTapGesture {
            playerVCView.addGestureRecognizer(tapGesture)
        }
        
        playerVCView.composerView.btnSendMessage.addTarget(self, action: #selector(messageSendTapped), for: .touchUpInside)
        
        playerVCView.tvMessage.onSendMessage = { [weak self] message in
            self?.output?.messageSendTapped(message: message)
        }
        
        playerVCView.tvMessage.onMessageTextChange = { [weak self] message in
            self?.playerVCView.composerView.lblStartTyping.text = message.isEmpty ? "Yazmaya başla...": message
            self?.playerVCView.composerView.setSendButtonState(isEnabled: !message.isEmpty)
        }
        
        playerVCView.btnMinimize.addTarget(self, action: #selector(minimizeTapped), for: .touchUpInside)
        playerVCView.btnPipClose.addTarget(self, action: #selector(pipCloseTapped), for: .touchUpInside)
        
        playerVCView.playerView.onStreaming = { [weak self] isStreaming in
            isStreaming ?
            self?.startLiveEventViewerCountTimer():
            self?.stopLiveEventViewerCountTimer()
        }
        
        playerVCView.composerView.btnChatVisibility.addTarget(self, action: #selector(chatVisibilityTapped), for: .touchUpInside)
    }
    
    @objc private func itemsTapped() {
        output?.itemsTapped()
    }
    
    @objc private func composeTapped() {
        playerVCView.tvMessage.autoSizingTextView.becomeFirstResponder()
    }
    
    @objc private func chatVisibilityTapped() {
        playerVCView.chatView.isHidden.toggle()
    }
    
    @objc func dismissKeyboard(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: playerVCView)
        let tvMessageFrame = playerVCView.tvMessage.convert(playerVCView.tvMessage.bounds, to: view)
        
        if !tvMessageFrame.contains(location) {
            view.endEditing(true)
        }
    }
    
    @objc private func minimizeTapped() {
        output?.minimizeTapped()
    }
    
    @objc private func pipCloseTapped() {
        output?.closePipTapped()
    }
    
    @objc private func messageSendTapped() {
        playerVCView.tvMessage.sendTapped()
    }
}

// MARK: - Keyboard related methods
extension PlayerViewController {
    @objc func handleKeyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            
            playerVCView.tvMessage.isHidden = !isKeyboardShowing
            playerVCView.tvMessageBottomConstraint?.constant = isKeyboardShowing ? -keyboardFrame!.height : 0
            
            playerVCView.handleChatView(isKeyboardShowing: isKeyboardShowing, keyboardHeight: -keyboardFrame!.height)
            
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut) {
                self.playerVCView.layoutIfNeeded()
            }
        }
        
    }
    
    // MARK: - Keyboard Observers
    private func observeKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

