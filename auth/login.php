<?php
require "../config/database.php";

if ($_SERVER["REQUEST_METHOD"] === "POST") {
  $stmt = $conn->prepare("SELECT * FROM users WHERE username=?");
  $stmt->bind_param("s", $_POST["username"]);
  $stmt->execute();
  $user = $stmt->get_result()->fetch_assoc();

  if ($user && password_verify($_POST["password"], $user["password_hash"])) {
    $_SESSION["user"] = $user["username"];
    header("Location: ../dashboard/index.php");
    exit;
  } else {
    $error = "Invalid login";
  }
}
?>
<link rel="stylesheet" href="../assets/css/style.css">

<div class="auth-box">
<h2>Login</h2>

<?php if (!empty($error)) echo "<div class='error'>$error</div>"; ?>

<form method="post">
  <input name="username" placeholder="Username" required>
  <input type="password" name="password" placeholder="Password" required>
  <button>Login</button>
</form>

<a href="register.php">Create account</a>
<a href="forgot.php">Forgot password?</a>
</div>
