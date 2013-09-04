<?php

$username = array(
    'name'	=> 'username',
    'id'	=> 'username',
    'value' => set_value('username'),
    'maxlength'	=> 255,
    'size'	=> 30
);

$website = array(
	'name'	=> 'website',
	'id'	=> 'website',
	'value'	=> set_value('website'),
	'size'	=> 30
);

$email = array(
	'name'	=> 'email',
	'id'	=> 'email',
	'value'	=> set_value('email'),
	'size'	=> 30
);

$body = array(
	'name'	=> 'body',
	'id'	=> 'body',
	'value'	=> set_value('body'),
	'rows'	=> 10,
	'cols'	=> 39,
);

?>

<? echo show_post($post) ?>


<?php echo form_open($this->uri->uri_string()); ?>
<h3> New comment </h3>
<table>
<? if (!$this->tank_auth->is_logged_in()) { ?>
	<tr>
		<td><?php echo form_label('username', $username['id']); ?></td>
		<td><?php echo form_input($username); ?></td>
		<td style="color: red;"><?php echo form_error($username['name']); ?><?php echo isset($errors[$username['name']])?$errors[$username['name']]:''; ?></td>
	</tr>

	<tr>
		<td><?php echo form_label('website', $website['id']); ?></td>
		<td><?php echo form_input($website); ?></td>
		<td style="color: red;"><?php echo form_error($website['name']); ?><?php echo isset($errors[$website['name']])?$errors[$website['name']]:''; ?></td>
	</tr>

	<tr>
		<td><?php echo form_label('email', $email['id']); ?></td>
		<td><?php echo form_input($email); ?></td>
		<td style="color: red;"><?php echo form_error($email['name']); ?><?php echo isset($errors[$email['name']])?$errors[$email['name']]:''; ?></td>
	</tr>
<? }?>
	<tr>
		<td><?php echo form_label('body', $body['id']); ?></td>
		<td><?php echo form_textarea($body); ?></td>
		<td style="color: red;"><?php echo form_error($body['name']); ?><?php echo isset($errors[$body['name']])?$errors[$body['name']]:''; ?></td>
	</tr>

	
</table>
<?php echo form_submit('create comment', 'Create comment'); ?>
<?php echo form_close(); ?>


<? if (isset($comments)) foreach ($comments as $comment){ ?>

	<? if (isset($comment['user_id'])) { ?>
		<? $comment_user =
				$this->users->get_user_by_id($comment['user_id']);
			$comment_userprofile =
				$this->users->get_user_profile($comment['user_id']);
			?>
		<p> user : <b> <?= $comment_user['username'] ?> </b> </p>
		<p> website :  <b> <?= $comment_userprofile['website']?> </b> </p>
		<p>email : <b> <?= $comment_user['email'] ?> </b> </p>
	
	<? }else{ ?>
		<p>user :  <b> <?= $comment['username'] ?> </b> </p>
		<p>website : <b> <?= isset($comment['website'])? $comment['website'] : ''?> </b> </p>
		<p>email : <b> <?= $comment['email'] ?> </b> </p>
	<? } ?>
	
	<p> <?= isset($comment['body']) ? $comment['body'] : ''  ?> </p>
	<? $current_user = $this->tank_auth->current_user(); ?>
	<? $author = $this->mpost->get_post_author_by_blog_id($post['blog_id']); ?>
	<? if ( $current_user['username'] == $author ) { //show button options only to the owners of the post ?> 
	
			<?= form_open('comment/delete/'.$comment['id']); ?>
			<?= form_submit('delete', 'Delete comment'); ?>
			<?= form_close(); ?>
	<? } ?>
<? } ?>
