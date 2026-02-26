<%@ page import="java.util.List" %>
<%@ page import="com.studyplanner.Task" %>
<%@ page import="com.studyplanner.Student, java.util.List, com.studyplanner.Task" %>
<%
    Student student = (Student) request.getAttribute("student");
List<Task> completedTasks = (List<Task>) request.getAttribute("completedTasks");
%>

<%
    String selectedPriority = request.getParameter("priority");
    String selectedCategory = request.getParameter("category");
%>


<!DOCTYPE html>
<html>
<head>
    <title>ZenOraFocus | History</title>
     <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
    <style>
    
    * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: poppins;
    text-decoration: none;
}

header{
   background-color: black;
        }
.navbar {
   display: flex;
   justify-content: space-between;
   align-items: center;
   padding: 10px;
   background-color: #13212A;
   font-size: 20px;
}

.navbar h1 {
    color: white;
}

.navbar a {
     color: white;
     text-decoration: none;
     padding: 5px 15px;
        }

.navbar a:hover {
      color: #54BDC9;
}
 .greet p{
    font-size: large;
    margin-left:24px;
 }
.greet h2{
    font-size: 40px;
    margin:8px;
    margin-left:24px; 
 }
 
 .filter input,select{
 	width:25%;
 	padding:8px;
 	border-radius:5px;
 }
   .filter button {
  	width:150px;
    font-family: poppins;
    padding: 8px;
    background-color: white;
    cursor: pointer;
    margin:0;
    border-radius: 5px;
    font-size: 16px;
    border: 1px solid black;
    color:black;
  }
 .filter button:hover{
    transform: scale(1.05);
    transition: transform 0.3s ease;
}
 
 
 .completed-tasks{
 	margin:50px;
 	margin-top:0px;}
.completed-tasks ul {
    list-style-type: none;
    margin: 0;
    padding: 0;
}

.completed-tasks li {
    margin-bottom: 10px;
}
 .task-list ul {
    list-style-type: none;
    padding: 0;
  }
 .task-list li {
    padding: 10px;
    border: 1px solid #ddd;
    margin-bottom: 10px;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
 .task-list li span {
    margin-right: 20px;
  }
.task-table {
    width: 100%;
    border-collapse: collapse;
    font-family: 'Poppins', sans-serif;
}

.task-table th, .task-table td {
    text-align: left;
    padding: 20px;
    margin:20px;
    border-bottom: 1px solid #ccc;
}
.task-table tr{
	padding: 20px;
    margin:20px;
    border-bottom: 1px solid #ccc;
}

.task-table th {
    background-color: #f2f2f2;
}
  .task-table button {
  	width:100px;
    font-family: poppins;
    padding: 10px;
    background-color: white;
    cursor: pointer;
    margin:0;
    border-radius: 5px;
    font-size: 16px;
    border: 1px solid black;
  }
 .task-table button:hover{
    transform: scale(1.05);
    transition: transform 0.3s ease;
}
 
    </style>
</head>
<body>

<header>
    <div class="navbar">
        <h1 class="logo">ZenOraFocus</h1>
        <div>
          <a href="dashboard">Dashboard</a>
            <a href="goToPlanner">Study Planner</a>
            <a href="history">History</a>
            <a href="LogoutServlet">Logout</a>
        </div>
    </div>
  </header>   
    <section class="greet">
    <%
    String username = (String) session.getAttribute("username");
    if (username != null) {
%>
    <h2>Hey <%= username %>!</h2>
<%
    } else {
%>
    <h2>Hello Student!</h2>
<%
    }
%>
    <p>Let's track your history!</p>
</section>
    <br>
    <section class="completed-tasks">
    <section class="filter">
    <form action="history" method="get">
    <form action="history" method="get">
    <label for="priority">Filter by Priority:</label>
    <select name="priority" id="priority">
        <option value="" <%= (selectedPriority == null || selectedPriority.isEmpty()) ? "selected" : "" %>>--All--</option>
        <option value="high" <%= "high".equals(selectedPriority) ? "selected" : "" %>>High</option>
        <option value="medium" <%= "medium".equals(selectedPriority) ? "selected" : "" %>>Medium</option>
        <option value="low" <%= "low".equals(selectedPriority) ? "selected" : "" %>>Low</option>
    </select>

    <label for="category">Filter by Category:</label>
    <select name="category" id="category">
        <option value="" <%= (selectedCategory == null || selectedCategory.isEmpty()) ? "selected" : "" %>>--All--</option>
        <option value="assignment" <%= "assignment".equals(selectedCategory) ? "selected" : "" %>>Assignment</option>
        <option value="exam" <%= "exam".equals(selectedCategory) ? "selected" : "" %>>Exam</option>
        <option value="project" <%= "project".equals(selectedCategory) ? "selected" : "" %>>Project</option>
        <option value="task" <%= "task".equals(selectedCategory) ? "selected" : "" %>>Task</option>
    </select>

    <button type="submit">Apply Filter</button>

    <!-- Clear Filter button -->
    <button><a href="history" style="color:red" >Clear Filter</a></button>
</form>

</section>
<br><br>
 <section class="task-list">
    <table class="task-table">
    <thead>
        <tr>
            <th>Task Name</th>
            <th>Due Date</th>
            <th>Priority</th>
            <th>Category</th>
        </tr>
    </thead>
    <tbody>
        <% if (completedTasks != null && !completedTasks.isEmpty()) {
    for (Task task : completedTasks) {
%>
            <tr>
                <td><%= task.getTaskName() %></td>
                <td><%= task.getDueDate() %></td>
                <td><%= task.getPriority() %></td>
                <td><%= task.getCategory() %></td>
            </tr>
        <% }} else { %>
            <tr>
                <td colspan="3"><i>No completed tasks found.</i></td>

            </tr>
        <% } %>
    </tbody>
</table>
</section></section>
</body>
</html>
