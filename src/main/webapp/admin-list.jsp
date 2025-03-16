<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE HTML>
<html>
<head>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
    <link rel="Bookmark" href="/favicon.ico">
    <link rel="Shortcut Icon" href="/favicon.ico"/>
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
    <title>管理员列表</title>
</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 管理员管理 <span
        class="c-gray en">&gt;</span> 管理员列表 <a class="btn btn-success radius r"
                                                    style="line-height:1.6em;margin-top:3px"
                                                    href="javascript:location.replace(location.href);" title="刷新"><i
        class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="page-container">
    <div class="text-c">
        <input type="text" class="input-text" style="width:250px" placeholder="输入管理员名称" id="searchInput">
        <button type="submit" onclick="pageList(1)" class="btn btn-success" id="search" name=""><i class="Hui-iconfont">&#xe665;</i>
            搜用户
        </button>
    </div>
    <div class="cl pd-5 bg-1 bk-gray mt-20">
        <span class="l">
            <a
                    href="javascript:;" onclick="admin_add('添加用户','admin-add.jsp','','250','250')"
                    class="btn btn-primary radius"><i class="Hui-iconfont">&#xe600;</i> 添加管理员</a></span>
    </div>
    <table class="table table-border table-bordered table-bg" id="adminTable">
        <thead>
        <tr class="text-c"><th width="40" id="sort-id" onclick="toggleSort('id')">ID</th><th width="150">用户名</th><th width="90">邮箱</th><th width="150">密码</th><th>角色</th><th width="130">加入时间</th><th width="100">操作</th></tr>

        </thead>
        <tbody id="tbody">

<%--        <tr class="text-c">--%>
<%--            <td>2</td>--%>
<%--            <td>zhangsan</td>--%>
<%--            <td>13000000000</td>--%>
<%--            <td>admin@mail.com</td>--%>
<%--            <td>超级管理员</td>--%>
<%--            <td>2014-6-11 11:11:42</td>--%>
<%--            <td class="td-manage">--%>
<%--                <a title="编辑" href="javascript:;" onclick="admin_edit('管理员编辑','admin-add.html','2','800','500')"--%>
<%--                   class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a>--%>
<%--                <a title="删除" href="javascript:;" onclick="admin_del(this,'1')" class="ml-5"--%>
<%--                   style="text-decoration:none">--%>
<%--                    <i class="Hui-iconfont">&#xe6e2;</i></a></td>--%>
<%--        </tr>--%>
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
<script type="text/javascript" src="lib/My97DatePicker/4.8/WdatePicker.js"></script>
<script type="text/javascript" src="lib/datatables/1.10.15/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="lib/laypage/1.2/laypage.js"></script>
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
        $.get("/info_system/adminServlet", {action: "list",pageNo:pageNo,pageSize:pageSize,searchInput:$("#searchInput").val(),sortOrder: sortOrder}, function (response) {
            $("#tbody").empty();
            if(response.list.length===0){
                alert("未查询到数据");
                return;
            }
            for (let admin of response.list) {
                let date = new Date(admin.createdTime);
                let formattedDate = date.toLocaleString();
                let tr = '<tr class="text-c">'
                    + '<td>' + admin.id + '</td>'
                    + '<td>' + admin.username + '</td>'
                    + '<td>' + admin.email + '</td>'
                    + '<td>' + admin.password + '</td>'
                    + '<td>'+'超级管理员' + '</td>'
                    + '<td>' + formattedDate + '</td>'
                    + '<td class="td-manage">'
                    + '<a title="编辑" href="javascript:;" onclick="admin_edit(\'管理员编辑\',\'admin-add.jsp?id=' + admin.id + '\',' + admin.id + ',500,250)" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a>'
                    // + '<a title="编辑" href="javascript:;" onclick="admin_edit(\'管理员编辑\',\'admin-add.jsp?id=\'+admin.id,' + admin.id + ',\'500\',\'250\')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a>'
                    + '<a title="删除" href="javascript:;" onclick="admin_del(this,' + admin.id + ')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a>'
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
            <input style="width: 50px;margin-left: 20px" value="`+response.pageNo+`" id="changePage"><input type="button" value="确定" style=";white: 40px" onclick="changePage()"/>
        </span>
`)


            }

        });
    }
    function changePage(that){
        var v=$("#changePage").val();
        if(!v){
            alert("请输入数字")
        }else if(isNaN(Number(v))) {
            alert("请输入数字")
        }else{
            pageList(v)
        }


    }

    function search() {
        usernam = document.getElementById("searchInput").value
        if (usernam === "") {
            alert("请输入用户名");
            return;
        }
        $.ajax({
            type: "GET",
            url: "/info_system/adminServlet",
            data: {
                action: "getByUsername",
                username: usernam
            },
            success: function (response) {
                $("#adminTable").empty();
                let thead = '<tr class="text-c">'
                    + '<th width="40">ID</th>'
                    + '<th width="150">用户名</th>'
                    + '<th width="90">密码</th>'
                    + '<th width="150">邮箱</th>'
                    + '<th>角色</th>'
                    + '<th width="130">加入时间</th>'
                    + '<th width="100">操作</th>'
                    + '</tr>';
                $("#adminTable").append(thead);
                console.log(response);
                if (response.length > 0) {
                //if (response.size !== 0) {
                    for (let admin of response) {
                        let date = new Date(admin.createdTime);
                        let formattedDate = date.toLocaleString();
                        let tr = '<tr class="text-c">'
                            + '<td>' + admin.id + '</td>'
                            + '<td>' + admin.username + '</td>'
                            + '<td>' + admin.email + '</td>'
                            + '<td>' + admin.password + '</td>'
                            + '<td>'+'超级管理员' + '</td>'
                            + '<td>' + formattedDate + '</td>'
                            + '<td class="td-manage">'
                            + '<a title="编辑" href="javascript:;" onclick="admin_edit(\'管理员编辑\',\'admin-add.jsp?id=\'+admin.id,' + admin.id + ',\'500\',\'250\')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a>'
                            + '<a title="删除" href="javascript:;" onclick="admin_del(this,' + admin.id + ')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a>'
                            + '</td>'
                            + '</tr>';
                        $("#adminTable").append(tr);
                    }
                }
                else{
                    alert("未找到用户数据");
                }
            },
            error: function (xhr, status, error) {
                console.error(error);
                alert("请求失败，请稍后重试");
            }
        });
    }


    /*
        参数解释：
        title	标题
        url		请求的url
        id		需要操作的数据id
        w		弹出层宽度（缺省调默认值）
        h		弹出层高度（缺省调默认值）
    */
    /*管理员-增加*/
    function admin_add(title, url, w, h) {
        layer_show(title, url, w, h);
    }
    /*管理员-删除*/
    function admin_del(obj, id) {
        layer.confirm('确认要删除吗？', function (index) {
            $.ajax({
                type: 'get',
                url: '/info_system/adminServlet?action=delete&id=' + id,
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

    /*管理员-编辑*/
    function admin_edit(title, url, id, w, h) {
        console.log(url)
        layer_show(title, url, w, h);
    }

    /*管理员-停用*/
    function admin_stop(obj, id) {
        layer.confirm('确认要停用吗？', function (index) {
            //此处请求后台程序，下方是成功后的前台处理……
            $(obj).parents("tr").find(".td-manage").prepend('<a onClick="admin_start(this,id)" href="javascript:;" title="启用" style="text-decoration:none"><i class="Hui-iconfont">&#xe615;</i></a>');
            $(obj).parents("tr").find(".td-status").html('<span class="label label-default radius">已禁用</span>');
            $(obj).remove();
            layer.msg('已停用!', {icon: 5, time: 1000});
        });
    }

    /*管理员-启用*/
    function admin_start(obj, id) {
        layer.confirm('确认要启用吗？', function (index) {
            //此处请求后台程序，下方是成功后的前台处理……
            $(obj).parents("tr").find(".td-manage").prepend('<a onClick="admin_stop(this,id)" href="javascript:;" title="停用" style="text-decoration:none"><i class="Hui-iconfont">&#xe631;</i></a>');
            $(obj).parents("tr").find(".td-status").html('<span class="label label-success radius">已启用</span>');
            $(obj).remove();
            layer.msg('已启用!', {icon: 6, time: 1000});
        });
    }
</script>
</body>
</html>