function register() {
    // 从页面上获取用户输入的信息
    var username = document.getElementById('username').value;
    var password = document.getElementById('password').value;
    var confirmPassword = document.getElementById('confirm_password').value;
    var email = document.getElementById('email').value;
    var role = document.getElementById('role').value;

    if (password !== confirmPassword) {
        alert("两次输入的密码不相同，请重新输入！");
        return;
    }
    // 构造请求对象
    var xhr = new XMLHttpRequest();
    xhr.open("POST", "/register", true);
    xhr.setRequestHeader("Content-Type", "application/json;charset=utf-8");

    // 处理响应
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
            var response = JSON.parse(xhr.responseText);
            // 根据响应结果，更新页面
            if (response.success) {
                alert("注册成功！");
                window.location.href = "/login";
            }
            else {
                alert("注册失败：" + response.message);
            }
        }
    };

    // 发送请求
    xhr.send(JSON.stringify({ username: username, password: password, email: email, role: role }));
}
