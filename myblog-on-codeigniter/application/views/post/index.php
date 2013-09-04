
<? if (isset($posts)) foreach ($posts as $post){ ?>
	<? echo show_post($post) ?>
<? }
echo "<br />";
echo $pagination;
?>


<h1> Your blog : <?= $this->tank_auth->get_username(); ?>'s blog </h1>


<? if (isset($his_posts)) foreach ($his_posts as $post){ ?>
	<? echo show_post($post) ?>
<? }
