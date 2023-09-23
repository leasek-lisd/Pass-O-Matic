<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
int curPeriod = 2;
int curTeacher = 128;
int curClassID= 481;

%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
  .spacer {
  width: 100px;}
</style>
<body>

<table>
  <tr>
    <td>
      <div id="outList"></div>
    </td>
    <td class="spacer"></td>
    <td>
      <div id="lineList"></div>
    </td>
  </tr>
    
</table>
<div></div>

<script>
function getLine() {

    var xmlhttp3 = new XMLHttpRequest();
    xmlhttp3.onreadystatechange = function() {
      if (this.readyState == 4 && this.status == 200) {
        document.getElementById("lineList").innerHTML = this.responseText;
      }
    };
    xmlhttp3.open("GET","getLine.jsp?classID=<%=curClassID%>",true);
    xmlhttp3.send();
}

function getStudentsOut() {

    var xmlhttp3 = new XMLHttpRequest();
    xmlhttp3.onreadystatechange = function() {
      if (this.readyState == 4 && this.status == 200) {
        document.getElementById("outList").innerHTML = this.responseText;
      }
    };
    xmlhttp3.open("GET","getStudentsOut.jsp?teacherID=<%=curTeacher%>&period=<%=curPeriod%>",true);
    xmlhttp3.send();
}
getStudentsOut();
getLine();
	
setInterval(function(){
	getStudentsOut()
	getLine()
}, 2500);
</script>
</body>
</html>