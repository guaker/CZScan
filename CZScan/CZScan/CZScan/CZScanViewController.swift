//
//  CZScanViewController.swift
//  CZScan
//
//  Created by chenzhen on 16/7/21.
//  Copyright © 2016年 huimeibest. All rights reserved.
//

import UIKit
import AVFoundation

class CZScanViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var captureSession: AVCaptureSession!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    
    var scanView: CZScanView!
    
    //启动区域识别功能
    var isOpenInterestRect = false
    
    //识别码的类型
    var arrayCodeType:[String]?
    
    //是否需要识别后的当前图像
    var isNeedCodeImage = false

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blackColor()

        self.scanView = CZScanView(frame: self.view.bounds)
        self.view.addSubview(self.scanView)
        
        self.startScan()
        
    }
    
    func startScan() {
        if CZScanPermission.isGetCameraPermission() == false {
            showMsg("提示", message: "没有相机权限，请到设置->隐私中开启本程序相机权限")
            
            return
        }
        
        self.startReading()
        self.scanView.startScanAnimation()
    }
    
    func startReading() -> Bool {
        //创建会话
        self.captureSession = AVCaptureSession()
        self.captureSession.sessionPreset = AVCaptureSessionPresetHigh
        
        do {
            //获取 AVCaptureDevice 实例
            let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
            //初始化输入流
            let input = try AVCaptureDeviceInput(device: captureDevice)
            //添加输入流
            self.captureSession.addInput(input)
        } catch {
            return false
        }
        
        //初始化输出流
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureMetadataOutput.rectOfInterest = CGRectMake(0.3, 0.3, 0.5, 0.5)
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        //添加输出流
        self.captureSession.addOutput(captureMetadataOutput)
        
        //设置元数据类型 AVMetadataObjectTypeQRCode
        captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        
        //创建输出对象
        self.videoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
        self.videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        self.videoPreviewLayer.frame = self.view.layer.bounds
        self.view.layer.insertSublayer(self.videoPreviewLayer, atIndex: 0)
        
        //开始会话
        self.captureSession.startRunning()
        
        return true
    }
    
    /**
     停止相机
     */
    func stopReading() {
        self.captureSession.stopRunning()
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        
        if metadataObjects.count > 0 {
            self.scanView.stopScanAnimation()
            self.stopReading()
            
            print(metadataObjects)
        }
    }
    
    func showMsg(title:String?,message:String?) {
        let alertController = UIAlertController(title: title, message:message, preferredStyle: UIAlertControllerStyle.Alert)
        let alertAction = UIAlertAction(title:  "知道了", style: UIAlertActionStyle.Default) { [weak self] (alertAction) -> Void in
            
            if let strongSelf = self {
                strongSelf.startScan()
            }
        }
        
        alertController.addAction(alertAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    

}
