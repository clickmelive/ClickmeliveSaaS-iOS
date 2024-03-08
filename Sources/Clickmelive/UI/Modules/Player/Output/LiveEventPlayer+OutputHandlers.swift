//
//  Player+OutputHandlers.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

extension PlayerUIComposer {
    final class LiveEventDetailManagerOutputHandler: LiveEventDetailManagerOutput {
        
        private weak var controller: PlayerViewController?
        private let imageLoader: ImageLoader
        
        init(controller: PlayerViewController,
             imageLoader: ImageLoader) {
            self.controller = controller
            self.imageLoader = imageLoader
        }
        
        func liveEventDetailLoaded(liveEvent: LiveEvent) {
            let liveEventViewModel = LiveEventViewModel(model: liveEvent)
            controller?.setLiveEventDetail(with: liveEventViewModel, imageLoader: imageLoader)
        }
    }
}

extension PlayerUIComposer {
    final class LiveEventStatsChangeManagerOutputHandler: LiveEventStatsChangeManagerOutput {
        
        private weak var controller: PlayerViewController?
        
        init(controller: PlayerViewController) {
            self.controller = controller
        }
        
        func liveEventDetailUpdated(liveEvent: LiveEvent) {
            let liveEventViewModel = LiveEventViewModel(model: liveEvent)
            controller?.updateStats(with: liveEventViewModel)
        }
    }
}

extension PlayerUIComposer {
    final class LiveEventUserInteractionManagerOutputHandler: LiveEventUserInteractionManagerOutput {
        
        private weak var controller: PlayerViewController?
        
        init(controller: PlayerViewController) {
            self.controller = controller
        }
        
        func liveEventUserInteractionLoaded(liveEventUserInteraction: LiveEventUserInteraction) {
            controller?.updateLikeStatus(with: liveEventUserInteraction.like, withAnimation: false)
        }
    }
}

extension PlayerUIComposer {
    final class LiveEventLikeManagerOutputHandler: LiveEventLikeManagerOutput {
        
        private weak var controller: PlayerViewController?
        private let userId: String
        
        init(controller: PlayerViewController,
             userId: String) {
            self.controller = controller
            self.userId = userId
        }
        
        func isLiveEventLiked(liveEvent: LiveEvent, like: Bool) {
            controller?.updateLikeStatus(with: like, withAnimation: true)
        }
    }
}

extension PlayerUIComposer {
    
    final class LiveEventViewerManagerOutputHandler: LiveEventViewerManagerOutput {
        
        private weak var controller: PlayerViewController?
        
        init(controller: PlayerViewController) {
            self.controller = controller
        }
        
        func loadedLiveEventViewer(viewerCount: LiveEventViewer) {
            let liveEventViewerViewModel = LiveEventViewerViewModel(model: viewerCount)
            controller?.updateLiveEventViewerCount(with: liveEventViewerViewModel)
        }
    }
}

extension PlayerUIComposer {
    final class LiveEventPlayerViewControllerOutputHandler: PlayerViewControllerOutput {
        
        private weak var controller: PlayerViewController?
        private let eventId: String
        private let userId: String
        private let username: String
        private let liveEventDetailManager: LiveEventDetailManager
        private let liveEventLikeManager: LiveEventLikeManager
        private let chatMessageCreateManager: ChatMessageCreateManager
        private let onItemsTapped: ([Item]) -> Void
        
        init(controller: PlayerViewController,
             eventId: String,
             userId: String,
             username: String,
             liveEventDetailManager: LiveEventDetailManager,
             liveEventLikeManager: LiveEventLikeManager,
             chatMessageCreateManager: ChatMessageCreateManager,
             onItemsTapped: @escaping ([Item]) -> Void) {
            self.controller = controller
            self.eventId = eventId
            self.userId = userId
            self.username = username
            self.liveEventDetailManager = liveEventDetailManager
            self.liveEventLikeManager = liveEventLikeManager
            self.chatMessageCreateManager = chatMessageCreateManager
            self.onItemsTapped = onItemsTapped
        }
        
        func itemsTapped() {
            let items = liveEventDetailManager.liveEvent?.items ?? []
            onItemsTapped(items)
        }
        
        func likeTapped(like: Bool) {
            liveEventLikeManager.like(liveEventId: eventId, userId: userId, like: !like)
        }
        
        func messageSendTapped(message: String) {
            guard let eventId = liveEventDetailManager.liveEvent?.id else { return }
            chatMessageCreateManager.createMessage(userId: userId, eventId: eventId, userDisplayName: username, message: message)
        }
        
        func minimizeTapped() {
            controller?.onMinimizeTapped()
        }
        
        func closePipTapped() {
            controller?.onCloseTapped()
        }
    }
}

extension PlayerUIComposer {
    final class ChatMessageLoadingManagerOutputHandler: ChatMessageLoadingManagerOutput {
        
        private weak var controller: PlayerViewController?
        
        init(controller: PlayerViewController) {
            self.controller = controller
        }
        
        func chatMessagesLoaded(messages: [ChatMessage]) {
            controller?.display(chatMessages: messages.map { message in
                let chatMessageViewModel = ChatMessageViewModel(model: message)
                return CollectionCellController(id: chatMessageViewModel.id, ChatCellController(viewModel: chatMessageViewModel))
            })
        }
    }
}
