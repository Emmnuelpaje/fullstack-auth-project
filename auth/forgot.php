<?php
require "../config/database.php";

if ($_SERVER["REQUEST_METHOD"] === "POST") {
  $stmt = $conn->prepare("SELECT * FROM users WHERE username=?");
  $stmt->bind_param("s", $_POST["username"]);
  $stmt->execute();
  $user = $stmt->get_result()->fetch_assoc();

  if ($user && password_verify($_POST["answer"], $user["security_answer_hash"])) {
    $_SESSION["reset_user"] = $user["username"];
    header("Location: reset.php");
    exit;
  } else {
    $error = "Wrong answer";
  }
}
?>
<link rel="stylesheet" href="../assets/css/style.css">

<div class="auth-box">
<h2>Reset Password</h2>

<?php if (!empty($error)) echo "<div class='error'>$error</div>"; ?>

<form method="post">
  <input name="username" placeholder="Username" required>

  <select name="question">
    <option>What is your dog's name?</option>
    <option>What city were you born in?</option>
    <option>What is your favorite food?</option>
  </select>

  <input name="answer" placeholder="Answer" required>
  <button>Verify</button>
</form>

<a href="login.php">Back to login</a>
</div>