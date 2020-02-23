//
//  Constants.swift
//  MeMe App
//
//  Created by Gerardo Tarazona Caceres on 2/23/20.
//  Copyright © 2020 udacity. All rights reserved.
//

import Foundation

struct Constants {
    struct Alert {
        static let ok = "Ok"
        static let cancel = "Cancel"
        static let unavailableCamera = "Camera is not Available"
        static let unavailablePhotoLibrary = "Photo Library is not Available"
        static let unkonwnError = "Unkown Error"
        static let permissionNotGranted = "Permission not granted"
        static let instructions = "Please go to your settings and let meme app the permission for write images"
        static let cameraInstructions = "Please go to your settings and let meme app take photos to create your fabulous Memes"
    }
    
    struct TextFields {
        static let defaultTopText = "TOP"
        static let defaultBottomText = "BOTTOM"
    }
    
    struct MediaTypes {
           static let imageType = "public.image"
           static let videType = "public.video"
       }
}
