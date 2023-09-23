<html>
<head>
<style>
@-webkit-keyframes cf3FadeInOut {
   0% {
     opacity:1;
   }
   25% {
    opacity:1;
  }
  75% {
    opacity:0;
  }
  100% {
   opacity:0;
 }
}

@-moz-keyframes cf3FadeInOut {
 0% {
   opacity:1;
 }
 25% {
  opacity:1;
}
75% {
  opacity:0;
}
100% {
 opacity:0;
}
}

@-o-keyframes cf3FadeInOut {
 0% {
   opacity:1;
 }
 25% {
  opacity:1;
}
75% {
  opacity:0;
}
100% {
 opacity:0;
}
}

@keyframes cf3FadeInOut {
 0% {
   opacity:1;
 }
 25% {
  opacity:1;
}
75% {
  opacity:0;
}
100% {
 opacity:0;
}
}

#cf3 {
  position:relative;
  height:281px;
  width:450px;
  margin:0 auto;
}
#cf3 img {
  position:absolute;
  left:0;
}

#cf3 img.top {
  -webkit-animation-name: cf3FadeInOut;
  -webkit-animation-timing-function: ease-in-out;
  -webkit-animation-iteration-count: infinite;
  -webkit-animation-duration: 10s;
  -webkit-animation-direction: alternate;

  -moz-animation-name: cf3FadeInOut;
  -moz-animation-timing-function: ease-in-out;
  -moz-animation-iteration-count: infinite;
  -moz-animation-duration: 10s;
  -moz-animation-direction: alternate;

  -o-animation-name: cf3FadeInOut;
  -o-animation-timing-function: ease-in-out;
  -o-animation-iteration-count: infinite;
  -o-animation-duration: 10s;
  -o-animation-direction: alternate;

  animation-name: cf3FadeInOut;
  animation-timing-function: ease-in-out;
  animation-iteration-count: infinite;
  animation-duration: 10s;
  animation-direction: alternate;
}
</style>

<body>
<p id = "result"></p>


<div id="cf3" class="shadow">

<img height = "200" class="bottom" src="img/Relieved.png">
<img height = "200" class="top" src="img/waiting.png">

</div>
<script>
getmad();

function getmad(){
         setTimeout(myURL, 60000);
         var result = document.getElementById("result");
         result.innerHTML = "<b> The page will redirect after delay of 5 seconds";
      }

function myURL(){
 document.location.href = 'passprintedLate.jsp?StuID=<%=request.getParameter("StuID")%>';
}
</script>
</body>