//
//  UIViewController+PIPKitExtensions.swift
//  Clickmelive
//
//  Created by Can on 5.03.2024.
//

import Foundation
import UIKit

extension UIViewController {
    
    private struct AssociatedKeys {
        // This static variable is used as a unique key for associating objects with UIViewController instances.
        // The warning "Forming 'UnsafeRawPointer' to an inout variable of type 'String' exposes the internal representation
        // rather than the string contents" arises because we're passing the address of `pipEventDispatcher` to functions
        // expecting a pointer (objc_getAssociatedObject and objc_setAssociatedObject). This practice might seem unsafe
        // because it could expose or alter the internal memory structure of the string if misused. However, in this context,
        // we are using the address of a static variable as a unique key for associated objects, which is a common and accepted
        // pattern when working with the Objective-C runtime in Swift. The static variable's address is stable and unique
        // throughout the application's lifecycle, ensuring consistent access to the associated object. Therefore, despite the warning,
        // this usage is safe and intentional. The warning can be disregarded in this specific case because we are not exposing or
        // modifying the string's internal representation; we are merely using its stable address as a unique key.
        static var pipEventDispatcher = "pipEventDispatcher"
    }
    
    var pipEventDispatcher: PIPKitEventDispatcher? {
        get {
            // Accessing the associated object using the unique key's memory address.
            return objc_getAssociatedObject(self, &AssociatedKeys.pipEventDispatcher) as? PIPKitEventDispatcher
        }
        set {
            // Associating an object using the unique key's memory address.
            // The association policy .OBJC_ASSOCIATION_RETAIN_NONATOMIC is chosen to ensure the associated object is
            // retained by the runtime, without enforcing atomic access, which is typically unnecessary for such use cases.
            objc_setAssociatedObject(self, &AssociatedKeys.pipEventDispatcher, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

