
<!DOCTYPE html>
<html>
<%



%>
<head>
    <title>Example</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<style>
input[type='number']{
    width: 40px;
}

table,td, th, tr {
  border-collapse: collapse;
  padding: 5px;
  border-width : 1px;
  border-style : solid;
  border-color : black;
  text-align : left;


}
</style>

<body>
<form action="addOffLinePass.jsp">
<h2>Passes To Review</h2>
<table>
<tr>
	<th>Student ID</th>
	<th>Date</th>
	<th>Start Time</th>
	<th>End Time</th>
	<th>Pass Type</th>
</tr>
<tr>
	<td><%=request.getParameter("idNum")%></td>
	<td><%=request.getParameter("passDate")%></td>
	<td>
	  <select name="startHour" id="startHour"  onchange="setStartHour()">
        <option value="8">8</option>
        <option value="9">9</option>
        <option value="10">10</option>
        <option value="11">11</option>
        <option value="12">12</option>
        <option value="13">1</option>
        <option value="14">2</option>
        <option value="15">3</option>
      </select>:
      <input type="number" id="startMinutes" name="startMinutes"  maxlength="2" size="2" min="0" max="59" onchange="setStartMinutes()" >
    </td>
	<td>
	  <select name="year" id="endHour" onchange="setEndHour()">
        <option value="8">8</option>
        <option value="9">9</option>
        <option value="10">10</option>
        <option value="11">11</option>
        <option value="12">12</option>
        <option value="13">1</option>
        <option value="14">2</option>
        <option value="15">3</option>
      </select>:
      <input type="number" id="endMinutes" name="endMinutes"  maxlength="2" size="2" min="0" max="59" onChange="setEndMinutes()">
    </td>

	<td>
	  <select name="passType" id="PassType">
        <option value="RT" selected>Restroom Pass</option>
        <option value="ER">Emergency Pass</option>
      </select>
    </td>
</tr>
<tr>
  <td>
     <div id="studentName" ><%=request.getParameter("firstName")%> <%=request.getParameter("lastName")%></div>
  </td>
  <td></td>
  <td colspan = "2">
  	  <span id="durationDisplay">Duration: X Minutes</span>
  </td>
  <td>
    <input type="radio" id="exclude" name="include" value="0">Exclude
    <input type="radio" id="include" name="include" value="1" checked>Include in stats
  </td>
</tr>
<tr>
  <td colspan="5"><b>Problem: <%=request.getParameter("enrollID")%></b></td>
 </tr>
</table>
<br>
 <input id="submit" type="submit" value="Submit">
<input type = "hidden" id="stuID" name="stuID" value = "x">
<input type = "hidden" id="hpID" name="hpID" value = "x">
<input type = "hidden" id="passStartDateString" name="passStartDate" value = "x">
<input type = "hidden" id="passEndDateString" name="passStartDate" value = "x">
<input type = "hidden" id="enrollID" name="enrollID" value = "<%=request.getParameter("enrollID")%>">
<input type = "hidden" id="periodNum" name="periodNum" value = "<%=request.getParameter("periodNum")%>">
<input type = "hidden" id="classID name="periodNum" value = "<%=request.getParameter("classID")%>">
<input type = "hidden" id="studentID" name="periodNum" value = "<%=request.getParameter("studentID")%>">
</form>


</body>
<script>

document.getElementById("submit").disabled = true;
const startTime = new Date();
const endTime = new Date();


var passDate = "2023-08-25";
var startHour =  "8";
var endHour = "8";
var startMinutes = "";
var endMinutes = "";

var passDateSet = 1;
var startHourSet = 1;
var endHourSet = 1;
var startMinutesSet = 0;
var endMinutesSet = 0;
var allSet = 0;



function setDateText(){
  passDate = document.getElementById("passDate").value;
  passDateSet = 1;
  setFinalDate();
}

function setStartHour(){
  startHour = document.getElementById("startHour").value;
  startHourSet = 1;
  setFinalDate();
}


function setStartMinutes(){
  if(parseInt(document.getElementById("startMinutes").value,10)<10)document.getElementById("startMinutes").value='0'+document.getElementById("startMinutes").value;
  startMinutes = document.getElementById("startMinutes").value;
  startMinutesSet = 1;
  setFinalDate();
}

function setEndHour(){
  endHour = document.getElementById("endHour").value;
  endHourSet = 1;
  setFinalDate();
}

function setEndMinutes(){

if(parseInt(document.getElementById("endMinutes").value,10)<10){document.getElementById("endMinutes").value = '0'+document.getElementById("endMinutes").value};
  endMinutes = document.getElementById("endMinutes").value;
  endMinutesSet = 1;

  setFinalDate();
}

function setFinalDate (){
allSet = passDateSet + startHourSet + endHourSet + startMinutesSet + endMinutesSet

if(allSet==5){

  var startPassDate = new Date(passDate);
  startPassDate.setHours(startHour);
  startPassDate.setMinutes(startMinutes);

  var endPassDate = new Date(passDate);
    endPassDate.setHours(endHour);
  endPassDate.setMinutes(endMinutes);


	durationMinutes = ((endPassDate.getTime() - startPassDate.getTime()) / (1000*60));
	if(durationMinutes>0){
      document.getElementById("durationDisplay").innerHTML = "Duration: "+durationMinutes+" minutes";
	  document.getElementById("submit").disabled = false;
	  document.getElementById("passStartDateString").value = passDate+" "+startHour+":"+startMinutes;
	  document.getElementById("passEndDateString").value = passDate+" "+endHour+":"+endMinutes;
	}
	else {
	  document.getElementById("durationDisplay").innerHTML = "Invalid duration";
	  document.getElementById("submit").disabled = true;}
	}
}

</script>

</html>
