//
//  Coordinator.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

protocol ParentCoordinator: AnyObject {
    var children: [AnyObject] { get set }

    func start()
}

protocol ChildCoordinator: AnyObject {
    var teardown: ((Self) -> Void)? { get set }

    func start()
}

extension ChildCoordinator {
    func stop() {
        teardown?(self)
    }
}
