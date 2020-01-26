$(function(){

  
    function buildHTML(message){
      if(message.image){
        var html=
        `<div class="message">
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
            <img class="lower-message__image" src=${message.image}>
          </div>
        </div>`
      return html;
    }else{
      var html=
        `<div class="message">
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
          </div>
        </div>`
      return html;
    };
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
});