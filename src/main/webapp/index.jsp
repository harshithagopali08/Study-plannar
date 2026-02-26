<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>ZenOraFocus</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: poppins;
        }

        body {
            background-color:#003652;
            background-repeat: no-repeat;
            background-size: cover;
            font-family: Arial, sans-serif;
        }

        .hero-section{
            background-color: #003652;
            background-repeat: no-repeat;
            background-size: cover;
            min-height: 100vh;
            display: flex;
            align-items:center
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

        .hero-text {
            text-align: left;
            margin-top: 0px;
            margin-bottom: 100px;
            color: white;
            padding: 0 50px;
        }

        h3 {
            font-size: 20px;
        }

        .btn{
            margin-top: 10px;
            display: inline-block;
            padding: 10px;
            font-size: 15px;
            cursor: pointer;
            color: black;
            background: #8DCCCE;
            border-radius: 0;
            position: relative;
            z-index: 0;
            overflow:hidden;
            text-decoration: none;
            box-shadow:0 8px 16px 0 rgba(0,0,0,0.2),0 6px 20px rgba(0,0,0,0.19);
            border-radius:8px;
            
        }
        .btn:hover{
            transform: scale(1.05);
            transition: transform 0.3s ease;
            background: white;
        }
        .services p{
            color:black;
        }
        .services h2{
            color: black;
        }
        .services {
            padding: 50px;
            background-color: #B3C5D7; /* slight transparency */
            text-align: center;
        }

        .services .heading {
            font-size: 36px;
            margin-bottom: 30px;
            text-transform: capitalize;
            gap: 3px;
        }

        .services .box-container {
            display: flex;
            justify-content: space-around;
            gap: 20px;
            flex-wrap: wrap;
        }

        .services .box {
            background: #D8E1E9; /* */
            padding: 10px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            flex: 1 1 300px;
            max-width: 300px;
        }
        
        .h2{
            padding-left: 20px;
            padding-right: 20px;
            color: white;

        }
        .box-container{
            padding-left: 20px;
            padding-right: 20px;
            color: black;
        }
        footer{
            background-color: black;
            color: white;
            text-align: center;
            padding: 10px;
            justify-content: space-between
            
        }
        @keyframes bgAnimation {
    0% { fill: #b2c2cb; }
    50% { fill: #00476c;}
    100% { fill: #003652; }
}

#bg {
    animation: bgAnimation 10s ease-in-out infinite; /* Looping animation */
}
img {
    max-width: 100%;
    height: auto;
    display: block;
}
.hero-img{
    width:100%;
    max-width:1200px;
    display:block;
    margin:20px auto;
}

.mobile-img1{
    width:100%;
    max-width:285px;
    margin:auto;
}
.mobile-img2{
    width:100%;
    max-width:500px;
    margin:auto;
}

    </style>
</head>
<body>
    <header>
    <div class="navbar">
        <h1 class="logo">ZenOraFocus</h1>
        <div>
          <a href="index.jsp">Home</a>
            <a href="log.jsp">Login</a>
            <a href="register.jsp">Register</a>
            <a href="aboutus.jsp">About Us</a>
            <a href="contact.jsp">Contact Us</a>
        </div>
    </div>
  </header>
    <div class="hero-section">
            <svg style="width: 100%; height:100vh">
            <!-- Animated Background -->
            <rect id="bg" width="100%" height="100%" fill="#a3cde3"/> <!-- Background that animates -->
        
            <defs>
                <filter id="turbulent-dissolve" x="0%" y="0%">
                    <feTurbulence type="fractalNoise" baseFrequency=".012"/>
                    <feColorMatrix type="luminanceToAlpha"/>
                    <feComponentTransfer>
                        <feFuncA type="linear" slope="0">
                            <animate attributeName="slope" values="0;0;0;0;0;0.5;1;1.5;2;2;2;2;2;2;1.5;1;0.5;0" dur="8s" repeatCount="indefinite"/>
                        </feFuncA>
                    </feComponentTransfer>
                    <feComponentTransfer>
                        <feFuncA type="discrete" tableValues="0 1"/>
                    </feComponentTransfer>
                    <feGaussianBlur stdDeviation="1"/>
                    <feComposite operator="in" in="SourceGraphic" result="overlay"/>
                </filter>
            </defs>
        
            <!-- Persistent Text (Always Visible) -->
            <text x="20%" y="45%" fill="white" font-size="36" text-anchor="middle">
                IGNITE YOUR CURIOSITY
            </text>
            <text x="16.3%" y="52%" fill="white" font-size="24" text-anchor="middle">
                Learn, Grow, and Succeed
            </text>
        
            <!-- Button -->
            <foreignObject x="5%" y="53%" width="20%" height="10%">
                <div xmlns="http://www.w3.org/1999/xhtml">
                    <a href="log.jsp" class="btn">Start Now</a>
                </div>
            </foreignObject>

            <image href="./Programming-amico.png" x="45%" y="0%" width="60%" height="100%" preserveAspectRatio="xMidYMid slice"/>

        </svg>
    </div>
    <div class="services" id="services">
        <h1 class="heading"> our <span>services</span></h1>
        <div class="box-container">
            <div class="box">
                <h2>Smarter studying</h2>
                <p>Work smarter, not harder. Our innovative productivity tools help you do just that, ensuring that you are working at maximum efficiency for maximum result.</p>
                <a href="#" class="btn">learn more</a>
            </div>
            <div class="box">
                <h2>Better organization</h2>
                <p>ZenOraFocus seamlessly manages your classes, exams, term dates, and extra-curricular activities – because school schedules need more than just a calendar..</p>
                <a href="#" class="btn">learn more</a>
            </div>
            <div class="box">
                <h2>Enhanced productivity</h2>
                <p>pomodoro ur personal acadamic assitant to handle all tasks and set reminders.</p>
                <a href="#" class="btn">learn more</a>
            </div>
        </div>
    </div>
    <div style="align-items: center;display: flex;justify-content: center;">
        <p class="p-5 text-center font-weight-bold" style="width: 800px; color: white;" >Manage your study life and start each day with the confidence that nothing important will be forgotten, so that you can stay focused and get more done.</p>
    </div>
    <div style="align-items: center;display: flex;justify-content: center;">
        <img src="webinterface.png" class="img-fluid hero-img">
    </div>
    <div style="align-items: center;display: flex;justify-content: center;">
        <p class="p-3 text-center font-weight-bold" style="width: 800px; color: white;" >Unlock a world of academic success with ZenOraFocus planner . Say goodbye to chaos and hello to streamlined brilliance.</p>
    </div>
      </div>
    <div style="align-items: center;display: flex;justify-content: center;">
        <img src="tabletview.png" class="img-fluid hero-img">
    </div>
    <div style="align-items: center;display: flex;justify-content: center;">
<p class="p-3 text-center" style="width: 800px; color: white; font-size: x-large; font-weight: bold;">“Featuring a clean interface, ZenOraFocus offers a comprehensive palette of schedules, timetables and personalized notifications that sync across multiple devices.”</p>
    </div>
    <section >
    <div class="container-fluid">

        <div class="row align-items-center">

            <!-- 2 phones -->
            <div class="col-md-6 text-center mb-4">
                <img src="twophones.png" class="img-fluid mobile-img2">

                <h4 class="text-white mt-4">Available offline</h4>
<br>
                <p class="text-white mx-auto" style="max-width:500px;">
                   Stay organized with our app, accessible both online and offline. Manage your class schedule, assignment deadlines, and activities anytime, anywhere. With real-time updates and interactive features, you’ll always be on top of your tasks.
                </p>
            </div>

            <!-- 1 phone -->
            <div class="col-md-6 text-center mb-4">
                <img src="onephone.png" class="img-fluid mobile-img1">

                <h4 class="text-white mt-4">Task History Tracking</h4>
<br>
                <p class="text-white mx-auto" style="max-width:500px;">
                    Monitor your productivity with detailed task history that allows you to analyze progress, identify patterns, and continuously improve your study workflow.
                </p>
            </div>

        </div>

    </div>
</section>

    <footer>
        <p>&copy; 2025 ZenOraFocus. All rights reserved</p>
    </footer>
</body>
</html>