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
        <title>Rock Lunch</title>
        <link href='https://fonts.googleapis.com/css?family=Lato:300' rel='stylesheet' type='text/css'>
        <link rel="stylesheet" href="main.css">
    </head>
    <body> 
        <div id="header">
            <h1>Rock Lunch</h1>
            <a href="https://www.rockhursths.edu/"><img src="rockhurst.png" width="75px" alt="Rockhurst"/></a>
            <p>Today is <?php echo $representation;?></p>
        </div>
        <div id="content">
            <?php echo $result;?>
        </div>
        <div id="footer">
            <iframe src="Test_Ad/Test_Ad.html"></iframe>
        </div>
        
    </body>
</html>
