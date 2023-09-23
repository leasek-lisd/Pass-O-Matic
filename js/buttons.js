function getButtons(studentID) {

    var xmlhttp3 = new XMLHttpRequest();
    xmlhttp3.onreadystatechange = function() {
      if (this.readyState == 4 && this.status == 200) {
        document.getElementById("txtButtons").innerHTML = this.responseText;
      }
    };
    xmlhttp3.open("GET","CheckStudent2.jsp?src=student&StuID="+studentID,true);
    xmlhttp3.send();
}

