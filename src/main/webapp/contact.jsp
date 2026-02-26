<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>ZenOraFocus | Contact Us</title>
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet" />
</head>
<style>

body {
    background-color: #003652;
}
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: poppins;
}

header{
    background-color: black;
}
.navbar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px;
    background-color:#13212A;
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

.container {
    max-width: 800px;
    margin: 50px auto;
    background: #ffffff;
    padding: 30px;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
}

.container h1 {
    text-align: center;
    margin-bottom: 24px;
    color: #333;
}

.form-group {
    margin-bottom: 18px;
}

label {
    display: block;
    margin-bottom: 6px;
    color: #555;
    font-weight: 600;
}

input, textarea, select {
    width: 100%;
    padding: 12px;
    border: 1px solid #ddd;
    border-radius: 8px;
    font-size: 16px;
}

textarea {
    resize: vertical;
    min-height: 100px;
}

button {
    background-color: #3b82f6;
    color: white;
    padding: 14px 24px;
    border: none;
    border-radius: 8px;
    font-size: 16px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

button:hover {
    background-color: #2563eb;
}

.contact-info {
    margin-top: 30px;
    text-align: center;
    font-size: 14px;
    color: #666;
}

.social-icons {
    margin-top: 10px;
}

.social-icons a {
    margin: 0 8px;
    text-decoration: none;
    color: #3b82f6;
    font-weight: bold;
}

@media (max-width: 600px) {
    button {
        width: 100%;
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
            <a href="register.jsp">Register</a>
            <a href="aboutus.jsp">About Us</a>
            <a href="contact.jsp">Contact Us</a>
        </div>
    </div>
  </header>
  <div class="container">
    <h1>Contact Us</h1>
<form id="contactForm" method="post" action="ContactServlet">

  <div class="form-group">
    <label for="name">Your Name</label>
    <input type="text" id="name" name="name" required />
  </div>

  <div class="form-group">
    <label for="email">Email Address</label>
    <input type="email" id="email" name="email" required />
  </div>

  <div class="form-group">
    <label for="subject">Subject</label>
    <select id="subject" name="subject">
      <option>Select Subject</option>
      <option>General Inquiry</option>
      <option>Bug Report</option>
      <option>Feature Request</option>
      <option>Account Help</option>
    </select>
  </div>

  <div class="form-group">
    <label for="message">Message </label>
    <textarea id="message" name="message" required></textarea>
  </div>

  <button type="submit">Send Message</button>
</form>


    <div class="contact-info">
      <p>Email us at: <strong>support@zenorafocus.com</strong></p>
      <p>We usually reply within 24 hours.</p>
      <div class="social-icons">
        <a href="#">Instagram</a>
        <a href="#">Twitter</a>
        <a href="#">LinkedIn</a>
      </div>
    </div>
  </div>
</body>
</html>