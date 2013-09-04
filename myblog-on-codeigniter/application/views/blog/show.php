<h1> <?= $title ?> </h1>

<h3> <?= $description ?> </h3>

<? if (isset($posts)) foreach ($posts as $post){ ?>
	<? echo show_post($post) ?>
<? }
	else
		echo anchor('/post/create','You haven\'t post anything yet, why don\'t you post something?');?>
