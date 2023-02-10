//
//  LaunchAnimator.swift
//  
//
//  Created by JSilver on 2022/12/20.
//

import UIKit

class LaunchAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    // Duration of transition
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        // Get from, to view controller of transition
        guard let fromVC = transitionContext.viewController(forKey: .from) else { return UIViewPropertyAnimator() }
        guard let toVC = transitionContext.viewController(forKey: .to) else { return UIViewPropertyAnimator() }

        // Add view
        transitionContext.containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
        // Set init frame
        toVC.view.frame = fromVC.view.frame

        let animator = UIViewPropertyAnimator(
            duration: transitionDuration(using: transitionContext),
            curve: .easeOut
        ) {
            fromVC.view.alpha = 0
        }

        animator.addCompletion { _ in
            fromVC.view.alpha = 1
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }

        return animator
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let animator = interruptibleAnimator(using: transitionContext)
        animator.startAnimation()
    }
}
