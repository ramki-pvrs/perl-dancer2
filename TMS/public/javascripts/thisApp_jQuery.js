$(document).ready(function(){
	// if there is a dot in id attribute, we need to escape it
	$(document).on('change', '#testcase\\.prod_id', function() {
		//reset the feature options lise each time the product list is changed
		$('#testcase\\.prod_rls_id option[value!="0"]').remove();
		var selectedProduct = $('#testcase\\.prod_id option:selected').val();
		$.ajax({
			url: "/get_rls",
			cache:false,
			dataType: "JSON",
			type:"POST",
			data:{productID:selectedProduct},
			success:function(response) {
				//alert(JSON.stringify(response));
				if(response!='error') {
					$.each(response, function(key,value){
						$('#testcase\\.prod_rls_id').append($("<option/>", {
							value:key,
							text:value
						}));                               
					});
				}
			}
		}); //end of ajax call
	}); // end of on change prod_id


	$(document).on('change', '#testcase\\.prod_rls_id', function() {
		//alert("chg prod rls");
		//reset the feature options lise each time the product list is changed
		$('#testcase\\.feat_id option[value!="0"]').remove();
		var selectedProductRls = $('#testcase\\.prod_rls_id option:selected').val();
		$.ajax({
			url: "/get_features",
			cache:false,
			dataType: "JSON",
			type:"POST",
			data:{productRlsID:selectedProductRls},
			success:function(response) {
				//alert(JSON.stringify(response));
				if(response!='error') {
					$.each(response, function(key,value){
						$('#testcase\\.feat_id').append($("<option/>", {
							value:key,
							text:value
						}));                               
					});
				}
			}
		}); //end of ajax call
	}); // end of on change prod_id

}); //end of document ready