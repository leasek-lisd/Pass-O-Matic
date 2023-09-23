<body><center>
Pass Printed<br>Click Image Below When You Return to Check In
<br><a href="ReturnStudentByNumber.jsp?StuID=<%=request.getParameter("StuID")%>&PassType=RS"><img src="img/Relieved.png"></a>
<p id = "result"></p>
<script>
getmad();

function getmad(){
         setTimeout(myURL, 600000);
         var result = document.getElementById("result");
         result.innerHTML = "";
      }

function myURL(){
 document.location.href = 'passprintedLate.jsp?StuID=<%=request.getParameter("StuID")%>';
}
</script>
</body>
