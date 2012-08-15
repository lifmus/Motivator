 $(document).ready(function(){
    if (typeof Stripe !== "undefined") {

        Stripe.setPublishableKey('pk_07T3vzpNsDZ1R1f6EXJUiQKC0u0qK');
         $("#payment-form").submit(function(e)
        {
            e.preventDefault();
            Stripe.createToken(
            {
                number: $(".card-number").val(),
                cvc: $('.card-cvc').val(),
                exp_month: $('.card-expiry-month').val(),
                exp_year: $('.card-expiry-year').val()
            }, stripeResponseHandler);

        });
   }
});






function stripeResponseHandler(status, response)
{
   if (response.error) {

       // show the errors on the form
       console.log("response")

       alert(response.error.message);
       $(".payment-errors").text(response.error.message);
   } else {

       var form$ = $("#payment-form");
       // token contains id, last4, and card type
       // debugger;
       var token = response['id'];
       // insert the token into the form so it gets submitted to the server
       form$.append("<input type='hidden' name='stripeToken' value='" + token + "'/>");
       // and submit
       form$.get(0).submit();
   }
}

