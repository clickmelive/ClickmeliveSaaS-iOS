//
//  CustomPlayerUIViews.swift
//  Clickmelive
//
//  Created by Can on 6.03.2024.
//

import Foundation

final class HiddenLikeView: LikeView {
    override func setUpAppearance() {
        super.setUpAppearance()
        isHidden = true
    }
}

final class HiddenTotalViewerView: TotalViewerView {
    override func setUpAppearance() {
        super.setUpAppearance()
        isHidden = true
    }
}

final class HiddenItemsView: ItemsView {
    override func setUpAppearance() {
        super.setUpAppearance()
        isHidden = true
    }
}

final class HiddenTitleView: TitleView {
    override func setUpAppearance() {
        super.setUpAppearance()
        isHidden = true
    }
}

final class HiddenStatusView: StatusView {
    override func setUpAppearance() {
        super.setUpAppearance()
        isHidden = true
    }
}
