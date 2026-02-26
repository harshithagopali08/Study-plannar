<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.studyplanner.Task, java.time.LocalDate" %>
<%@ page import="java.util.List" %>
<%@ page import="com.studyplanner.Task" %>

<%
    List<Task> taskList = (List<Task>) request.getAttribute("taskList");
%>



<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>ZenOraFocus | Go To Planner</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
<!-- FullCalendar CSS -->
<link href="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.css" rel="stylesheet" />

<!-- FullCalendar JS -->
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.js"></script>

  <style>
    body {
      font-family: 'Poppins', sans-serif;
      background-color: #fff;
      margin: 0;
      padding: 0;
    }

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

    .main-content {
      display: flex;
      flex-wrap: wrap;
      padding: 1rem;
      gap: 1rem;
    }

    .week-grid {
      flex: 1;
      min-width: 400px;
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
      gap: 1rem;
    }

    .day-column {
      padding: 1rem;
      border-radius: 12px;
      box-shadow: 0 2px 6px rgba(0,0,0,0.05);
    }

    .day-column h2 {
      font-size: 1.2rem;
      border-bottom: 1px solid #ddd;
      margin-bottom: 0.75rem;
      padding-bottom: 0.5rem;
      text-align: center;
    }
.day-column:hover{
	transform: scale(1.05);
    transition: transform 0.3s ease;
  cursor: pointer;
  box-shadow: 1px 2px 6px #2196F3;
  }
    .day-column ul {
      list-style: none;
      padding-left: 0;
    }

    .task-item {
      background-color: #eef9ff;
      margin-bottom: 10px;
      padding: 10px;
      border-left: 6px solid transparent;
      border-radius: 8px;
      font-size: 14px;
      box-shadow: 1px 2px 4px rgba(0,0,0,0.05);
      
    }
    .task-low:hover{
    transform: scale(1.05);
    transition: transform 0.3s ease;
  cursor: pointer;
  }

    .task-low {
      border-left-color: #FFD700; /* Yellow */
    }

    .task-medium {
      border-left-color: #32CD32; /* Green */
    }
.task-medium:hover{
    transform: scale(1.05);
    transition: transform 0.3s ease;
  cursor: pointer;
  }
    .task-high {
      border-left-color: #FF4C4C; /* Red */
    }
.task-high:hover{
    transform: scale(1.05);
    transition: transform 0.3s ease;
  cursor: pointer;
  }
    .no-task {
      border-left: 6px solid #999;
      background-color: #f4f4f4;
      padding: 10px;
      border-radius: 8px;
      font-style: italic;
      color: #666;
    }
    .no-task:hover{
    transform: scale(1.05);
    transition: transform 0.3s ease;
  cursor: pointer;
  }
.day-card.missed {
    background-color: #fff5f5;
    border-left: 5px solid #e63946;
    padding: 15px;
    border-radius: 10px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    width:45%;
}
.day-card.missed h3{
	font-size:20px;
	margin-bottom:10px;
	}
	
.task-card.overdue {
    background-color: #ffe6e6;
    padding: 8px;
    margin-top: 8px;
    border-radius: 5px;
    font-weight: 500;
}
.task-card.overdue:hover{
	transform: scale(1.05);
    transition: transform 0.3s ease;
    }
    .task-card.overdue form {
  margin-top: 5px;
}

.task-card.overdue input[type="date"] {
  margin-left: 5px;
  padding: 3px;
  font-size: 0.9em;
}

.task-card.overdue button {
  padding: 3px 8px;
  font-size: 0.9em;
  margin-left: 5px;
  background-color: #007bff;
  color: white;
  border: none;
  border-radius: 4px;
}
    
.planner-container {
  display: flex;
  flex-direction: row;
  padding: 2rem;
  gap: 2rem;
}

.missed-task {
    background-color: #f8d7da;
    padding: 8px;
    margin-top: 5px;
    border-radius: 8px;
}
#calendar {
  flex: 1;
  height: 600px;
  background-color: #fff;
  padding: 1rem;
  border-radius: 12px;
  box-shadow: 0 4px 8px rgba(0,0,0,0.1);
}
    @media (max-width: 900px) {
      .main-content {
        flex-direction: column;
      }
    }
    .extras-container {
  display: flex;
  justify-content: center;
  gap: 2rem;
  margin: 2rem;
  flex-wrap: wrap;
}

.day-card.missed,#pomodoro {
  flex: 1;
  max-width: 500px;
}
    #pomodoro {
      background: white;
      padding: 30px;
      border-radius: 12px;
      box-shadow: 0 5px 15px rgba(0,0,0,0.2);
      text-align: center;
    }

    #timer {
      font-size: 60px;
      margin: 20px 0;
    }

    button {
      padding: 10px 20px;
      margin: 5px;
      font-size: 16px;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      background-color: #3498db;
      color: white;
      transition: background-color 0.3s;
    }

    button:hover {
      background-color: #2980b9;
    }
    .day-column-alltasks {
      padding: 1rem;
      border-radius: 12px;
      box-shadow: 0 2px 6px rgba(0,0,0,0.05);
    }
    .day-column li .task-items{
    transform: scale(1.05);
    transition: transform 0.3s ease;
  cursor: pointer;
    }
    .day-column-alltasks ul {
      list-style: none;
      padding-left: 0;
    }
    .task-highlight {
  outline: 2px solid blue;
}
  </style>
</head>
<body>

  <header class="navbar">
    <h1 class="logo">ZenOraFocus</h1>
    <div>
      <a href="dashboard">Dashboard</a>
      <a href="viewTasks">Add Task</a>
      <a href="history">History</a>
      <a href="LogoutServlet">Logout</a>
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
    <p>Let's Plan. Prioritize. Progress!</p>
  </section>

  <div class="planner-container">
    <!-- Weekly Planner -->
    <section class="week-grid">
<%
Map<String, List<Task>> tasksByDay = (Map<String, List<Task>>) request.getAttribute("tasksByDay");
String[] days = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"};
java.time.LocalDate today = java.time.LocalDate.now(); // moved to top
for (String day : days) {
    List<Task> tasks = tasksByDay != null ? tasksByDay.get(day) : null;
%>
<div class="day-column">
    <h2><%= day %></h2>
    <ul>
        <%
        boolean hasPending = false;
        if (tasks != null) {
            for (Task task : tasks) {
                if ("pending".equalsIgnoreCase(task.getStatus())) {
                    hasPending = true;

                    String icon = "📌";
                    String cat = task.getCategory().toLowerCase();
                    if ("assignment".equals(cat)) icon = "📄";
                    else if ("exam".equals(cat)) icon = "📝";
                    else if ("project".equals(cat)) icon = "🗂️";

                    String priority = task.getPriority().toLowerCase();
                    String className = "task-item";
                    if ("low".equals(priority)) className += " task-low";
                    else if ("medium".equals(priority)) className += " task-medium";
                    else if ("high".equals(priority)) className += " task-high";

                    boolean isMissed = task.getDueDate().isBefore(today);
                    if (isMissed) className += " missed-task";
        %>
        <li class="<%= className %>">
            <form action="completeTask" method="post" style="display:inline;">
                <input type="hidden" name="redirectPage" value="goToPlanner">
                <input type="checkbox" name="taskId" value="<%= task.getId() %>" onchange="this.form.submit()"
                    <%= "completed".equals(task.getStatus()) ? "checked disabled" : "" %> >
                <strong><%= icon + " " + task.getTaskName() %></strong>
                (<%= task.getCategory() %> – <%= task.getPriority() %>)
                <% if (isMissed) { %>
                    – Due: <%= task.getDueDate() %>
                <% } %>
            </form>
        </li>
        <%
                }
            }
        }
        if (!hasPending) {
        %>
        <li class="no-task">No pending tasks</li>
        <%
        }
        %>
    </ul>
</div>
<% } %>
    </section>
    
    
    
    <!-- Calendar -->
    <div id='calendar'></div>
  </div>
  
  <%
    Set<String> missedDates = (Set<String>) request.getAttribute("missedDates");
    Set<String> activeTaskDates = (Set<String>) request.getAttribute("activeTaskDates");

    List<Map<String, String>> calendarEvents = new ArrayList<>();

    if (missedDates != null) {
        for (String date : missedDates) {
            Map<String, String> event = new HashMap<>();
            event.put("title", "❌ Missed Task");
            event.put("start", date);
            event.put("color", "#ff9999"); // light red
            calendarEvents.add(event);
        }
    }

    if (activeTaskDates != null) {
        for (String date : activeTaskDates) {
            Map<String, String> event = new HashMap<>();
            event.put("title", "📌 Task Due");
            event.put("start", date);
            event.put("color", "#add8e6"); // light blue
            calendarEvents.add(event);
        }
    }

%>
<script>
  const missedDates = [<% if (missedDates != null) {
         for (Iterator<String> it = missedDates.iterator(); it.hasNext(); ) {
             String date = it.next(); %>"<%= date %>"<%= it.hasNext() ? "," : "" %><% } } %>];

  const activeTaskDates = [<% if (activeTaskDates != null) {
         for (Iterator<String> it = activeTaskDates.iterator(); it.hasNext(); ) {
             String date = it.next(); %>"<%= date %>"<%= it.hasNext() ? "," : "" %><% } } %>];
</script>

  

<script>
  document.addEventListener('DOMContentLoaded', function () {
    var calendarEl = document.getElementById('calendar');

    var calendar = new FullCalendar.Calendar(calendarEl, {
      initialView: 'dayGridMonth',
      selectable: true,
      events: [
        <% 
          if (missedDates != null) {
            for (String date : missedDates) { %>
            {
            	  start: "<%= date %>",
            	  display: "background",
            	  backgroundColor: "#ffcccc" // light red for missed task
            	},
        <%    }
          }
          if (activeTaskDates != null) {
            for (String date : activeTaskDates) { %>
            {
            	  start: "<%= date %>",
            	  display: "background",
            	  backgroundColor: "#cce5ff" // light blue for due task
            	},

        <%    }
          }
        %>
      ],
      dateClick: function(info) {
    	  const clickedDate = info.dateStr;

    	  if (missedDates.includes(clickedDate)) {
    	    const taskElement = document.getElementById("missedTask-" + clickedDate);
    	    if (taskElement) {
    	      taskElement.scrollIntoView({ behavior: "smooth", block: "center" });
    	      taskElement.style.border = "2px solid red";
    	      setTimeout(() => {
    	        taskElement.style.border = "none";
    	      }, 1500);
    	    }
    	  } else {
    	    window.location.href = "viewTasks?date=" + clickedDate;
    	  }
    	}



    });

    calendar.render();
  });
</script>



<div class="extras-container">
 <%-- Missed Deadlines Section --%>

<% if (taskList != null && !taskList.isEmpty()) {
        boolean hasMissed = false;
        for (Task task : taskList) {
            java.time.LocalDate dueDate = task.getDueDate();
            if (!"completed".equalsIgnoreCase(task.getStatus()) && dueDate.isBefore(today)) {
                hasMissed = true;
                break;
            }
        }
%>
    <div class="day-card missed" id="missedSection">
        <h3>Missed Deadlines</h3>
        <% if (hasMissed) {
                for (Task task : taskList) {
                    java.time.LocalDate dueDate = task.getDueDate();
                    if (!"completed".equalsIgnoreCase(task.getStatus()) && dueDate.isBefore(today)) {
        %>
           <div class="task-card overdue" id="missedTask-<%= task.getDueDate() %>">
    📌 <strong><%= task.getTaskName() %></strong>
    (<%= task.getCategory() %> – <%= task.getPriority() %>)
    <br><small style="color: gray;">Due: <%= task.getDueDate() %></small>

    <form action="rescheduleTask" method="post" style="margin-top: 8px;">
        <input type="hidden" name="taskId" value="<%= task.getId() %>">
        <label for="newDueDate_<%= task.getId() %>">Reschedule to:</label>
        <input type="date" id="newDueDate_<%= task.getId() %>" name="newDueDate"
               min="<%= java.time.LocalDate.now().toString() %>" required>
        <button type="submit">Reschedule</button>
    </form>
</div>

        <%          }
                }
            } else { %>
            <p>No missed tasks 🎉</p>
        <% } %>
    </div>
<% } %>
      
      <div id="pomodoro">
    <h2>Pomodoro Timer</h2>
    <div id="timer">25:00</div>
    <button onclick="startTimer()">Start</button>
    <button onclick="pauseTimer()">Pause</button>
    <button onclick="resetTimer()">Reset</button>
  </div>

  <script>
    let time = 25 * 60;
  let timerInterval;
  let isRunning = false;

  function pad(num) {
    return num < 10 ? "0" + num : num;
  }

  function updateDisplay() {
    const minutes = Math.floor(time / 60);	
    const seconds = time % 60;
    document.getElementById("timer").textContent = pad(minutes) + ":" + pad(seconds);
  }

  function startTimer() {
    if (isRunning) return;
    isRunning = true;
    timerInterval = setInterval(() => {
      if (time > 0) {
        time--;
        updateDisplay();
      } else {
        clearInterval(timerInterval);
        document.getElementById("alarm-sound").play();
        isRunning = false;
      }
    }, 1000);
  }

  function pauseTimer() {
    clearInterval(timerInterval);
    isRunning = false;
  }

  function resetTimer() {
    pauseTimer();
    time = 25 * 60;
    updateDisplay();
  }

  updateDisplay(); // Initialize timer
  </script>
 <audio id="alarm-sound" src="wind-up-clock-alarm-bell-64219.mp3" preload="auto"></audio>  
</div>


</body>
</html>
