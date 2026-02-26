<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>ZenOraFocus | Login/Register</title>
  <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet"/>
  <style>
  @import url('https://fonts.googleapis.com/css2?family=Segoe+UI:wght@400;600&display=swap');

* {
  box-sizing: border-box;
}

body {
  font-family: 'Segoe UI', sans-serif;
  /* Changed background gradient to light blue shades */
  background: linear-gradient(to right, #a3cef1, #7fb3d5);
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  margin: 0;
}

.container {
  background: #f8f9fa;
  border-radius: 20px;
  box-shadow: 0 10px 30px rgba(0,0,0,0.3);
  width: 900px;
  max-width: 100%;
  min-height: 600px;
  position: relative;
  overflow: hidden;
}

.form-container {
  position: absolute;
  top: 0;
  height: 100%;
  transition: all 0.6s ease-in-out;
}

.sign-in-container {
  left: 0;
  width: 50%;
  z-index: 2;
}

.sign-up-container {
  left: 0;
  width: 50%;
  opacity: 0;
  z-index: 1;
}

.container.right-panel-active .sign-in-container {
  transform: translateX(100%);
}

.container.right-panel-active .sign-up-container {
  transform: translateX(100%);
  opacity: 1;
  z-index: 5;
}

form {
  background: #f8f9fa;
  display: flex;
  flex-direction: column;
  padding: 0 50px;
  height: 100%;
  justify-content: center;
  text-align: center;
}

form h1 {
  color: #1d3557;
}

input {
  background: #ffffff;
  border: 1px solid #ced4da;
  padding: 12px 15px;
  margin: 10px 0;
  width: 100%;
  border-radius: 8px;
  font-size: 14px;
}

input:focus {
  outline: none;
  border-color: #457b9d;
}

button {
  border-radius: 8px;
  border: none;
  padding: 12px 45px;
  background-color: #1d3557;
  color: #fff;
  font-size: 14px;
  font-weight: bold;
  margin: 15px 0;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

button:hover {
  background-color: #16324f;
}

.ghost {
  background-color: transparent;
  border: 2px solid #fff;
}

a {
  font-size: 14px;
  color: #457b9d;
  text-decoration: none;
  margin-top: 10px;
}

a:hover {
  text-decoration: underline;
}

.overlay-container {
  position: absolute;
  top: 0;
  left: 50%;
  width: 50%;
  height: 100%;
  overflow: hidden;
  transition: transform 0.6s ease-in-out;
  z-index: 100;
}

.container.right-panel-active .overlay-container {
  transform: translateX(-100%);
}

.overlay {
  background: linear-gradient(to right, #1d3557, #457b9d);
  color: #fff;
  position: relative;
  left: -100%;
  width: 200%;
  height: 100%;
  transform: translateX(0);
  transition: transform 0.6s ease-in-out;
}

.container.right-panel-active .overlay {
  transform: translateX(50%);
}

.overlay-panel {
  position: absolute;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  text-align: center;
  padding: 0 40px;
  height: 100%;
  width: 50%;
  top: 0;
}

.overlay-left {
  transform: translateX(-20%);
  left: 0;
}

.overlay-right {
  right: 0;
  transform: translateX(0);
}

.container.right-panel-active .overlay-left {
  transform: translateX(0);
}

.container.right-panel-active .overlay-right {
  transform: translateX(20%);
}

.overlay h1 {
  font-size: 28px;
}

.overlay p {
  font-size: 14px;
  max-width: 250px;
  line-height: 1.5;
  margin: 20px 0 30px;
}
  </style>
</head>
<body>
  <div class="container" id="container">
    <!-- Register Form -->
    <div class="form-container sign-up-container">
      <form action="RegServlet" method="post">
        <h1>Register</h1>
        <input type="text" name="username" placeholder="Username" required />
        <input type="email" name="email" placeholder="Email" required />
        <input type="password" name="password" placeholder="Password" required />
        <button type="submit">Sign Up</button>
        <a href="log.jsp" id="toLogin">Already have an account? Login</a>
      </form>
    </div>

    <!-- Login Form -->
    <div class="form-container sign-in-container">
      <form action="LogServlet" method="post">
        <h1>Login</h1>
        <input type="text" name="username" placeholder="Username" required />
        <input type="email" name="email" placeholder="Email" required />
        <input type="password" name="password" placeholder="Password" required />
        <button type="submit">Login</button>
        <a href="#">Forgot your password?</a>
      </form>
    </div>

    <!-- Overlay Panels -->
    <div class="overlay-container">
      <div class="overlay">
        <div class="overlay-panel overlay-left">
          <h1>Welcome Back!</h1>
          <p>To keep connected with us, please login with your personal info</p>
          <button class="ghost" id="signIn">Login</button>
        </div>
        <div class="overlay-panel overlay-right">
          <h1>Hello!</h1>
          <p>Don’t have an account? Register now and get started!</p>
          <button class="ghost" id="signUp" onclick="myFunction()">Sign Up</button>
        </div>
      </div>
    </div>
  </div>

  <%-- Feedback Messages --%>
  <%
    String status = request.getParameter("status");
    if ("success".equals(status)) {
  %>
    <p style="color: green; text-align:center; margin-top:10px;">Registration successful. Please log in.</p>
  <%
    } else if ("failed".equals(status)) {
  %>
    <p style="color: red; text-align:center; margin-top:10px;">Registration failed or user already exists.</p>
  <%
    } else if ("invalid".equals(status)) {
  %>
    <p style="color: red; text-align:center; margin-top:10px;">Invalid login credentials.</p>
  <%
    }
  %>
 <script>
 
 const container = document.getElementById('container');
 const signUpBtn = document.getElementById('signUp');
 const signInBtn = document.getElementById('signIn');

 signUpBtn.addEventListener('click', () => {
   container.classList.add("right-panel-active");
 });

 signInBtn.addEventListener('click', () => {
   container.classList.remove("right-panel-active");
 });
 
 </script>
</body>
</html>