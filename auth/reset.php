<?php
require "../config/database.php";

if (!isset($_SESSION["reset_user"])) {
  header("Location: login.php");
  exit;
}

if ($_SERVER["REQUEST_METHOD"] === "POST") {
  $pass = password_hash($_POST["password"], PASSWORD_DEFAULT);
  $stmt = $conn->prepare("UPDATE users SET password_hash=? WHERE username=?");
  $stmt->bind_param("ss", $pass, $_SESSION["reset_user"]);
  $stmt->execute();

  unset($_SESSION["reset_user"]);
  header("Location: login.php");
  exit;
}
?>
<link rel="stylesheet" href="../assets/css/style.css">

<div class="auth-box">
<h2>New Password</h2>

<form method="post">
  <input type="password" name="password" placeholder="New password" required>
  <button>Reset</button>
</form>
</div>
