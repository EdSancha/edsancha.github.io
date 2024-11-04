document.addEventListener('scroll', _ => {
    var docElem = document.documentElement;
    var docBody = document.body;
    var scrollTop = (docBody.scrollTop || docElem.scrollTop);
    var height = docElem.scrollHeight - docElem.clientHeight;
  
    readPercent = scrollTop / height * 100;
  
    if (readPercent > 0) {
      progressBar = document.querySelector('#progress-bar');
      progressBar.style.setProperty('--progress', readPercent + '%');
    } else {
      progressBar.style.setProperty('--progress', '0%');
    }
  })
  