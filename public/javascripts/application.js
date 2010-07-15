/* Returns a function that binds a click event handler to a selection result. 
   This is used to add a class to an element when it's clicked. 

   params:
     @selector (string) - the elements to search for
     @className (string) - the class to add to a clicked element
*/

 $("a").click(function(event){
   event.preventDefault();
   $(this).hide("slow");
 });

var handleTabClick = function(selector, className) {
    return function() {
        var current = $(selector + '.' + className);
        $(selector).click(function() {
            current.length && current.removeClass(className);
            $(this).addClass(className);
            current = $(this);
        });
    }();
};

$(document).ready(function() {
    /* top slider - image slideshow */
    $(function() {
        var topslider = $('#topslider');
        if (!topslider.length) return;

	topslider.tabs({ 
            fx: [{opacity: 'toggle', duration: 'fast'}, {opacity: 'toggle', duration: 'fast'}] 
        }).tabs('rotate', 6500);
    });


    /* search tab selection */
    $(function() {
        handleTabClick('#search_categories li', 'active');
    });

    /* search result categories */
    $(function() {
        handleTabClick('#results ul.filters li', 'active');
    });

    /* search bar */
    $(function() {
        var searchInput = $('#search_form input');
        if (!searchInput.length) return;
        // reset the value
        searchInput.val(searchInput.attr('data-default'));
        searchInput.parent().addClass('idle-field');
    
        searchInput.focus(function() {
            var $input = $(this);
            $input.parent().removeClass('idle-field').addClass('focused-field');
            // remove the helper text
            if ($input.val() === $input.attr('data-default')) {
                $input.val('');
            }
        });

        searchInput.blur(function() {
            var $input = $(this);
            $input.parent().removeClass('focused-field');
            if ($.trim($input.val()) === '') {
                var value = $input.attr('data-default') || '';
                $input.parent().addClass('idle-field');
                $input.val(value);
            }
        });
    });

    /* export menu */
    $(function() {
        $('#export_button').click(function() {
            var menu = $(this).next('ul');
            menu.slideDown('fast').show();
            menu.parent().hover(function() {}, function() {
                menu.slideUp('fast');
            });
            menu.click(function() {
                menu.slideUp('fast');
            });
        });
    });

    /* search results checkall */
    $(function() { 
        $('#results_checkall').click(function () {
            $(this).parents('table:eq(0)').find(':checkbox').attr('checked', this.checked);
        });
    });

    /* table sort arrows */
    $(function() {
        var bc = 'sort-carat-both',
            uc = 'sort-carat-up',
            dc = 'sort-carat-down';

        $('#result_table th.sortable').click(function() { 
            var th =  $(this);
           
            if (th.hasClass(bc)) {
                $(this).siblings('.sortable').removeClass(uc).removeClass(dc).addClass(bc);
                th.removeClass(bc).addClass(uc);
            }
            else {
                th.hasClass(uc) ? th.removeClass(uc).addClass(dc) : th.removeClass(dc).addClass(uc);
            }
        });
    });
});

