<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>ZenOraFocus | About Us</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet"/>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
  <link rel="stylesheet" href="aboutus.css">
</head>
<style>

*{
    font-family: poppins;
}
body {
    margin: 0;
    font-family: 'Inter', sans-serif;
    background:  #4379a8;
    color: white;
  }
header{
  background-color: black;
}
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: poppins;
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
  .hero {
    background-color: #003652;
    text-align: center;
    padding: 80px 20px 60px;
  }

  .hero h1 {
    font-size: 36px;
    margin-bottom: 12px;
  }

  .hero p {
    font-size: 18px;
    opacity: 0.9;
  }

  .section {
    max-width: 1000px;
    margin: 0 auto;
    padding: 60px 20px;
  }

  .section h2 {
    font-size: 28px;
    margin-bottom: 12px;
  }

  .section p {
    font-size: 16px;
    color: white;
    line-height: 1.7;
  }

  .features {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
    gap: 24px;
    margin-top: 30px;
  }

  .feature-card {
    background: #8DCCCE;
    padding: 24px;
    border-radius: 12px;
    box-shadow: 0 4px 10px rgba(0,0,0,0.06);
    transition: transform 0.3s ease;
    text-align: center;
  }

  .feature-card:hover {
    transform: translateY(-6px);
  }

  .feature-card i {
    font-size: 32px;
    margin-bottom: 12px;
  }

  .team {
    display: flex;
    flex-wrap: wrap;
    gap: 24px;
    margin-top: 30px;
    justify-content: center;
  }

  .team-member {
    background: #8DCCCE;
    text-align: center;
    padding: 20px;
    border-radius: 12px;
    width: 220px;
    box-shadow: 0 4px 10px rgba(0,0,0,0.05);
  }

  .team-member h4 {
    margin-bottom: 4px;
    font-size: 18px;
  }

  .cta {
    background: #003652;
    text-align: center;
    padding: 60px 20px;
  }

  .cta h2 {
    margin-bottom: 16px;
    font-size: 28px;
  }

  .cta a {
    display: inline-block;
    margin-top: 12px;
    background: white;;
    padding: 12px 24px;
    border-radius: 8px;
    text-decoration: none;
    font-weight: bold;
    transition: background 0.3s ease;
    color:black;
  }

  .cta a:hover {
    background: #e0e7ff;
  }

  @media (max-width: 600px) {
    .hero h1 {
      font-size: 28px;
    }

    .cta h2 {
      font-size: 22px;
    }
  }

</style>
<body>
  <header>
    <div class="navbar">
        <h1 class="logo">ZenOraFocus</h1>
        <div>
          <a href="index.jsp">Home</a>
            <a href="log.jsp">Login</a>
            <a href="log.jsp">Register</a>
            <a href="aboutus.jsp">About Us</a>
            <a href="contact.jsp">Contact Us</a>
        </div>
    </div>
  </header>
  <section class="hero">
    <h1>About StudyPlanar 📚</h1>
    <p>Your smarter way to plan, study, and succeed.</p>
  </section>

  <section class="section">
    <h2>🚀 Our Mission</h2>
    <p>
      We empower students to take control of their academic journey. StudyPlanar is more than just a planner — it's a daily companion designed to make your goals achievable, your schedule stress-free, and your productivity feel effortless.
    </p>
  </section>

  <section class="section">
    <h2>✨ What Makes Us Different</h2>
    <div class="features">
      <div class="feature-card">
        <i class="fas fa-calendar-check"></i>
        <h4>Smart Planning</h4>
        <p>Organize tasks, classes, and deadlines in one clean dashboard.</p>
      </div>
      <div class="feature-card">
        <i class="fas fa-bolt"></i>
        <h4>Productivity Tools</h4>
        <p>Timers, streaks, reminders & motivation — built right in.</p>
      </div>
      <div class="feature-card">
        <i class="fas fa-heart"></i>
        <h4>For Students, By Students</h4>
        <p>We know what works — because we’ve lived it.</p>
      </div>
    </div>
  </section>

  <section class="section">
    <h2>👩‍💻 Meet the Team</h2>
    <div class="team">
      <div class="team-member">
        <h4>Kushmi Maddi</h4>
        <p>Founder & Product Designer</p>
      </div>
      <div class="team-member">
        <h4>Harshitha Gopali</h4>
        <p>Lead Developer</p>
      </div>
      <div class="team-member">
        <h4>Khushi Peram</h4>
        <p>Community Manager</p>
      </div>
    </div>
  </section>

  <section class="cta">
    <h2>Ready to plan your best semester yet?</h2>
    <a href="contact.jsp">Get in Touch</a>
  </section>

</body>
</html>