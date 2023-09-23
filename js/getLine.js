function getLine(curClass) {

    var xmlhttp3 = new XMLHttpRequest();
    xmlhttp3.onreadystatechange = function() {
      if (this.readyState == 4 && this.status == 200) {
        document.getElementById("txtLine").innerHTML = this.responseText;
      }
    };
    xmlhttp3.open("GET","getLine.jsp?classID="+curClass,true);
    xmlhttp3.send();
}