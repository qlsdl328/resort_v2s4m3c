<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Resort world</title>

<link href="../css/style.css" rel="Stylesheet" type="text/css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript">

// 이미지 클릭시 원본파일 출력
function panel_img(file) {
  var tag = "";
  tag = "<A href=\"javascript: $('#attachfile_panel').hide();\">";
  tag += "  <IMG src='../attachfile/storage/" + file
      + "' style='width: 100%;'>";
  tag += "</A>";

  $('#attachfile_panel').html(tag); // 문자열을 태그로 적용
  $('#attachfile_panel').show();    //패널 출력
}



  $(function() { // 자동 실행
    list_by_contentsno_add_view();  // 댓글 목록 출력
    

    $('#btn_delete_youtube').on('click', youtube_delete_send); 
    $('#btn_create').on('click', create_reply); // 댓글 등록 
  
    if ('${sessionScope.memberno}' != '') { // 로그인된 경우
      // alert('sessionScope.memberno: ' + '${sessionScope.memberno}');

      var frm_reply = $('#frm_reply');
      $('#content', frm_reply).attr('placeholder', '댓글 작성');//attr 태그의 속성에 접근
    }
  
  });

  function youtube_delete_modal() {
    $('#modal_panel_youtube').modal();              // 다이얼로그 출력
  }
  $('#modal_panel').on('keypress', function (event) {
    alert("닫기 버튼을 클릭하지 않으셨네요~");
    var keycode = (event.keyCode ? event.keyCode : event.which);
    if(keycode == '13'){
      alert("ENTER 눌렀네요~");
      $('#modal_panel_close').click();   
    }
  });

  
  // jQuery ajax 요청
  function youtube_delete_send () {
    // alert('삭제 진행');
    // return;
    
    var frm = $('#frm_youtube');  // Youtube 삭제 폼
    var contentsno = $('#contentsno', frm).val();
    var passwd = $('#passwd', frm).val();
    
    var params = 'contentsno=' + contentsno + '&passwd=' + passwd;
    var msg = '';
  
    $.ajax({
      url: './passwd.do',
      type: 'get',  // post
      cache: false, // 응답 결과 임시 저장 취소
      async: true,  // true: 비동기 통신
      dataType: 'json', // 응답 형식: json, html, xml...
      data: params,      // 데이터
      success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우
        // alert(rdata);
        var msg = "";
          
        if (rdata.cnt > 0) { // 패스워드 일치
          frm.submit();
        } else {  // 패스워드 불일치
          msg = "패스워드가 일치하지 않습니다.";
          
          $('#modal_content').attr('class', 'alert alert-danger'); // Bootstrap CSS 변경
          $('#modal_title').html('패스워드 에러'); // 제목 
          $('#modal_content').html(msg);        // 내용
          $('#modal_panel').modal();              // 다이얼로그 출력
        }
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
  
  
  
  
  
  
  function create_reply() {
    var frm_reply = $('#frm_reply');
    var params = frm_reply.serialize();
    // alert('checkId() 호출됨: ' + params);
    // return;
    if ($('#memberno', frm_reply).val().length == 0) {
      $('#modal_title').html('댓글 등록'); // 제목 
      $('#modal_content').html("로그인해야 등록 할 수 있습니다."); // 내용
      $('#modal_panel').modal();            // 다이얼로그 출력
      return;  // 실행 종료
    }
    
    // 영숫자, 한글, 공백, 특수문자: 글자수 1로 인식, 오라클은 1자가 3바이트임으로 300자로 제한
    // alert('내용 길이: ' + $('#content', frm_reply).val().length);
    // return;
    if ($('#content', frm_reply).val().length > 300) {
      $('#modal_title').html('댓글 등록'); // 제목 
      $('#modal_content').html("댓글 내용은 300자이상 입력 할 수 없습니다."); // 내용
      $('#modal_panel').modal();           // 다이얼로그 출력
      return;  // 실행 종료
    }
    
    $.ajax({
      url: "../reply/create.do", // action 대상 주소
      type: "post",           // get, post
      cache: false,          // 브러우저의 캐시영역 사용안함.
      async: true,           // true: 비동기
      dataType: "json",   // 응답 형식: json, xml, html...
      data: params,        // 서버로 전달하는 데이터
      success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우
        // alert(rdata);
        var msg = "";
        
        if (rdata.count > 0) {
          $('#modal_content').attr('class', 'alert alert-success'); // CSS 변경
          msg = "댓글을 등록했습니다.";
          $('#content',frm_reply).val('');
          $('#passwd',frm_reply).val('');
          list_by_contentsno_add_view() // 댓글 목록을 새로 읽어옴.
          
        } else {
          $('#modal_content').attr('class', 'alert alert-danger'); // CSS 변경
          msg = "댓글 등록에 실패했습니다.";
        }
        
        $('#modal_title').html('댓글 등록'); // 제목 
        $('#modal_content').html(msg);        // 내용
        $('#modal_panel').modal();              // 다이얼로그 출력
      },
      // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
      error: function(request, status, error) { // callback 함수
        var msg = 'ERROR request.status: '+request.status + '/ ' + error;
        console.log(msg); //Chrome에 출력
      }
    });
  }

  
// contentsno 별 댓글 목록 + 더보기 버튼
  function list_by_contentsno_add_view() {
  var replyPage=parseInt($("#reply_list").attr("data-replyPage"));
    // alert(contentsno);
    var params = 'contentsno=' + ${contentsVO.contentsno}+"&replyPage="+replyPage;

    $.ajax({
      url: "../reply/list_by_contentsno_join_add_view.do", // action 대상 주소
      type: "get",           // get, post
      cache: false,          // 브러우저의 캐시영역 사용안함.
      async: true,           // true: 비동기
      dataType: "json",   // 응답 형식: json, xml, html...
      data: params,        // 서버로 전달하는 데이터
      success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우
        $("#reply_list").attr("data-replyPage", replyPage+1);
        // alert(rdata);
        var msg = '';
        
        //$('#reply_list').html(''); // 패널 초기화, val(''): 안됨
        
        for (i=0; i < rdata.list.length; i++) {
          var row = rdata.list[i];
          
          msg += "<DIV style='border-bottom: solid 1px #EEEEEE; margin-bottom: 10px;'>";
          msg += "<span style='font-weight: bold;'>" + row.id + "</span>";
          msg += "  " + row.rdate;
          if ('${sessionScope.memberno}' == row.memberno) { // 글쓴이 일치여부 확인
            msg += " <A href='javascript:reply_delete("+row.replyno+")'><IMG src='./images/delete.png'></A>";
          }
          msg += "  " + "<br>";
          msg += row.content;
          msg += "</DIV>";
        }
        // alert(msg);
        $('#reply_list').append(msg);
      },
      // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
      error: function(request, status, error) { // callback 함수
        var msg = 'ERROR request.status: '+request.status + '/ ' + error;
        console.log(msg);
      }
    });
    $("#addBtn").on("click", list_by_contentsno_add_view);
  }
  
//댓글 삭제 레이어 출력
  function reply_delete(replyno) {
    // alert('replyno: ' + replyno);
    var frm_reply_delete = $('#frm_reply_delete');
    $('#replyno', frm_reply_delete).val(replyno); // 삭제할 댓글 번호 저장
    $('#modal_panel_delete').modal();               // 삭제폼 다이얼로그 출력
  }
  
  
  
// 댓글 삭제 처리
  function reply_delete_proc(replyno) {
    // alert('replyno: ' + replyno);
    var params = $('#frm_reply_delete').serialize();
    $.ajax({
      url: "../reply/delete.do", // action 대상 주소
      type: "post",           // get, post
      cache: false,          // 브러우저의 캐시영역 사용안함.
      async: true,           // true: 비동기
      dataType: "json",   // 응답 형식: json, xml, html...
      data: params,        // 서버로 전달하는 데이터
      success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우
        // alert(rdata);
        var msg = "";
        
        if (rdata.count ==1) { // 패스워드 일치
          if (rdata.delete_count == 1) { // 삭제 성공

            $('#btn_frm_reply_delete_close').trigger("click"); // 삭제폼 닫기, click 발생 
            
            list_by_contentsno(${contentsVO.contentsno }); // 목록을 다시 읽어옴
            
            return; // 함수 실행 종료
          } else {  // 삭제 실패
            msg = "패스 워드는 일치하나 댓글 삭제에 실패했습니다. <br>";
            msg += " 다시한번 시도해주세요."
          }
        } else { // 패스워드 일치하지 않음.
          msg = "패스워드가 일치하지 않습니다.";
        }
        
        $('#modal_panel_delete').hide();       // 삭제폼이 있는창을 숨김
        
        $('#modal_panel_delete_msg_content').html(msg);   // 내용
        $('#modal_panel_delete_msg').modal();                   // 다이얼로그 출력        

      },
      // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
      error: function(request, status, error) { // callback 함수
        var msg = 'ERROR request.status: '+request.status + '/ ' + error;
        console.log(msg);
      }
    });

    
  }

  
</script>
</head>

<body>
<c:set var="cateno" value="${cateVO.cateno}" />
<c:set var="contentsno" value="${contentsVO.contentsno }" />

<jsp:include page="/menu/top.jsp" flush='false' />

  <!-- Modal Youtube 삭제 요청 시작 -->
  <div class="modal fade" id="modal_panel_youtube" role="dialog">
    <div class="modal-dialog">
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">×</button>
          <h4 class="modal-title">Youtube 삭제</h4><!-- 제목 -->
        </div>
        <div class="modal-body">

            <form name='frm_youtube' id='frm_youtube' action='./youtube_delete.do'
                      method='POST'>
              <input type='hidden' name='cateno' id='cateno' value='${cateno }'>                      
              <input type='hidden' name='contentsno' id='contentsno' value='${contentsno }'>
              삭제된 Youtube 영상 관련 정보는 복구 할 수 없습니다.<br>
              <input type='password' class="form-control" name='passwd' id='passwd' value='' placeholder="패스워드" style='width: 20%;'>
            </form>

        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
          <button type="button" id="btn_delete_youtube" class="btn btn-default" data-dismiss="modal">삭제</button>
        </div>
      </div>
    </div>
  </div> <!-- Modal Youtube 삭제 요청  종료 -->
  
  <!-- Modal 알림창 시작 -->
  <div class="modal fade" id="modal_panel" role="dialog">
    <div class="modal-dialog">
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">×</button>
          <h4 class="modal-title" id='modal_title'></h4><!-- 제목 -->
        </div>
        <div class="modal-body">
          <p id='modal_content'></p>  <!-- 내용 -->
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
        </div>
      </div>
    </div>
  </div> <!-- Modal 알림창 종료 -->
  
  <!-- 댓글 삭제폼 -->
  <div class="modal fade" id="modal_panel_delete" role="dialog">
    <div class="modal-dialog">
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">×</button>
          <h4 class="modal-title">댓글 삭제</h4><!-- 제목 -->
        </div>
        <div class="modal-body">
          <form name='frm_reply_delete' id='frm_reply_delete' method='POST' 
                    action='./reply_delete.do'>
            <input type='hidden' name='replyno' id='replyno' value=''>
            
            <label>패스워드</label>
            <input type='password' name='passwd' id='passwd' class='form-control'>
            <div style='text-align: right; margin: 5px;'>
              <button type='button' class='btn btn-default' 
                           onclick="reply_delete_proc(frm_reply_delete.replyno.value);frm_reply_delete.passwd.value='';">삭제</button>
            </div> 
          </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal" 
                       id='btn_frm_reply_delete_close'>Close</button>
        </div>
      </div>
    </div>
  </div> <!-- 댓글 삭제폼 종료 -->


  
  <DIV class='title_line'>
    ${cateVO.name }
  </DIV>
  
  <ASIDE style='float: left;'>
    ${categrpVO.name } > ${cateVO.name }
  </ASIDE>
  <ASIDE style='float: right;'>
    <A href='./reply.do?contentsno=${contentsno }&cateno=${cateno }'>답변</A>
    <span class='menu_divide' > | </span>
    <A href='../attachfile/create.do?contentsno=${contentsno }&cateno=${cateno }'>파일 등록</A>
    <span class='menu_divide' > | </span>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' > | </span> 
    <A href='./list.do?cateno=${cateno }'>목록</A>
       <c:if test="${sessionScope.id != null || sessionScope.id_admin != null}">
       
    <span class='menu_divide' > | </span>
   
    <A href='./update.do?cateno=${cateno }&contentsno=${contentsno}'>수정</A>
    <c:choose>
      <c:when test="${contentsVO.map.trim().length() > 0 }">
        <span class='menu_divide' > | </span> 
        <A href='./map_delete.do?cateno=${cateno }&contentsno=${contentsno}'>지도 삭제</A>     
      </c:when>
      <c:otherwise>
        <span class='menu_divide' > | </span> 
        <A href='./map_create.do?cateno=${cateno }&contentsno=${contentsno}'>지도 등록</A>     
      </c:otherwise>
    </c:choose>
    
    <c:choose>
      <c:when test="${contentsVO.youtube.trim().length() > 0 }">
        <span class='menu_divide' > | </span> 
        <A href='javascript:youtube_delete_modal()'>Youtube 삭제</A>     
      </c:when>
      <c:otherwise>
        <span class='menu_divide' > | </span> 
        <A href='./youtube_create.do?cateno=${cateno }&contentsno=${contentsno}'>Youtube 등록</A>     
      </c:otherwise>
    </c:choose>
    
    <c:choose>
      <c:when test="${contentsVO.mp3.trim().length() > 0 }">
        <span class='menu_divide' > | </span> 
        <A href='./mp3_delete.do?cateno=${cateno }&contentsno=${contentsno}'>MP3 삭제</A>     
      </c:when>
      <c:otherwise>
        <span class='menu_divide' > | </span> 
        <A href='./mp3_create.do?cateno=${cateno }&contentsno=${contentsno}'>MP3 등록</A>     
      </c:otherwise>
    </c:choose>
    
     <c:choose>
      <c:when test="${contentsVO.mp4.trim().length() > 0 }">
        <span class='menu_divide' > | </span> 
        <A href='./mp4_delete.do?cateno=${cateno }&contentsno=${contentsno}'>MP4 삭제</A>     
      </c:when>
      <c:otherwise>
        <span class='menu_divide' > | </span> 
        <A href='./mp4_create.do?cateno=${cateno }&contentsno=${contentsno}'>MP4 등록</A>     
      </c:otherwise>
    </c:choose>
    
    
    
    <span class='menu_divide' > | </span> 
    <A href='./delete.do?cateno=${cateno }&contentsno=${contentsno}'>삭제</A>
   </c:if> 
  </ASIDE> 
  
  <div class='menu_line'></div>

  <FORM name='frm' method="get" action='./update.do'>
      <input type="hidden" name="contentsno" value="${contentsno}">
      <fieldset class="fieldset">
        <ul>
          <li class="li_none" style='border-bottom: solid 1px #AAAAAA;'>
            <span>${contentsVO.title}</span>
            (<span>${contentsVO.recom}</span>)
            <span>${contentsVO.rdate.substring(0, 16)}</span>
          </li>
          
          
          <li class="li_none">
            <DIV id='attachfile_panel' style="width: 70%; margin: 0px auto;"></DIV> <!-- 원본 이미지 출력 -->
          </li>
          <li class="li_none" style='text-align: center;' >
            <c:forEach var="attachfileVO" items="${attachfile_list }">
              <c:set var="thumb" value="${attachfileVO.thumb.toLowerCase() }" />
              
              <c:choose>
                <c:when test="${thumb.endsWith('jpg') || thumb.endsWith('png') || thumb.endsWith('gif')}">
                  <A href="javascript:panel_img('${attachfileVO.fname }')"><IMG src='../attachfile/storage/${thumb }' style='margin-top: 2px;'></A>
                </c:when>
              </c:choose>
            </c:forEach>
          </li>
          
          
          
          
          <li class="li_none">
            <DIV>${contentsVO.content }</DIV>
          </li>
          <li class="li_none">
            ${contentsVO.web }
          </li>
          
          <c:if test="${contentsVO.map.trim().length() > 0 }">
            <li class='li_none' style='clear: both;'>
              <DIV style='width:640px; height: 380px; margin: 0px auto;'>
                ${contentsVO.map }
              </DIV>
            </li>
          </c:if>
          
          <c:if test="${contentsVO.youtube.trim().length() > 0 }">
            <li class='li_none' style='clear: both;'>
              <DIV style='width:900px; margin: 0px auto; text-align: center;'>
                ${contentsVO.youtube}
              </DIV>
            </li>
          </c:if>  
          
           <c:if test="${contentsVO.mp4.trim().length() > 0 }">
            <li class='li_none' style='clear: both;'>
              <DIV style='width:900px; margin: 0px auto; text-align: center;'>
                <VIDEO controls src='./storage/mp4/${contentsVO.mp4}'
                            style='width: 70%; background-color: #EEEEEE;'>
                </VIDEO>
              </DIV>
            </li>
          </c:if>           

          
          

          <li class="li_none">
            <DIV style='text-decoration: none;'>
              검색어(키워드): ${contentsVO.word } IP: ${contentsVO.ip }
              
              <c:if test="${contentsVO.mp3.trim().length() > 0 }">
                <AUDIO controls autoplay="autoplay">
                  <source src="./storage/mp3/${contentsVO.mp3 }" type="audio/mp3">
                </AUDIO>
              </c:if>  
          
            </DIV>
          </li>
          
        </ul>
      </fieldset>
  </FORM>
  
  
  <!-- 댓글 영역 시작 -->
  <DIV style='width: 80%; margin: 0px auto'>
    <HR>
    <FORM name='frm_reply' id='frm_reply'> <%-- 댓글 등록 폼 --%>
      <input type='hidden' name='contentsno' id='contentsno' value='${contentsno}'>
      <input type='hidden' name='memberno' id='memberno' value='${sessionScope.memberno}'>
      
      <textarea name='content' id='content' style='width: 100%; height: 60px;' placeholder="댓글 작성, 로그인해야 등록 할 수 있습니다."></textarea>
      <input type='password' name='passwd' id='passwd' placeholder="비밀번호">
      <button type='button' id='btn_create' >등록</button>
    </FORM>
    <HR>
    <DIV id='reply_list' data-replyPage='1'>  <%-- 댓글 목록 --%>
   
    </DIV>
   <DIV id='reply_list_btn' style='border: solid 1px #AAAAAA; margin: 0px auto; width: 70%; background-color: #AAAAAA;'>
    <button id='addBtn' style='width: 100%;'>더보기 ▽</button>     
  </DIV>  
    
  </DIV>
  
  <!-- 댓글 영역 종료 -->
  
  

<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>

</html>