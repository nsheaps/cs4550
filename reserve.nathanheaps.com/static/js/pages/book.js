$(function(){
	$("#reservation-form").validate({

		rules:{
			name:{
				required: true,
				minlength: 5
			},
			email:{
				required:true,
				email:true
			},
			phone:{
				required:true,
				phoneUS: true
			},
			date:{
				required:true,
				date:true
			},
			time:{
				required:true,
				minlength:7
			}
		}
	});
});