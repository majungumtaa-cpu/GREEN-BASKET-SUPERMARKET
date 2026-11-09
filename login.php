<?php
require_once __DIR__ . '/config.php';

$error = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = trim($_POST['email'] ?? '');
    $password = $_POST['password'] ?? '';

    if ($email === '' || $password === '') {
        $error = 'Tafadhali jaza barua pepe na nenosiri.';
    } else {
        $st = $pdo->prepare('SELECT * FROM users WHERE email = ? LIMIT 1');
        $st->execute([$email]);
        $u = $st->fetch();

        if ($u && password_verify($password, $u['password'])) {
            session_regenerate_id(true);
            $_SESSION['user_id'] = $u['id'];
            $_SESSION['user_name'] = $u['name'] ?? 'Mteja';
            $_SESSION['user_email'] = $u['email'];
            header('Location: index.php');
            exit;
        }

        $error = 'Barua pepe au nenosiri si sahihi.';
    }
}
?>
<!doctype html>
<html lang="sw">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Ingia | GreenBasket Supermarket</title>
<style>
*{box-sizing:border-box;margin:0;padding:0}
html,body{min-height:100%;font-family:Arial,Helvetica,sans-serif}
body{
  min-height:100vh;
  display:flex;
  align-items:center;
  justify-content:center;
  padding:24px;
  color:#fff;
  background:
    linear-gradient(135deg,rgba(2,35,12,.45),rgba(7,55,21,.30)),
    url('assets/login-bg.jpg') center center/cover fixed no-repeat;
  overflow:auto;
}
.login-overlay{position:fixed;inset:0;background:rgba(0,20,8,.12);pointer-events:none}
.login-card{
  position:relative;z-index:1;
  width:min(455px,100%);
  padding:38px 36px 30px;
  border:1.5px solid rgba(255,255,255,.72);
  border-radius:28px;
  background:rgba(18,35,27,.43);
  box-shadow:0 25px 70px rgba(0,0,0,.35),inset 0 1px 0 rgba(255,255,255,.20);
  backdrop-filter:blur(18px);
  -webkit-backdrop-filter:blur(18px);
}
.brand{text-align:center;margin-bottom:24px}
.brand-mark{
  width:58px;height:58px;margin:0 auto 10px;border-radius:18px;
  display:grid;place-items:center;font-size:28px;
  background:linear-gradient(135deg,#bce52a,#20bd68);
  box-shadow:0 12px 30px rgba(87,205,53,.25)
}
.brand h1{font-size:28px;letter-spacing:-.5px}.brand h1 i{font-style:normal;color:#b8df2b}.brand p{font-size:11px;opacity:.82;margin-top:3px}
h2{font-size:31px;margin-bottom:6px}.intro{font-size:15px;opacity:.88;margin-bottom:24px}
.notice{margin-bottom:16px;padding:12px 14px;border-radius:12px;background:rgba(194,37,37,.22);border:1px solid rgba(255,170,170,.45);font-size:13px}
.field{margin-bottom:16px}.field label{display:block;font-size:13px;font-weight:700;margin:0 0 7px 3px}
.input{width:100%;height:56px;padding:0 17px;border:1px solid rgba(255,255,255,.52);border-radius:16px;background:rgba(255,255,255,.08);color:#fff;outline:none;font-size:15px}
.input::placeholder{color:rgba(255,255,255,.70)}.input:focus{border-color:#b9e62b;box-shadow:0 0 0 3px rgba(185,230,43,.13)}
.password-wrap{position:relative}.password-wrap .input{padding-right:52px}.show{position:absolute;right:14px;top:50%;transform:translateY(-50%);border:0;background:none;color:#fff;cursor:pointer;font-size:18px;opacity:.82}
.options{display:flex;justify-content:space-between;align-items:center;gap:10px;margin:3px 2px 21px;font-size:13px}.remember{display:flex;align-items:center;gap:8px}.remember input{width:17px;height:17px;accent-color:#7bd038}
a{color:#fff}.forgot{opacity:.9}.forgot:hover,.signup a:hover{text-decoration:underline}
.submit{width:100%;height:57px;border:0;border-radius:16px;background:linear-gradient(100deg,#c2e923,#22be6b);color:#fff;font-size:18px;font-weight:800;cursor:pointer;box-shadow:0 12px 28px rgba(30,188,101,.24)}
.submit:hover{filter:brightness(1.06)}
.signup{text-align:center;margin-top:19px;font-size:14px}.signup a{color:#d8f76d;font-weight:800;text-decoration:none}
.credit{text-align:center;margin-top:25px;font-size:11px;opacity:.65}
@media(max-width:520px){body{padding:15px}.login-card{padding:30px 22px 24px;border-radius:24px}h2{font-size:27px}}
</style>
</head>
<body>
<div class="login-overlay"></div>

<section class="login-card" aria-label="Fomu ya kuingia GreenBasket">
  <div class="brand">
    <div class="brand-mark">🛒</div>
    <h1><i>Green</i>Basket</h1>
    <p>Fresh kutoka Shambani • Supermarket</p>
  </div>

  <h2>Ingia</h2>
  <p class="intro">Karibu tena GreenBasket.</p>

  <?php if ($error): ?>
    <div class="notice"><?= h($error) ?></div>
  <?php endif; ?>

  <form method="post" autocomplete="on">
    <div class="field">
      <label for="email">Barua pepe</label>
      <input class="input" id="email" type="email" name="email" placeholder="Weka barua pepe yako" required autocomplete="username">
    </div>

    <div class="field">
      <label for="password">Nenosiri</label>
      <div class="password-wrap">
        <input class="input" id="password" type="password" name="password" placeholder="Weka nenosiri lako" required autocomplete="current-password">
        <button class="show" type="button" onclick="togglePassword()" aria-label="Onyesha nenosiri">◉</button>
      </div>
    </div>

    <div class="options">
      <label class="remember"><input type="checkbox" name="remember"> <span>Nikumbuke</span></label>
      <a class="forgot" href="forgot-password.php">Umesahau nenosiri?</a>
    </div>

    <button class="submit" type="submit">Ingia</button>
  </form>

  <p class="signup">Huna akaunti? <a href="signup.php">Jisajili</a></p>
  <p class="credit">© <?= date('Y') ?> GreenBasket Supermarket</p>
</section>

<script>
function togglePassword(){
  const input=document.getElementById('password');
  input.type=input.type==='password'?'text':'password';
}
</script>
</body>
</html>
