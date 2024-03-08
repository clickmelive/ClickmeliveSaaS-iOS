//
//  Components.swift
//  ClickmeliveUI
//
//  Created by Can on 3.03.2024.
//

struct Components {
    init() {}
    
    static var `default` = Self()
    
    var itemsVCView: ItemsVCView.Type = ItemsVCView.self
    var itemsView: ItemsView.Type = ItemsView.self
    var itemCell: ItemCell.Type = ItemCell.self
    
    var playerVCView: PlayerVCView.Type = PlayerVCView.self
    var playerView: PlayerView.Type = PlayerView.self
   
    var titleView: TitleView.Type = TitleView.self
    var totalViewerView: TotalViewerView.Type = TotalViewerView.self
    var likeView: LikeView.Type = LikeView.self
    var statusView: StatusView.Type = StatusView.self
    var chatView: ChatView.Type = ChatView.self
    var chatCell: ChatCell.Type = ChatCell.self
    var composerView: ComposerView.Type = ComposerView.self
    var autoSizingTextView: AutoSizingTextView.Type = AutoSizingTextView.self
    var messageTextView: MessageTextView.Type = MessageTextView.self
}
