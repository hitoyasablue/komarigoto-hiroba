$(window).bind("load", function(){
  if (document.URL.match(/cards/)){

    const stripe = Stripe('pk_test_51IOzkSI7CbPhhw7o7ckmcCdslTVPalDqIBDuDv4kiMQGJMi6gHOtJ0QuayvkOJSQhXsucJuHho0ecb3aBUAz7A6M005dC5lGzj')

    const elements = stripe.elements();

    const style = {
      base: {
        // ここでStyleの調整をします。
        fontSize: '16px',
        color: "black",
      }
    };

    const card = elements.create('card', {style: style, hidePostalCode: true});

    card.mount('#card-element')

    card.addEventListener('change', function(event) {
      const displayError = document.getElementById('card-errors');
      if (event.error) {
        displayError.textContent = event.error.message;
      } else {
        displayError.textContent = '';
      }
    });

    const form = document.getElementById('payment-form');
    form.addEventListener('submit', function(event) {
      event.preventDefault();

      stripe.createToken(card).then(function(result) {
        if (result.error) {
          // エラー表示.
          var errorElement = document.getElementById('card-errors');
          errorElement.textContent = result.error.message;
        } else {
          // トークンをサーバに送信
          alert('カード情報を登録しました');
          stripeTokenHandler(result.token);
        }
      });
    });

    function stripeTokenHandler(token) {
      // tokenをフォームへ包含し送信
      const form = document.getElementById('payment-form');
      const hiddenInput = document.createElement('input');
      hiddenInput.setAttribute('type', 'hidden');
      hiddenInput.setAttribute('name', 'stripeToken');
      hiddenInput.setAttribute('value', token.id);
      form.appendChild(hiddenInput);

      // Submit します
      form.submit();
    }

  }
});