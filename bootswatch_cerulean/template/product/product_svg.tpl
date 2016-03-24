<?php echo '<?xml version="1.0" encoding="UTF-8"?>' . "\n"; ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" lang="en" xml:lang="en">
<head>
<title></title>
<script type="text/javascript" src="catalog/view/javascript/jquery/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="catalog/view/javascript/jquery/ui/jquery-ui-1.8.16.custom.min.js"></script>
<link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/ui/themes/ui-lightness/jquery-ui-1.8.16.custom.css" />
</head>
<body style="padding:0; margin:0;">

<span class="picw-image">
<?php echo $product_svg; ?>
</span>

<script type="text/javascript">
var paths;
var ellipses;
var polygons;
var rects;
var g;

var sw = <?php echo $picw_svg_width; ?>;
var sh = <?php echo $picw_svg_height; ?>;

scaleSVG(sw, sh);

var mapping = new Array();
var imageLinks = new Array();

<?php foreach($picw_mapping as $pm) { ?>
	mapping.push({optionId: "<?php echo $pm['option_id']; ?>", colorCode: "<?php echo $pm['color_code']; ?>"});
<?php } ?>
<?php $cnt = 0; ?>
<?php foreach($image_option_images as $image) { ?>
	imageLinks.push({imageId: "picw-img-<?php echo $cnt; ?>", imageLink: "<?php echo $image['link']; ?>"});
<?php $cnt++;} ?>

//mark svg objects
markObjects();

function scaleSVG(sw, sh)
{
	$svg = $(".picw-image svg");
	$svg_g = $(".picw-image svg > g");
	
	if($svg_g.length == 1)
	{
		var w = $svg_g.width();
		var h = $svg_g.height();
		
		if(w == 0 || h == 0)
		{
//			w = $svg.width();
//			h = $svg.height();
			$svg.width(sw).height(sh);
			return;
		}
		
		//NOTE: sw and sw are configurable width and height value initialised in product.tpl
		var scalew = Math.round(sw / w * 10000) / 10000;
		var scaleh = Math.round(sh / h * 10000) / 10000;
		var scalewh = 1;
		
		if(scalew < scaleh)
			scalewh = scalew;
		else
			scalewh = scaleh;
		
		$svg_g.attr('transform', 'scale(' + scalewh + ' ' + scalewh + ')');
	}
	else
	{
		$(".picw-image svg").attr('viewBox', '0 0 ' + sw + ' ' + sh);
	}
	
	$svg.width(sw).height(sh);
}

function markObjects()
{
	var svgns="http://www.w3.org/2000/svg";
	
	if(!document.getElementsByTagNameNS)
		return;
	
	//init svg objects
	g = document.getElementsByTagNameNS(svgns, 'g');
	paths = document.getElementsByTagNameNS(svgns, 'path');
	ellipses = document.getElementsByTagNameNS(svgns, 'ellipse');
	polygons = document.getElementsByTagNameNS(svgns, 'polygon');
	rects = document.getElementsByTagNameNS(svgns, 'rect');		

	configSVGElements(g, mapping);
	configSVGElements(paths, mapping);
	configSVGElements(ellipses, mapping);
	configSVGElements(polygons, mapping);
	configSVGElements(rects, mapping);
}

function configSVGElements(obj, mapping) {	
	for (var i = 0; i < obj.length; i++) {
		var fill = $(obj[i]).attr('fill');
		if(fill != null)
		{
			fill = fill.toLowerCase();
			
			for(idx in mapping)
			{
				var temp = mapping[idx];
				
				if (fill == temp.colorCode) {
					obj[i].marker = temp.optionId;
					break;
				}
			}
		}
		else
		{
			var style = $(obj[i]).attr('style');
			
			if(style != null)
			{
				var pattern = /fill:([^;]*)/;

				matches = style.match(pattern);
				if (matches != null)
				{ // Did it match?
					fill = matches[1].toLowerCase();
			
					for(idx in mapping)
					{
						var temp = mapping[idx];
						
						if (fill.trim() == temp.colorCode.trim()) {
							obj[i].marker = temp.optionId;
							break;
						}
					}
				}
			}
		}
	}
}

function swapColor(optionId, newColor)
{
	colourObjects(g, optionId, newColor);
	colourObjects(paths, optionId, newColor);
	colourObjects(ellipses, optionId, newColor);
	colourObjects(polygons, optionId, newColor);
	colourObjects(rects, optionId, newColor);
}

function swapColor2(optionId, imageLink)
{
	var imgId = lookupImageId(imageLink);

	colourObjects2(g, optionId, imgId);
	colourObjects2(paths, optionId, imgId);
	colourObjects2(ellipses, optionId, imgId);
	colourObjects2(polygons, optionId, imgId);
	colourObjects2(rects, optionId, imgId);
}

function colourObjects(obj, marker, colour) {
	for (var i = 0; i < obj.length; i++) {
		if (obj[i].marker == marker) {
			var fill = $(obj[i]).attr('fill');
			
			if(fill != null)			
				$(obj[i]).attr("fill", colour);
			else
			{
				var style = $(obj[i]).attr('style');
			
				if(style != null)
				{
					var pattern = /fill:([^;]*)/;

					matches = style.match(pattern);
					if (matches != null)
					{
						style = style.replace('fill:' + matches[1], 'fill:' + colour);
						$(obj[i]).attr("style", style);
					}
				}
			}
		} 
	}
}

function colourObjects2(obj, marker, imgId) {
	var fillValue = "url(#" + imgId + ")";

	for (var i = 0; i < obj.length; i++) {
		if (obj[i].marker == marker) {
			var fill = $(obj[i]).attr('fill');
			
			if(fill != null)			
				$(obj[i]).attr("fill", fillValue);
			else
			{
				var style = $(obj[i]).attr('style');
			
				if(style != null)
				{
					var pattern = /fill:([^;]*)/;

					matches = style.match(pattern);
					if (matches != null)
					{
						style = style.replace('fill:' + matches[1], 'fill:' + fillValue);
						$(obj[i]).attr("style", style);
					}
				}
			}
		} 
	}
}

function lookupImageId(imageLink)
{
	for(idx in imageLinks)
	{
		var temp = imageLinks[idx];
		
		if (imageLink == temp.imageLink) {
			return temp.imageId;
		}
	}
	
	return -1;
}
</script>

</body>
</html>