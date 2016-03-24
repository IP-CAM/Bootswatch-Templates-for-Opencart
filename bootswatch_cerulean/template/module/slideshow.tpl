<section class="homeslider fullwidth flexslider" id="home-slider" style="top:-20px;">
    <ul class="slides">

        <?php foreach ($banners as $banner) { ?>
        <li class="text-center" >

                <?php if ($banner['link']) { ?>
            <a href="<?php echo $banner['link']; ?>"><img src="<?php echo $banner['image']; ?>" 
                                                          alt="<?php echo $banner['title']; ?>"  /></a>
                <?php } else { ?>
            <img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>"  />
                <?php } ?>

            <div class="flex-caption transparent light-font center " style="top:25%;">
                <div class="container">
                <div class="row">
                    <div class="col-sm-12 col-md-6 "></div>
                    <div class="col-sm-12 col-md-6 grey-transparent-bg">
                    <h1 class="animated fadeInDown"><span class="uppercase"><?php echo $banner['title']; ?></span></h1>
                                <?php if ($banner['link']) { ?>
                    <br/>
                    <a href="<?php echo $banner['link']; ?>" class="buttonsimple animated fadeInUpBig"><i class="fa fa-download"></i> Purchase Asher</a>
                                <?php } ?>
                    </div>
                    </div>

                </div>
            </div>

        </li>
        <?php } ?> 
    </ul>
</section>

<script>

    jQuery(document).ready(function ($) {
        $('#home-slider').flexslider({
            pauseOnHover: true,
            slideshow: true, //Boolean: Animate slider automatically
            slideshowSpeed: 6000, //Integer: Set the speed of the slideshow cycling, in milliseconds
            animationSpeed: 600,
            animation: "fade", //String: Select your animation type, "fade" or "slide"
            easing: "swing", //{NEW} String: Determines the easing method used in jQuery transitions. jQuery easing plugin is supported!
            direction: "horizontal",
            controlNav: true, //Boolean: Create navigation for paging control of each clide? Note: Leave true for manualControls usage
            useCSS: true, //{NEW} Boolean: Slider will use CSS3 transitions if available
            touch: true,
            directionNav: true
        });
    });

</script>