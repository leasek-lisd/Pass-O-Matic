<style>
.switch {
  position: relative;
  display: inline-block;
  width: 45px;
  height: 20px;
}

.switch input { 
  opacity: 0;
  width: 0;
  height: 0;
}

.slider {
  position: absolute;
  cursor: pointer;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: #ccc;
  -webkit-transition: .4s;
  transition: .4s;
}

.slider:before {
  position: absolute;
  content: "";
  height: 12px;
  width: 12px;
  left: 4px;
  bottom: 4px;
  background-color: white;
  -webkit-transition: .4s;
  transition: .4s;
}

input:checked + .slider {
  background-color: #2196F3;
}

input:focus + .slider {
  box-shadow: 0 0 1px #2196F3;
}

input:checked + .slider:before {
  -webkit-transform: translateX(26px);
  -ms-transform: translateX(26px);
  transform: translateX(21px);
}

/* Rounded sliders */
.slider.round {
  border-radius: 24px;
}

.slider.round:before {
  border-radius: 50%;
  }
.periodTitle {
  font-size: 1.25em;
  font-weight: bold;
}
.smallTitle {
  font-size: .5em;
  font-weight: bold;
}

</style>
<table>
<tr><td>Self Service Passes</td><td colspan="2">
<label class="switch">
  <input id="selfService" name = "selfService" type="checkbox" onchange = "processClick(<%out.print("'selfService'"); %>)" checked>
  <span class="slider round"></span>

</td></tr>
<tr><td>Emergency Passes</td><td colspan="2">
<label class="switch">
  <input id="emergency" name = "emergency" type="checkbox" onchange = "processClick(<%out.print("'emergency'"); %>)" checked>
  <span class="slider round"></span>

</td></tr>

<tr><td>Display Announcements</td><td colspan="2">
<label class="switch">
  <input id="announcements" name = "announcements" type="checkbox" onchange = "processClick(<%out.print("'announcements'"); %>)" checked>
  <span class="slider round"></span>

</td></tr>

<tr><td>Display Links <%out.print("\"links\"");%></td><td colspan="2">
<label class="switch">
  <input id="links" name = "links" type="checkbox" onchange = "processClick(<%out.print("'links'"); %>)" checked>
  <span class="slider round"></span>   

</td></tr>

<tr><td>Bus Alert</td><td>

<label class="switch">
  <input id="busAlert" name = "busAlert" type="checkbox" onchange = "processClick(<%out.print("'busAlert'"); %>)" checked>
  <span class="slider round"></span><br>
  <div id="txtStudentsOut"></div>
</label></td></tr>
</table>



<script>
function processClick(switchID) {
    let checkbox = document.getElementById(switchID);
    console.log(switchID + ": "+checkbox.checked);
    
    var xmlhttp3 = new XMLHttpRequest();
    xmlhttp3.onreadystatechange = function() {
      if (this.readyState == 4 && this.status == 200) {
        document.getElementById("txtStudentsOut").innerHTML = this.responseText;
      }
    };
    var useURL = "updateClassSettings.jsp?setting="+switchID+"&value="+checkbox.checked+"&classID="+classID+"
    console.log(useURL);
    xmlhttp3.open("GET",useURL,true); xmlhttp3.send();    
    
    
}
</script>