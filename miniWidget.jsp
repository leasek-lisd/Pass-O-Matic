<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
  .spacer {
  width: 100px;}

  .listLabel {
    font-size: .75em;

  }

  .bold {
  	font-weight: bold;
  }

  .name {
    font-size: 1.25em;
  }

  .smallDetail{
    font-size: .75em;
  }

 #imgStatus {
     width: 100%;
     height: 50px;
     border: 1px solid white;
	 padding: 5px;
}

#bigText{
  font-size: 40px;
  text-align: center;

}

.red
{
background-color: red;
}

.yellow
{
background-color: yellow;
}

.green
{
background-color: green;
}

.blue
{
background-color: blue;
}

.purple
{
background-color: purple;
}

.white{
  color: white;
}

.black{
  color: black;
}




</style>
<body onload="window.resizeTo(250,50)">
<div id="imgStatus"><div id="bigText" class="white"></div></div>
</body>

<script>

function setSize() {
	  window.resizeTo(window.screen.availWidth, window.screen.availHeight / 20);
	}






function updateData(){
	const xmlhttp = new XMLHttpRequest();
	xmlhttp.onload = function() {
	  const myObj = JSON.parse(this.responseText);
	  console.log(myObj.color);
	  console.log(myObj.textColor);
	  console.log(myObj.displayText);
	$("#imgStatus").removeClass();
	$("#imgStatus").addClass(myObj.color);
	$("#bigText").removeClass();

	$("#bigText").addClass(myObj.textColor);
	document.getElementById("bigText").innerHTML = myObj.displayText;
}
xmlhttp.open("GET", "http://studentxampp.lisd.local:8080/passomatic/roomData.jsp?room=<%=session.getAttribute("lastRoom")%>");
xmlhttp.send();
}

updateData();


setInterval(function(){

    updateData();
	}, 2500);
	
// setTimeout(()=> {location.reload()},300000)	
</script>
<br><br>
</body>
</html>