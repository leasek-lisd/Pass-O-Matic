<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<table>
<tr>
  <th>Period</th>
  <th>classID</th>
  <th>Title</th>
    <th>Class Room</th>
</tr>
<tr>
  <td>1</td>
  <td><%=session.getAttribute("firstPeriodClassID")%></td>
  <td><%=session.getAttribute("firstPeriodClassTitle")%></td>
  <td><%=session.getAttribute("firstPeriodClassRoom")%></td>
</tr>

</table>
</body>
</html>