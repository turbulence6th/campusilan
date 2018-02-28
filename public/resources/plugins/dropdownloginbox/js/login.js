// Login Form

$(function() {
    var button = $('#loginContainer #loginButton');
    var box = $('#loginContainer #loginBox');
    var form = $('#loginContainer #loginForm');
    button.removeAttr('href');
    button.mouseup(function(login) {
        box.toggle();
        button.toggleClass('active');
    });
    form.mouseup(function() { 
        return false;
    });
    $(this).mouseup(function(login) {
        if(!($(login.target).parent('#loginContainer #loginButton').length > 0)) {
            button.removeClass('active');
            box.hide();
        }
    });
});

$(function() {
    var button = $('#loginContainer2 #loginButton');
    var box = $('#loginContainer2 #loginBox');
    var form = $('#loginContainer2 #loginForm');
    button.removeAttr('href');
    button.mouseup(function(login) {
        box.toggle();
        button.toggleClass('active');
    });
    form.mouseup(function() { 
        return false;
    });
    $(this).mouseup(function(login) {
        if(!($(login.target).parent('#loginContainer2 #loginButton').length > 0)) {
            button.removeClass('active');
            box.hide();
        }
    });
});
