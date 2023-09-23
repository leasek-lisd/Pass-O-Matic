<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<style>
  #imgDot {
     width: 100px;
     height: 100px;
     border: 1px solid white;
     border-radius: 50px;
     
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
</style>


<body>

<div class="blue" id="imgDot"></div>


</body>

<script>
function updateData(){
	const xmlhttp = new XMLHttpRequest();
	xmlhttp.onload = function() {
	  const myObj = JSON.parse(this.responseText);
	  console.log(myObj.color);
	  console.log(myObj.textColor);
	  console.log(myObj.displayText);
	$("#imgDot").removeClass();
	$("#imgDot").addClass(myObj.color);
//	document.getElementById("imgTxt").innerHTML = myObj.color;




}
xmlhttp.open("GET", "roomData.jsp?room=122");
xmlhttp.send();
}

updateData();
setInterval(function(){updateData();},2000);
</script>   