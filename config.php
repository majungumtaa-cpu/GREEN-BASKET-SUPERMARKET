<?php
session_start();
$pdo=new PDO("mysql:host=127.0.0.1;dbname=greenbasket;charset=utf8mb4","root","",[PDO::ATTR_ERRMODE=>PDO::ERRMODE_EXCEPTION,PDO::ATTR_DEFAULT_FETCH_MODE=>PDO::FETCH_ASSOC]);
function h($s){return htmlspecialchars((string)$s,ENT_QUOTES,'UTF-8');}
function cartCount(){return array_sum($_SESSION['cart']??[]);}
function money($n){return 'TSh '.number_format($n,0,'.',',');}
?>