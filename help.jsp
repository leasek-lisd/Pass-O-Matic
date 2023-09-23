<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%String pageTitle = "Help"; %>
    <%@ include file="includes/navbar.jsp" %> 
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
.smallPrint {
  font-size: .75em;
  }
  
  .topicHeader {
  font-weight: bold;
}
.finePrint{
  font-size: .75em;
}
.warning{
  font-weight: bold;
  color: red;
}
</style>
</head>
<body>

<h2>Help FAQ</h2>
<div class="smallPrint">Please do NOT call the help desk if you have any issues with Pass-O-Matic!</div>



<button class="accordion">Who do I contact for help</button>
<div class="panel">

  <p class="warning">Again, please do not contact the usual help desk for Pass-O-Matic, they do NOT support this application.>/p>  
  <p class="topicHeader">You can get support:</p>
  <ul>
  <li>In person in room E205 during 1st period(after duty)</li>
  <li>Problems can be reported by filling out this Google form <a href="https://docs.google.com/forms/d/e/1FAIpQLSdcF5_KyXOvGKfQssUpGtVqfyr7YN28MtIc--gYRQj6hAV9OQ/viewform?usp=sf_link" target = "_blank">here</a></li>
  <li>New features / change requests can be made <a href="https://docs.google.com/forms/d/e/1FAIpQLSca4Y_F_Gdy4QLogwtCVy78QCVed48SCyfzZ-eoMOQ3oOMvAA/viewform?usp=sf_link" target = "_blank">here</a>
  </ul>

</div>

<button class="accordion">Getting Started</button>
<div class="panel">
  <div class="topicHeader">Room Layout</div>
  <p>Before you setup your seating chart you must define your room layout:</p>
  <ol>
    <li>Click "Room Layout" in the Navigation Bar</li>
    <li>Select room if required <br><span class="finePrint">(Note: if you share a room with another teacher you will both have the ability to adjust the layout)</span></li>
    <li>Select the type of object you want to add</li>
    <li>Click on the spot you would like to place the object</li>
    <li>Repeat as needed</li>
    <li>Note: If you need to remove an object just click it again</li>
    
   </ol>
  <div class="topicHeader">Seating Chart</div>
  <p>To create your seating chart</p>
    <ol>
    <li>Click "Seating Chart" in the Navigation Bar</li>
    <li>Select desired period</li>
    <li>Select desired student from dropdown in desired location <br><span class="finePrint">(Note: Only students with unassigned seats will appear in drop down menu)</span></li>
    </ol>
    To remove a student from a seat:
    <ol>
    <li>Click on the students name</li>
    <li>On the following menu click "Remove From Seat" button</li>
    
   </ol>
   Once all seats are assigned "Vacant" signs will appear in the empty seats
</div>

<button class="accordion">Managing Students</button>
<div class="panel">
<div class="topicHeader">Editing Student Details</div>
    <ol>
      <li>You can get to the edit menu through either the My Students menu or the seating chart
      <ul>
        <li>My Students menu:
          <ol>
            <li>Click My Students</li> 
            <li>Find student</li>
            <li>Click edit</li>
          </ol>
         </li>
         <li>Seating Chart:
          <ol>
            <li>Click on desired student's name</li> 
            <li>Click edit student</li>
          </ol>
         </li>
          
        
      </ul>
      </li>
    
     <li>Make desired changes</li>
     <li>Click Submit</li>
    
   </ol>
 
<div class="topicHeader">Adding an existing student</div>  
<ol>
  <li>Enter their school ID number into the "Find Student" box</li>
  <li>Click "Search"</li>
  <li>Click "If the student is in the system their schedule will appear</li>
  <li>Find the desired class and click the green arrow to add</li>
</ol> 

<div class="topicHeader">Adding a student to the system</div>  
<p>If the student isn't found using the previous steps the add student form will appear.  If you are sure the student is new, use the following steps to add the student:</p>
<ol>
  <li>Fill in all of the fields</li>
  <li>Click "Add Student"</li>
  <li>The student will be added and you will be shown the schedule page</li>
</ol> 
 
<div class="topicHeader">Removing a student</div>  
<ol>
  <li>Find student on My Students menu</li>
  <li>Click Schedule</li>
  <li>Click "Remove: link under student's name</li>
</ol>

</div>

<button class="accordion">Classroom Displays</button>
<div class="panel">
<p>Each classroom is different so there are several display options for you to choose from or you choose to not use one.  The advantage of using a display is that you and the students get a better idea of what is going on with the tool and your classroom.  If you don't use a display you can also monitor students' iPads as their screen will turn green when they have checked out</p>
<p>Each display is designed to clearly show if passes are generally available, show why if they are not, and make it clear that the student leaving the room has properly checked out</p>
<p>In addition, each display will automatically update throughout the day so that the proper content is displayed without intervention.  Keep in mind your device may still go to stand by mode though</p>

<div class="topicHeader">Large Status Display</div> 
  <p>If you have a large screen such as a monitor or TV, or if your projector is available then you may want to use the Large Status Display.  It will show:</p>
  <ul>
  <li>The current period number with class details</li>
  <li>A countdown timer</li>
  <li>An image that shows general status</li>
  <li>A list of all students who are out along with how long they have been out</li>
  <li>A list of all students in line</li>
  <li>If you have your device attached to speakers it will also play "Wheels On The Bus" chimes five minutes before the end of class</li>
  </ul>

<span class="topicHeader">Kiosk Diplay</span> 
  <p>The Kiosk Display can be used as just a display or as a method for students to access the tool.  It is ideal for an iPad which can be put in a special mode to keep it available</p>
  
  <p>General Operation: When you first open the display the screen will be the color of the current status and possibly a message.  If you tap/click anywhere the overlay will disappear and you will see buttons for each students.  The student can select their name to check out or check back in subject to the same eligibility rules.</p>
  
  <h3>Ipad use</h3>
  <p>You can put an ipad in "Guided Access" mode which will keep it locked to the browser but keep the device from going to sleep.</p>
  <p><span class="warning">Note: You are still responsible for maintaing control of the device and students.  It should only be placed in a location where you can observe the student using the device.</span>  While guided access will keep the student from going to other applications, the browser is still fully open.  A student using the device to checkout should not need anymore that a few taps.  You should investigate if you see extensive typing</p>
  
  <div>Setting up Guided Access</div>
  <ol>
  <li>Go to settings</li>
  <li>Find the accesibility menu</li>
  <li>Click Guided Access</li>
  <li>Switch the button to on</li>
  <li>Set a passcode</li>
  <li>Set screen timeout to "unlimited"</li>
  
  </ol>
  
  <div>Turning Guided Access On</div>
  <ol>
  <li>Open the browser</li>
  <li>Open the kiosk display</li>
  <li>Close any additional tabs</li>
  <li>Rapidly press the home button three times</li>
  <li>Monitor student use</li>
  </ol>
  
  <div>Turning Guided Access Off</div>
  <ol>
    <li>Rapidly press the home button three times</li>
    <li>Enter your passcode (the one you set for Guided Access)</li>
    <li>Click "Turn Off"</li>
    </ol>
  
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