<?php

$username = array(
    'name'	=> 'username',
    'id'	=> 'username',
    'value' => set_value('username',$username),
    'maxlength'	=> $this->config->item('username_max_length', 'tank_auth'),
    'size'	=> 30,
);

$email = array(
	'name'	=> 'email',
	'id'	=> 'email',
	'value'	=> set_value('email',$email),
	'maxlength'	=> 80,
	'size'	=> 30,
);

$website = array(
	'name'	=> 'website',
	'id'	=> 'website',
	'value'	=> set_value('website',$website),
	'maxlength'	=> 80,
	'size'	=> 30,
);

$avatar = array(
	'name'	=> 'avatar',
	'id'	=> 'avatar',
	'value'	=> set_value('website',$avatar),
    'show' => array(
        'src' => 'avatars/'.$avatar,
        'alt' => 'profile picture',
        'class' => 'post_images',
        'width' => '200',
        'height' => '200',
        'title' => 'profile picture',
        'rel' => 'lightbox',
    )
    
);

?>


<? if ( isset($upload_data) ){ ?>
    <ul>
    <?php foreach ($upload_data as $item => $value):?>
    <li><?php echo $item;?>: <?php echo $value;?></li>
    <?php endforeach; ?>
    </ul>
<? } ?>


<?php echo form_open('auth/update'); ?>
<table>
	
	<tr>
		<td><?php echo form_label('Username', $username['id']); ?></td>
		<td><?php echo form_input($username); ?></td>
		<td style="color: red;"><?php echo form_error($username['name']); ?><?php echo isset($errors[$username['name']])?$errors[$username['name']]:''; ?></td>
	</tr>
	
	<tr>
		<td><?php echo form_label('Email Address', $email['id']); ?></td>
		<td><?php echo form_input($email); ?></td>
		<td style="color: red;"><?php echo form_error($email['name']); ?><?php echo isset($errors[$email['name']])?$errors[$email['name']]:''; ?></td>
	</tr>

    <tr>
		<td><?php echo form_label('Website', $website['id']); ?></td>
		<td><?php echo form_input($website); ?></td>
		<td style="color: red;"><?php echo form_error($website['name']); ?><?php echo isset($errors[$website['name']])?$errors[$website['name']]:''; ?></td>
	</tr>
    <?php echo form_submit('update', 'Update'); ?>
    <?php echo form_close(); ?>

    
</table>

<?php echo form_open_multipart('auth/upload_avatar'); ?>
<table>
    <tr>
        <td><?= form_label('Avatar', $avatar['id']); ?></td>
        <td><?= img($avatar['show']) ?></td>
        <td><?= form_upload($avatar) ?></td>
        <td style="color: red;"><?= form_error($avatar['name']); ?><?= isset($errors['avatar'])?$errors['avatar']:''; ?></td>
	</tr>
    <?php echo form_submit('upload_avatar', 'Upload avatar'); ?>
    <?php echo form_close(); ?>
</table>



<?php echo form_open('auth/delete'); ?>
<?php echo form_submit('delete', 'Delete account'); ?>
<?php echo form_close(); ?>
