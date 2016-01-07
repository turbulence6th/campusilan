$tooltip(document).ready(function() {
	// Tooltip only Text
	$tooltip('.masterTooltip').hover(function() {
		// Hover over code
		var title = $tooltip(this).attr('title');
		$tooltip(this).data('tipText', title).removeAttr('title');
		$tooltip('<p class="tooltipeklentisi"></p>').text(title).appendTo('body').fadeIn('slow');
	}, function() {
		// Hover out code
		$tooltip(this).attr('title', $tooltip(this).data('tipText'));
		$tooltip('.tooltipeklentisi').remove();
	}).mousemove(function(e) {
		var mousex = e.pageX + 20;
		//Get X coordinates
		var mousey = e.pageY + 10;
		//Get Y coordinates
		$tooltip('.tooltipeklentisi').css({
			top : mousey,
			left : mousex
		})
	});
});
