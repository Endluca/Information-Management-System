<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
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
    <title>品牌管理</title>
    <style> /* 隐藏弹窗初始状态 */
    .modal {
        display: none;
        position: fixed;
        z-index: 1;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        overflow: auto;
        background-color: rgba(0, 0, 0, 0.4);
    }

    /* 弹窗内容样式 */
    .modal-content {
        background-color: #fefefe;
        margin: 15% auto;
        padding: 20px;
        border: 1px solid #888;
        width: 30%;
    }

    /* 输入框样式 */
    input[type=text] {
        width: 100%;
        padding: 12px 20px;
        margin: 8px 0;
        box-sizing: border-box;
    }

    /* 按钮样式 */
    button {
        padding: 10px 20px;
        background-color: #4CAF50;
        color: white;
        border: none;
        cursor: pointer;
    }

    button.cancel {
        background-color: #f44336;
    } </style>
</head>
<body>
<div id="modal" class="modal">
    <div class="modal-content">
        <form id="brandForm"><label for="sort">排序</label>
            <input type="text" id="sort" name="sort"> <label
                    for="brand_name">品牌名称</label> <input type="text" id="brand_name" name="brand_name"> <label
                    for="description">品牌描述</label> <input type="text" id="description" name="description">
            <button type="button" class="cancel" onclick="hideModal()">取消</button>
            <button type="button" onclick="submitForm()">提交</button>
        </form>
    </div>
</div>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 产品管理 <span
        class="c-gray en">&gt;</span> 品牌管理 <a class="btn btn-success radius r"
                                                  style="line-height:1.6em;margin-top:3px"
                                                  href="javascript:location.replace(location.href);" title="刷新"><i
        class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="page-container">
    <div class="text-c">
        <input type="text" class="input-text" style="width:250px" placeholder="输入品牌名称" id="searchInput">
        <button type="submit" onclick="pageList(1)" class="btn btn-success" id="search" name=""><i class="Hui-iconfont">&#xe665;</i>
            搜品牌
        </button>
    </div>
    <div class="cl pd-5 bg-1 bk-gray mt-20">
        <span class="l">
            <a
                    href="javascript:;" onclick="showModal()"
                    class="btn btn-primary radius"><i class="Hui-iconfont">&#xe600;</i> 添加品牌</a></span>
    </div>
    <div class="mt-20">
        <table class="table table-border table-bordered table-bg table-sort" id="brandTable">
            <thead>
            <tr class="text-c"><th width="70" onclick="toggleSort('id')">ID</th><th width="80">排序</th><th width="120">品牌名称</th><th>具体描述</th><th width="100">操作</th></tr>
            </thead>
            <tbody id="tbody">
            </tbody>
        </table>
    </div>
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
    function showModal() {
        clearForm()
        document.getElementById('modal').style.display = 'block';
    }

    function clearForm() {
        $("#sort").val("");
        $("#brand_name").val("");
        $("#description").val("");
    }

    function hideModal() {
        clearForm()
        document.getElementById('modal').style.display = 'none';
    }

    function submitForm() {
        var name = $("#sort").val();
        var category = $("#brand_name").val();
        var description = $("#description").val();

        // 检查这三个字段是否都填写了
        if (!name || !category || !description) {
            // 弹出提示信息
            alert("请填入完整的三个信息.");
            return;
        }
        $.ajax({
            type: "POST",
            url: "/info_system/brandServlet",
            data: $("#brandForm").serialize(), success: function () {
                console.log('提交成功');
                alert("添加成功")
                hideModal();
                location.reload();
            }, error: function () {
                alert("添加失败");
                console.error('提交失败');
            }
        });
    }

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
        $.get("/info_system/brandServlet", {action: "list",pageNo:pageNo,pageSize:pageSize,searchInput:$("#searchInput").val(),sortOrder:sortOrder}, function (response) {
            $("#tbody").empty();
            if(response.list.length===0){
                alert("未查询到数据");
                return;
            }
            for (let brand of response.list) {
                let tr = '<tr class="text-c">'
                    + '<td>' + brand.id + '</td>'
                    + '<td>' + brand.sort + '</td>'
                    + '<td class="text-l">' + brand.brandName + '</td>'
                    + '<td class="text-l">' + brand.description + '</td>'
                    + '<td class="f-14 product-brand-manage">'
                    + '<a style="text-decoration:none" onClick="brand_edit(\'品牌编辑\',\'brand-add.jsp?id=' + brand.id + '\',' + brand.id + ')" href="javascript:;" title="编辑"><i class="Hui-iconfont">&#xe6df;</i></a> '
                    + '<a style="text-decoration:none" class="ml-5" onClick="brand_del(this,' + brand.id + ')" href="javascript:;" title="删除"><i class="Hui-iconfont">&#xe6e2;</i></a>'
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

    function admin_role_add(title, url, w, h) {
        layer_show(title, url, w, h);
    }

    /*管理员-角色-编辑*/
    function brand_edit(title, url, id, w, h) {
        layer_show(title, url, w, h);
    }

    /*$('.table-sort').dataTable({
        "aaSorting": [[1, "desc"]],//默认第几个排序
        "bStateSave": true,//状态保存
        "aoColumnDefs": [
            //{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
            {"orderable": false, "aTargets": [0, 6]}// 制定列不参与排序
        ]
    });*/
    /* $('.table-sort').dataTable({
         "aaSorting": [[1, "desc"]],//默认第几个排序
         "bStateSave": true,//状态保存
         "aoColumnDefs": [
             //{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
             {"orderable": false, "aTargets": [0, 6]}// 制定列不参与排序
         ]
     });
 */

    function brand_del(obj, id) {
        layer.confirm('品牌删除须谨慎，确认要删除吗？', function (index) {
            $.ajax({
                type: 'get',
                url: '/info_system/brandServlet?action=delete&id=' + id,
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


    function search() {
        usernam = document.getElementById("searchInput").value
        if (usernam === "") {
            alert("请输入品牌名")
        }
        $.ajax({
            type: "GET",
            url: "/info_system/brandServlet",
            data: {
                action: "getByBrandName",
                brandName: usernam
            },
            success: function (response) {
                $("#brandTable").empty();
                let tableHeader = '<tr class="text-c">'
                    + '<th width="70">ID</th>'
                    + '<th width="80">排序</th>'
                    + '<th width="120">品牌名称</th>'
                    + '<th>具体描述</th>'
                    + '<th width="100">操作</th>'
                    + '</tr>';
                $("#brandTable").append(tableHeader);
                for (let brand of response) {
                    let tr = '<tr class="text-c">'
                        + '<td>' + brand.id + '</td>'
                        + '<td>' + brand.sort + '</td>'
                        + '<td class="text-l">' + brand.brandName + '</td>'
                        + '<td class="text-l">' + brand.description + '</td>'
                        + '<td class="f-14 product-brand-manage">'
                        + '<a style="text-decoration:none" onClick="brand_edit(\'品牌编辑\',\'brand-add.jsp?id=' + brand.id + '\',' + brand.id + ')" href="javascript:;" title="编辑"><i class="Hui-iconfont">&#xe6df;</i></a> '
                        + '<a style="text-decoration:none" class="ml-5" onClick="brand_del(this,' + brand.id + ')" href="javascript:;" title="删除"><i class="Hui-iconfont">&#xe6e2;</i></a>'
                        + '</td>'
                        + '</tr>';
                    $("#brandTable").append(tr);
                }
            },
            error: function (xhr, status, error) {
                console.error(error);
            }
        });
    }
</script>
</body>
</html>