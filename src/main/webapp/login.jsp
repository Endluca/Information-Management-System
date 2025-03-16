<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>登录页面</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
        }

        .login-container {
            width: 350px;
            margin: 100px auto;
            padding: 30px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: #333;
            text-align: center;
        }

        label {
            display: block;
            margin-bottom: 10px;
            font-weight: bold;
        }

        input[type="text"],
        input[type="password"],
        input[type="text"]#captchaInput {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        input[type="submit"] {
            width: 100%;
            padding: 15px;
            background-color: #4CAF50;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }

        .error-message {
            color: red;
            font-size: 14px;
            text-align: center;
            margin-bottom: 20px;
        }

        .captcha-container {
            margin-bottom: 20px;
        }
    </style>
    <script>
        function generateCaptcha() {
            const captcha = Math.random().toString(36).substr(2, 6).toUpperCase();
            document.getElementById("captchaDisplay").innerText = captcha;
            document.getElementById("captchaHidden").value = captcha;
        }

        function validateForm() {
            const errorCount = parseInt(document.getElementById("errorCount").value, 10);
            if (errorCount >= 3) {
                const captchaInput = document.getElementById("captchaInput").value.trim();
                const captchaHidden = document.getElementById("captchaHidden").value.trim();
                if (captchaInput !== captchaHidden) {
                    alert("验证码输入错误！");
                    return false;
                }
            }
            return true;
        }

        document.addEventListener("DOMContentLoaded", () => {
            const errorCount = parseInt(document.getElementById("errorCount").value, 10);
            if (errorCount >= 3) {
                generateCaptcha();
            }
        });
    </script>
</head>

<body>
<div class="login-container">
    <h2>用户登录</h2>
    <c:if test="${not empty errorMessage}">
        <div class="error-message">${errorMessage}</div>
    </c:if>
    <form action="login" method="post" onsubmit="return validateForm();">
        <label for="username">用户名：</label>
        <input type="text" id="username" name="username" required>
        <label for="password">密码：</label>
        <input type="password" id="password" name="password" required>
        <c:if test="${errorCount >= 3}">
            <!-- 显示验证码输入框 -->
            <div class="captcha-container">
                <label for="captchaInput">验证码：</label>
                <span id="captchaDisplay"></span>
                <input type="text" id="captchaInput" name="captchaInput" required>
                <input type="hidden" id="captchaHidden" name="captchaHidden">
            </div>
        </c:if>

        <input type="hidden" id="errorCount" value="${errorCount != null ? errorCount : 0}">
        <input type="submit" value="登录">
    </form>
</div>
</body>

</html>
