$(function () {
  function valid_data(data){
    if ((data.title !== undefined) &&
        (data.title[0] !== "can't be blank") &&
        (data.title[0] !== "is too long (maximum is 100 characters)") &&
        (data.description !== undefined) &&
        (data.description[0] !== "can't be blank") &&
        (data.description[0] !== "is too long (maximum is 500 characters)") &&
        (data.price !== undefined) &&
        (data.price[0] !== "is not a number")){
      return true;
    } else {
      return false;
    }
  }

  $("#submit_button_create").click(function () { 
    var title = $("#item_title").val();
    var description = $("#item_description").val();
    var price = $("#item_price").val();
    var image = $("#item_image").val();
    $.ajax({
      type: 'POST', 
      url: '/items', 
      data: {item: { title: title, description: description, price: price, image: image } }, 
      dataType: 'json' 
    })
    .done(function (data) {
      // 通信に成功した場合の処理
      if (valid_data(data)) {
        alert("商品を登録しました！");
        var message = `\
                    <div class="item_row item_block" id="item_${data.id}">\
                      <p><b>title</b>: ${data.title}</p>\
                      <p><b>description</b>: ${data.description}</p>\
                      <p><b>price</b>: ${data.price}</p>\
                      <p><b>shop name</b>: ${data.shop_name}</p>\
                      <div class="center">\
                      <a href="/items/${data.id}">Show</a>\
                      <a href="/items/${data.id}/edit">Edit</a>\
                      <a data-confirm="削除します．よろしいですか？" data-remote="true" rel="nofollow" data-method="delete" href="/items/${data.id}">Delete</a>\
                      </div>\
                    </div>\
                    `;
        // 非同期でitemを追加
        $('.items').prepend(message);
        // エラーメッセージは外す
        $('.error').addClass('display_none');
        // フォームの中身を消去する
        $('#item_title').val("");
        $('#item_description').val("");
        $('#item_price').val("");
        $('#item_image').val("");
      } else {
        alert("商品の登録に失敗しました。エラー内容を確認してください。");
      }
    })
    .fail(function () {
      alert('通信に失敗しました。エラー内容を確認してください。')
    })
  })
})

$(function () {
  $("#submit_button_search").click(function () { 
    var text = $("#text").val();
    var shop_name = $("#shop_name").val();
    console.log(text);
    $.ajax({
      type: 'GET', 
      url: '/items', 
      data: { text: text, shop_name: shop_name },
      dataType: 'json' 
    })
      .done(function (data) {
        alert("検索結果を取得しました。");
        $('.item_row').hide();
        data.forEach(function (item) {
          var message = `\
                  <div class="item_row item_block" id="item_${item.id}">\
                    <p><b>title</b>: ${item.title}</p>\
                    <p><b>description</b>: ${item.description}</p>\
                    <p><b>price</b>: ${item.price}</p>\
                    <p><b>shop name</b>: ${item.shop_name}</p>\
                    <div class="center">\
                    <a href="/items/${item.id}">Show</a>\
                    <a href="/items/${item.id}/edit">Edit</a>\
                    <a data-confirm="削除します．よろしいですか？" data-remote="true" rel="nofollow" data-method="delete" href="/items/${item.id}">Delete</a>\
                    </div>\
                  </div>\
                  `;
          console.log(message);
          $('.items').prepend(message);
          $("#text").val("");
        })
        $('.error').addClass('display_none');
      })
      .fail(function () {
        alert('検索エラーが発生しました。') 
      })
  })
})

$(function () {
  $(document).on('keyup', '#shop_name', function (e) { 
    e.preventDefault(); 
    var input = $('#shop_name').val();
    $.ajax({ 
      url: '/search', 
      type: 'GET', 
      data: { keyword: input }, 
      dataType: 'json' ,
    })

    .done(function (data) { 
      $('#result').find('ol').remove();
      $('#result').find('br').remove();
      $(data).each(function (i, user) { 
        if (user.name !== "") {
          $('#result').append(`<ol class="search-list" id="${user.name}" value="${user.name}">` + user.name + '</ol>'); 
        }
      });
    })
  });
});
