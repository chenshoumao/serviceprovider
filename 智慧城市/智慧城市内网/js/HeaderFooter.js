// 头部header
function Header(){
	var strVar = "";
    strVar += "<div class=\"header_top\">";
    strVar += "	<div id='date'><script>getdates();<\/script><\/div>";
    strVar += "	<div class=\"loginbar\">";
    strVar += "		<span>宋小福，欢迎你<\/span>|<a>注销<\/a>";
    strVar += "	<\/div> ";
    strVar += "<\/div>";
   	var headerId = document.getElementById('header');
    headerId.innerHTML = strVar;
}


// banner
function Banner(){
    var strVar = "";
    strVar += "<div class=\"slider\">";
    strVar += " <div class=\"callbacks_container\">";
    strVar += "     <ul class=\"rslides\" id=\"slider\">";
    strVar += "          <li><img src=\"./images/slider1.jpg\" class=\"img-responsive\" alt=\"\"/><\/li>";
    strVar += "          <li><img src=\"./images/slider2.jpg\" class=\"img-responsive\" alt=\"\"/><\/li>";
    strVar += "          <li><img src=\"./images/slider3.jpg\" class=\"img-responsive\" alt=\"\"/><\/li>";
    strVar += "     <\/ul>";
    strVar += " <\/div>  ";
    strVar += "<\/div>";
    var BannerId = document.getElementById('banner');
    BannerId.innerHTML = strVar;
}


// nav
function Nav(){
    var strVar = "";
    strVar += "<ul>";
    strVar += " <a href=\"#\"><li class=\"NavSelect\">网站首页<\/li><\/a>";
    strVar += " <a href=\"#\"><li>个人空间<\/li><\/a>";
    strVar += " <a href=\"#\"><li>信息中心<\/li><\/a>";
    strVar += " <a href=\"#\"><li>集团OA</li><\/li><\/a>";
    strVar += " <a href=\"#\"><li>集团HR</li><\/li><\/a>";
    strVar += "<\/ul>";
    var NavId = document.getElementById('nav');
    NavId.innerHTML = strVar;
}


// footer
function Footer(){
    var strVar = "";
    strVar += " <div class=\"footer_logo\"><img src=\"./images/logo3.png\"><\/div>";
    strVar += " <div class=\"footer_word\">";
        strVar += "<div class=\"footer_left\">";
            strVar += "     <span>2010版权所有：漳州招商局经济技术开发区<\/span><br>";
            strVar += "     <span>联系地址：福建漳州招商局经济技术开发区招商大厦<\/span><br>";
            strVar += "     <span>Tel：0596-6851001<\/span>";
            strVar += "     <span>Fax：0596-685130<\/span>";
        strVar += " <\/div>";
        strVar += "<div class=\"footer_right\">";
            strVar += "     <span>闽CP备05034220号<\/span>";
            strVar += "     <span><img src=\"./images/footer_word.png\"><\/span><br>";
            strVar += "     <span>邮箱：363122<\/span>";
            strVar += "     <span>Mail:xmwnwb@cmzd.com<\/span>";
        strVar += " <\/div>";
    strVar += " <\/div>";
    var FooterId = document.getElementById('footer');
    FooterId.innerHTML = strVar;
}


// 获取时间js
function getdates()
        {
            var w_array=new Array("星期天","星期一","星期二","星期三","星期四","星期五","星期六");
            var d=new Date();
            var year=d.getFullYear();
            var month=d.getMonth()+1;
            var day=d.getDate();
            var week=d.getDay();
            var h=d.getHours();
            var mins=d.getMinutes();
            var s=d.getSeconds();

            if(month<10) month="0" + month
            if(day<10) month="0" + day
            if(h<10) h="0" + h
            if(mins<10) mins="0" + mins
            if(s<10) s="0" + s

            var shows="北京时间： <span>" + year + "-" + month + "-" + day + " " + h + ":" + mins +  ":" + s + " " + w_array[week] + "</span>";
            document.getElementById("date").innerHTML=shows;
            setTimeout("getdates()",1000);
        }


// 加载执行头部,尾部,banner,导航条,尾部等函数
$(function(){
	Header(); getdates();Banner();Nav();Footer();
    // banner加载函数
    $("#slider").responsiveSlides({
        auto: true,
        nav: true,
        speed: 500,
        namespace: "callbacks",
        pager: true,
      });
})
