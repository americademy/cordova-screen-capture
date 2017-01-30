# Screen Capture

Enables full-screen capture of the current app view

## Install

Cordova CLI:

```
cordova plugin add https://github.com/americademy/cordova-screen-capture.git
```

## Usage


```js

// quality: default 1 (0.0 low - 1.0 high)
// scale: default 1, (0.5 is 50% the original size)
// screenCapture.save(callback, quality, scale);

// jpg data:uri
navigator.screenCapture.save(function(error, response) {
  // if error
  if (error) { console.error(error); }

  // otherwise
  console.log('success', response.filePath);
}, 0.1, 1);
```

NOTE: Only JPG is supported