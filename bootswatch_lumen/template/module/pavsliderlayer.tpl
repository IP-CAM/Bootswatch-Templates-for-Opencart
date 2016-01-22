7<?php 
	$randID = rand( 20,   rand() );

	$sliderParams['hide_navigator_after'] = $sliderParams['show_navigator']?0:$sliderParams['hide_navigator_after'];
	$class 	   = isset( $sliderParams['fullwidth'] ) && !empty($sliderParams['fullwidth']) ? $sliderParams['fullwidth']: 'boxed';
	$fullwidth = $class =="boxed"?"off":"on";
?>
<script type="text/javascript">
	$(document).ready(function(){
		$('#iview').iView({
			pauseTime: <?php echo $sliderParams['delay'];?>,
			directionNav: false,
			directionNavHide: false,
			controlNavNextPrev: true,
			controlNav: true,
			tooltipY: -15,
			<?php if($sliderParams['navigator_type'] == 'bullet' || $sliderParams['navigator_type'] == 'thumb'){ ?>
				controlNavThumbs: true,
			<?php } ?>
		});
	});
</script>

<?php if( $class =="boxed") { ?>
<div class="layerslider-wrapper carousel slide pavcontentslider" style="max-width:<?php echo $sliderParams['width'];?>px;">
<?php } ?>
	<div class="fix-margin-right" style="padding: <?php echo $sliderParams['padding'];?>;margin: <?php echo $sliderParams['margin'];?>;">
		<div id="iview" class="hidden-xs hidden-sm" style="width:100%;height:<?php echo $sliderParams['height'];?>px; " >

			<?php foreach( $sliders as $_key => $slider ){ ?>
			<div data-iview-thumbnail="<?php echo $slider['thumbnail']; ?>" data-iview-image="<?php echo $slider['thumbnail'];?>" data-iview-transition="slice-top-fade,slice-right-fade">

				<?php 
					foreach( $slider['layersparams']->layers as $i => $layer ){
						$type = $layer['layer_type']; 
				?>

				<div class="iview-caption tp-caption <?php echo $layer['layer_class']; ?>" data-start="<?php echo $layer['time_start']; ?>" data-x="<?php echo $layer['layer_left']; ?>" data-y="<?php echo $layer['layer_top']; ?>" data-width="600" data-transition="fade">
					<?php if( $type=='image') { ?>
						<img src="<?php echo $url."image/".$layer['layer_content'];?>" alt="<?php echo $layer['layer_content']; ?>" />
					<?php } else if( $type == 'video' ) { ?>
						<?php if( $layer['layer_video_type'] == 'vimeo')  { ?>
							<iframe src="http://player.vimeo.com/video/<?php echo $layer['layer_video_id'];?>?wmode=transparent&amp;title=0&amp;byline=0&amp;portrait=0;api=1" width="<?php echo $layer['layer_video_width'];?>" height="<?php echo $layer['layer_video_height'];?>"></iframe>
						<?php } else { ?>
							<iframe width="<?php echo $layer['layer_video_width'];?>" height="<?php echo $layer['layer_video_height'];?>" src="http://www.youtube.com/embed/<?php echo $layer['layer_video_id'];?>?wmode=transparent" frameborder="0" allowfullscreen="1"></iframe>
						<?php } ?>
					<?php } else { ?>
						<?php echo html_entity_decode( str_replace( '_ASM_', '&', $layer['layer_caption']) , ENT_QUOTES, 'UTF-8'); ?>
					<?php } ?>
				</div>
				<?php } ?>

				
			</div>
			<?php } //end foreach slideres ?>
		</div>
	</div>
<?php if( $class =="boxed") { ?>
 </div>
<?php } ?>

