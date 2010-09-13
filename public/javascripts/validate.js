function createUser() {

var firstname = document.getElementById("firstname").value;
var lastname = document.getElementById("lastname").value;
var email = document.getElementById("email").value;
var password = document.getElementById("password").value;



//$("#firstname");
alert("submitted this!" + firstname + lastname + email + password);
userdata="firstname=" + firstname + "&lastname=" + lastname + "&email=" + email + "&password=" + password; 
 
 $.ajax({
                                    url: 'users/create',
                                    type: 'GET',
                                    data: userdata,
                                    DataType: 'script',
                                    success: function(){
                                            if (userdata.length > 0)
                                                self.location= 'export_to_csv?'+ array2
                                    },
                                    error: function(){
                                    }
                                  });

};



/* Runs when the page is ready */
$(document).ready(function() {



$("#clickme").click(function () {
document.getElementById("connectuser").style.display='none';
    $("#registeruser").fadeIn("slow");
    });



	var validator = $("#signupform").validate({
		rules: {
			firstname: "required",
			lastname: "required",
			password: {
				required: true,
				minlength: 5
			},
			email: {
				required: true,
				email: true,
			},
			terms: "required"
		},
		messages: {
			firstname: "Su nombre",
			lastname: "Su apellido",
			password: {
				required: "Su contraseña",
				rangelength: jQuery.format("por lo menos {0} caracteres")
			},
			email: {
				required: "Su correo electronico ",
				minlength: "Con formato correcto",
				remote: jQuery.format("{0} is already in use")
			},
			terms: " "
		},
        
		// the errorPlacement has to take the table layout into account
		errorPlacement: function(error, element) {
            if ( element.is(":checkbox") )
				error.appendTo ( element.next() );
			else
				error.appendTo( element.parent().next() );
		},
		// specifying a submitHandler prevents the default submit, good for the demo
		submitHandler: function() {
				createUser();			
//alert("submitted!");
		},
		// set this class to error-labels to indicate valid fields
		success: function(label) {
			// set &nbsp; as text for IE
			label.html("&nbsp;").addClass("checked");
		}
	});


    
});
