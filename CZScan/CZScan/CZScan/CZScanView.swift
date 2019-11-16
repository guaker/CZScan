//
//  CZScanView.swift
//  CZScan
//
//  Created by chenzhen on 16/7/20.
//  Copyright © 2016年 huimeibest. All rights reserved.
//

import UIKit

class CZScanView: UIView {
    
    //线条扫码动画封装
    var scanLineAnimation: CZScanLineAnimation!
    
    //扫码区域
    var scanRetangleRect:CGRect = CGRectZero
    
    //记录动画状态
    var isAnimationing = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.scanLineAnimation = CZScanLineAnimation()
        self.backgroundColor = UIColor.clearColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startScanAnimation() {
        if self.isAnimationing == true {
            return
        }
        
        self.isAnimationing = true
        
        let cropRect = self.getScanRectForAnimation()
        
        self.scanLineAnimation.startAnimatingWithRect(cropRect, parentView: self, image: UIImage(named: "scan_line")!)
    }
    
    func stopScanAnimation() {
        self.isAnimationing = false
        
        self.scanLineAnimation.stopStepAnimating()
    }
    
    override func drawRect(rect: CGRect) {
        self.drawScanRect()
    }
    
    
    //MARK:----- 绘制扫码效果-----
    func drawScanRect()
    {
        let XRetangleLeft: CGFloat = 60
        let sizeRetangle = CGSizeMake(self.frame.size.width - XRetangleLeft * 2, self.frame.size.width - XRetangleLeft * 2)
        
        //扫码区域Y轴最小坐标
        let YMinRetangle = self.frame.size.height / 2 - sizeRetangle.height / 2 - 44
        let YMaxRetangle = YMinRetangle + sizeRetangle.height
        let XRetangleRight = self.frame.size.width - XRetangleLeft
        
        //上下文
        let context = UIGraphicsGetCurrentContext()
        
        //非扫码区域半透明
        //设置非识别区域颜色
        CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 0.5)
        
        //填充矩形
        //扫码区域上面填充
        var rect = CGRectMake(0, 0, self.frame.size.width, YMinRetangle)
        CGContextFillRect(context, rect)
        
        //扫码区域左边填充
        rect = CGRectMake(0, YMinRetangle, XRetangleLeft,sizeRetangle.height)
        CGContextFillRect(context, rect)
        
        //扫码区域右边填充
        rect = CGRectMake(XRetangleRight, YMinRetangle, XRetangleLeft,sizeRetangle.height)
        CGContextFillRect(context, rect)
        
        //扫码区域下面填充
        rect = CGRectMake(0, YMaxRetangle, self.frame.size.width,self.frame.size.height - YMaxRetangle)
        CGContextFillRect(context, rect)
        
        //执行绘画
        CGContextStrokePath(context)
        
        //中间画矩形(正方形)
        CGContextSetStrokeColorWithColor(context, UIColor.whiteColor().CGColor)
        CGContextSetLineWidth(context, 0.5)
        CGContextAddRect(context, CGRectMake(XRetangleLeft, YMinRetangle, sizeRetangle.width, sizeRetangle.height))
        CGContextStrokePath(context)
        
        scanRetangleRect = CGRectMake(XRetangleLeft, YMinRetangle, sizeRetangle.width, sizeRetangle.height)
        
        //画矩形框4格外围相框角
        //相框角的宽度和高度
        let wAngle: CGFloat = 16
        let hAngle: CGFloat = 16
        
        //4个角的 线的宽度
        let linewidthAngle: CGFloat = 2
        
        //画扫码矩形以及周边半透明黑色坐标参数
        let diffAngle: CGFloat = -0.5
        
        CGContextSetStrokeColorWithColor(context, UIColor(red: 0/255.0, green: 200/255.0, blue: 20/255.0, alpha: 1.0).CGColor);
        CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
        
        CGContextSetLineWidth(context, linewidthAngle)
        
        let leftX = XRetangleLeft - diffAngle
        let topY = YMinRetangle - diffAngle
        let rightX = XRetangleRight + diffAngle
        let bottomY = YMaxRetangle + diffAngle
        
        //左上角水平线
        CGContextMoveToPoint(context, leftX - linewidthAngle / 2, topY)
        CGContextAddLineToPoint(context, leftX + wAngle, topY)
        
        //左上角垂直线
        CGContextMoveToPoint(context, leftX, topY - linewidthAngle / 2)
        CGContextAddLineToPoint(context, leftX, topY+hAngle)
        
        //左下角水平线
        CGContextMoveToPoint(context, leftX - linewidthAngle / 2, bottomY)
        CGContextAddLineToPoint(context, leftX + wAngle, bottomY)
        
        //左下角垂直线
        CGContextMoveToPoint(context, leftX, bottomY + linewidthAngle / 2)
        CGContextAddLineToPoint(context, leftX, bottomY - hAngle)
        
        //右上角水平线
        CGContextMoveToPoint(context, rightX + linewidthAngle / 2, topY)
        CGContextAddLineToPoint(context, rightX - wAngle, topY)
        
        //右上角垂直线
        CGContextMoveToPoint(context, rightX, topY - linewidthAngle / 2)
        CGContextAddLineToPoint(context, rightX, topY + hAngle)
        
        //右下角水平线
        CGContextMoveToPoint(context, rightX + linewidthAngle / 2, bottomY)
        CGContextAddLineToPoint(context, rightX - wAngle, bottomY)
        
        //右下角垂直线
        CGContextMoveToPoint(context, rightX, bottomY + linewidthAngle / 2)
        CGContextAddLineToPoint(context, rightX, bottomY - hAngle)
        
        CGContextStrokePath(context)
    }
    
    func getScanRectForAnimation() -> CGRect {
        let XRetangleLeft: CGFloat = 60
        let sizeRetangle = CGSizeMake(self.bounds.width - XRetangleLeft * 2, self.bounds.width - XRetangleLeft * 2)
        
        //扫码区域Y轴最小坐标
        let YMinRetangle = self.bounds.height / 2 - sizeRetangle.height / 2 - 44 + 12
        
        //扫码区域坐标
        let cropRect =  CGRectMake(XRetangleLeft, YMinRetangle, sizeRetangle.width, sizeRetangle.height - 12)
        
        return cropRect
    }

}
