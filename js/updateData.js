function updateData(lastRoom){
	const xmlhttp = new XMLHttpRequest();
	xmlhttp.onload = function() {
	  const myObj = JSON.parse(this.responseText);
	$("#imgStatus").removeClass();
	$("#imgStatus").addClass(myObj.color);

	}
	
	
	xmlhttp.open("GET", "roomData.jsp?room="+lastRoom);
	xmlhttp.send();
	
}	