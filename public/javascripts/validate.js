

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
			alert("submitted!");
		},
		// set this class to error-labels to indicate valid fields
		success: function(label) {
			// set &nbsp; as text for IE
			label.html("&nbsp;").addClass("checked");
		}
	});


    
});
