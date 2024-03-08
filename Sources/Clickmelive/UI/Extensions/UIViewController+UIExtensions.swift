//
//  UIViewController+Extensions.swift
//  ClickmeliveUI
//
//  Created by Can on 3.03.2024.
//

import UIKit

protocol UIViewControllerLifecycleObserver {
    func remove()
}

extension UIViewController {
    @discardableResult
    func onDeinit(run callback: @escaping () -> Void) -> UIViewControllerLifecycleObserver {
        let observer = ViewControllerLifeCycleObserver(
            deinitCallback: callback
        )
        add(observer)
        return observer
    }
    
    @discardableResult
    func onViewDidLoad(run callback: @escaping () -> Void) -> UIViewControllerLifecycleObserver {
        let observer = ViewControllerLifeCycleObserver(
            viewDidLoadCallback: callback
        )
        add(observer)
        return observer
    }
    
    @discardableResult
    func onViewWillAppear(run callback: @escaping () -> Void) -> UIViewControllerLifecycleObserver {
        let observer = ViewControllerLifeCycleObserver(
            viewWillAppearCallback: callback
        )
        add(observer)
        return observer
    }
    
    @discardableResult
    func onViewDidAppear(run callback: @escaping () -> Void) -> UIViewControllerLifecycleObserver {
        let observer = ViewControllerLifeCycleObserver(
            viewDidAppearCallback: callback
        )
        add(observer)
        return observer
    }
    
    @discardableResult
    func onViewWillDisappear(run callback: @escaping () -> Void) -> UIViewControllerLifecycleObserver {
        let observer = ViewControllerLifeCycleObserver(
            viewWillDisappearCallback: callback
        )
        add(observer)
        return observer
    }
    
    @discardableResult
    func onViewDidDisappear(run callback: @escaping () -> Void) -> UIViewControllerLifecycleObserver {
        let observer = ViewControllerLifeCycleObserver(
            viewDidDisappearCallback: callback
        )
        add(observer)
        return observer
    }
    
    private func add(_ observer: UIViewController) {
        addChild(observer)
        observer.view.isHidden = true
        view.addSubview(observer.view)
        observer.didMove(toParent: self)
    }
}

private class ViewControllerLifeCycleObserver: UIViewController, UIViewControllerLifecycleObserver {
  
    private var deinitCallback: () -> Void = {}
    private var viewDidLoadCallback: () -> Void = {}
    private var viewWillAppearCallback: () -> Void = {}
    private var viewDidAppearCallback: () -> Void = {}
    private var viewWillDisappearCallback: () -> Void = {}
    private var viewDidDisappearCallback: () -> Void = {}
    
    convenience init(deinitCallback: @escaping () -> Void = {}) {
        self.init()
        self.deinitCallback = deinitCallback
    }
    
    convenience init(viewDidLoadCallback: @escaping () -> Void = {}) {
        self.init()
        self.viewDidLoadCallback = viewDidLoadCallback
    }
    
    convenience init(viewWillAppearCallback: @escaping () -> Void = {}) {
        self.init()
        self.viewWillAppearCallback = viewWillAppearCallback
    }
    
    convenience init(viewDidAppearCallback: @escaping () -> Void = {}) {
        self.init()
        self.viewDidAppearCallback = viewDidAppearCallback
    }
    
    convenience init(viewWillDisappearCallback: @escaping () -> Void = {}) {
        self.init()
        self.viewWillDisappearCallback = viewWillDisappearCallback
    }
    
    convenience init(viewDidDisappearCallback: @escaping () -> Void = {}) {
        self.init()
        self.viewDidDisappearCallback = viewDidDisappearCallback
    }
    
    deinit {
        deinitCallback()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDidLoadCallback()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        viewWillAppearCallback()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        viewDidAppearCallback()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        viewWillDisappearCallback()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)
        viewDidDisappearCallback()
    }
    
    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
