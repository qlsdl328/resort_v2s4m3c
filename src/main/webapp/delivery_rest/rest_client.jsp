<%@ page contentType="text/html; charset=UTF-8" %>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
<link href="../css/style.css" rel="Stylesheet" type="text/css">

<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript">
  $(function() {
    // 등록, POST 방식 전송의 경우
    $('#btn_create').on('click', function() {
      var data = {
        deliveryno: 2020,
        title: '제목1',
        content: '내용1',
        writer: '작성자1',
        rdate: '2020-0710'
      }
      // alert(JSON.stringify(data));
      // CORS(Cross-Origin Resource Sharing): 보안상의 이유로 같은 웹사이트에서만 GET/POST 가능
      // var url = 'http://127.0.0.1:9090/resort/delivery_rest/create'; // CORS 요청 문제로 처리 불가
      var url = './create';
      
      $.ajax({
        contentType:'application/json; charset=UTF-8',
        url: url,
        type: 'POST',  
        cache: false, // 응답 결과 임시 저장 취소
        async: true,  // true: 비동기 통신
        dataType: 'json', // 응답 형식: json, html, xml...
        data: JSON.stringify(data),  // 데이터: JSON -> String 변환
        success: function(rdata) {    // 서버로부터 성공적으로 응답이 온경우
          // alert(rdata);
          $('#panel').html(rdata);
        },
        // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
        error: function(request, status, error) { // callback 함수
          var msg = 'ERROR<br><br>';
          msg += '<strong>request.status</strong><br>'+request.status + '<hr>';
          msg += '<strong>error</strong><br>'+error + '<hr>';
          console.log(msg);
          alert(msg)
        }
      });
    });  

    // 목록, GET 방식 URL 요청의 경우
    $('#btn_list').on('click', function() {
      var url = './list/A001/1/2020-0001';
      // CORS ERROR
      // var url = 'http://127.0.0.1:9090/resort/delivery_rest/list/A001/1/2020-0001'; 
      
      $.ajax({
        contentType:'application/json; charset=UTF-8',        
        url: url,
        type: 'GET',  
        cache: false, // 응답 결과 임시 저장 취소
        async: true,  // true: 비동기 통신
        dataType: 'json', // 응답 형식: json, html, xml...
        success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우
          // alert(rdata);
          var msg = '';
          msg += "<OL>";
          for(i=0; i < rdata.length; i++) {
            msg += "<LI>";
            msg += rdata[i].deliveryno + " " + rdata[i].title + " " + rdata[i].content
            msg += rdata[i].writer + " " + rdata[i].rdate
            msg += "</LI>";   
          }
          msg += "</OL>";
          $('#panel').html(msg);
        },
        // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
        error: function(request, status, error) { // callback 함수
          var msg = 'ERROR<br><br>';
          msg += '<strong>request.status</strong><br>'+request.status + '<hr>';
          msg += '<strong>error</strong><br>'+error + '<hr>';
          console.log(msg);
        }
      });
    });

  
    // 1건 조회, GET 방식 URL 요청의 경우
    $('#btn_read').on('click', function() {
      var url = './read/1000';
      
      $.ajax({
        contentType:'application/json; charset=UTF-8',        
        url: url,
        type: 'GET',  
        cache: false, // 응답 결과 임시 저장 취소
        async: true,  // true: 비동기 통신
        dataType: 'json', // 응답 형식: json, html, xml...
        success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우
          // alert(rdata);
          var msg = '';
          msg += "<OL>";
          msg += "<LI>";
          msg += rdata.deliveryno + " " + rdata.title + " " + rdata.content
          msg += rdata.writer + " " + rdata.rdate
          msg += "</LI>";   
          msg += "</OL>";
          $('#panel').html(msg);
        },
        // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
        error: function(request, status, error) { // callback 함수
          var msg = 'ERROR<br><br>';
          msg += '<strong>request.status</strong><br>'+request.status + '<hr>';
          msg += '<strong>error</strong><br>'+error + '<hr>';
          console.log(msg);
        }
      });
    });  

    // 수정, PUT 방식 전송의 경우
    $('#btn_update').on('click', function() {
      var data = {
        deliveryno: 2021,
        title: '제목4',
        content: '내용4',
        writer: '작성자4',
        rdate: '2020-0710'
      }
      var url = './update';
      $.ajax({
        contentType:'application/json; charset=UTF-8',
        url: url,
        type: 'PUT',  
        cache: false, // 응답 결과 임시 저장 취소
        async: true,  // true: 비동기 통신
        dataType: 'json', // 응답 형식: json, html, xml...
        data: JSON.stringify(data),      // 데이터
        success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우
          // alert(rdata);
          $('#panel').html(rdata);
        },
        // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
        error: function(request, status, error) { // callback 함수
          var msg = 'ERROR<br><br>';
          msg += '<strong>request.status</strong><br>'+request.status + '<hr>';
          msg += '<strong>error</strong><br>'+error + '<hr>';
          console.log(msg);
        }
      });
    });  

    // 삭제, DELETE 방식 전송의 경우
    $('#btn_delete').on('click', function() {
      var url = './delete/2022';
      
      $.ajax({
        contentType:'application/json; charset=UTF-8',
        url: url,
        type: 'DELETE',  
        cache: false, // 응답 결과 임시 저장 취소
        async: true,  // true: 비동기 통신
        dataType: 'json', // 응답 형식: json, html, xml...
        success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우
          // alert(rdata);
          $('#panel').html(rdata);
        },
        // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
        error: function(request, status, error) { // callback 함수
          var msg = 'ERROR<br><br>';
          msg += '<strong>request.status</strong><br>'+request.status + '<hr>';
          msg += '<strong>error</strong><br>'+error + '<hr>';
          console.log(msg);
        }
      });
    });  

   // 목록, JSONP GET 방식, 다른 도메인의 URL 요청의 경우
    $('#btn_list_jsonp').on('click', function() {
      // eval('delivery_list_jsonp({"list":[{"rdate":"2020-0715","deliveryno":1,"writer":"???1","title":"??1","content":"??1"},{"rdate":"2020-0715","deliveryno":2,"writer":"???2","title":"??2","content":"??2"},{"rdate":"2020-0715","deliveryno":3,"writer":"???3","title":"??3","content":"??3"}]})');
      // delivery_list_jsonp({"list":[{"rdate":"2020-0715","deliveryno":1,"writer":"???1","title":"??1","content":"??1"},
      //                               {"rdate":"2020-0715","deliveryno":2,"writer":"???2","title":"??2","content":"??2"},
      //                               {"rdate":"2020-0715","deliveryno":3,"writer":"???3","title":"??3","content":"??3"}]})
      // return;
      
      // url 명시
      var url = 'http://127.0.0.1:9090/resort/delivery_rest/list_jsonp/delivery_list_jsonp/A001/1/2020-0001';
      
      $.ajax({
        contentType:'application/json; charset=UTF-8',        
        url: url,
        type: 'GET',  
        cache: false, // 응답 결과 임시 저장 취소
        async: true,  // true: 비동기 통신
        dataType: 'jsonp', // 응답 형식: jsonp, GET 방식만 호출 가능
        jsonpCallback: "delivery_list_jsonp",        
        success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우
          eval(rdata);// 문자열을 코드로 변환되어 delivery_list_jsonp 함수 호출이 됨
        },
        // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
        error: function(request, status, error) { // callback 함수
          var msg = 'ERROR<br><br>';
          msg += '<strong>request.status</strong><br>'+request.status + '<hr>';
          msg += '<strong>error</strong><br>'+error + '<hr>';
          console.log(msg);
        }
      });
    });
    
  });

  //jsonpCallback 함수
   function delivery_list_jsonp(rdata) {
    var msg = '';
    msg += "<OL>";
    var list = rdata.list;
    for(i=0; i < list.length; i++) {
      msg += "<LI>";
      msg += list[i].deliveryno + " " + list[i].title + " " + list[i].content
      msg += list[i].writer + " " + list[i].rdate
      msg += "</LI>";   
    }
    msg += "</OL>";
    $('#panel').html(msg);    
  }  
</script>
</head>
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
<Form id='frm' name='frm'>
  <button type='button' id='btn_create'>등록</button>
  <button type='button' id='btn_list'>목록</button>
  <button type='button' id='btn_read'>조회</button>
  <button type='button' id='btn_update'>수정</button>
  <button type='button' id='btn_delete'>삭제</button>
  <button type='button' id='btn_list_jsonp'>목록(JSONP)</button>  
</Form>
<hr>

<fieldset>
    <legend>알림</legend>
    <DIV id='panel' style='margin: 30px auto; width: 80%;'>
    
    </DIV>
</fieldset>

<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
</html>

