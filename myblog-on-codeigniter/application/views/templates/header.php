<?
$search= array(
    'name'	=> 'search',
    'id'	=> 'search',
    'value' => set_value('search'),
    'maxlength'	=> 1000,
    'size'	=> 30,
);
?>
<html>
<head>
	<title><?php echo $title ?> - MyBlog</title>
</head>
<body>
    <h1><?= anchor('/','Myblog' );?></h1>
    <div id='search'>     
        <?= form_open('/', array('method' => 'get')); ?>
        <?= form_label('Search', $search); ?>
        <?= form_input($search); ?>
        <?= form_submit('','Search'); ?>
        <?= form_close(); ?>
    </div>
    <div id='menu'>
        <ul>
            <?php if ($this->tank_auth->is_logged_in()){ ?>
                <li>Hello <?= $this->tank_auth->get_username(); ?>  </li>
                <li><?= anchor('/auth/update/', 'Settings'); ?>  </li>
                <?php if ($this->tank_auth->has_blog()){ ?>
                    <li><?= anchor('/'.$this->tank_auth->get_username(), 'Myblog'); ?>  </li>
                    <li><?= anchor('/post/create','Create a post') ?>  </li>
                <? } else { ?>
                    <li><?= anchor('/blog/create/', 'You don\'t have a blog, why don\'t you create one?'); ?>  </li>
                <? } ?>
                <li><?= anchor('/auth/logout/', 'Logout'); ?>  </li>
            <? }else{ ?>
                <li> <?= anchor('/auth/login/', 'Login'); ?> </li>
                <li> <?= anchor('/auth/register/', 'Register'); ?> </li>
             
            <? } ?>
         
        </ul>
    </div>
    <div id='message' style="color: green;">
        <? echo $this->session->flashdata('message') ;?>
    </div>
