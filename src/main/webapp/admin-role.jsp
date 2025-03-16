<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
    <!--[if lt IE 9]>
    <script type="text/javascript" src="lib/html5shiv.js"></script>
    <script type="text/javascript" src="lib/respond.min.js"></script>
    <![endif]-->
    <link rel="stylesheet" type="text/css" href="static/h-ui/css/H-ui.css"/>
    <link rel="stylesheet" type="text/css" href="static/h-ui.admin/css/H-ui.admin.css"/>
    <link rel="stylesheet" type="text/css" href="lib/Hui-iconfont/1.0.8/iconfont.css"/>
    <link rel="stylesheet" type="text/css" href="static/h-ui.admin/skin/default/skin.css" id="skin"/>
    <link rel="stylesheet" type="text/css" href="static/h-ui.admin/css/style.css"/>
    <!--[if IE 6]>
    <script type="text/javascript" src="lib/DD_belatedPNG_0.0.8a-min.js"></script>
    <script>DD_belatedPNG.fix('*');</script>
    <![endif]-->
    <title>角色管理</title>
</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 管理员管理 <span
        class="c-gray en">&gt;</span> 角色管理 <a class="btn btn-success radius r"
                                                  style="line-height:1.6em;margin-top:3px"
                                                  href="javascript:location.replace(location.href);" title="刷新"><i
        class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="page-container">
    <div class="cl pd-5 bg-1 bk-gray"><span class="l">  <a class="btn btn-primary radius" href="javascript:;"
                          onclick="admin_role_add('添加角色','admin-role-add.jsp','300','300')"><i
            class="Hui-iconfont">&#xe600;</i> 添加角色</a> </span> <span
            class="r">共有数据：<strong>54</strong> 条</span></div>
    <table class="table table-border table-bordered table-hover table-bg" id="roleTable">
        <thead>
        <tr class="text-c"><th width="40" onclick="toggleSort('id')">ID</th><th width="200">角色名</th><th width="300">描述</th><th width="300">创建时间</th><th width="70">操作</th></tr>

        </thead>
        <tbody id="tbody">
        </tbody>
    </table>
    <div id="page-btn">
        <%--<span style="margin-right: 50px">
            第1页/共2页(20条记录)
        </span>

        <span>
            <a onclick="pageList(1)">首页</a>
            <a>上一页</a>
            <a>1</a>
            <a>2</a>
            <a>下一页</a>
            <a>尾页</a>
        </span>--%>
    </div>
    <style>
        #page-btn {
            margin-top: 10px;
            color: #666;
            font-size: 14px;
            display: flex;
            justify-content: start;
        }

        #page-btn a, #page-btn span {
            color: #666;
            font-size: 14px
        }
        .change-page{
            color: #666;
            margin: 0 5px;
            text-decoration: underline;
        }
        .change-page.is-select{
            color: #0a6999 !important;
            font-weight: bold;
            text-decoration: none;
        }
    </style>
</div>
<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="static/h-ui/js/H-ui.min.js"></script>
<script type="text/javascript" src="static/h-ui.admin/js/H-ui.admin.js"></script> <!--/_footer 作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="lib/datatables/1.10.15/jquery.dataTables.min.js"></script>
<script type="text/javascript">

    window.onload = function () {
        pageList(1)
    }
    let currentSortBy = 'id'; // 当前排序字段
    let currentSortOrder = 0; // 当前排序顺序，0 表示未排序，1 表示升序，-1 表示降序
    // 处理排序切换
    function toggleSort(column) {
        // 如果点击的是相同列，切换排序顺序
        if (column === currentSortBy) {
            currentSortOrder = currentSortOrder === 1 ? -1 : 1; // 切换排序方向
        } else {
            // 如果点击的是不同列，默认升序
            currentSortBy = column;
            currentSortOrder = 1;
        }
        pageList(1, 10, currentSortOrder);
    }
    function pageList(pageNo=1,pageSize=10,sortOrder=1){
        $.get("/info_system/roleServlet", {action: "list",pageNo:pageNo,pageSize:pageSize,searchInput:$("#searchInput").val(),sortOrder:sortOrder}, function (response) {
            $("#tbody").empty();

            for (let role of response.list) {
                let date = new Date(role.createdTime);
                let formattedDate = date.toLocaleString();
                let tr = '<tr class="text-c">'
                    + '<td>' + role.id + '</td>'
                    + '<td>' + role.roleName + '</td>'
                    + '<td>' + role.description + '</td>'
                    + '<td>' + formattedDate + '</td>'
                    + '<td class="td-manage">'
                    + '<a title="编辑" href="javascript:;" onclick="admin_role_edit(\'角色编辑\',\'admin-role-add.jsp?id=' + role.id + '\',' + role.id + ',500,250)" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a>'
                    + '<a title="删除" href="javascript:;" onclick="admin_role_del(this,' + role.id + ')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a>'
                    + '</td>'
                    + '</tr>';

                $("#tbody").append(tr);
            }


            {
                var pages="";
                for(var i=0;i<response.totalPage;i++){
                    if(i+1===pageNo){
                        pages+=`<a class="change-page is-select" >`+(i+1)+`</a>`
                    }else{
                        pages+=`<a class="change-page" onclick="pageList(`+(i+1)+`)">`+(i+1)+`</a>`
                    }
                }
                $("#page-btn").html(`
<span style="margin-right: 50px">
            第`+response.pageNo+`页/共`+response.totalPage+`页(`+response.totalRow+`条记录)
        </span>

        <span>
            <a onclick="pageList(1)" style="display: `+(response.pageNo<=1?'none':'inline-block')+`">首页</a>
            <a onclick="pageList(`+(response.pageNo-1)+`)" style="display: `+(response.pageNo<=1?'none':'inline-block')+`">上一页</a>
            `+pages+`
            <a onclick="pageList(`+(response.pageNo+1)+`)" style="display: `+(response.pageNo>=response.totalPage?'none':'inline-block')+`">下一页</a>
            <a onclick="pageList(`+response.totalPage+`)" style="display: `+(response.pageNo>=response.totalPage?'none':'inline-block')+`">尾页</a>
            <input style="width: 50px;margin-left: 20px" value="`+response.pageNo+`" id="changePage"><input type="button" value="确定" style=";white: 40px" onclick="changePage(`+response.totalPage+`)"/>
        </span>
`)


            }

        });
    }
    function changePage(that){
        console.log(that)
        var v=$("#changePage").val();
        if(!v){
            alert("请输入数字")
        }else if(isNaN(Number(v))) {
            alert("请输入数字")
        }else{
            if(v>that){
                alert("输入的页码大于实际页码");
                return;
            }
            pageList(v)
        }


    }
    /*管理员-角色-添加*/
    function admin_role_add(title, url, w, h) {
        layer_show(title, url, w, h);
    }

    /*管理员-角色-编辑*/
    function admin_role_edit(title, url, id, w, h) {
        layer_show(title, url, w, h);
    }

    /*管理员-角色-删除*/
    function admin_role_del(obj, id) {
        layer.confirm('角色删除须谨慎，确认要删除吗？', function (index) {
            $.ajax({
                type: 'get',
                url: '/info_system/roleServlet?action=delete&id=' + id,
                success: function (data) {
                    $(obj).parents("tr").remove();
                    layer.msg('已删除!', {icon: 1, time: 1000});
                },
                error: function (data) {
                    console.log(data.msg);
                },
            });
        });
    }
</script>
</body>
</html>