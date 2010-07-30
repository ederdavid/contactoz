/* Returns a function that binds a click event handler to a selection result. 
   This is used to add a class to an element when it's clicked. 

   params:
     @selector (string) - the elements to search for
     @className (string) - the class to add to a clicked element
*/
     //jQuery.noConflict();
     
     // Put all your code in your document ready area
jQuery(document).ready(function($){
	//Modal Form
	$(function() {
			// a workaround for a flaw in the demo system (http://dev.jqueryui.com/ticket/4375), ignore!
			/*$("#dialog").dialog("destroy");*/
		
			var email = $("#email"),
				password = $("#password"),
				allFields = $([]).add(email).add(password),
				tips = $(".validateTips");

			function updateTips(t) {
				tips
					.text(t)
					.addClass('ui-state-highlight');
				setTimeout(function() {
					tips.removeClass('ui-state-highlight', 1500);
				}, 500);
			}

			function checkLength(o,n,min,max) {

				if ( o.val().length > max || o.val().length < min ) {
					o.addClass('ui-state-error');
					updateTips("Length of " + n + " must be between "+min+" and "+max+".");
					return false;
				} else {
					return true;
				}

			}

			function checkRegexp(o,regexp,n) {

				if ( !( regexp.test( o.val() ) ) ) {
					o.addClass('ui-state-error');
					updateTips(n);
					return false;
				} else {
					return true;
				}

			}
			$('#log-in').click(function() {
				$('#dialog-form').dialog('open');
			
				return false;
			});
	$("#dialog-form").dialog({
					autoOpen: false,
					height: 220,
					width: 350,
					modal: true,
					buttons: {
						'Log in': function() {
							var bValid = true;
							allFields.removeClass('ui-state-error');
							bValid = bValid && checkLength(email,"email",6,80);
							bValid = bValid && checkLength(password,"password",5,16);

							// From jquery.validate.js (by joern), contributed by Scott Gonzalez: http://projects.scottsplayground.com/email_address_validation/
							bValid = bValid && checkRegexp(email,/^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i,"eg. ui@jquery.com");
							bValid = bValid && checkRegexp(password,/^([0-9a-zA-Z])+$/,"Password field only allow : a-z 0-9");
					
							if (bValid) {
								jQuery.ajax({
								    url: 'login',
								    type: 'POST',
								    data: 'user_session[email]='+email.val()+'&user_session[password]='+password.val()+'&authenticity_token=fHMB08SvRjE0/kQU27JVnch8xaoZMp83Uy0gpbTxyKQ=',
								    DataType: 'script',
								    success: function(){
									self.location='login/?user_session[email]='+email.val()+'&user_session[password]='+password.val()+'&authenticity_token=fHMB08SvRjE0/kQU27JVnch8xaoZMp83Uy0gpbTxyKQ='
								    },
								    error: function(){
								    }
								  });
								$(this).dialog('close');
							}
						},
						Cancel: function() {

							$(this).dialog('close');
						}
					},
					close: function() {
						//allFields.val('').removeClass('ui-state-error');
					}
				});

		});

	//End Modal Form


	 
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
		    $('#export_select').click(function() {
			   var inputs = document.getElementsByTagName("input"); //or document.forms[0].elements;    
			   var array = []; //will contain all checked checkboxes  
			   var array2 = ""
			   var j = 1;
			   for (var i = 0; i < inputs.length-1; i++) {  
			     if (inputs[i].type == "checkbox" && inputs[i].id != "results_checkall") {
			       if (inputs[i].checked) {  
				 array.push(inputs[i]);
				 if (inputs[i].id == "contact_") {
					 if (array2 == "") {
					     array2 = array2 + "contact[" + j + "]=" + inputs[i].value;
				         } else {
					     array2 = array2 + "&contact[" + j + "]=" + inputs[i].value;
					 }
				 }else{
					if (array2 == "") {
					     array2 = array2 + "company[" + j + "]=" + inputs[i].value;
				         } else {
					     array2 = array2 + "&company[" + j + "]=" + inputs[i].value;
					 }
				 }
				 j ++;
			       }  
			     }  
			   }
			jQuery.ajax({
				    url: 'export_to_csv',
				    type: 'POST',
				    data: array2,
				    DataType: 'script',
				    success: function(){
                                            if (array2.length > 0)
					        self.location= 'export_to_csv?'+ array2
				    },
				    error: function(){
				    }
				  });
		    });
                    $('#add_select').click(function() {
			   var inputs = document.getElementsByTagName("input"); //or document.forms[0].elements;    
			   var array = []; //will contain all checked checkboxes  
			   var array2 = ""
			   var j = 1;
			   for (var i = 0; i < inputs.length-1; i++) {  
			     if (inputs[i].type == "checkbox" && inputs[i].id != "results_checkall") {
			       if (inputs[i].checked) {  
				 array.push(inputs[i]);
				 if (inputs[i].id == "contact_") {
					 if (array2 == "") {
					     array2 = array2 + "contact[" + j + "]=" + inputs[i].value;
				         } else {
					     array2 = array2 + "&contact[" + j + "]=" + inputs[i].value;
					 }
				 }
				 j ++;
			       }  
			     }  
			   }
                           if (array2.length > 0)
			      self.location= 'contacts/cart?'+ array2
		    });
                    $('#add_all').click(function() {
			   var inputs = document.getElementsByTagName("input"); //or document.forms[0].elements;    
			   var array = []; //will contain all checked checkboxes  
			   var array2 = ""
			   var j = 1;
			   for (var i = 0; i < inputs.length-1; i++) {  
			     if (inputs[i].type == "checkbox" && inputs[i].id != "results_checkall") {
			        array.push(inputs[i]);
				if (inputs[i].id == "contact_") {
				   if (array2 == "") {
				       array2 = array2 + "contact[" + j + "]=" + inputs[i].value;
				     } else {
				       array2 = array2 + "&contact[" + j + "]=" + inputs[i].value;
			             }
			        }
				j ++;
			     }  
			   }
                           if (array2.length > 0)
			      self.location= 'contacts/cart?'+ array2
		    });
                    $('#get_select').click(function() {
			   var inputs = document.getElementsByTagName("input"); //or document.forms[0].elements;    
			   var array = []; //will contain all checked checkboxes  
			   var array2 = ""
			   var j = 1;
			   for (var i = 0; i < inputs.length-1; i++) {  
			     if (inputs[i].type == "checkbox" && inputs[i].id != "results_checkall") {
			       if (inputs[i].checked) {  
				 array.push(inputs[i]);
				 if (inputs[i].id == "contact_") {
					 if (array2 == "") {
					     array2 = array2 + "contactSaveds[" + j + "]=" + inputs[i].value;
				         } else {
					     array2 = array2 + "&contactSaveds[" + j + "]=" + inputs[i].value;
					 }
				 }
				 j ++;
			       }  
			     }  
			   }
                           if (array2.length > 0)
			      self.location= 'contact_saveds/comprar?'+ array2
		    });
		    menu.click(function() {
		        menu.slideUp('fast');
		
		    });
		});
	    });

	

	    /* tab menus */
	    $(function() {
        		// search tab selection
        		//handleClick('#search_categories li', 'active');
        		// search result categories
        		//handleClick('#results ul.filters li', 'active');
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
});
$("a").click(function(event){
   event.preventDefault();
   $(this).hide("slow");
 });

/* other scripts */


var handleClick = function(selector, className) {
    var current = $(selector + '.' + className);
    $(selector).click(function() {
        current.length && current.removeClass(className);
        $(this).addClass(className);
        current = $(this);
    });
};

/* Initiates a table by adding various effects to it. 

   params:
     @selector (string) - the table to manipulate
     @rows (boolean) - add background colour to every other row
     @hover (boolean) - add a background colour to the row being hovered on
     @api (public)
*/
var initTable = function(selector, rows, hover) {
    if (rows === true) {
        var td = $(selector + ' tbody tr:odd td');
        td.addClass('odd'); 
        $(selector).data('zebra-rows', true); // save for other functions
    }

    if (hover === true) {
        $(selector + ' tbody tr').hover(function() {
            $(this).find('td').addClass('hovered');
        }, function() {
            $(this).find('td').removeClass('hovered');
        });
    }

    // add sort arrows if the sortable class is present
    var bc = 'sort-carat-both',
    uc = 'sort-carat-up',
    dc = 'sort-carat-down';

    $(selector + ' th.sortable').click(function() { 
        var th =  $(this);
        if (th.hasClass(bc)) {
            $(this).siblings('.sortable').removeClass(uc).removeClass(dc).addClass(bc);
            th.removeClass(bc).addClass(uc);
        }
        else {
            th.hasClass(uc) ? th.removeClass(uc).addClass(dc) : th.removeClass(dc).addClass(uc);
        }
    });
}

/* Filters out the selector matches based on a text query

   params:
     @selector (string) - the elements to search for
     @query (string) - the text to find in the selector result array
     @returns (integer) - the number of elements being displayed 
     @api (private)
*/
function filter(selector, query) {  
    var count = 0;
    query = $.trim(query);   
    // add OR between words so that multiple matches can be found 
    query = query.replace(/ /gi, '|'); 

    $(selector).each(function() {  
        if ($(this).text().search(new RegExp(query, "i")) < 0) {
            $(this).hide();
        }
        else {
            $(this).show(); 
            count++;
        }
    });
    return count;
}  

/* Filters the content of a table. 

   params:
     @filter_id (string) - the element with filter text
     @filter_count (string) - the element to hold the displayed content text
     @table_id (string) - the table to filter
     @api (public)
*/
function filterTable(filter_id, filter_count, table_id) {
    var $filter = $(filter_id);
    $filter.parent().show();

    var table = table_id + ' tbody tr';
    filter_count = $(filter_count);

    // display the total items
    var total = $(table).length;
    var oldShow = total;
    var countMsg = function(num) { return 'showing ' + num + ' of ' + total; };
    filter_count.text(countMsg(total)); // display before we filter

    $filter.keyup(function(event) {
        // check for 'esc' or blank input
        if (event.keyCode == 27 || $filter.val() == '') {
            $filter.val(''); // for esc
            $(table).show(); // display each row again
            filter_count.text(countMsg(total));
            oldShow = total;
        }
        else {
            var show = filter(table, $filter.val());
            if (show !== oldShow) {
                filter_count.text(countMsg(show));
                oldShow = show;
            }
        }
        if ($(table_id).data('zebra-rows')) {
            // doing zebra rows, so reset them
            $(table_id + ' tbody tr:visible td').removeClass('odd');
            $(table_id + ' tbody tr:visible:odd td').addClass('odd');
        }
    });
}

/* Adds helper text to an input. 

   params:
     @selector (string) - the input to add helper text to
     @api (public)
*/
function inputHelperText(selector) {
    $(selector).each(function() {
        var input = $(this);
        // reset the value
        input.val(input.attr('data-default'));
        input.parent().addClass('idle-field');
    
        input.focus(function() {
            var self = $(this);
            self.parent().removeClass('idle-field').addClass('focused-field');
            // remove the helper text
            if (self.val() === self.attr('data-default')) {
                self.val('');
            }
        });

        input.blur(function() {
            var self = $(this);
            self.parent().removeClass('focused-field');
            if ($.trim(self.val()) === '') {
                var value = self.attr('data-default') || '';
                self.parent().addClass('idle-field');
                self.val(value);
            }
        });
    });
}

/* Creates a dropdown that hides when it looses focus or is clicked. 

   params:
     @selector (string) - the element to display (typically a list)
     @api (public)
*/
var slideMenu = function(selector) {
    $(selector).click(function() {
        var menu = $(this).next('ul');
        menu.slideDown('fast').show();
        menu.parent().hover(function() {}, function() {
            menu.slideUp('fast');
        });
        menu.click(function() {
            menu.slideUp('fast');
        });
    });
}

/* Runs when the page is ready */
$(document).ready(function() {
    /* top slider - image slideshow */
    $(function() {
        var topslider = $('#topslider');
        if (!topslider.length) return;

	topslider.tabs({ 
            fx: [{opacity: 'toggle', duration: 'fast'}, {opacity: 'toggle', duration: 'fast'}] 
        }).tabs('rotate', 6500);
    });

    /* tab menus */
    $(function() {
        // search tab selection 
        handleClick('#search_categories li', 'active');
        // search result categories
        handleClick('#results ul.filters li', 'active');
    });

    /* search bar */
    $(function() {
        // add helper text
        inputHelperText('#search_form input');
    });

    /* search results checkall */
    $(function() { 
        $('#results_checkall').click(function () {
            $(this).parents('table:eq(0)').find(':checkbox').attr('checked', this.checked);
        });
    });
});


