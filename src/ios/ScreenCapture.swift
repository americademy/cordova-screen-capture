/*
 * ScreenCapture
 *
 * Created by Americademy, Inc
 */

@objc(ScreenCapture) class ScreenCapture : CDVPlugin {

  /*
   * ScreenCapture.getScreen
   * Gets the current screen, scales to size
   */
  func getScreen(_ scale: CGFloat) -> UIImage {
    let keyWindow: UIWindow? = UIApplication.shared.keyWindow
    let rect: CGRect? = keyWindow!.bounds
    UIGraphicsBeginImageContextWithOptions(rect!.size, true, 0)
    keyWindow!.drawHierarchy(in: keyWindow!.bounds, afterScreenUpdates: false)
    let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    let resizedImage = self.resize(image: image!, scale: scale)
    return resizedImage
  }

  /*
   * ScreenCapture.getScreen
   * Convert screen capture to data URI
   */
  func saveScreenAsURI(_ command: CDVInvokedUrlCommand) {
    let quality = command.arguments[0]
    let scale = command.arguments[1]
    let image: UIImage? = self.getScreen(scale as! CGFloat)
    let imageData: Data? = UIImageJPEGRepresentation(image!, quality as! CGFloat)
    let strBase64:String = imageData!.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
    let jsonObj: [AnyHashable: Any] = ["URI": "data:image/jpeg;base64,\(strBase64)"]
    let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: jsonObj)
    self.commandDelegate!.send(pluginResult, callbackId: command.callbackId)
  }

  /*
   * ScreenCapture.resize
   * Resize an image
   */
  func resize(image: UIImage, scale: CGFloat) -> UIImage {
    let width = image.size.width * scale
    let height = image.size.height * scale
    UIGraphicsBeginImageContext(CGSize(width: width, height: height))
    image.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage!
  }
}
