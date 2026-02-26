<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.studyplanner.Student, com.studyplanner.Task, java.util.List" %>



<%
Student student = (Student) request.getAttribute("student");
List<Task> todayTasks = (List<Task>) request.getAttribute("todayTasks");
List<Task> upcomingTasks = (List<Task>) request.getAttribute("upcomingTasks");
List<Task> reminderTasks = (List<Task>) request.getAttribute("reminderTasks");
List<Task> upcomingAssignments = (List<Task>) request.getAttribute("upcomingAssignments");
List<Task> upcomingExams = (List<Task>) request.getAttribute("upcomingExams");
List<Task> upcomingProjects = (List<Task>) request.getAttribute("upcomingProjects");
int progress = (request.getAttribute("progress") != null) ? (Integer) request.getAttribute("progress") : 0;
int overallProgress = (request.getAttribute("overallProgress") != null) ? (Integer) request.getAttribute("overallProgress") : 0;
%>

<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
    <style>
        /* --- styles here (same as yours) --- */
        /* KEEP ALL STYLES UNCHANGED FOR BREVITY */
        /* You already have good style setup */
        * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: poppins;
    text-decoration: none;
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

/* Main section part II*/
.dashboard-container {
    padding: 20px;
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 20px;
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
.student-info {
    background-color: white;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}
.student-info p{
    margin:15px 15px 15px 0px;
}
.student-info h3{
	font-size:30px;
	}
.student-details h4{
	font-size:30px;
	}
.student-info strong{
	margin-left:20px;
}
 i{
margin-left:20px;
}

/* part III*/
.study-progress {
    background-color: white;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}
.study-progress h3{
	font-size:30px;
	}
.progress-bar {
    width: 100%;
    height: 20px;
    border-radius: 5px;
    overflow: hidden;
}
.progress {
    height: 100%;
}
.progress-container {
  margin: 15px 0;
}

.progress-bar-bg {
  width: 100%;
  background-color: #ddd;
  border-radius: 5px;
  height: 20px;
  overflow: hidden;
  margin: 10px;
  
}

.progress-bar-fill {
  height: 100%;
  background-color: #2196F3; /* default blue for today */
  width: 0%;
  transition: width 0.6s ease-in-out;
}

.button{
    font-family: poppins;
    height:40px;
    width:200px;
    background-color: #8DCCCE;
    font-size: 16px;
    border-radius:5px;
    margin:15px;
    margin-top:2px;
    font-weight: bold;
    cursor: pointer;
}
button:hover{
    transform: scale(1.05);
    transition: transform 0.3s ease;
}
button a{
    color:black;
}
/* part IV */
.upcoming-tasks {
    background-color: white;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}
.upcoming-tasks h3{
    margin-bottom:15px;
    font-size:30px;
}
.upcoming-tasks ul {
    list-style-type: none;
    margin: 0;
    padding: 0;
}

.upcoming-tasks li {
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

/*part V */
.todays-tasks {
    background-color: white;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}
.todays-tasks h3{
    margin-bottom:15px;
    font-size:30px;
}
.todays-tasks ul {
    list-style-type: none;
    margin: 0;
    padding: 0;
}

.todays-tasks li {
    margin-bottom: 10px;
}

/Toast popup/
#toast {
            display: none;
            position: fixed;
            bottom: 20px;
            right: 20px;
            background: #333;
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            z-index: 9999;
            font-family: Arial, sans-serif;
            box-shadow: 0 0 10px rgba(0,0,0,0.3);
        }

    </style>
</head>
<body>
<c:out value="JSTL is working!" />

<header>
    <div class="navbar">
        <h1 class="logo">ZenOraFocus</h1>
        <div>
            <a href="index.jsp">Home</a>
            <a href="dashboard">Dashboard</a>
            <a href="aboutus.jsp">About Us</a>
            <a href="contact.jsp">Contact Us</a>
            <a href="LogoutServlet">Logout</a>
            <a href="history">History</a>
        </div>
    </div>
</header>


<section class="greet">
    <h2><b>Hello <%= student != null ? student.getUsername() : "Student" %>!</b></h2>
    <p>Let's make today productive!</p>
</section>

<div class="dashboard-container">

<!-- STUDENT INFO -->
<section class="student-info">
    <h3>Student Dashboard</h3><br>
    <div class="student-details">
        <h4><%= student != null ? student.getUsername() : "Student" %></h4>

        <p><b>Upcoming Assignments</b></p>
        <% if (upcomingAssignments != null && !upcomingAssignments.isEmpty()) {
            for (Task task : upcomingAssignments) { %>
                <strong><%= task.getTaskName() %></strong> - Due: <%= task.getDueDate() %> - Priority: <%= task.getPriority() %><br>
        <% }} else { %><i>No upcoming assignments.</i><% } %>

        <p><b>Upcoming Exams</b></p>
        <% if (upcomingExams != null && !upcomingExams.isEmpty()) {
            for (Task task : upcomingExams) { %>
                <strong><%= task.getTaskName() %></strong> - Due: <%= task.getDueDate() %> - Priority: <%= task.getPriority() %><br>
        <% }} else { %><i>No upcoming exams.</i><% } %>

        <p><b>Upcoming Projects</b></p>
        <% if (upcomingProjects != null && !upcomingProjects.isEmpty()) {
            for (Task task : upcomingProjects) { %>
                <strong><%= task.getTaskName() %></strong> - Due: <%= task.getDueDate() %> - Priority: <%= task.getPriority() %><br>
        <% }} else { %><i>No upcoming projects.</i><% } %>
    </div>
</section>

<!-- STUDY PROGRESS -->
<section class="study-progress">
    <h3>Progress Overview</h3>
    <div class="progress-container">
        <h4>Today's Progress</h4>
        <div class="progress-bar-bg">
            <div class="progress-bar-fill" style="width: <%= progress %>%"></div>
        </div>
        <p><%= progress %>% completed today</p>
    </div>

    <div class="progress-container">
        <h4>Overall Progress</h4>
        <div class="progress-bar-bg">
            <div class="progress-bar-fill" style="width: <%= overallProgress %>%; background-color: #4CAF50;"></div>
        </div>
        <p><%= overallProgress %>% of all tasks completed</p>
    </div>

    <div><br><br>
        <a href="viewTasks"><button class="button">Add Task</button></a>
        <a href="goToPlanner"><button class="button">Go to Planner</button></a>
    </div>
</section>

<!-- UPCOMING TASKS -->
<section class="upcoming-tasks">
    <section class="task-list">
        <h3>Upcoming Tasks</h3>
        <table class="task-table">
            <thead>
                <tr>
                    <th>Task Name</th>
                    <th>Due Date</th>
                    <th>Priority</th>
                </tr>
            </thead>
            <tbody>
            <% if (upcomingTasks != null && !upcomingTasks.isEmpty()) {
                for (Task task : upcomingTasks) { %>
                    <tr>
                        <td>
                            <form action="completeTask" method="post" style="display:inline;">
                                <input type="hidden" name="redirectPage" value="dashboard">
                                <input type="checkbox" name="taskId" value="<%= task.getId() %>" onchange="this.form.submit()"
                                    <%= "completed".equals(task.getStatus()) ? "checked disabled" : "" %> >
                                <%= task.getTaskName() %>
                            </form>
                        </td>
                        <td><%= task.getDueDate() %></td>
                        <td><%= task.getPriority() %></td>
                    </tr>
            <% }} else { %>
                <tr><td colspan="3"><i>No upcoming tasks found.</i></td></tr>
            <% } %>
            </tbody>
        </table>
    </section>
</section>

<!-- TODAY'S TASKS -->
<section class="todays-tasks">
    <h3>Today's Tasks</h3>
    <% if (todayTasks != null && !todayTasks.isEmpty()) { %>
        <ul class="task-to-do-list">
        <% for (Task task : todayTasks) { %>
            <li>
                <form action="completeTask" method="post">
                    <input type="hidden" name="redirectPage" value="dashboard">
                    <label>
                        <input type="checkbox" name="taskId" value="<%= task.getId() %>" onchange="this.form.submit()"
                            <%= "completed".equals(task.getStatus()) ? "checked disabled" : "" %> >
                        <strong style="<%= "completed".equals(task.getStatus()) ? "text-decoration: line-through; color: gray;" : "" %>">
                            <%= task.getTaskName() %>
                        </strong>
                        - Priority: <%= task.getPriority() %>
                    </label>
                </form>
            </li>
        <% } %>
        </ul>
    <% } else { %>
        <p><i>No tasks scheduled for today.</i></p>
    <% } %>
</section>

</div>
<%
if (reminderTasks != null) {
    for (Task task : reminderTasks) {
        String toastId = "toast-" + task.getId();
%>
    <div id="<%= toastId %>" 
         style="position: fixed; bottom: 10px; right: 10px; background-color: black; color: white; 
                padding: 10px; border-radius: 5px; margin-bottom: 10px; z-index: 9999; display: none;">
        <strong>Reminder:</strong><br>
        Task: <strong><%= task.getTaskName() %></strong><br>
        Due: <%= task.getDueDate() %><br>
        Priority: <%= task.getPriority() %><br>
        <button onclick="hideToast('<%= toastId %>')">Mark as Read</button>
    </div>
<%
    }
}
%>

<script>
function showToast(id) {
    var toast = document.getElementById(id);
    if (toast) {
        toast.style.display = 'block';
        setTimeout(function() {
            toast.style.display = 'none';
            // Call your servlet here to mark notified via AJAX or similar if needed
            markAsNotified(id);
        }, 7000); // 7 seconds display
    }
}

function hideToast(id) {
    var toast = document.getElementById(id);
    if (toast) {
        toast.style.display = 'none';
        markAsNotified(id);
    }
}

function markAsNotified(toastId) {
    // Extract taskId from toastId (toast-123 -> 123)
    var taskId = toastId.replace('toast-', '');

    // Simple AJAX POST to notify the server task has been notified
    var xhr = new XMLHttpRequest();
    xhr.open("POST", "NotificationServlet", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.send("taskId=" + encodeURIComponent(taskId));
}

// On page load, show all toast notifications one after another with a small delay
window.onload = function() {
<%
if (reminderTasks != null) {
    int delay = 0;
    for (Task task : reminderTasks) {
        String toastId = "toast-" + task.getId();
%>
    setTimeout(function() {
        showToast('<%= toastId %>');
    }, <%= delay %>);
<%
        delay += 8000; // 8 seconds gap between toasts
    }
}
%>
};
</script>




</body>
</html>