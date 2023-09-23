<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
body {
  margin: 0;
  font-family: Arial, Helvetica, sans-serif;
}

.navItems {
  color: white;
}
.topnav {
  overflow: hidden;
  background-color: maroon; 
  color: white;
}

.topnav a {
  float: left;
  display: block;
  color: white;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
  font-size: 1.25em;
}

.topnav a:hover {
  background-color: white;
  color: maroon;
}

.topnav a.active {
  background-color: #A24857;
  color: white;
}

.topnav .icon {
  display: none;
}

@media screen and (max-width: 600px) {
  .topnav a:not(:first-child) {display: none;}
  .topnav a.icon {
    float: right;
    display: block;
  }
}

@media screen and (max-width: 600px) {
  .topnav.responsive {position: relative;}
  .topnav.responsive .icon {
    position: absolute;
    right: 0;
    top: 0;
  }
  .topnav.responsive a {
    float: none;
    display: block;
    text-align: left;
  }
  .titleBanner{
  font-size: 3em;
  color: maroon;
  text-weight: bold;}
}

@media print {
#myTopnav { display:none; }
}
</style>
<title><%=pageTitle%></title>
<link rel="icon" type="image/x-icon" href="img/LHSlogo.png">
</head>
<body>
 <a href="setTeacher.jsp"><img src="img\LHSlogo.png" height = "50px"></a> <span class = "titleBanner">Pass-O-Matic <%=pageTitle%></span>
<div class="topnav" id="myTopnav">
 

 
   <a href="teacherDashboard.jsp"
    <% if( (request.getServletPath()).equals("/teacherDashboard.jsp"))
       {out.println("class=\"active\"");
    }%>

  >Dashboard</a>
  

  
  <a href="myStudents.jsp"
    <% if( (request.getServletPath()).equals("/myStudents.jsp"))
       {out.println("class=\"active\"");
    }%>

  >My Students</a>




  
  <a href="SeatingChart.jsp?mode=1"
    <% if( (request.getServletPath()).equals("/SeatingChart.jsp"))
       {out.println("class=\"active\"");
    }%>

  >Seating Chart</a>
  
  
    <a href="setBlankChart2.jsp"
    <% if( (request.getServletPath()).equals("/setBlankChart2.jsp"))
       {out.println("class=\"active\"");
    }%>

  >Room Layout</a>
  


  
  <a href="javascript:void(0);" class="icon" onclick="myFunction()">
    <i class="fa fa-bars"></i>
  </a>
  
<a href="displayMenu.jsp"
    <% if( (request.getServletPath()).equals("/displayMenu.jsp"))
       {out.println("class=\"active\"");
    }%>

  >Displays</a>  
  
  
<a href="help.jsp"
    <% if( (request.getServletPath()).equals("/help.jsp"))
       {out.println("class=\"active\"");
    }%>

  >Help</a>

  
<a href="admin.jsp"
    <% if( (request.getServletPath()).equals("/admin.jsp"))
       {out.println("class=\"active\"");
    }%>

  >Admin</a>  
  
  <a href="javascript:void(0);" class="icon" onclick="myFunction()">
    <i class="fa fa-bars"></i>
  </a>
</div>



<script>
function myFunction() {
  var x = document.getElementById("myTopnav");
  if (x.className === "topnav") {
    x.className += " responsive";
  } else {
    x.className = "topnav";
  }
}
</script>
