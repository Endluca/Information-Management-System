<%@ page language="java" pageEncoding="UTF-8" %>
<!DOCTYPE HTML>
<html>
<head>
  <meta charset="utf-8">
  <meta name="renderer" content="webkit|ie-comp|ie-stand">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
  <!--[if lt IE 9]>
  <script type="text/javascript" src="lib/html5shiv.js"></script>
  <script type="text/javascript" src="lib/respond.min.js"></script>
  <![endif]-->
  <link rel="stylesheet" type="text/css" href="static/h-ui/css/H-ui.css" />
  <link rel="stylesheet" type="text/css" href="static/h-ui.admin/css/H-ui.admin.css" />
  <link rel="stylesheet" type="text/css" href="lib/Hui-iconfont/1.0.8/iconfont.css" />
  <link rel="stylesheet" type="text/css" href="static/h-ui.admin/skin/default/skin.css" id="skin" />
  <link rel="stylesheet" type="text/css" href="static/h-ui.admin/css/style.css" />
  <!--[if IE 6]>
  <script type="text/javascript" src="lib/DD_belatedPNG_0.0.8a-min.js" ></script>
  <script>DD_belatedPNG.fix('*');</script>
  <![endif]-->
  <title>添加品牌 - 品牌管理 - H-ui.admin v3.1</title>
  <meta name="keywords" content="H-ui.admin v3.1,H-ui网站后台模版,后台模版下载,后台管理系统模版,HTML后台模版下载">
  <meta name="description" content="H-ui.admin v3.1，是一款由国人开发的轻量级扁平化网站后台模板，完全免费开源的网站后台管理系统模版，适合中小型CMS后台系统。">
</head>
<body>
<article class="page-container">
  <form class="form form-horizontal" id="form-brand-add">
    <input name="id" id="id" style="display: none">
    <div class="row cl">
      <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>排序</label>
      <div class="formControls col-xs-8 col-sm-9">
        <input type="text" class="input-text" value="" placeholder="" id="sort" name="sort">
      </div>
    </div>
    <div class="row cl">
      <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>品牌名称</label>
      <div class="formControls col-xs-8 col-sm-9">
        <input type="text" class="input-text" value="" placeholder="" id="brand_name" name="brand_name">
      </div>
    </div>
    <div class="row cl">
      <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>具体描述</label>
      <div class="formControls col-xs-8 col-sm-9">
        <input type="text" class="input-text" placeholder="" name="description" id="description">
      </div>
    </div>
    <div class="row cl">
      <div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-3">
        <input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
      </div>
    </div>
  </form>
</article>

<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="static/h-ui/js/H-ui.min.js"></script>
<script type="text/javascript" src="static/h-ui.admin/js/H-ui.admin.js"></script> <!--/_footer 作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="lib/jquery.validation/1.14.0/jquery.validate.js"></script>
<script type="text/javascript" src="lib/jquery.validation/1.14.0/validate-methods.js"></script>
<script type="text/javascript" src="lib/jquery.validation/1.14.0/messages_zh.js"></script>
<script type="text/javascript">
  var url = window.location.href; // 获取当前URL
  var id = url.split('id=')[1];
  window.onload = function (){
    if (id){
      $.ajax({
        type: "GET",
        url: "/info_system/BrandDAO",  // 替换为实际的请求 URL
        data: { id: id, action: "getById" },
        success: function (response) {
          $("#id").val(response.id);
          $("#sort").val(response.sort);
          $("#brandName").val(response.brandName);
          $("#description").val(response.description);
        },
        error: function (xhr, status, error) {
          console.error(error);
        }
      });
    }


  }


  $(function(){
    $('.skin-minimal input').iCheck({
      checkboxClass: 'icheckbox-blue',
      radioClass: 'iradio-blue',
      increaseArea: '20%'
    });

    $("#form-admin-add").validate({
      rules:{
        sort:{
          required:true,
          minlength:1,
          maxlength:16
        },
        brandName:{
          required:true,
        },
        description:{
          required:true,
        },
      },
      onkeyup:false,
      focusCleanup:true,
      success:"valid",
      submitHandler:function(form){
        $(form).ajaxSubmit({
          type: 'post',
          url: "/info_system/BrandDAO" ,
          success: function(data){
            if (id){
              alert("修改成功！")
            }else{
              alert("添加成功！")
            }
            layer.msg('添加成功!',{icon:1,time:1000});
            var index = parent.layer.getFrameIndex(window.name);
            parent.$('.btn-refresh').click();
            parent.layer.close(index);
          },
          error: function(XmlHttpRequest, textStatus, errorThrown){
            layer.msg('error!',{icon:1,time:1000});
            alert("添加失败，请稍候重试！");
          }
        });
      }
    });
  });
</script>
<!--/请在上方写此页面业务相关的脚本-->
</body>
</html>