<?php
$year = date("Y");
$month = date("n");
$day = date("d");

$representation = "$year-$month-$day";


$url = 'http://myschooldining.com/Rockhurst%20High%20School/calendarWeek';
$data = array('current_day' => $representation,
                'adj' => '3');

$options = array(
    'http' => array(
        'header'  => "Content-type: application/x-www-form-urlencoded",
        'header'  => "X-Requested-With: XMLHttpRequest",
        'header'  => "Accept: text/html",
        'method'  => 'POST',
        'content' => http_build_query($data),
    ),
);
$context  = stream_context_create($options);
$result = file_get_contents($url, false, $context);
?>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Flik Lunch</title>
        <link href='https://fonts.googleapis.com/css?family=Open+Sans:300' rel='stylesheet' type='text/css'>
        <link rel="stylesheet" href="../main.css">
        <script src="../jquery-1.10.2.min.js"></script>
        <script src="../jquery.mobile-1.4.5.min.js"></script>
        <script type="text/javascript" src="Script.js"></script>
        <style>
            .ui-loader{ display: none;}
        </style>
    </head>
    <body onload="showAndroidToast(getDate())"> 
        <div id="content">
            <div id="header">
                <ul id="nav">
                    <li><a href="https://www.rockhursths.edu/">Rockhurst</a></li>
                    <li><a href="http://myschooldining.com/Rockhurst%20High%20School">mySchoolDining</a></li>
                </ul>
                <img src="../rockhurst.png" alt="Rockhurst High School" />
                <h1>Rockhurst Lunch</h1>
            </div>
            <div id="echo">
                <?php echo $result;?>
            </div>
            
            <div class="box">Created by Jacob</div>
 
            <script>
            $(function(){
                // Bind the swipeleftHandler callback function to the swipe event on div.box
                $( "div.box" ).on( "swipeleft", swipeleftHandler );
 
                // Callback function references the event target and adds the 'swipeleft' class to it
                function swipeleftHandler( event ){
                $( event.target ).addClass( "swipeleft" );
                }
            });

            $(function(){
                // Bind the swiperightHandler callback function to the swipe event on div.box
              $( "div.box" ).on( "swiperight", swiperightHandler );
 
              // Callback function references the event target and adds the 'swiperight' class to it
              function swiperightHandler( event ){
                $( event.target ).removeClass( "swipeleft" );
              }
            });
            </script>
        
    </body>
</html>
