$("a[rel=popover]").popover();

setTimeout(function(){

    $('.progress .bar').each(function() {
        var me = $(this);
        var perc = me.attr("data-percentage");

        //TODO: left and right text handling

        var current_perc = 0;

        var progress = setInterval(function() {
            if (current_perc>=perc) {
                clearInterval(progress);
            } else {
                current_perc +=1;
                me.css('width', (current_perc)+'%');
            }

            me.text((current_perc)+'%');

        }, 50);

    });

},300);

$('#creditCardModal').modal(options)



