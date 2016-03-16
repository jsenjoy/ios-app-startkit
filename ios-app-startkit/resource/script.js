(function(global) {

  var $ = function(selector) {
    return document.querySelector(selector)
  }

  global.updateUserName = function(name) {
    $('#username').innerText = name
  }

  var callNative = function(message) {
    global.webkit.messageHandlers.webViewApp.postMessage(message)
  }

  $('#set-button').addEventListener('click', function() {
    callNative({
      method: 'setTitle',
      title: $('#title').value
    })
  })

  $('#push-button').addEventListener('click', function() {
    callNative({ method: 'push' })
  })

  $('#pop-button').addEventListener('click', function() {
    callNative({ method: 'pop' })
  })

})(window)
