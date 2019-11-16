//
//  CZScanPermission.swift
//  CZScan
//
//  Created by chenzhen on 16/7/21.
//  Copyright © 2016年 huimeibest. All rights reserved.
//

import Foundation
import AVFoundation

class CZScanPermission {
    
    /**
     相机权限
     
     - returns: 是否有相机权限
     */
    class func isGetCameraPermission() -> Bool {
        return AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo) != AVAuthorizationStatus.Denied
    }
}
