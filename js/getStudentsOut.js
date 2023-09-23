function getStudentsOut(curTeacher, curPeriod) {

    var xmlhttp3 = new XMLHttpRequest();
    xmlhttp3.onreadystatechange = function() {
      if (this.readyState == 4 && this.status == 200) {
        document.getElementById("txtStudentsOut").innerHTML = this.responseText;
      }
    };
    xmlhttp3.open("GET","getStudentsOut.jsp?teacherID="+curTeacher+"&period="+curPeriod,true);
    xmlhttp3.send();
}