<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>시각화</title>

<link href="../css/style.css" rel="Stylesheet" type="text/css">

<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- jqPlot 기본 설정 파일 -->
<link rel="stylesheet" type="text/css" href="./jquery.jqplot.min.css" />
<script type="text/javascript" src="./jquery.jqplot.min.js"></script>
 
<!-- 막대그래프 추가 설정 파일 -->
<script type="text/javascript" src="./plugins/jqplot.barRenderer.js"></script>
<script type="text/javascript" src="./plugins/jqplot.categoryAxisRenderer.js"></script>
 
<!-- 원형 그래프 추가 설정 파일 -->
<script type="text/javascript" src="./plugins/jqplot.pieRenderer.js"></script>

<!-- Meter gauge -->
<script type="text/javascript" src="./plugins/jqplot.meterGaugeRenderer.js"></script>

<!-- 막대 그래프 값 출력 -->
<script type="text/javascript" src="./plugins/jqplot.pointLabels.js"></script>


<script type="text/javascript">
  var auto_reload = null; // 자동실행 객체 선언
  $(function() { // 자동 실행
    auto_reload = setInterval(meter, 5000); // 5초마다 meter 함수 호출
    // clearInterval(auto_reload); // 자동 반복 실행 중지
  });
  

  // jQuery ajax 요청
  function meter() {
    // alert('자동 호출됨');
    var params = 'code=METER'; // 차트의 종류
    var msg = '';

      $.ajax({
        url: './read_top_code.do',
        type: 'get',  // post
        cache: false, // 응답 결과 임시 저장 취소
        async: true,  // true: 비동기 통신
        dataType: 'json', // 응답 형식: json, html, xml...
        data: params,      // 데이터
        success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우
         // alert(rdata.data);
          data = [rdata.data];
          
          $.jqplot('chart_panel',[data],{
              seriesDefaults: {
                  renderer: $.jqplot.MeterGaugeRenderer,
                  rendererOptions: {
                      min: 100,
                      max: 500,
                      intervals:[200, 300, 400, 500],
                      intervalColors:['#66cc66', '#93b75f', '#E7E658', '#cc6666']
                  }
              }
          });
        },
        // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
        error: function(request, status, error) { // callback 함수
          var msg = 'ERROR<br><br>';
          msg += '<strong>request.status</strong><br>'+request.status + '<hr>';
          msg += '<strong>error</strong><br>'+error + '<hr>';
          console.log(msg);
        }
      });
      
  }

</script>
</head> 

<body>
<jsp:include page="/menu/top.jsp" flush='false' />
  <DIV class='title_line'>
    현재 광고 open중인 상품의 실시간 주문자수 시각화
  </DIV>

  <ASIDE style='float: left;'>
      현재 주문자수  
  </ASIDE>
  <ASIDE style='float: right;'>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span> 
  </ASIDE> 

  <div class='menu_line'></div>
  
  <DIV style='margin: 50px auto; width: 60%; text-align: center;'>
    현재 광고 open중인 상품의 실시간 주문자수 시각화
  </DIV>
  <div id="chart_panel" style='margin: 10px auto; width: 60%;'></div>
    
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>

</html>