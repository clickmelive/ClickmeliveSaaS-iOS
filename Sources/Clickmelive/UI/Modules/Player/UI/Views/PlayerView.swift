//
//  PlayerView.swift
//  ClickmeliveUI
//
//  Created by Can on 4.03.2024.
//

import UIKit
import AmazonIVSPlayer

private extension LiveEventViewModel {
    var videoToPlay: URL? {
        if replayAvailable {
            return replayUrl
        } else {
            switch status {
            case .Created, .Teaser:
                return teaserUrl
            case .Streaming:
                return playbackUrl
            case .StreamEnded, .ReadyToStream, .Cancelled, .None:
                return nil
            }
        }
    }

    var shouldHideThumbnail: Bool {
        replayAvailable || status == .Streaming
    }
}

extension PlayerView {
    func configure(with viewModel: VideoViewModel, imageLoader: ImageLoader) {
        imageLoader.loadImage(to: ivThumbnail, with: viewModel.thumbnailUrl, placeholder: nil)
        shouldConfigureVideo(viewModel: viewModel)
    }
    
    private func shouldConfigureVideo(viewModel: VideoViewModel) {
        if videoPlayer?.path != viewModel.videoUrl {
            playVideo(from: viewModel.videoUrl)
        }
    }
}

extension PlayerView {
    func configure(with viewModel: LiveEventViewModel, imageLoader: ImageLoader) {
        imageLoader.loadImage(to: ivThumbnail, with: viewModel.thumbnailUrl, placeholder: nil)
        ivThumbnail.isHidden = viewModel.shouldHideThumbnail
        
        if let videoUrl = viewModel.videoToPlay {
            if viewModel.status == .Streaming {
                if livePlayer?.path != videoUrl {
                    onStreaming?(true)
                    playLive(from: videoUrl)
                }
            } else {
                if videoPlayer?.path != videoUrl {
                    onStreaming?(false)
                    playVideo(from: videoUrl)
                }
            }
        }
    }
}

// MARK: - Player Lifecycle management
extension PlayerView {
    @objc private func applicationDidEnterBackground(notification: Notification) {
        if livePlayer?.state == .playing || livePlayer?.state == .buffering ||
            videoPlayer?.state == .playing || videoPlayer?.state == .buffering {
            didPauseOnBackground = true
            pauseLivePlayback()
            pauseVideoPlayback()
        } else {
            didPauseOnBackground = false
        }
    }

    @objc private func applicationDidBecomeActive(notification: Notification) {
        if didPauseOnBackground && videoPlayer?.error == nil && livePlayer?.error == nil {
            if isLive {
                startLivePlayback()
            } else {
                startVideoPlayback()
            }
            didPauseOnBackground = false
        }
    }

    private func addApplicationLifecycleObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidEnterBackground(notification:)), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive(notification:)), name: UIApplication.didBecomeActiveNotification, object: nil)
    }

    private func removeApplicationLifecycleObservers() {
        NotificationCenter.default.removeObserver(self, name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
    }
}

// MARK: - Stream related methods
extension PlayerView {
    private func loadLiveStream(from url: URL?) {
        guard let streamURL = url else {
            print("❌ could not create url from: \(url?.absoluteString ?? "")")
            return
        }
        let livePlayer: IVSPlayer
        if let existingPlayer = self.livePlayer {
            livePlayer = existingPlayer
        } else {
            livePlayer = IVSPlayer()
            livePlayer.delegate = self
            self.livePlayer = livePlayer
            print("Live player initialized: version \(livePlayer.version)")
        }
        livePlayer.load(streamURL)
    }

    private func loadVideoStream(from url: URL?) {
        guard let streamURL = url else {
            print("❌ could not create url from: \(url?.absoluteString ?? "")")
            return
        }
        let videoPlayer: IVSPlayer
        if let existingPlayer = self.videoPlayer {
            videoPlayer = existingPlayer
        } else {
            videoPlayer = IVSPlayer()
            videoPlayer.delegate = self
            self.videoPlayer = videoPlayer
            print("Video player initialized: version \(videoPlayer.version)")
        }
        videoPlayer.load(streamURL)
    }
    
    func playLive(from url: URL?) {
        print("Playing LIVE")
        clearPlayers()
        updatePositionDisplay()
        loadLiveStream(from: url)
        seekSlider.isHidden = true
        startLivePlayback()
    }
    
    func playVideo(from url: URL?) {
        clearPlayers()
        updatePositionDisplay()
        loadVideoStream(from: url)
        seekSlider.isHidden = false
        startVideoPlayback()
    }
    
    private func startLivePlayback() {
        ivsLivePlayerView.isHidden = false
        ivsVideoPlayerView.isHidden = true
        pauseVideoPlayback()
        livePlayer?.play()
        isLive = true
    }

    private func startVideoPlayback() {
        ivsLivePlayerView.isHidden = true
        ivsVideoPlayerView.isHidden = false
        pauseLivePlayback()
        videoPlayer?.play()
    }

    func pauseLivePlayback() {
        livePlayer?.pause()
        isLive = false
    }

    func pauseVideoPlayback() {
        videoPlayer?.pause()
    }
    
    private func clearPlayers() {
        pauseLivePlayback()
        pauseVideoPlayback()
        livePlayer = nil
        videoPlayer = nil
    }
}

// MARK: - Delegate related methods
extension PlayerView: IVSPlayer.Delegate {
    func player(_ player: IVSPlayer, didChangeState state: IVSPlayer.State) {
        updateForState(state)
    }
    
    func player(_ player: IVSPlayer, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func player(_ player: IVSPlayer, didChangeVideoSize videoSize: CGSize) {
       // if videoSize.height == 0 || videoSize.width == 0 { return }
       // ivsVideoPlayerView.videoGravity = player.videoSize.height > player.videoSize.width ? AVLayerVideoGravity.resizeAspectFill : AVLayerVideoGravity.resizeAspect
       // ivsLivePlayerView.videoGravity = player.videoSize.height > player.videoSize.width ? AVLayerVideoGravity.resizeAspectFill : AVLayerVideoGravity.resizeAspect
    }
    
    func player(_ player: IVSPlayer, didChangeDuration duration: CMTime) {
        updateForDuration(duration: duration)
    }
}

// MARK: - Actions
extension PlayerView {
    private func registerActions() {
        seekSlider.addTarget(self, action: #selector(onSeekSliderValueChanged(_:event:)), for: .valueChanged)
        seekSlider.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapToSeek(_:))))
        
        let controlGesture = UITapGestureRecognizer(target: self, action: #selector(configureControlGestures))
        ivsVideoPlayerView.addGestureRecognizer(controlGesture)
    }
    
    @objc private func configureControlGestures() {
        videoPlayer?.state == .playing ? pauseVideoPlayback(): startVideoPlayback()
        ivPlay.isHidden = videoPlayer?.state != .playing
    }
}

// MARK: - Seekbar related methods
extension PlayerView {
    func setUpDisplayLink() {
        let displayLink = CADisplayLink(target: self, selector: #selector(playbackDisplayLinkDidFire(_:)))
        displayLink.preferredFramesPerSecond = 30
        displayLink.isPaused = videoPlayer?.state != .playing
        displayLink.add(to: .main, forMode: .common)
        playbackPositionDisplayLink = displayLink
    }

    func tearDownDisplayLink() {
        playbackPositionDisplayLink?.invalidate()
        playbackPositionDisplayLink = nil
    }

    @objc private func playbackDisplayLinkDidFire(_ displayLink: CADisplayLink) {
        self.updatePositionDisplay()
    }
}

extension PlayerView {
    
    private func configureTransparentThumbImage() {
        let thumbSize = CGSize(width: 30, height: 30)
        
        UIGraphicsBeginImageContextWithOptions(thumbSize, false, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let rect = CGRect(origin: .zero, size: thumbSize).insetBy(dx: 2, dy: 2)
        let path = UIBezierPath(ovalIn: rect)
        
        context.setFillColor(UIColor.clear.cgColor)
        path.fill()
       
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        seekSlider.setThumbImage(image, for: .normal)
    }
    
    @objc private func onSeekSliderValueChanged(_ sender: UISlider, event: UIEvent) {
        guard let touchEvent = event.allTouches?.first else {
            seek(toFractionOfDuration: sender.value)
            return
        }

        switch touchEvent.phase {
            case .began, .moved:
                seekStatus = .choosing(sender.value)

            case .ended:
                seekSliderChanged(sender.value)

            case .cancelled:
                seekStatus = nil

            default: ()
        }
    }
    
    private func seek(toFractionOfDuration fraction: Float) {
        guard let player = videoPlayer else {
            seekStatus = nil
            return
        }
        let position = CMTimeMultiplyByFloat64(
            player.duration,
            multiplier: Float64(fraction == 0 ? 0.000001 : fraction)
        )
        seek(to: position)
    }
    
    private func seek(to position: CMTime) {
        guard let player = videoPlayer else {
            seekStatus = nil
            return
        }
        seekStatus = .requested(position)
        player.seek(to: position) { [weak self] _ in
            guard let self = self else {
                return
            }
            if self.seekStatus == .requested(position) {
                self.seekStatus = nil
            }
        }
    }
    
    private func seekSliderChanged(_ toValue: Float) {
        seek(toFractionOfDuration: toValue)
    }
    
    private func updateSeekSlider(position: CMTime, duration: CMTime) {
        if duration.isNumeric && position.isNumeric {
            let scaledPosition = position.convertScale(duration.timescale, method: .default)
            let progress = Double(scaledPosition.value) / Double(duration.value)
            seekSlider.setValue(Float(progress), animated: false)
        }
    }
    
    private func updatePositionDisplay() {
        guard let player = videoPlayer else {
            return
        }
        let playerPosition = player.position
        let duration = player.duration
        let position: CMTime
        switch seekStatus {
            case let .choosing(fractionOfDuration):
                position = CMTimeMultiplyByFloat64(duration, multiplier: Float64(fractionOfDuration))
            case let .requested(seekPosition):
                position = seekPosition
            case nil:
                position = playerPosition
                updateSeekSlider(position: position, duration: duration)
        }
    }
    
    private func updateForState(_ state: IVSPlayer.State) {
        playbackPositionDisplayLink?.isPaused = state != .playing
        
        if state == .buffering {
            bufferIndicator.startAnimating()
        } else {
            bufferIndicator.stopAnimating()
        }
    }

    private func updateForDuration(duration: CMTime) {
        if duration.isIndefinite {
            ivsVideoPlayerView.isUserInteractionEnabled = true
            seek(to: duration)
        } else if duration.isNumeric {
            ivsVideoPlayerView.isUserInteractionEnabled = true
        } else {
            ivsVideoPlayerView.isUserInteractionEnabled = false
        }
    }
    
    @objc private func tapToSeek(_ sender: UITapGestureRecognizer) {
        let seekPosition = sender.location(in: seekSlider).x / seekSlider.frame.width
        seekSliderChanged(Float(seekPosition))
    }
}

class PlayerView: _View {
    
    var onStreaming: ((_ isStreaming: Bool) -> Void)?
    
    var isStreaming: Bool {
        livePlayer != nil
    }
    
    private var playbackPositionDisplayLink: CADisplayLink?
    
    private var didPauseOnBackground = false
    private var isLive: Bool = false
    
    private var videoPlayer: IVSPlayer? {
        didSet {
            ivsVideoPlayerView.player = videoPlayer
            ivsVideoPlayerView.videoGravity = .resizeAspectFill
            videoPlayer?.looping = true
            seekStatus = nil
            updatePositionDisplay()
        }
    }
    
    private var livePlayer: IVSPlayer? {
        didSet {
            if oldValue != nil {
                removeApplicationLifecycleObservers()
            }
            ivsLivePlayerView.player = livePlayer
            ivsLivePlayerView.videoGravity = .resizeAspectFill
            seekStatus = nil
            updatePositionDisplay()
           
            if livePlayer != nil {
                addApplicationLifecycleObservers()
            }
        }
    }
    
    private enum SeekStatus: Equatable {
        case choosing(Float)
        case requested(CMTime)
    }

    private var seekStatus: SeekStatus? {
        didSet {
            updatePositionDisplay()
        }
    }
    
    private(set) lazy var ivThumbnail: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    private(set) lazy var ivPlay: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    private(set) lazy var ivsVideoPlayerView: IVSPlayerView = {
        let view = IVSPlayerView()
        return view
    }()
    
    private(set) lazy var ivsLivePlayerView: IVSPlayerView = {
        let view = IVSPlayerView()
        return view
    }()
    
    private(set) lazy var bufferIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        return view
    }()
    
    private(set) lazy var seekSlider: UISlider = {
        let view = UISlider()
        return view
    }()
    
    override func setUp() {
        super.setUp()
        registerActions()
    }
    
    override func setUpAppearance() {
        super.setUpAppearance()
        
        backgroundColor = .appColor(.appBlack)
        ivThumbnail.contentMode = .scaleAspectFill
        
        ivPlay.isHidden = true
        
        ivsVideoPlayerView.backgroundColor = .clear
        ivsLivePlayerView.backgroundColor = .clear
        
        bufferIndicator.color = .appColor(.appBackground)
        
        configureTransparentThumbImage()
     
        seekSlider.isHidden = true
        seekSlider.minimumTrackTintColor = .appColor(.appBackground)
        seekSlider.maximumTrackTintColor = .clear
    }
    
    override func setUpLayout() {
        super.setUpLayout()
        
        [ivThumbnail, ivsVideoPlayerView, ivsLivePlayerView, bufferIndicator, seekSlider, ivPlay].forEach {
            addSubview($0)
        }
        
        ivThumbnail.fillSuperview()
        
        ivPlay.constrainHeight(80)
        ivPlay.constrainWidth(80)
        ivPlay.anchorCenterSuperview()
        
        ivsVideoPlayerView.fillSuperview()
        ivsLivePlayerView.fillSuperview()
        
        bufferIndicator.anchorCenterSuperview()
        
        seekSlider.anchor(left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor)
    }
    
    override func updateContent() {
        super.updateContent()
        ivPlay.image = .appImage(.imgPlay)
    }
}
