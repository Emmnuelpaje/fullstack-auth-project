<?php
$conn = new mysqli("localhost", "root", "", "auth_db");
if ($conn->connect_error) die("DB ERROR");
session_start();
