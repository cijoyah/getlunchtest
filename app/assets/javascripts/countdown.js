$(function(){


    function CountDownTimer(dt, id){
        var end = new Date(dt);

        var _second = 1000;
        var _minute = _second * 60;
        var _hour = _minute * 60;
        var _day = _hour * 24;
        var timer;

        function showRemaining() {
            var now = new Date();
            var distance = end - now;
            if (distance < 0) {
                clearInterval(timer);
                document.getElementById(id).innerHTML = 'THIS OFFER HAS NOW ENDED!';
                return;
            }

            var days = Math.floor(distance / _day);
            var hours = Math.floor((distance % _day) / _hour);
            var minutes = Math.floor((distance % _hour) / _minute);
            var seconds = Math.floor((distance % _minute) / _second);

            document.getElementById(id).innerHTML = days + ' Days ';
            document.getElementById(id).innerHTML += hours + ' Hours ';
            document.getElementById(id).innerHTML += minutes + ' Mins ';
            document.getElementById(id).innerHTML += seconds + ' Secs';
        }

        timer = setInterval(showRemaining, 1000);
    }

    $('.promotion_content').each(function(k, v){
        var from = $(this).find('.promotion_from').val()
        var to = $(this).find('.promotion_to').val()
        var countdown = $(this).find('.countdown').attr('id')
        console.log("countdown_id", countdown)
        CountDownTimer(to, countdown)

    })




    // from = $("#promotion_from").val()
    // to = $("#promotion_to").val()
    // console.log(from)


    // if(new Date(from) < new Date()){
    //     CountDownTimer(to, 'countdown');
    // }
})
