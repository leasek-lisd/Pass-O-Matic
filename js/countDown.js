function updateCountDown(bellTime) {

  var countDownDate = new Date(bellTime).getTime();
  var now = new Date().getTime();
  var distance = countDownDate - now;

  var days = Math.floor(distance / (1000 * 60 * 60 * 24));
  var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
  var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
  var seconds = Math.floor((distance % (1000 * 60)) / 1000)+1;


  if (seconds < -1){location.reload();}
  var countDownText = "";
  if (days>0){countDownText = '<span class="countDownDigit">' + days + '</span><span class="countDownUnit">d </span>';}

  countDownText += 
   '<span class="countDownDigit">' + hours + '</span><span class="countDownUnit">h </span>'
  + '<span class="countDownDigit">' + minutes + '</span><span class="countDownUnit">m </span>'
  + '<span class="countDownDigit">' + seconds + '</span><span class="countDownUnit">s </span>';
  
  // Display the result in the element with id="demo"
  if(days>=0 && hours>=0 && minutes >= 0 && seconds >= 0)
  document.getElementById("time").innerHTML = countDownText;
}

function startCountDown(nextBellTime){
		
}

