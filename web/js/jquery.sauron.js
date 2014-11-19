(function($){
	$.fn.sauron = function(options){
		return this.each(function(index, element){
			var cached = $(element);

			if(cached.attr("type") !== "password"){
				return;
			}

			var width = cached.width()+16;
			var height = cached.height();
			var size = Math.min(width, height);
			var pos = cached.position();
			var eye = $("<div>");

			eye.width(size);
			eye.height(size);
			eye.addClass("sauron")
			eye.css({
                                "top" : parseInt(cached.css("margin-top"), 10) + parseInt(cached.css("padding-top"), 10) + parseInt(cached.css("border-top-width"), 10),
				"right" : parseInt(cached.css("margin-right"), 10) + parseInt(cached.css("padding-right"), 10) + parseInt(cached.css("border-right-width"), 10),
			 });

			eye.mousedown(function(event){
				cached.attr("type", "text");
				eye.addClass("sauron-show");
			});

			var mouseup = function(event){
				cached.attr("type", "password");
				eye.removeClass("sauron-show")
			};

			eye.mouseup(mouseup);
			eye.mouseout(mouseup);

			cached.css("padding-right", parseInt(cached.css("padding-right"), 10) + parseInt(eye.css("width"), 10) + "px");
			cached.wrap("<div id='ojito' style='display: inline-block; position: relative'>");

			cached.parent().append(eye);
		});
	};
})(jQuery);
