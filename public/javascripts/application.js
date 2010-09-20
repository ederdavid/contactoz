//var postBox = new PostBox();
// var postBox;
// = new PostBox();
                                        
// Always send the authenticity_token with ajax

$(document).ajaxSend(function(event, request, settings) {
    if ( settings.type == 'post' ) {
        settings.data = (settings.data ? settings.data + "&" : "") + "authenticity_token=" + encodeURIComponent( AUTH_TOKEN );
    }
});


function followFeed(user,feed) {

//userdata="user[firstname]=" + firstname + "&user[lastname]=" + lastname + "&user[email]=" + email + "&user[password]=" + password;
data = "user_id=" + user + "&feed_id= " + feed;

 $.ajax({
                                    url: '/users/follow',
                                    type: 'GET',
                                    data: data,
                                    DataType: 'script',
                                    success: function(){
                                                self.location= url + data
                                    },
                                    error: function(){
                                    }
                                  });

};


function invite() {


var emails = [];
var i = 0;


//grab all the inputs
  $('#invitation-section input[type=text]').each(function() {
        var input = $(this);
         email[i] =this.value;
         i = i+1;
    });

var url_email = '';
var j= 0;

while(email[j]){
var url_email = url_email + '&email_' + j + '=' + email[j];
j = 1+j;
}

//userdata="user[firstname]=" + firstname + "&user[lastname]=" + lastname + "&user[email]=" + email + "&user[password]=" + password;
//data = "user_id=" + user + "&feed_id= " + feed;


 $.ajax({
                                    url: '/users/invite',
                                    type: 'GET',
                                    data: url_email,
                                    DataType: 'script',
                                    success: function(){
                                                self.location= url + url_email
                                    },
                                    error: function(){
                                    }
                                  });


};

function sendMessage(type,postBox) {
var inputArray = [];
var i = 0;

  $('#post_box input[type=text]').each(function() {
        var input = $(this);
         inputArray[i] =this.value;
         i = i+1;
    });

var buy_sell;
if(type == "sell")
{
buy_sell = '[sell]=1'; 
}
else
{
buy_sell = '[buy]=1';
}

if ($('#type_product').hasClass('checked')){
       var data = '&product[name]=' + inputArray[0] + '&product[contact_name]=' + inputArray[1] + '&product[contact_title]=' + inputArray[2] + '&product[contact_phone]=' + inputArray[3] + '&product[contact_email]=' + inputArray[4] + '&product' + buy_sell;
      url = '/products/create_feed';
}
else
{
       var data = '&service[name]=' + inputArray[0] + '&service[contact_name]=' + inputArray[1] + '&service[contact_title]=' + inputArray[2] + '&service[contact_phone]=' + inputArray[3] + '&service[contact_email]=' + inputArray[4] + '&service' + buy_sell;
       url = '/services/create_feed';
}

 $.ajax({
                                    url: url,
                                    type: 'POST',
                                    data: data,
                                    DataType: 'script',
                                    success: function(){
                                                self.location= url + data
                                    },
                                    error: function(){
                                    }
                                  });

        jQuery.facebox.close()

        //call postbox
	postBox.reset()
	//$(this).reset()
};

function postFeed() {


        jQuery.facebox({ div: '#postdialog' });

//var html = '<div id="postdialog" style="display:none;"><div id="pd-header"><h4>Post Name</h4></div><div id="pd-content"><p><label for="post-desc">Post Description:</label><textarea name="post-desc" id="post-desc"></textarea></p></div><div id="pd-footer"><div class="clear-button btn-grey btn">Buy</div><div class="clear-button btn-grey btn">Sell</div></div></div>';

//jQuery.facebox('this is ');



//var message = $('#post_content').value;
//var mess = document.getElementById('post_content').value;
//alert(mess);
    
};


/* Binds a click event handler to a selection. 

    TODO: Replace with jQuery tabs
   params:
     @selector (string) - the elements to search for
     @className (string) - the class to add to a clicked element
     @api (private)
*/

function handleClick(selector, className) {
    var current = $(selector + '.' + className);
    $(selector).click(function() {
        current.length && current.removeClass(className);
        $(this).addClass(className);
        current = $(this);
    });
};

//active elements
function type() {
	array = document.getElementsByClassName("active");
	if (array[0])
		return array[0].id;
	else
		return "all";
};

$(function AutoScript(){
    var search = $('#search');
    if (search.length) {
        search.autocomplete({serviceUrl:'/application.js', params: {
            type: function() { return type(); }}, noCache: true});
    }
});

// Initiaties 
/* Initiates a table by adding various effects to it. 

   params:
     @selector (string) - the table to manipulate
     @rows (boolean) - add background colour to every other row
     @hover (boolean) - add a background colour to the row being hovered on
     @api (public)
*/
function initTable(selector, rows, hover) {
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
};

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
};

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
};

/* Adds helper text to an input. 

   params:
     @selector (string) - the input to add helper text to
     @api (public)
*/
function inputHelperText(selector, use_self) {
    use_self = use_self || false;

    $(selector).each(function() {
        var input = $(this);
        
        if (!input.attr('data-default')) {
            console.log('no default data');
            return;
        }

        var target = (use_self === true) ? input : input.parent();

        // reset the value
        input.val(input.attr('data-default'));
        target.addClass('idle-field');
    
        input.focus(function() {
            var self = $(this);
            target.removeClass('idle-field').addClass('focused-field');
            // remove the helper text
            if (self.val() === self.attr('data-default')) {
                self.val('');
            }
        });

        input.blur(function() {
            var self = $(this);
            target.removeClass('focused-field');
            if ($.trim(self.val()) === '') {
                var value = self.attr('data-default') || '';
                target.addClass('idle-field');
                self.val(value);
            }
        });
    });
};

/* Creates a dropdown that hides when it looses focus or is clicked. 

   params:
     @selector (string) - the element to display (typically a list)
     @api (public)
*/
function slideMenu(selector) {
    var parent = $(selector);

    if (!parent.length) {
        return;
    }

    var menu = parent.next('ul');
    
    $(selector).click(function() {
        menu.slideDown('fast').show();
        menu.parent().hover(function() {}, function() {
            menu.slideUp('fast');
        });
    });
    
    menu.click(function() {
        menu.slideUp('fast');
        parent.removeClass('click');
    });
};

/* The PostBox class manages the posting functionality on the account page. 

   params:
     @api (public)
*/
function PostBox() {
    // type slide menu
    this.button = $('#post_type_btn');
    this.menu = this.button.next('ul');
    this.types = $('#post_type_menu li');
    this.state = {
        type: undefined,
        error: false
    }

    // configure 
    this.init();
};


/* Initializes the Postbox by setting the field helper text and event listeners. 

   params:
     @api (private)
*/
PostBox.prototype.init = function() {
    inputHelperText('#post_box input[type=text]', true);
    $('#post_details input[type=text]:odd').addClass('odd');
    var self = this;
    
    // add listener for post button
    $('#post_btn').click(function() {
        self.post();


    });

    // listener for the save checkbox
    $('#post_save_checkbox').click(function() {
        var checkbox = this;
        $('#post_details input[type=text]').each(function() {
            (checkbox.checked) ? 
                $(this).attr("disabled", "disabled") : $(this).attr("disabled", "");
        });
    });

    // check for enter key
    $('#post_box').keypress(function(e) {
        if (e.keyCode == 13) {
            self.post();
        }
    });

    // add event listeners for the post type slide menu
    this.button.click(function() {
        if (!self.state.error)  {
            $(this).addClass('click');
        }
        self.menu.slideDown('fast').show();
        self.menu.parent().hover(function() {}, function() {
            self.menu.slideUp('fast');
            self.button.removeClass('click');
        });
    });


    this.types.click(function() {
        $(this).parent().slideUp('fast');
        self.button.removeClass('click');
        self.types.removeClass('checked'); // remove the checked class from previous li
        $(this).addClass('checked');

        // select a type
        self.state.type = this.id;
        if (self.state.error) {
            self.state.error = false;
            self.button.removeClass('error');
        }
    });
};

/* Post to the server. 

   params:
     @api (public)
*/
PostBox.prototype.post = function() {
    if (!this.state.type) {
        // need to select a type before posting...
        this.button.addClass('error');
        this.state.error = true;
    }
    else {
        postFeed();
        // make the post and reset everything
//        this.reset();

    }
}

/* Reset the state of the post box. 

   params:
     @api (public)
*/
PostBox.prototype.reset = function() {
    this.state.type = undefined;
    this.state.error = false;
    this.types.removeClass('checked');
    $('#post_details').slideUp('fast', function() {
        $('#post_box input').each(function() {
            $(this).val($(this).attr('data-default'));
            $(this).addClass('idle-field');
        });
    });
};

/* Runs when the page is ready */
$(document).ready(function() {


$("#morefeeds").click(function () {
 $("#hiddenfeed").fadeIn("slow");
//document.getElementById("hiddenfeed").fadeIn("slow");
    });

$("#oauth_provider_twitter").click(function () {
$("#connectext").submit();
    });

$("#oauth_provider_linked_in").click(function () {
$("#connectext").submit();
    });



	$(function(){
		var $invitationToggle = $("#toggleInvitations");
		var $invitationSection = $("#invitation-section ol");
		var $invitationsNotificationSection = $(".invitation-notifications");
		
		$invitationToggle.bind("click", function(){
		
			if ($(this).hasClass("activeShow"))
				$(this).removeClass("activeShow");
			else
				$(this).addClass("activeShow");
				
			$invitationSection.find("input[type=text]").val("")
			$invitationSection.slideToggle();
		})
		
		$("#sendButton").bind("click", function(){
			$invitationToggle.removeClass("activeShow");
			invite();
			$invitationSection.fadeOut('fast');
			$invitationsNotificationSection.slideDown();
		})
		
		$(".invitation-notifications .close-button").bind("click", function(){
			$invitationsNotificationSection.slideUp("fast");
		});
	});

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
    inputHelperText('#search_form input');

    /* search results checkall */
    $(function() { 
        $('#results_checkall').click(function () {
            $(this).parents('table:eq(0)').find(':checkbox').attr('checked', this.checked);
        });
    });
    
    
    /* Search choices menu */
    $(function(){
    	var $searchForm = $("#search_form");
    	var $searchFormValues = $("#search_form ul");
    	
    	/*
    	$searchForm.css("opacity", "0.6");
    	$searchForm.bind("mouseenter click", function(){
    		$(this).fadeTo("fast", 1.0)
    	}).bind("mouseleave", function(){
    		$(this).fadeTo("fast", 0.6);
    		$searchFormValues.slideUp()
    	})
    	*/
    	
		$("#activeSearch").bind("click", function(){
			$searchFormValues.slideToggle("fast");
		})
		
		$searchFormValues.find("li").bind("click", function(){
			var l_val = $(this).find("a").text();
			$("#activeSearch a").text(l_val);
			$("#searchFilter").val(l_val)
			$(this).parent().hide();
		})
	})

    
});
$("a").click(function(event){
   event.preventDefault();
   $(this).hide("slow");
 });
 

$(document).ready(function($){

 $(function() {
                    $('#add_post').click(function() {
			 var inputs = document.forms[1].elements;
                         var name = inputs[1].value
                         var description = inputs[2].value
                         var contact_name = inputs[3].value
                         var contact_phone = inputs[4].value
			 var contact_email = inputs[5].value
			var url = 'name=' + inputs[1].value + '&description=' + inputs[2].value + '&contact_name=' + inputs[3].value + '&contact_phone=' + inputs[4].value + '&contact_email=' + inputs[5].value
                             
                        $.ajax({
                                    url: 'add_post',
                                    type: 'GET',
                                    data: url,
                                    DataType: 'script',
                                    success: function(){
                                                self.location= 'users/add_post'+ url
                                    },
                                    error: function(){
                                    }
                                  });
                    });
});


	$(function() {
                var notificationForm = $('#notification-form'),
                    notificationForm2 = $('#notification-form2');

		$('#must-login').click(function() {
			notificationForm.dialog('open');
		});
		
                if (notificationForm.length) {
                    notificationForm.dialog({
			autoOpen: false,
			height: 120,
			width: 350,
			modal: true,
			buttons: {
                            'aceptar': function() {
                                $(this).dialog('close');
                            }
			},
			close: function() {
                            //allfields.val('').removeclass('ui-state-error');
			}
	    	    });
                }

                if (notificationForm2.length) {
		    notificationForm2.dialog({
			autoOpen: false,
			height: 120,
			width: 350,
			modal: true,
			buttons: {
                            'aceptar': function() {
                                $(this).dialog('close');
                            }
			},
			close: function() {
                            //allfields.val('').removeclass('ui-state-error');
			}
                    });
                }
	});
//end modal notification
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

        var dialogForm = $('#dialog-form');
	if (dialogForm.length) {
            dialogForm.dialog({
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
								$.ajax({
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
                    }
		});
                
	//End Modal Form
    
    

/* notification */
$(function() {

});
/* notification */
        
        /* export */
        
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
			$.ajax({
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
		    $('#limited_export_select').click(function() {
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
			if (array.length < 6) {
			$.ajax({
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
		       } else {
				$('#notification-form2').dialog('open');
		       }
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
        
        
        
        
        /* export */
});
