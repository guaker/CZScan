//
//  CZScanLineAnimation.swift
//  CZScan
//
//  Created by chenzhen on 16/7/21.
//  Copyright © 2016年 huimeibest. All rights reserved.
//

import UIKit

class CZScanLineAnimation: UIImageView {

    var isAnimationing = false
    var animationRect = CGRectZero
    
    func startAnimatingWithRect(animationRect: CGRect, parentView: UIView, image: UIImage) {
        self.image = image
        self.animationRect = animationRect
        parentView.addSubview(self)
        
        self.isAnimationing = true
        
        self.stepAnimation()
    }
    
    func stepAnimation() {
        if self.isAnimationing == false {
            return
        }
        
        var frame = animationRect
        let hImg = self.image!.size.height * self.animationRect.width / self.image!.size.width
        
        frame.origin.y -= hImg
        frame.size.height = hImg
        self.frame = frame
        
        UIView.animateWithDuration(3, animations: {
            var frame = self.animationRect
            let hImg = self.image!.size.height * self.animationRect.width / self.image!.size.width
            
            frame.origin.y += frame.height - hImg
            frame.size.height = hImg
            self.frame = frame
            
        }) { (finished: Bool) in
            self.performSelector(#selector(self.stepAnimation))
        }
    }
    
    func stopStepAnimating() {
        self.hidden = true
        isAnimationing = false
    }
}
