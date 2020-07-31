<?php
if( is_file('api/config.php') ){
	include 'api/config.php';
	if(isset($qudao)  ){
		header("location:index.php");
	}
	
} 
if($_POST){
	$appcode = isset($_POST['appcode'])?trim($_POST['appcode']):'';
	$token = isset($_POST['token'])?trim($_POST['token']):'';
	$str_tmp="<?php\r\n"; //得到php的起始符。$str_tmp将累加 
$str_end="?>"; //php结束符 
$str_tmp.="$"."qudao='".$_POST['qudao']."';\r\n"; //加入用户名 
$str_tmp.="$"."appcode='".$appcode."';\r\n"; //加入用户名 
$str_tmp.="$"."token='".$token."';\r\n"; //加入用户名 
 
$str_tmp.=$str_end; //加入结束符 

//保存文件 
$sf="api/config.php"; //文件名 
$fp=fopen($sf,"w"); //写方式打开文件 
fwrite($fp,$str_tmp); //存入内容 
fclose($fp); //关闭文件 
	
}
?>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="utf-8" />
<title>财经日历安装</title>
<script src='style/js/jquery-1.11.1.min.js'></script>
</head>
<div style='margin:0 auto;text-align:center;padding-top:10%'>
<form action='' method='post' id="form1">
	<h1>欢迎安装财经日历</h1>
	<p>环境要求：php5.3以上版本，全目录可写，根目录安装</p>
		选择购买渠道 <input type=radio name=qudao value=1 onclick='aliyun()'> 阿里云 <input type=radio name=qudao value=2 onclick='api51()'> Api51
<br/><br/>
购买入口：阿里云：<a href='https://market.aliyun.com/products/57000002/cmapi021714.html' target='_blank'>点此</a> API51:<a href='http://data.api51.cn' target='_blank'>点此</a>
<br/><br/>
</form>
</div>
<script>
function aliyun(){
	 $('#form1 div').hide();
	$('#form1').append('<div>输入Appcode<input type=text name=appcode id=appcode /><a href="https://www.kancloud.cn/wangjikeji/wangjiapi/352770" target="_blank">如何获取？</a><br/><input type=submit></div>');
	
}
function api51(){
	 $('#form1 div').hide();
	$('#form1').append('<div>输入Token<input type=text name=token id=token /><a href="http://data.api51.cn/user.php" target="_blank">如何获取？</a><br/><input type=submit></div>');
	
}


</script>