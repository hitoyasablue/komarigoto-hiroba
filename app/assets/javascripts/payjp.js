$(window).bind("load", function(){
  if (document.URL.match(/cards/)){
  //　　URlに/cards/がある時のみ発火するように

    const payjp = Payjp('pk_test_2316ee76015cc1c70beb02a7')
     //  公開鍵から以下操作の起点となるPayjpインスタンスを生成

    const elements = payjp.elements();
　　　// Elementsインスタンスを生成。Elementsインスタンス1つにつき、1組のカード情報入力フォームを用意可能

    const style = {
      base: {
        color: 'black',
        '::placeholder': {
          fontStyle: 'italic',
        },
      }
    }

    const numberElement = elements.create('cardNumber', {style: style});
    const expiryElement = elements.create('cardExpiry', {style: style});
    const cvcElement = elements.create('cardCvc', {style: style});
　　//　Elementインスタンスを生成

    numberElement.mount('#number-form');
    expiryElement.mount('#expiry-form');
    cvcElement.mount('#cvc-form');
　　　// elementをDOM上に配置

    const submit_btn = $("#info_submit");
    submit_btn.click(function (e) {
      e.preventDefault();
      payjp.createToken(numberElement).then(function (response) {
　　　　//  ↑↑　ここでトークンを作成　// createTokenの引数には任意のElement1つを渡します

        if (response.error) {  //  通信に失敗したとき
          alert(response.error.message)
          regist_card.prop('disabled', false)
        } else {
          alert("登録が完了しました");
          $("#card_token").append(
            `<input type="hidden" name="payjp_token" value=${response.id}>
            <input type="hidden" name="card_token" value=${response.card.id}>`
          );
          $('#card_form')[0].submit();
        　 //  ↑↑　ここでtype='hidden'にしてsubmitにtokenを乗せています

          $("#card_number").removeAttr("name");
          $("#cvc-from").removeAttr("name");
          $("#exp_month").removeAttr("name");
        　$("#exp_year").removeAttr("name");
　　　　　　//  ↑↑　ここでremoveAttrで記述を削除してます
        };
      });
    });
  }
});