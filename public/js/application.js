// Some general UI pack related JS

$(function () {
	// Custom selects
	$("select").dropkick();
});

function customForm(action, method, input) {
    "use strict";
    var form;
    form = $('<form />', {
        action: action,
        method: method,
        style: 'display: none;'
    });
    if (input !== undefined) {
        $.each(input, function (name, value) {
            $('<input />', {
                type: 'hidden',
                name: name,
                value: value
            }).appendTo(form);
        });
    }
    form.appendTo('body').submit();
}

$(document).ready(function() {
	// Todo list
	$(".todo li").click(function() {
		if ($(".todo-done").length > 0) {
			$(".todo-done").removeClass("todo-done");
		}
		$(this).toggleClass("todo-done");
	});
	
	$("#pope_submit").click(function() {
		if ($(".email_input").val() == "") {
			$(".error_container").html("DAFUQ? You have to input your <a href='#' class='return_to_top' style='color:red'>email address</a>")
		}
		if ($(".todo-done").length != 1) {
			$(".error_container").html("DAFUQ? You have to select your <a href='#' class='return_to_top' style='color:red'>Pope tip</a>")
		}
		if (($(".email_input").val() != "") && ($(".todo-done").length == 1)) {
			$(".error_container").html("");
			customForm("/", 'post', {
			    id: $(".todo-done").data("id"),
				email: $(".email_input").val()
			});
		}
		
		
		return false;
	})
	
	$(".see_rules_link").click(function() {
		$('html, body').animate({
			scrollTop: $("footer").offset().top
		}, 2000);
		return false
	})
	
	$(".return_to_top").on("click",function() {
		$('html, body').animate({
			scrollTop: $(".container").offset().top
		}, 2000);
		return false
	})
	


	$('.todo-search-field').fastLiveFilter('.pope-list');



	// Init tooltips
	$("[data-toggle=tooltip]").tooltip("show");

	// Init tags input
	$("#tagsinput").tagsInput();

	// Init jQuery UI slider
	$("#slider").slider({
		min: 1,
		max: 5,
		value: 2,
		orientation: "horizontal",
		range: "min",
	});

	// JS input/textarea placeholder
	$("input, textarea").placeholder();

	// Make pagination demo work
	$(".pagination a").click(function() {
		if (!$(this).parent().hasClass("previous") && !$(this).parent().hasClass("next")) {
			$(this).parent().siblings("li").removeClass("active");
			$(this).parent().addClass("active");
		}
	});

	$(".btn-group a").click(function() {
		$(this).siblings().removeClass("active");
		$(this).addClass("active");
	});

	// Disable link click not scroll top
	$("a[href='#']").click(function() {
		return false
	});

});

