//
//  Customizable.swift
//  ClickmeliveUI
//
//  Created by Can on 3.03.2024.
//

// Just a protocol to formalize the methods required
protocol Customizable {
    /// Main point of customization for the view functionality.
    ///
    /// **It's called zero or one time(s) during the view's lifetime.** Calling super implementation is required.
    func setUp()

    /// Main point of customization for the view appearance.
    ///
    /// **It's called multiple times during the view's lifetime.** The default implementation of this method is empty
    /// so calling `super` is usually not needed.
    func setUpAppearance()

    /// Main point of customization for the view layout.
    ///
    /// **It's called zero or one time(s) during the view's lifetime.** Calling super is recommended but not required
    /// if you provide a complete layout for all subviews.
    func setUpLayout()

    /// Main point of customizing the way the view updates its content.
    ///
    /// **It's called every time view's content changes.** Calling super is recommended but not required if you update
    /// the content of all subviews of the view.
    func updateContent()
}
