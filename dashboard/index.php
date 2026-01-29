<?php
session_start();
if (!isset($_SESSION["user_id"])) {
    header("Location: ../auth/login.php");
    exit;
}
?>

<!DOCTYPE html>
<html>
<head>
<title>Dashboard</title>
<link rel="stylesheet" href="../assets/css/style.css">
</head>
<body class="auth-bg">

<div class="auth-box">
<h2>Dashboard</h2>

<p>Welcome! You are logged in.</p>

<a href="users.php">View Users</a><br><br>
<a href="../auth/logout.php">Logout</a>
</div>

</body>
</html>
