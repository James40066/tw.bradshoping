<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//從session拿到東西
	LinkedList<String> pnameList = (LinkedList<String>) session.getAttribute("pnameList");
	LinkedList<String> tquantityList = (LinkedList<String>) session.getAttribute("tquantityList");
	HashMap<String, Object> member = (HashMap<String, Object>) session.getAttribute("member");
	boolean isMemberNull = member == null;
	StringBuffer code = null;
	if (!isMemberNull) {
		int id = (int) member.get("id");
		code = new StringBuffer(
				"https://pdfmyurl.com/index.php?url="+getServletContext().getInitParameter("ngrok")+"tw.bradshoping/report2PDF.jsp?code=");
		for (int i = 0; i < 9; i++) {
			code.append((int) (Math.random() * 10));
			if (i == 2) {
				code.append(id);
			}
		}
	}
%>
<div class="row">
	<div class="col-md-12" <%=isMemberNull?"style='display: none;'":"" %>>
		<a href="<%=isMemberNull?"":code.toString()%>">下載BS銷售PDF報表</a>
		<a href="Report2Excel">下載BS銷售Excel報表</a>
	</div>
	<div class="col-md-12" style="height: 500px">
		<!--利用canvas(畫布)將Chart類別畫出來-->
		<canvas id="chart1" width="100%"></canvas>
	</div>
</div>
<script>
            //資料標題

            var labels=[];
            <%for (String pname : pnameList) {%>
    			labels.push("<%=pname%>");
<%}%>
	var total1 = 0;

	var ctx = document.getElementById('chart1').getContext('2d');
	var pieChart = new Chart(
			ctx,
			{
				type : 'pie',
				data : {
					labels : labels,
					datasets : [ {
						//預設資料
						data :<%=tquantityList.toString()%>,
						backgroundColor : [
						//資料顏色
						"#FF88C2", "#66FF66", "#FF8888", "#FF77FF", "#FFA488",
								"#77FFCC", "#77FFEE", "#FFBB66", "#66FFFF",
								"#FFDD55", "#FFFF77", "#77DDFF", "#DDFF77",
								"#99BBFF", "#BBFF66", "#9F88FF" ],
					} ],
				},
				options : {
					//標題
					title : {
						display : true,
						text : '產品銷售分析圖表',
						fontSize : 16,
						fontColor : '#1b1b1b',
						fontStyle : 'bolder',
						fontFamily : 'Microsoft YaHei'
					},

					//set圖片將如何畫出
					animation : {
						animateScale : true,
						animateRotate : true
					},
					// 關於Tooltip(工具提示)
					// 利用label方法
					tooltips : {
						callbacks : {
							//callbacks 裡面 label拿到參數是(TooltipItem)是一個Obj callback要在工具提示中為單個項目呈現的資料
							label : function(tooltipItem, data) {
								//dataset拿到data全部的資料
								var dataset = data.datasets[tooltipItem.datasetIndex];

								//變數sum 全部總和
								//data拿到的值是一個array
								//利用Array.prototype.reduce() 方法將一個累加器及陣列中每項元素（由左至右）傳入回呼函式，將陣列化為單一值。
								var sum = dataset.data.reduce(
								//previousValue(累加值)+currentValue(當前值)
								function(previousValue, currentValue) {
									return previousValue + currentValue;
								});

								//currentValue 拿到指定index的值
								//當你指到哪個部分它就會拿到那個索引值
								var currentValue = dataset.data[tooltipItem.index];

								//percent(百分率))=round方法(索引值/總和)*100
								var percent = Math
										.round(((currentValue / sum) * 100));

								//return View上要呈現的部分
								return "品名:" + data.labels[tooltipItem.index]
										+ " 售出數量:" + currentValue + " 總售出佔有率:("
										+ percent + " %)";
							}
						}
					},

					//提示項目的處理
					legend : {
						display : true,
						position : 'left',
						labels : {
							generateLabels : function(chart) {
								//拿到data資料
								var data = chart.data;

								//如果兩邊都有值()那就執行
								if (data.labels.length && data.datasets.length) {
									//js map()方法 所以以下的事情對array的元素都會做
									return data.labels
											.map(function(label, i) {
												var ds = data.datasets[0];
												//getDatasetMeta 查找當前index匹配的data並returns該數據。數據包含 建構表單的所有數據
												var arc = chart
														.getDatasetMeta(0).data[i];
												var custom = arc && arc.custom
														|| {};
												var getValueAtIndexOrDefault = Chart.helpers.getValueAtIndexOrDefault;

												// chart.options.elements.arc全局弧配置
												// arc方法如下1.backgroundColor(弧填充顏色) 2.borderColor(弧形筆觸顏色)3.borderWidth(弧形行程寬度)
												var arcOpts = chart.options.elements.arc;

												//js三元運算式 (條件)? True return 值1 : False return 值2
												var fill = custom.backgroundColor ? custom.backgroundColor
														: getValueAtIndexOrDefault(
																ds.backgroundColor,
																i,
																arcOpts.backgroundColor);
												var stroke = custom.borderColor ? custom.borderColor
														: getValueAtIndexOrDefault(
																ds.borderColor,
																i,
																arcOpts.borderColor);
												var bw = custom.borderWidth ? custom.borderWidth
														: getValueAtIndexOrDefault(
																ds.borderWidth,
																i,
																arcOpts.borderWidth);

												//getDatasetMeta 查找當前index匹配的data並returns該數據。數據包含 建構表單的所有數據
												var value = chart.config.data.datasets[chart
														.getDatasetMeta(0).data[i]._datasetIndex].data[chart
														.getDatasetMeta(0).data[i]._index];

												return {
													text : label + " : "
															+ value,
													fillStyle : fill,
													strokeStyle : stroke,
													lineWidth : bw,
													hidden : isNaN(ds.data[i])
															|| chart
																	.getDatasetMeta(0).data[i].hidden,
													index : i
												};
											});
								} else {
									return [];
								}
							}
						}
					}
				},

			});
</script>
