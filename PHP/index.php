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
        <div class="footer">
            <h3>Daily Offerings</h3>
            <p>Fresh Salad Bar with assortment of freshly prepared toppings, homemade salad dressings and croutons, composed salads, etc. | Deli and Soup Station with daily sliced deli meats and cheese, sandwich fixings and condiments, made from scratch soups | Beverage Station with 100% juices, juice blends and infused waters, In-House made Waterworks infused water, iced tea, coffee, low fat milk, skim milk and low fat chocolate milk | Fresh Fruit and Yogurt Bar with yogurt toppings | Make your own Peanut Butter and Jelly Station | Frozen Yogurt Station with cones, bowls and sauces</p>
        </div>
        
    </body>
</html>
