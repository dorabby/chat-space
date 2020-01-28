$(function(){
  function buildHTML(message){
    var image = message.image ? `<img class="lower-message__image" src=${message.image} >` : " ";
    var html = `<div class="message" data-message-id="${message.id}" >
                  <div class="message__box">
                    <div class="message__box__name">
                      ${message.user_name}
                    </div>
                    <div class="message__box__date">
                      ${message.data}
                    </div>
                  </div>
                  <div class="lower-message">
                    <p class="lower-message__content">
                      ${message.text}
                    </p>
                      ${image}  
                  </div>
                </div>`
                  return html;
  }   

  $("#new_message").on("submit",function(e){
    e.preventDefault()
    var formData = new FormData(this);
    var url = $(this).attr('action');
    $.ajax({
      url: url,
      type: 'POST',
      data: formData,
      dataType:'json',
      processData: false,
      contentType: false
    })
    .done(function(message){
      var html = buildHTML(message);
        $('.main-contents').append(html);
        $('.main-contents').animate({ scrollTop: $('.main-contents')[0].scrollHeight});
        $('.form__submit').prop('disabled', false);
        $('form')[0].reset();
      })
    .fail(function(){
      alert("メッセージ送信に失敗しました");
    });
    return false;
  })
  // 以下自動更新
  var reloadMessages = function() {
    
    last_message_id = $('.message:last').data("message-id");
    $.ajax({
      url: "api/messages",
      type: 'get',
      dataType: 'json',
      data: {id: last_message_id}
    })
    .done(function(messages) {
      if (messages.length !== 0) {
        var insertHTML = '';
        $.each(messages, function(i,message) {
          insertHTML += buildHTML(message)
        });
        $('.main-contents').append(insertHTML);
        $('.main-contents').animate({ scrollTop: $('.main-contents')[0].scrollHeight});
        $("#new_message")[0].reset();
        $(".form__submit").prop("disabled", false);
      }
    })
    .fail(function() {
      console.log('error');
    });
  };
    if (document.location.href.match(/\/groups\/\d+\/messages/)) {
      setInterval(reloadMessages, 7000);
    }
});