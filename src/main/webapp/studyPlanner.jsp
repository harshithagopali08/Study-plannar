<%@ page import="java.sql.*" %>
<%@ page import="java.util.List" %>
<%@ page import="com.studyplanner.Task" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>StudyPlanner</title>
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
            /* background-color: pink;
            border-radius: 5px; */
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
 /* part II */
 .planner {
    padding: 20px;
    max-width: 800px;
    margin:auto;
  }
  form {
    display: flex;
    flex-direction: column;
  }
 
  label {
    margin-top: 10px;
  }
  input, select {
    font-family: poppins;
    padding: 8px;
    margin-top: 5px;
    border-radius: 5px;
  }
  .planner button {
    width: 150px;
    font-family: poppins;
    margin-top: 15px;
    padding: 10px;
    background-color: #8DCCCE;
    border: none;
    cursor: pointer;
    border-radius: 5px;
    font-size: 16px;
    align-items: center;
    margin: 20px auto 0 auto; 
    display: block;
    border: 1px solid black;
  }
  .planner button:hover{
    transform: scale(1.05);
    transition: transform 0.3s ease;
}
  #priority{
    font-family: poppins;
  }
  /*PART III */
  .upcoming-tasks {
    background-color: white;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}
.upcoming-tasks h3{
    margin-bottom:15px;
}
.upcoming-tasks ul {
    list-style-type: none;
    margin: 0;
    padding: 0;
}

.upcoming-tasks li {
    margin-bottom: 10px;
}
  
  .task-list {
    margin-top: 40px;
  }
  .task-list ul {
    list-style-type: none;
    padding: 0;
  }
  .task-list li {
    padding: 10px;
    border-bottom: 1px solid #ddd;
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
    margin-top: 20px;
    font-size: 16px;
}

.task-table th,
.task-table td {
    padding: 12px;
    text-align: left;
    border-bottom: 1px solid #ccc;
}

.task-table th {
    font-weight: bold;
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
            <a href="goToPlanner">Go To Planner</a>
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
    <p>Let's plan your studies!</p>
</section>

<section class="planner">
    <form action="addTask" method="post">
        <label for="task">Task Name:</label>
        <input type="text" id="task" name="taskName" required>

        <label for="due-date">Due Date:</label>
        <input type="date" id="due-date" name="dueDate" required>

        <label for="priority">Priority:</label>
        <select id="priority" name="priority">
        	<option value="" disabled selected>Select Priority</option>
            <option value="Low">Low</option>
            <option value="Medium">Medium</option>
            <option value="High">High</option>
        </select>
        
        <label for="category">Category:</label>
		<select id="category" name="category" required>
			<option value="" disabled selected>Select Type</option>
    		<option value="Assignment">Assignment</option>
    		<option value="Exam">Exam</option>
    		<option value="Project">Project</option>
    		<option value="Task">Task</option>
		</select>
        <label>Reminder Time:</label>
        <input type="datetime-local" name="reminderTime"><br>
        

        <button type="submit" value="Add Task">Add Task</button>
    </form><br>
    
   <%
    String status = request.getParameter("status");
    if ("success".equals(status)) {
%>
    <p style="color: green; text-align:center;"><b>Task added successfully!</b></p>
<%
    } else if ("error".equals(status)) {
%>
    <p style="color: red; text-align:center;"><b>Error adding task. Try again.</b></p>
<%
    } else if ("deleted".equals(status)) {
%>
    <p style="color: blue; text-align:center;"><b>Task deleted successfully!</b></p>
<%
    }
%>
    <section class="task-list">
        <h2>Upcoming Tasks</h2>
       <%
    List<Task> taskList = (List<Task>) request.getAttribute("taskList");
    if (taskList != null && !taskList.isEmpty()) {
%>

    <table class="task-table">
        <thead>
            <tr>
                <th>Task</th>
                <th>Due Date</th>
                <th>Priority</th>
                <th>Category</th>
                <th>Delete</th>
            </tr>
        </thead>
        <tbody>
            <% for (Task task : taskList) {
       if (!"completed".equalsIgnoreCase(task.getStatus())) {
%>
<tr>
    <td><form action="completeTask" method="post" style="display:inline;">
             <input type="hidden" name="redirectPage" value="viewTasks">
            <input type="checkbox" name="taskId" value="<%= task.getId() %>" onchange="this.form.submit()"
    <%= "completed".equals(task.getStatus()) ? "checked disabled" : "" %> >

            <%= task.getTaskName() %>
        </form></td>
    <td><%= task.getDueDate() %></td>
    <td><%= task.getPriority() %></td>
    <td><%= task.getCategory() %></td>
    <td>
        <form action="deleteTask" method="post" style="display:inline;">
            <input type="hidden" name="taskId" value="<%= task.getId() %>">
            <button type="submit" onclick="return confirm('Are you sure you want to delete this task?');">Delete</button>
        </form>
    </td>
    
</tr>
<%
       } // only show if not completed
   } // end for
%>

        </tbody>
    </table>
<% } else { %>
    <p>No tasks found.</p>
<% } %>

    </section>
</section>
<script>
  // Get selectedDate from URL params
  const urlParams = new URLSearchParams(window.location.search);
  const selectedDate = urlParams.get("selectedDate");

  if (selectedDate) {
    document.addEventListener("DOMContentLoaded", function () {
      const dueDateInput = document.getElementById("due-date");
      if (dueDateInput) {
        dueDateInput.value = selectedDate;
      }
    });
  }
</script>
<script>
document.querySelector("form").addEventListener("submit", function(e) {
    const reminderTime = document.querySelector("[name='reminderTime']").value;
    if (reminderTime && new Date(reminderTime) < new Date()) {
        alert("Reminder time must be in the future.");
        e.preventDefault();
    }
});
</script>


</body>
</html>