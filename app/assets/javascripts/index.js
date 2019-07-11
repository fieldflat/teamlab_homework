$('#register-btn').click(function(){
  console.log("sfsf");
  $('.register').toggleClass("display_none");
})

$('#search-btn').click(function () {
  console.log("sdsd");
  $('.search').toggleClass("display_none");
})

$(function () {
  $("#submit_button_create").click(function () { //送信ボタンを押すとイベントが発火します
    var title = $("#item_title").val();
    var description = $("#item_description").val();
    var price = $("#item_price").val();
    var image = $("#item_image").val();
    $.ajax({
      type: 'POST', // リクエストのタイプはGETです
      url: '/items', // URLは"/meals"を指定します
      data: {item: { title: title, description: description, price: price, image: image } }, // コントローラへフォームの値を送信します
      dataType: 'json' // データの型はjsonで指定します
    })
    .done(function (data) {
      // 通信に成功した場合の処理です
      console.log("通信成功！！");
      console.log(data);
      alert("商品を登録しました！");
      var message = `\
                  <div class="item_row item_block" id="item_${data.id}">\
                    <p><b>title</b>: ${data.title}</p>\
                    <p><b>description</b>: ${data.description}</p>\
                    <p><b>price</b>: ${data.price}</p>\
                    <div class="center">\
                    <a href="/items/${data.id}">Show</a>\
                    <a href="/items/${data.id}/edit">Edit</a>\
                    <a data-remote="true" rel="nofollow" data-method="delete" href="/items/${data.id}">Delete</a>\
                    </div>\
                  </div>\
                  `;
      console.log(message);
      $('.items').prepend(message);
      $('.error').addClass('display_none');
    })
    .fail(function () {
      // 通信に失敗した場合の処理です
      alert('商品登録できませんでした。エラー内容を確認してください。') // alertで検索失敗の旨を表示します
    })
  })
})

$(function () {
  $("#submit_button_search").click(function () { //送信ボタンを押すとイベントが発火します
    var text = $("#text").val();
    console.log(text);
    $.ajax({
      type: 'GET', // リクエストのタイプはGETです
      url: '/items', // URLは"/meals"を指定します
      // data: { item: { } }, // コントローラへフォームの値を送信します
      data: { text: text },
      dataType: 'json' // データの型はjsonで指定します
    })
      .done(function (data) {
        // 通信に成功した場合の処理です
        console.log("通信成功！！！！！");
        console.log(data);
        alert("検索結果を取得しました。");
        $('.item_row').hide();
        data.forEach(function (item) {
          var message = `\
                  <div class="item_row item_block" id="item_${item.id}">\
                    <p><b>title</b>: ${item.title}</p>\
                    <p><b>description</b>: ${item.description}</p>\
                    <p><b>price</b>: ${item.price}</p>\
                    <div class="center">\
                    <a href="/items/${item.id}">Show</a>\
                    <a href="/items/${item.id}/edit">Edit</a>\
                    <a data-remote="true" rel="nofollow" data-method="delete" href="/items/${item.id}">Delete</a>\
                    </div>\
                  </div>\
                  `;
          console.log(message);
          $('.items').prepend(message);
        })
        $('.error').addClass('display_none');
      })
      .fail(function () {
        // 通信に失敗した場合の処理です
        alert('検索エラーが発生しました。') // alertで検索失敗の旨を表示します
      })
  })
})