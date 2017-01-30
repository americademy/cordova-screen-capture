/*
 * Screen Capture Cordova Interface
 */

var exec = require('cordova/exec');

module.exports = {

  /*
   * Save Screen as Data URI
   */
  save: function(callback, quality, scale){
    quality = typeof(quality) !== 'number'? 1 : quality;
    scale = typeof(scale) !== 'number'? 1 : scale;

    exec(function(res){
      callback && callback(null, res);
    }, function(error){
      callback && callback(error);
    }, "ScreenCapture", "saveScreenAsURI", [quality, scale]);

  }
};