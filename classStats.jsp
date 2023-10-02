<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
.accordion {
  background-color: #eee;
  color: #444;
  cursor: pointer;
  padding: 18px;
  width: 100%;
  border: none;
  text-align: left;
  outline: none;
  font-size: 15px;
  transition: 0.4s;
}

.active, .accordion:hover {
  background-color: #ccc; 
}

.panel {
  padding: 0 18px;
  display: none;
  background-color: white;
  overflow: hidden;
}
.spacer{
    width: 100px
}
.center {
    text-align: center;
}

</style>
</head>
<body>

<h2>All Classes</h2>

    


<Table>
    <tr>
        <th colspan="4">Passes by day </td>
        <td class="spacer"></td>
        <th colspan="3">Longest Passes</td>
        <td class="spacer"></td>
        <th colspan="3">Top Users </td>
        <td class="spacer"></td>
    </tr>
    <tr>
        <td>Date</td>
        <td>Period</td>
        <td>Passes</td>
        <td>Avg Duration</td>
        <td class="spacer"></td>

        <td>Student</td>
        <td>Period</td>
        <td>Avg Duration</td>
        <td class="spacer"></td>

        <td>Student</td>
        <td>Period</td>
        <td># of passes</td>
        <td class="spacer"></td>  
    </tr>
    <tr>
        <td>10/3</td>
        <td class="center">All</td>
        <td>38</td>
        <td>11:16</td>
        <td class="spacer"></td>

        <td>Jeremy T.</td>
        <td class="center">All</td>
        <td>17:54</td>
        <td class="spacer"></td>

        <td>Jeremy T</td>
        <td class="center">All</td>
        <td>15</td>
        <td class="spacer"></td>  
    </tr>
    <tr>
        <td>10/3</td>
        <td class="center">2</td>
        <td>8</td>
        <td>6:15</td>
        <td class="spacer"></td>

        <td>Jeremy T.</td>
        <td class="center">2</td>
        <td>17:54</td>
        <td class="spacer"></td>

        <td>Jeremy Y</td>
        <td class="center">2</td>
        <td>15</td>
        <td class="spacer"></td>  
    </tr>
    <tr>
        <td>10/3</td>
        <td class="center">3</td>
        <td>4</td>
        <td>8:24</td>
        <td class="spacer"></td>

        <td>Tuan C.</td>
        <td class="center">3</td>
        <td>13:48</td>
        <td class="spacer"></td>

        <td>Zalen L.</td>
        <td class="center">3</td>
        <td>13</td>
        <td class="spacer"></td>  
    </tr>
    <tr>
        <td>10/3</td>
        <td class="center">4</td>
        <td>26</td>
        <td>4:27</td>
        <td class="spacer"></td>

        <td>Jocylen.</td>
        <td class="center">4</td>
        <td>11:09</td>
        <td class="spacer"></td>

        <td>James</td>
        <td class="center">4</td>
        <td>9</td>
        <td class="spacer"></td>  
    </tr>
</Table><br>
<table>
    <tr>
      <th>Period</th>  
      <th>Type</th>
      <th>Student</th>
      <th>Timestamp</th>
    </tr>
    <tr>
        <td>2</td>
        <td>Long Out time</td>
        <td>Carlos L</td>
        <td>9/28 11:16am</td>
      </tr>
</table>
<button class="accordion">Period 2 Details</button>
<div class="panel">
    <table>
        <tr>
            <th>Timestamp</th>
            <th>Student</th>
             
          <th>Type</th>
          <th></th>
          
          
        </tr>
        <tr>
            <td>9/28 11:16am</td>
            <td>Carlos L</td>
            
            <td>Long Out time</td>
            <td>Edit</td>
            
          </tr>
    </table></div>

<button class="accordion">Period 3 Details</button>
<div class="panel">
  <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
</div>

<button class="accordion">Period 4 Details</button>
<div class="panel">
  <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
</div>

<script>
var acc = document.getElementsByClassName("accordion");
var i;

for (i = 0; i < acc.length; i++) {
  acc[i].addEventListener("click", function() {
    this.classList.toggle("active");
    var panel = this.nextElementSibling;
    if (panel.style.display === "block") {
      panel.style.display = "none";
    } else {
      panel.style.display = "block";
    }
  });
}
</script>

</body>
</html>
