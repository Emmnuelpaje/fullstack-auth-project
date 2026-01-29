<?php
require "../config/database.php";

if ($_SERVER["REQUEST_METHOD"] === "POST") {
  if ($_POST["captcha"] != $_SESSION["captcha"]) {
    $error = "Wrong captcha";
  } elseif ($_POST["password"] !== $_POST["password2"]) {
    $error = "Passwords do not match";
  } else {
    $username = $_POST["username"];
    $pass = password_hash($_POST["password"], PASSWORD_DEFAULT);
    $q = $_POST["question"];
    $a = password_hash($_POST["answer"], PASSWORD_DEFAULT);

    $stmt = $conn->prepare("INSERT INTO users (username,password_hash,security_question,security_answer_hash) VALUES (?,?,?,?)");
    $stmt->bind_param("ssss", $username, $pass, $q, $a);
    $stmt->execute();

    header("Location: login.php");
    exit;
  }
}

$_SESSION["captcha"] = rand(1000,9999);
?>
<link rel="stylesheet" href="../assets/css/style.css">

<div class="auth-box">
<h2>Register</h2>

<?php if (!empty($error)) echo "<div class='error'>$error</div>"; ?>

<form method="post">
  <input name="username" placeholder="Username" required>
  <input type="password" name="password" placeholder="Password" required>
  <input type="password" name="password2" placeholder="Re-enter Password" required>

  <select name="question">
    <option>What is your dog's name?</option>
    <option>What city were you born in?</option>
    <option>What is your favorite food?</option>
  </select>

  <input name="answer" placeholder="Answer" required>

  <p>Captcha: <b><?= $_SESSION["captcha"] ?></b></p>
  <input name="captcha" required>

  <button>Create Account</button>
</form>

<a href="login.php">Back to login</a>
</div>
