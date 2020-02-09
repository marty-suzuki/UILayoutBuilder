//
//  Builder.swift
//  UILayoutBuilder
//
//  Created by marty-suzuki on 2020/02/09.
//

import UIKit

public final class Builder {

   private let updater: ConstraintUpdater
   private let context: Context

   deinit {
        context.addConstraint(updater.constraint)
   }

   init(constraint: NSLayoutConstraint, context: Context) {
       self.updater = ConstraintUpdater(constraint)
       self.context = context
   }

   @discardableResult
   public func multiplier(_ multiplier: CGFloat) -> Builder {
       updater.update(multiplier: multiplier)
       return self
   }

   @discardableResult
   public func constant(_ constant: CGFloat) -> Builder {
       updater.update(constant: constant)
       return self
   }

   @discardableResult
   public func priority(_ priority: UILayoutPriority) -> Builder {
       updater.update(priority: priority)
       return self
   }

   public func asConstraint() -> NSLayoutConstraint {
       return updater.constraint
   }
}
